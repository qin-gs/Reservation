<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/12
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>规则</title>
</head>
<body>

<div class="hrms_container">
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div class="hrms_body" style="position:relative; top:-15px;">

        <!-- 左侧栏 -->
        <%@ include file="leftsidebar.jsp" %>

        <!-- 中间员工表格信息展示内容 -->
        <div class="emp_info col-sm-10" style="align-content: center">

            <h3>预约规则：</h3>
            <div>1、机房仅开放未来五天的预约许可；</div>
            <div>2、每个人在同一时间仅能预约一个机位；</div>
            <div>3、一天分为五节课，每次只能预约一节课；</div>
        </div>
        <!-- 尾部 -->
        <%@ include file="foot.jsp" %>

    </div>


</body>
</html>
