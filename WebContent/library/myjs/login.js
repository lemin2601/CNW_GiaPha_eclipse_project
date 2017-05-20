
/* #####################################################################
 #
 #   Project       : Modal Login with jQuery Effects
 #   Author        : Rodrigo Amarante (rodrigockamarante)
 #   Version       : 1.0
 #   Created       : 07/29/2015
 #   Last Change   : 08/04/2015
 #
 ##################################################################### */

$(function () {

    var $formLogin = $('#login-form');
    var $formLost = $('#lost-form');
    var $formRegister = $('#register-form');
    var $divForms = $('#div-forms');
    var $modalAnimateTime = 300;
    var $msgAnimateTime = 150;
    var $msgShowTime = 2000;

    $("form").submit(function (e) {
        switch (this.id) {
            case "login-form":
                var $lg_username = $('#login_username').val();
                var $lg_password = $('#login_password').val();
                e.preventDefault();
                //alert('login');
                $.ajax({
                    type: 'post',
                    url: '../User',
                    data: {username: $lg_username, password: $lg_password, command: 'login'},
                    beforeSend: function () {
                        //msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'),"success", "glyphicon-ok", "Send OK");
                        msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "default", "glyphicon-remove", "Loading...");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Can't connect to server, try again.");
                    },
                    success: function (data) {
                        if (data == "pass") {// sai pass
                            msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Password doesn't correct.");
                        } else if (data == "user") {// user or email chưa đăng kí 
                            msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Username have not been register.");
                        } else if (data == "active") {// user or email chưa đăng kí 
                            msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Account didn't active.");
                        } else if (data == "success") {// thành công
                            msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Send OK");
                            document.location.href = '../User?command=view&page=1&key=';
                        } else {
                            alert(data);
                        }
                        //$("#message").html(data);
                    },
                });
                return false;
                break;
            case "lost-form":
                //reactive
                var $ls_email = $('#lost_email').val();
                e.preventDefault();
                alert('reactive');
                $.ajax({
                    type: 'post',
                    url: '../User',
                    data: {email: $ls_email, command: 'reactive'},
                    beforeSend: function () {
                        //msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'),"success", "glyphicon-ok", "Send OK");
                        msgChange($('#div-lost-msg'), $('#icon-login-msg'), $('#text-login-msg'), "default", "glyphicon-remove", "Loading...");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        msgChange($('#div-lost-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Can't connect to server, try again.");
                    },
                    success: function (data) {
                         alert(data);
                        if (data == "failed") {// sai pass
                            msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "Send error");
                        } else if (data == "success") {// thành công
                            msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "success", "glyphicon-ok", "Send OK");
                        } else {
                            alert(data);
                        }
                        //$("#message").html(data);
                    },
                });

                return false;
                break;
            case "register-form":
                var $rg_username = $('#register_username').val();
                var $rg_email = $('#register_email').val();
                var $rg_password = $('#register_password').val();
                e.preventDefault();
                //alert('login');
                $.ajax({
                    type: 'post',
                    url: '../User',
                    data: {username: $rg_username, password: $rg_password, email: $rg_email, command: 'register'},
                    beforeSend: function () {
                        msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "default", "glyphicon-remove", "Loading...");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Can't connect to server.");
                    },
                    success: function (data) {
                        alert(data);
                        if (data == "email") {// sai pass
                            msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Email had been used. try again");
                        } else if (data == "user") {// user or email chưa đăng kí 
                            msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "User had been used. try again");
                        } else if (data == "success") {// thành công
                            msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "success", "glyphicon-ok", "Register Success.");
                            // document.location.href = '../User?command=view&page=1&key=';
                        } else {
                            alert(data);
                        }
                        //$("#message").html(data);
                    },
                });
                return false;
                break;
            default:
                return false;
        }
        return false;
    });

    $('#login_register_btn').click(function () {
        modalAnimate($formLogin, $formRegister)
    });
    $('#register_login_btn').click(function () {
        modalAnimate($formRegister, $formLogin);
    });
    $('#login_lost_btn').click(function () {
        modalAnimate($formLogin, $formLost);
    });
    $('#lost_login_btn').click(function () {
        modalAnimate($formLost, $formLogin);
    });
    $('#lost_register_btn').click(function () {
        modalAnimate($formLost, $formRegister);
    });
    $('#register_lost_btn').click(function () {
        modalAnimate($formRegister, $formLost);
    });

    function modalAnimate($oldForm, $newForm) {
        var $oldH = $oldForm.height();
        var $newH = $newForm.height();
        $divForms.css("height", $oldH);
        $oldForm.fadeToggle($modalAnimateTime, function () {
            $divForms.animate({height: $newH}, $modalAnimateTime, function () {
                $newForm.fadeToggle($modalAnimateTime);
            });
        });
    }

    function msgFade($msgId, $msgText) {
        $msgId.fadeOut($msgAnimateTime, function () {
            $(this).text($msgText).fadeIn($msgAnimateTime);
        });
    }

    function msgChange($divTag, $iconTag, $textTag, $divClass, $iconClass, $msgText) {
        var $msgOld = $divTag.text();
        msgFade($textTag, $msgText);
        $divTag.addClass($divClass);
        $iconTag.removeClass("glyphicon-chevron-right");
        $iconTag.addClass($iconClass + " " + $divClass);
        setTimeout(function () {
            msgFade($textTag, $msgOld);
            $divTag.removeClass($divClass);
            $iconTag.addClass("glyphicon-chevron-right");
            $iconTag.removeClass($iconClass + " " + $divClass);
        }, $msgShowTime);
    }


});