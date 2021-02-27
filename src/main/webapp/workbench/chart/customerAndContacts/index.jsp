<%--
  Created by IntelliJ IDEA.
  User: 10237
  Date: 2021/2/27
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>" />
</head>
<body>

</body>
</html>
