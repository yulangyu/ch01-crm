<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":"
+ request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page isELIgnored="false" %><%--阻止jsp忽略el表达式--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <base href="<%=basePath%>" />

    <script type="application/javascript" src="jquery/jquery-1.11.1-min.js"></script>
</head>
<body>
<script>
    $(function (){
        first();
    })
    function  first(){
        alert("1");
        alert("2");
        return false;
        alert("3");
        alert("4");
    }

</script>
</body>
</html>