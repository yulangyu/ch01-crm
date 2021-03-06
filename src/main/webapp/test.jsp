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
    <script>
        $(function (){
            //时间控件
            $(".time").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            })

            //自动补全插件
            $("#create-customerName").typeahead({
                source: function (query, process) {
                    $.post(
                        "workbench/transaction/getCustomerName.do",
                        { "name" : query },
                        function (data) {
                            //alert(data);
                            process(data);
                        },
                        "json"
                    );
                },
                delay: 1500
            });



        })
        
    </script>
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