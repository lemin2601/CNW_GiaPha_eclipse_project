<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">-->
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->

        <title>Welcome to login system</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">   
        <!--<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" >-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="../library/bootstrap/css/w3.css" rel="stylesheet" >
        <link href="../library/bootstrap/css/bootstrap-select.min.css" rel="stylesheet" >
        <!--css danh cho select-->
        <link rel="stylesheet" href="../library/bootstrap/css/bootstrap-select.css">
        <link rel="stylesheet" href="https://cdn.rawgit.com/tonystar/bootstrap-float-label/v3.0.0/dist/bootstrap-float-label.css">

        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
        <!--dành cho tree & zoom-->
        <script src="../library/zoom/libs/jquery.js"></script>
        <script src="../library/zoom/dist/jquery.panzoom.js"></script>
        <script src="../library/zoom/libs/jquery.mousewheel.js"></script>
        <link href="../library/mystyle/tree.css" rel="stylesheet">
        <!--css login & register form-->
        <link href="../library/mystyle/login.css" rel="stylesheet">
        <!--css cho form table gia pha-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'>
        <!-- bootstrap datepicker -->
        <link rel="stylesheet" href="../library/plugins/datepicker/datepicker3.css">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <!--Menu here Xem chi tiết thêm mới, sửa, tìm kiếm thêm mới-->
            <div class="container-fluid " >
                <div id="demo" class="collapse">
                    <div class="container-fluid " >
                        <div class="col-sm-12">
                            <div class="col-sm-1">
                                <button id="btn-show-form-create-genealogy" type="button" class="btn btn-block btn-success"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> New</button>
                            </div>
                            <div class="col-sm-1">
                                <button id="btn-show-form-edit-genealogy" type="button" class="btn btn-block btn-warning"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Edit</button>
                            </div>
                            <div class="col-sm-1">
                                <button id="btn-show-form-delete-genealogy" type="button" class="btn btn-block btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> Delete</button>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group has-float-label">
                                    <select class="form-control selectpicker" data-live-search="true" data-width="100%" id="guide-genealogy">
                                        <!--                                        <option selected>United States</option>
                                                                                
                                                                                <option>Tộc Lê</option>
                                                                                <option>Tộc Nguyễn</option>
                                                                                <option>Tộc Trần</option>-->
                                    </select>
                                    <label for="guide-genealogy">Gia phả</label>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group has-float-label">
                                    <select class="form-control selectpicker" data-live-search="true" data-width="100%" id="guide-name">
                                        <option selected>United States</option>
                                        <option>Nguyễn Văn Tèo</option>
                                        <option>Trần Thị Tươi</option>
                                        <option>Trường công mạnh</option>
                                    </select>
                                    <label for="guide-name">Họ & Tên</label>
                                </div>

                            </div>
                            <div class="col-sm-1">
                                <div class="form-group has-float-label">
                                    <select class="form-control selectpicker" data-live-search="true" data-width="100%" id="guide-deep-genealogy">
                                        <option>2</option>
                                        <option selected>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                        <option>6</option>
                                    </select>
                                    <label for="guide-deep-genealogy">Sâu nhánh</label>
                                </div>
                            </div>

                            <div class="col-sm-2">
                                <button id="btn-xem-gia-pha" type="button" class="btn btn-info btn-block navbar-right">
                                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span> Xem
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--title des & zoom + menu button--> 
            <div class="container-fluid " >
                <div class="col-sm-2">
                    <button type="button" class="btn btn-default" data-toggle="collapse" data-target="#demo"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span></button>
                </div>
                <div class="col-sm-8">
                    <div class="row">
                        <input type="hidden" id ="view-genealogy-id" value="">
                        <h1 id="view-genealogy-name"class="text-center">Gia Phả Họ Trần</h1> 
                        <p id="view-genealogy-description" class="text-right">Here is description genealogy</p>
                    </div>
                </div>             
                <div class="col-sm-2">
                    <button id="btn-zoom-plus" type="button" class="btn navbar-right"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
                    <button id="btn-zoom-refresh" type="button" class="btn navbar-right"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
                    <button id="btn-zoom-minus" type="button" class="btn navbar-right"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></button>
                </div>
            </div>


            <!--khu vuc ve cay gia pha-->
            <section id="focal" >
                <div id="tree-parent" class="parent"  style="height:85vh; width: 100%;"  >
                    <div class="panzoom">
                        <div id="tree" class="tree" style="zoom:100% ;height:100vh; width: 1000%;">

                        </div>
                    </div>

                </div>
                <script>
                    (function () {
                        var $section = $('#focal');
                        var $panzoom = $section.find('.panzoom').panzoom({
                            startTransform: 'scale(0.3)',
                            which: 1,
                            minScale: 0.01,
                            maxScale: 6,
                            duration: 200,
                            $zoomIn: $('#btn-zoom-plus'),
                            $zoomOut: $('#btn-zoom-minus'),
                            $zoomRange: $(),
                            $reset: $('#btn-zoom-refresh'),
                            //$set: $('#btn-xem-gia-pha'),
                        }
                        );
                        $panzoom.parent().on('mousewheel.focal', function (e) {
                            e.preventDefault();
                            var delta = e.delta || e.originalEvent.wheelDelta;
                            var zoomOut = delta ? delta < 0 : e.originalEvent.deltaY > 0;
                            $panzoom.panzoom('zoom', zoomOut, {
                                increment: 0.1,
                                focal: e
                            });
                        });
                    })();
                </script>
            </section>   
        <%--<jsp:include page="../form/grid-gia-pha-temp.jsp"></jsp:include>--%>

        <%--<%@include  file="../form/grid-gia-pha-temp.html" %>--%>

        <!-- form-create-genealogy -->
        <div class="modal fade" id="form-create-genealogy" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">X</span></button>
                        <h4 class="modal-title" id="myModalLabel">Create new genealogy</h4>
                    </div>
                    <div class="modal-body" >
                        <form data-toggle="validator" id="form-create-genealogy-submit" action="../Genealogy" method = "post">
                            <input type="hidden" name="command" value="create_genealogy">
                            <input type="hidden" name="id" class="create-id">

                            <div class="form-group">
                                <label>Name</label>
                                <input name="name" type="text" class="form-control"  placeholder="Name genealogy" data-error="Please enter name" required >
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <label >Description:</label>
                                <textarea type="text" name="description" class="form-control" placeholder="Description" ></textarea>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <div id='message-form-create-genealogy' class="col-sm-offset-2 col-sm-10"></div>
                            </div>
                            <div class="form-group">
                                <button type="submit"  class="btn btn-block btn-success " >Create</button>
                                <button  data-dismiss="modal" class="btn btn-block btn-warning">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- form-edit-genealogy -->
        <div class="modal fade" id="form-edit-genealogy" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">X</span></button>
                        <h4 class="modal-title" id="myModalLabel">Edit my genealogy</h4>
                    </div>
                    <div class="modal-body" >
                        <form data-toggle="validator" id="form-edit-genealogy-submit" action="../Genealogy" method = "post">
                            <input type="hidden" name="command" value="edit_genealogy">
                            <input type="hidden" name="id" class="edit-id">
                            <div class="form-group">
                                <label>Name</label>
                                <input name="name" type="text" class="form-control" placeholder="Name genealogy" data-error="Please enter name"  required >
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <label >Description:</label>
                                <textarea type="text" name="description" class="form-control" placeholder="Description" ></textarea>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <div id='message-form-edit-genealogy' class="col-sm-offset-2 col-sm-10"></div>
                            </div>
                            <div class="form-group">
                                <button type="submit"  class="btn btn-block btn-success " >Create</button>
                                <button  data-dismiss="modal" class="btn btn-block btn-warning">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- form-delete-genealogy -->
        <div class="modal fade" id="form-delete-genealogy" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">X</span></button>
                        <h4 class="modal-title" id="myModalLabel">Delete my genealogy</h4>
                    </div>
                    <div class="modal-body" >
                        <form data-toggle="validator" id="form-delete-genealogy-submit" action="../Genealogy" method = "post">
                            <input type="hidden" name="command" value="delete_genealogy">
                            <input type="hidden" name="id" class="delete-id">
                            <div class="form-group">
                                <label>Name</label>
                                <input name="name" type="text" class="form-control" placeholder="Name genealogy" data-error="Please enter name"  readonly >
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <label >Description:</label>
                                <textarea type="text" name="description" class="form-control" placeholder="Description" readonly></textarea>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <div id='message-form-delete-genealogy' class="col-sm-offset-2 col-sm-10"></div>
                            </div>
                            <div class="form-group">
                                <button type="submit"  class="btn btn-block btn-success " >Delete</button>
                                <button  data-dismiss="modal" class="btn btn-block btn-warning">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- BEGIN # MODAL LOGIN -->
        <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" align="center">
                        <img class="img-circle" id="img_logo" src="../img/logo.jpg">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                        </button>
                    </div>

                    <!-- Begin # DIV Form -->
                    <div id="div-forms">

                        <!-- Begin # Login Form -->
                        <form id="login-form">
                            <div class="modal-body">
                                <div id="div-login-msg">
                                    <div id="icon-login-msg" class="glyphicon glyphicon-chevron-right"></div>
                                    <span id="text-login-msg">Type your username and password.</span>
                                </div>
                                <input id="login_username" class="form-control" type="text" placeholder="Username (type ERROR for error effect)" required>
                                <input id="login_password" class="form-control" type="password" placeholder="Password" required>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox"> Remember me
                                    </label>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div>
                                    <button type="submit" class="btn btn-primary btn-lg btn-block">Login</button>
                                </div>
                                <div>
                                    <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                    <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                                </div>
                            </div>
                        </form>
                        <!-- End # Login Form -->

                        <!-- Begin | Lost Password Form -->
                        <form id="lost-form" style="display:none;">
                            <div class="modal-body">
                                <div id="div-lost-msg">
                                    <div id="icon-lost-msg" class="glyphicon glyphicon-chevron-right"></div>
                                    <span id="text-lost-msg">Type your e-mail.</span>
                                </div>
                                <input id="lost_email" class="form-control" type="text" placeholder="E-Mail (type ERROR for error effect)" required>
                            </div>
                            <div class="modal-footer">
                                <div>
                                    <button type="submit" class="btn btn-primary btn-lg btn-block">Send</button>
                                </div>
                                <div>
                                    <button id="lost_login_btn" type="button" class="btn btn-link">Log In</button>
                                    <button id="lost_register_btn" type="button" class="btn btn-link">Register</button>
                                </div>
                            </div>
                        </form>
                        <!-- End | Lost Password Form -->

                        <!-- Begin | Register Form -->
                        <form id="register-form" style="display:none;">
                            <div class="modal-body">
                                <div id="div-register-msg">
                                    <div id="icon-register-msg" class="glyphicon glyphicon-chevron-right"></div>
                                    <span id="text-register-msg">Register an account.</span>
                                </div>
                                <input id="register_username" class="form-control" type="text" placeholder="Username (type ERROR for error effect)" required>
                                <input id="register_email" class="form-control" type="text" placeholder="E-Mail" required>
                                <input id="register_password" class="form-control" type="password" placeholder="Password" required>
                            </div>
                            <div class="modal-footer">
                                <div>
                                    <button type="submit" class="btn btn-primary btn-lg btn-block">Register</button>
                                </div>
                                <div>
                                    <button id="register_login_btn" type="button" class="btn btn-link">Log In</button>
                                    <button id="register_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                </div>
                            </div>
                        </form>
                        <!-- End | Register Form -->

                    </div>
                    <!-- End # DIV Form -->

                </div>
            </div>
        </div>
        <!-- END # MODAL LOGIN -->
        
        <!-- view form people Modal -->
        <div class="modal fade" id="form-view-people" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                        <h4 class="modal-title" id="myModalLabel">View people model</h4>
                    </div>
                    <div class="modal-body">
                        <form data-toggle="validator" >
                            <input type="hidden" name="command" value="view">
                            <input type="hidden" name="id" class="view-id">
                            <div class="form-group">
                                <div class="col-xs-7">
                                    <div class="form-group">
                                        <label>First name</label>
                                        <input type="text" class="form-control" placeholder="First name" >
                                    </div>
                                    <div class="form-group">
                                        <label>First name</label>
                                        <input type="text" class="form-control" placeholder="First name" >
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="form-group">
                                        <img src="../img/congai.jpg" id='img-upload'  class="w3-circle"  style="width: 142px;height: 142px;">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-5">
                                    <label>Alias</label>
                                    <input type="text" class="form-control" placeholder="Alias" >
                                </div>
                                <div class="col-xs-5">
                                    <label>Hình ảnh</label>
                                    <div class="input-group">
                                        <span class="input-group-btn">
                                            <span class="btn btn-default btn-file">
                                                <input type="file" id="imgInp">
                                            </span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-4">
                                    <label>Sex</label>
                                    <select  name="roles" class="form-control" data-error="Please enter roles">
                                        <option value="1">Nam</option>
                                        <option value="0">Nữ</option>
                                    </select>
                                </div>
                                <div class="col-xs-4">
                                    <label>Ngày Sinh:</label>
                                    <div class="input-group date">
                                        <div class="input-group-addon"> <i class="fa fa-calendar"></i>
                                        </div>
                                        <input type="text" class="form-control pull-right" id="datepicker-birth-day">
                                    </div>
                                </div>
                                <div class="col-xs-4">
                                    <label>Từ trần:</label>
                                    <div class="input-group date">
                                        <div class="input-group-addon"> <i class="fa fa-calendar"></i>
                                        </div>
                                        <input type="text" class="form-control pull-rFight" id="datepicker-dead-day">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <label >Địa Chỉ:</label>
                                    <textarea type="text" name="username" class="form-control" placeholder="User name"  data-error="Please enter username"></textarea>
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <button  data-dismiss="modal" class="btn btn-block btn-warning">Close</button>
                                <button  data-backdrop="static" data-toggle="modal" data-target="#form-create-genealogy" class="btn btn-block btn-warning">Open model</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        
        <!--Một số form cần thiết-->
        <%--<%@include  file="../form/view-add-create-edit-people.jsp" %>--%>

        <%@include  file="../form/view-create-edit-item.html" %>
        <%--<%@include  file="../form/login-register.html" %>--%>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!--<script src="../bootstrap/js/jquery.min.js"></script>-->
        <!--<script src="../bootstrap/js/bootstrap.min.js"></script>-->
        <script src="../library/myjs/login.js"></script>
        <script src="../library/myjs/index.js"></script>
        <script src="../library/myjs/view-add-create-edit-genealogy.js"></script>

        <script src="../library/myjs/view-add-create-edit-people.js"></script>

        <!-- bootstrap datepicker -->
        <script src="../library/plugins/datepicker/bootstrap-datepicker.js"></script>
        <!--dành cho validate & toast-->
        <!--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.js"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
        <script src="../library/myjs/createtree.js"></script>
        <!--js dành cho select https://silviomoreto.github.io/bootstrap-select/examples/#basic-examples -->
        <script src="../library/bootstrap/js/bootstrap-select.js"></script>
        <%--<jsp:include page="login.html"></jsp:include>--%>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
