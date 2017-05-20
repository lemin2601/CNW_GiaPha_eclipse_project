<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gia Phả</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">   
        <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet" >
        <link href="<%=request.getContextPath()%>/bootstrap/css/w3.css" rel="stylesheet" >
        <!--css login & register form-->
        <link href="<%=request.getContextPath()%>/mystyle/login.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.print(message);
            } else {
                out.print("Xin Chào");
            }
        %>

        <jsp:include page="footer.jsp"></jsp:include>

    <script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/myjs/login.js"></script>
        <script src="<%=request.getContextPath()%>/myjs/index.js"></script>
    </body>
</html>
