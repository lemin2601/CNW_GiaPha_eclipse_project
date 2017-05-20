<%@page import="model.User"%>
<%@page import="model.User"%>
<%@page import="controller.UserServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <body>
        <%
            User user = (User) request.getSession().getAttribute(UserServlet.USER_SESSION);

        %>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>  
                    </button>
                    <a class="navbar-brand" href="<%=request.getContextPath()%>/about.html"><img src="<%=request.getContextPath()%>/img/logo.jpg" alt="LeeMin" style="width: 25px"></a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="<%=request.getContextPath()%>/about.html">About</a></li>
                        <li class="dropdown">

                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Menu<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">View by Table</a></li>
                                <li><a href="#">View by Grid</a></li>
                            </ul>
                        </li>
                        <!--<li><a data-toggle="collapse" data-target="#demo" ><span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span> Togle Menu</a></li>-->
                    </ul>

                    <form class="navbar-form navbar-right">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search">
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="submit">
                                    <i class="glyphicon glyphicon-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <% if (user != null) {%>
                        <li>
                            <a href="#" style="width: auto;"> Welcome <b><%=user.getEmail()%></b></a>
                        </li>
                        <li><a href="<%=request.getContextPath()%>/User?command=logout" style="width: auto;"><span
                                    class="glyphicon glyphicon-log-in"></span> Logout</a>
                        </li>
                        <%} else {%>
                        <li>
                            <a>Chào Mừng Bạn Đến Với Sơ Đồ Gia Phả Online</a>
                        </li>
                        <li><a href="#" class="login_register_btn" role="button" data-toggle="modal" data-target="#login-modal">
                                <span class="glyphicon glyphicon-log-in"></span> Login
                            </a>
                        </li>

                        <%}%>


                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>