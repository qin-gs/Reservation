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
                <span class="glyphicon glyphicon-user" aria-hidden="true">机房预约管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_emp">
                <li role="presentation"><a href="#" class="appoint_position">预约机位</a></li>
                <li role="presentation"><a href="#" class="cancel_appoint">取消预约</a></li>
                <li role="presentation"><a href="#" class="appoint_info">预约记录</a></li>
            </ul>
        </li>
    </ul>
    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_dept">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">个人信息管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li role="presentation"><a href="#" class="dept_info">修改密码</a></li>
            </ul>
        </li>
    </ul>

</div>

<script type="text/javascript">
    //跳转到员工页面
    $(".appoint_position").click(function () {
        $(this).attr("href", "/appointment/listRooms");
    });
    // 跳转到部门页面
    $(".appoint_info").click(function () {
        $(this).attr("href", "/appointment/listRecord");
    });

    $(".cancel_appoint").click(function () {
        $(this).attr("href", "/appointment/cancelAppoint")
    });

    $(".dept_info").click(function () {
        $(this).attr("href", "/changePassword");
    })
</script>

