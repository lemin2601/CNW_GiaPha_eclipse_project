//Tiến hành view 
$(document).ready(function () {
    //lấy danh sách all gia phả.
    manageDataGenealogy();

    //Hiển thị tên gia phả ra select
    function manageDataGenealogy() {
        console.log("get list gia phả");
        $.ajax({
            url: '../Genealogy',
            type: 'post',
            dataType: 'json',
            data: {command: 'get_list'},
            beforeSend: function () {

            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert("Can;t to load data, try again");
                // $("#message-form-delete-genealogy").html("<p style ='color:red;'>Can't connect to server, try again.</p>");
            },
            success: function (data) {

                viewSelectGenealogy(data);
                manageDataPeopleByIdGenealogy();
            }
        });
//        $.ajax({
//            url: '../Genealogy',
//            type: 'post',
//            dataType: 'json',
//            data: {command: 'get_list'}
//        }).done(function (data) {
//            console.log(data);
////            viewSelectGenealogy(data);
////            manageDataPeopleByIdGenealogy();
//        });
    }
    //hiển thị tên người trong gia phả ra select với id gia phả
    function manageDataPeopleByIdGenealogy() {
        var id = $("#guide-genealogy option:selected").val();
        $.ajax({
            url: '../Genealogy',
            type: 'post',
            dataType: 'json',
            data: {command: 'get_list_people', id: id},
            beforeSend: function () {
                console.log("get list select people");
                //$("#guide-name").attr('disabled','disabled') ;  
            }
        }).done(function (data) {
            console.log(data);
            viewSelectPeople(data);

        });
    }

    //tên trong gia pha
    /* Add new Item select row */
    function viewSelectGenealogy(data) {
        var rows = '';
        $.each(data, function (key, value) {
            rows = rows + '<option value="' + value.id + '">' + value.name + '</option>';
        });
        $("#guide-name").removeAttr('disabled');
        $("#guide-genealogy").html(rows);
        $('#guide-genealogy').html(rows).selectpicker('refresh');

    }
    function viewSelectPeople(data) {
        var rows = '';
        $.each(data, function (key, value) {
            rows = rows + '<option value="' + value.id + '">' + value.firstname + " " + value.lastname + '</option>';
        });
        $("#guide-name").html(rows);
        $('#guide-name').html(rows).selectpicker('refresh');
    }
// cập nhật lại danh sách people khi thay đổi gia phả
    $("#guide-genealogy").change(function (e) {
        console.log($("#guide-genealogy option:selected").val());
        toastr.info('Wait to reload people in genealogy.', 'Info Alert', {positionClass: 'toast-bottom-right'}, {timeOut: 2000});
        manageDataPeopleByIdGenealogy();
    });


    //xem detail gia pha
    $('#btn-xem-gia-pha').click(function () {

        //gửi lên:
        //1. id gia phả
        //2. id người mà muốn view. mặc định là người lớn nhất.
        var id = $("#guide-genealogy option:selected").val();
        var id_people = $("#guide-name option:selected").val();
        var deep = $("#guide-deep-genealogy option:selected").val();

        $.ajax({
            url: '../Genealogy',
            type: 'post',
            dataType: 'json',
            data: {command: 'get_data_view_grid', id: id, id_people: id_people, deep: deep},
            beforeSend: function () {
                //$("#guide-name").attr('disabled','disabled') ;  
            }
        }).done(function (data) {
            //console.log(data);
            viewGenealogy(data.genealogy);
            $('#tree').html(taoCay(data.people));
            
            $(".btn-show-form-create-people").click(function () {
                console.log("click to view form people");
                $('#form-view-people').modal();
            });
            //console.log(taoCayGiaPha(data.people));
            //$('#tree').html(taoCayGiaPha(data.people));
        });

        //yêu cầu trả về:
        // 1. Thông tin gia phả
        // 2. danh sách người trong gia phả
        // 3.
    });

    function taoCay(people) {
        var result = '<ul><li>';
        $.each(people, function (key, value) {
            if (key == 'cha') {
                result += taoProfileFromCha(value);
            } else {
                result += taoChildFromCon(value);
            }
        });
        result += '</li></ul>';
        return result;
    }
    function taoProfileFromCha(cha) {
        var result = '<a>';
        $.each(cha, function (key, value) {
            if (key == 'item')
                result += taoProfileCaNhan(value);
        });
        result += '</a>';
        return result;
    }
    function taoProfileCaNhan(profile) {
        var item = '';
        $.each(profile, function (key, value) {
            item = item + '<div style=" display: inline-block;" data-toggle="tooltip" title="Đàn ông" data-placement="bottom" class = "btn-show-form-create-people">';
            item = item + '<img class="w3-circle" style="width: 100px;height: 100px;" src="../img/danong.jpg" alt="Person">';
            item = item + '<div class="w3-container">';
            item = item + '<h4><b>' + value.firstname + '</b></h4>';
            item = item + '<p>26/01/1995 - 20/20/2200</p>';
            item = item + '</div>';
            item = item + '</div>';
        });
        return item;
    }

    function taoChildFromCon(con) {
        if ((Object.keys(con).length === 0))
            return '';
        var result = '<ul>';
        $.each(con, function (key, value) {
            result += taoProfileChildFromCon(value);
        });
        result += '</ul>';
        return result;
    }
    function taoProfileChildFromCon(con) {
        var result = '<li>';
        $.each(con, function (key, value) {
            if (key == 'cha')
                result += taoProfileFromCha(value);
            if (key == 'con') {
                result += taoChildFromCon(value);
            }
        });
        result += '</li>';
        return result;
    }


    //function load View Genealogy
    function viewGenealogy(data) {
        $("#view-genealogy-name").html(data.name);
        $("#view-genealogy-id").val(data.name);
        $("#view-genealogy-description").html(data.description);

    }

});

// $("#message-form-create-genealogy").html("<img src='../img/ajax-loader.gif' /> Loading...");
//$("#form-edit-genealogy").find("textarea[name='description']").val("roles");
//        $("#form-edit-genealogy").find(".edit-id").val("id-edit");
// toastr.success('Item Created Successfully.', 'Success Alert', {positionClass: 'toast-bottom-right'}, {timeOut: 3000});
//toastr.error('Item Created Successfully.', 'Success Alert', {positionClass: 'toast-bottom-right'}, {timeOut: 3000});
//toastr.info('Wait to reload people in genealogy.', 'Info Alert', {positionClass: 'toast-bottom-right'}, {timeOut: 2000});
