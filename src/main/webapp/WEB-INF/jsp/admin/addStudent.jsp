<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/8
  Time: 21:50
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>学生信息管理</title>
</head>
<body>
<div>
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <div style="position:relative; top:-15px;">
        <%@ include file="leftsidebar.jsp" %>

        <div role="tabpanel" class="tab-pane">
            <div style="padding: 50px 0;background-color: #fff; text-align: center;width: 420px;margin: 50px auto;">
                <form class="form-horizontal">

                    <div class="form-group" style="height: 50px">
                        <h3>修改学生密码</h3>
                    </div>

                    <div class="form-group" style="height: 37px">
                        <label for="studentId" class="col-xs-4 control-label">请输入学号：</label>
                        <div class="col-xs-5">
                            <input type="text" class="form-control input-sm" id="studentId" placeholder=""
                                   style="margin-top: 7px;">
                        </div>
                    </div>
                    <div class="form-group" style="height: 37px">
                        <label for="password" class="col-xs-4 control-label">请输入新密码：</label>
                        <div class="col-xs-5">
                            <input type="password" class="form-control input-sm" id="password" placeholder=""
                                   style="margin-top: 7px;">
                        </div>
                    </div>

                    <div class="form-group text-right">
                        <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                            <button type="button" class="btn  btn-primary updatePassword">修改</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 尾部 -->
<%@ include file="../common/foot.jsp" %>
</body>

<script>

    $('.updatePassword').click(function () {
        var studentId = $('#studentId').val();
        var password = $('#password').val();

        var reg=/^[\w]{6,16}$/
        if (!password.match(reg)) {
            alert("密码必须为6-16为数字、字母或下划线");
        } else {
            $.ajax({
                url: "/admin/updatePassword",
                data: {'studentId': studentId, 'password': password},
                type: "POST",
                async: false,
                success: function (result) {
                    alert(result.extendInfo.info);
                    window.location.reload();
                }
            });
        }
    });

</script>

</html>
