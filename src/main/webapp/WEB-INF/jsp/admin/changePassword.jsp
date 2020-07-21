<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/27
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
</head>
<body>

<div >
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <div style="position:relative; top:-15px;">
        <%@ include file="leftsidebar.jsp" %>

        <div role="tabpanel" class="tab-pane">
            <div style="padding: 50px 0;background-color: #fff; text-align: center;width: 420px;margin: 50px auto;">
                <form class="form-horizontal">

                    <div class="form-group" style="height: 50px">
                        <h3>修改密码</h3>
                    </div>

                    <div class="form-group" style="height: 37px">
                        <label for="oldPassword" class="col-xs-4 control-label">请输入原始密码：</label>
                        <div class="col-xs-5">
                            <input type="password" class="form-control input-sm duiqi" id="oldPassword" placeholder=""
                                   style="margin-top: 7px;">
                        </div>
                    </div>
                    <div class="form-group" style="height: 37px">
                        <label for="newPassword" class="col-xs-4 control-label">请输入新密码：</label>
                        <div class="col-xs-5">
                            <input type="password" class="form-control input-sm duiqi" id="newPassword" placeholder=""
                                   style="margin-top: 7px;">
                        </div>
                    </div>
                    <div class="form-group" style="height: 37px">
                        <label for="newPassword2" class="col-xs-4 control-label">再次输入新密码：</label>
                        <div class="col-xs-5">
                            <input type="password" class="form-control input-sm duiqi" id="newPassword2" placeholder=""
                                   style="margin-top: 7px;">
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                            <button type="button" class="btn  btn-primary changePassword">修改</button>
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
    $(".changePassword").click(function () {

        var newP1 = $("input[id='newPassword']").val();
        var newP2 = $("input[id='newPassword2']").val();

        var reg=/^[\w]{6,16}$/
        if (newP1 != newP2) {
            alert("两次新密码不相同，请重新输入");
        } else if (!newP1.match(reg)) {
            alert("密码必须为6-16位，由数字、字母或下划线组成，请重新输入");
        } else {

            $.ajax({
                url: "/admin/changePassword",
                type: "POST",
                data: {
                    newPassword: $("input[id='newPassword']").val(),
                    oldPassword: $("input[id='oldPassword']").val()
                },
                dataType: 'json',
                async: false,
                success: function (result) {

                    if (result.code == 100) {
                        alert(result.extendInfo.info);
                        $(window).attr("location", "/reservation/logout");
                    } else {
                        alert(result.extendInfo.info);
                    }

                }
            });
        }
    });
</script>

<style type="text/css">


    .form-horizontal .form-group {
        margin-right: -100px !important;
    }


</style>


</html>

