<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/12
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>机房介绍</title>
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
        <div class="emp_info col-sm-10">

            <h3>机房介绍：</h3>
            <div>
                学院建有各类基础及专业实验室，拥有设备总价值1900余万，仪器设备台数2000余台套，
                各类实验室占地面积总和超过9000平方米，有面向重庆理工大学全校计算机基础教育和其
                他非计算机专业教育的计算机公共实验室20个，有面向计算机学院各个计算机专业教育的
                专业实验室11个。专业实验室包括有计算机软件实验室、计算机网络实验室、计算机图象
                图形学实验室、嵌入式技术应用实验室、计算机组成原理实验室、软件工程实验室、网络
                工程及网络安全实验室、物联网技术实验室、学生软件创新实验室、大学生博弈创新实验
                室（机器人足球、武术机器人、计算机博弈）、卓越工程师计划创新实验室、研究生创新
                实验室等。建有重庆市计算机视觉智能技术工程研究中心、重庆市工业控制系统信息安全
                技术研发中心、重庆市网络与信息安全基地、重庆市高校众创空间星云智慧空间、重庆市
                高校机器人与智能制造技术重点实验室（共建）和重庆市重理工九龙科创空间（共建）等
                六个省部级研发平台，计算机图像图形学研究所、嵌入式系统工程中心、软件技术与应用
                研究所、CIMS研究所、人工智能系统研究所、物联网实验室等6个校级研究基地。
            </div>

        </div>

        <!-- 尾部 -->
        <%@ include file="foot.jsp" %>
    </div>
</div>

</body>
</html>

