<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/25
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="panel-group col-sm-2" id="hrms_sidebar_left" role="tablist" aria-multiselectable="true">
    <ul class="nav nav-pills nav-stacked emp_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_emp">
                <span class="glyphicon glyphicon-user" aria-hidden="true">预约记录管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="#" class="student_record">学生预约记录</a></li>
                <li role="presentation"><a href="#" class="room_record">机房使用记录</a></li>
            </ul>
        </li>
    </ul>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_dept">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">信息管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li role="presentation"><a href="#" class="add_room">机房管理</a></li>
                <li role="presentation"><a href="#" class="add_student">学生账号管理</a></li>
            </ul>
        </li>
    </ul>

    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_dept">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">个人信息管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="#" class="change_password">修改密码</a></li>
            </ul>
        </li>
    </ul>

</div>

<script type="text/javascript">
    //跳转到员工页面
    $(".student_record").click(function () {
        $(this).attr("href", "/admin/chooseStudent");
    });
    // 跳转到部门页面
    $(".room_record").click(function () {
        $(this).attr("href", "/admin/chooseRoom");
    });

    $(".add_room").click(function () {
        $(this).attr("href", "/admin/addRoom")
    });

    $(".add_student").click(function () {
        $(this).attr("href", "/admin/addStudent");
    })

    $(".change_password").click(function () {
        $(this).attr("href", "/admin/changePassword");
    });
</script>

