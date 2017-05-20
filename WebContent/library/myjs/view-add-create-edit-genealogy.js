// view form gui
$(function () {
//Date picker
    $('#datepicker-birth-day').datepicker({
        autoclose: true
    });
    $('#datepicker-dead-day').datepicker({
        autoclose: true
    });
   
    $("#btn-show-form-create-genealogy").click(function () {
        console.log("click to view form giapha");
        //jQuery.noConflict(); 
        $('#form-create-genealogy').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
    $("#btn-show-form-edit-genealogy").click(function () {
        console.log("click to view form giapha");
        $('#form-edit-genealogy').modal({
            backdrop: 'static',
            keyboard: false
        });

        $("#form-edit-genealogy").find("input[name='name']").val("nam genealogy here");
        $("#form-edit-genealogy").find("textarea[name='description']").val("roles");
        $("#form-edit-genealogy").find(".edit-id").val("id-edit");
//        message-form-edit-genealogy
    });
    $("#btn-show-form-delete-genealogy").click(function () {
        console.log("click to delte giapha");
        $('#form-delete-genealogy').modal({
            backdrop: 'static',
            keyboard: false
        });
        $("#form-delete-genealogy").find("input[name='name']").val("nam genealogy here");
        $("#form-delete-genealogy").find("textarea[name='description']").val("roles");
        $("#form-delete-genealogy").find(".delete-id").val("id-edit");
    });


// Create new genealogy */
    $("#form-create-genealogy-submit").submit(function (e) {
        e.preventDefault();
        var url = $(this).attr('action');
        var type = $(this).attr('method');
        //validate 
        var command = $(this).find("input[name='command']").val();
        var name = $(this).find("input[name='name']").val();
        var description = $(this).find("textarea[name='description']").val();
        if (name == "") {
            //$("#message-form-create-genealogy").html("<p style ='color:red;'>Name not empty, try again.</p>");
            return;
        }
        console.log(url + "|" + type + "|" + command + "|" + name + "|" + description);
        $.ajax({
            url: url,
            type: type,
            data: $(this).serialize(),
            beforeSend: function () {
                $("#message-form-create-genealogy").html("<img src='../img/ajax-loader.gif' /> Loading...");
            },
            error: function (xhr, ajaxOptions, thrownError) {
                $("#message-form-create-genealogy").html("<p style ='color:red;'>Can't connect to server, try again.</p>");
            },
            success: function (data) {
                if (data == "name") {
                    $("#message-form-create-genealogy").html("<p style ='color:red;'>Name not empty, try again</p>");
                } else if (data == "failed") {
                    $("#message-form-create-genealogy").html("<p style ='color:red;'>It's failed.</a></p>");
                } else if (data == "success") {
                    $("#message-form-create-genealogy").html("<p style ='color:green;'>Add success</p>");
                    $("#form-create-genealogy-submit").trigger("reset");
                } else {
                    alert(data);
                }
            }
        });
        return false;
    });
//Edit genealogy
    $("#form-edit-genealogy-submit").submit(function (e) {
        e.preventDefault();
        var url = $(this).attr('action');
        var type = $(this).attr('method');
        //validate 
        var command = $(this).find("input[name='command']").val();
        var name = $(this).find("input[name='name']").val();
        var description = $(this).find("textarea[name='description']").val();
        if (name == "")
            return;
        console.log(url + "|" + type + "|" + command + "|" + name + "|" + description);
        $.ajax({
            url: url,
            type: type,
            data: $(this).serialize(),
            beforeSend: function () {
                $("#message-form-edit-genealogy").html("<img src='../img/ajax-loader.gif' /> Loading...");
            },
            error: function (xhr, ajaxOptions, thrownError) {
                $("#message-form-edit-genealogy").html("<p style ='color:red;'>Can't connect to server, try again.</p>");
            },
            success: function (data) {
                if (data == "name") {
                    $("#message-form-edit-genealogy").html("<p style ='color:red;'>Name not empty, try again</p>");
                } else if (data == "failed") {
                    $("#message-form-edit-genealogy").html("<p style ='color:red;'>It's failed.</a></p>");
                } else if (data == "success") {
                    $("#message-form-edit-genealogy").html("<p style ='color:green;'>Update success</p>");
                    toastr.success('Update Genealogy Successfully.', 'Success Alert', {positionClass: 'toast-bottom-right'}, {timeOut: 3000});
                } else {
                    alert(data);
                }
            }
        });
        return false;
    });
//Delete genealogy
    $("#form-delete-genealogy-submit").submit(function (e) {
        e.preventDefault();
        var url = $(this).attr('action');
        var type = $(this).attr('method');
        //validate 
        var command = $(this).find("input[name='command']").val();
        var name = $(this).find("input[name='name']").val();
        var description = $(this).find("textarea[name='description']").val();
        if (name == "")
            return;
        console.log(url + "|" + type + "|" + command + "|" + name + "|" + description);
        $.ajax({
            url: url,
            type: type,
            data: $(this).serialize(),
            beforeSend: function () {
                $("#message-form-delete-genealogy").html("<img src='../img/ajax-loader.gif' /> Loading...");
            },
            error: function (xhr, ajaxOptions, thrownError) {
                $("#message-form-delete-genealogy").html("<p style ='color:red;'>Can't connect to server, try again.</p>");
            },
            success: function (data) {
                if (data == "name") {
                    $("#message-form-delete-genealogy").html("<p style ='color:red;'>Name not empty, try again</p>");
                } else if (data == "failed") {
                    $("#message-form-delete-genealogy").html("<p style ='color:red;'>It's failed.</a></p>");
                } else if (data == "success") {
                    $("#message-form-delete-genealogy").html("<p style ='color:green;'>Update success</p>");
                    toastr.success('Delete Genealogy Successfully.', 'Success Alert', {positionClass: 'toast-bottom-right'}, {timeOut: 3000});
                    location.reload();
                } else {
                    alert(data);
                }
            }
        });
        return false;
    });

});