<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/25
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/ionicons/2.0.1/css/ionicons.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="//cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>

    <script src="https://cdn.staticfile.org/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

</head>
<body>

<div class="container">
    <div class="col-md-4 col-md-offset-4" style="margin: 200px 380px">
        <div class="login-panel panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title" style="text-align: center;">登录</h3>
            </div>
            <div class="panel-body">
                <form role="form" action="#" method="post" id="login_form">
                    <fieldset>
                        <div class="form-group">
                            <input class="form-control" placeholder="请输入学号" name="username" id="username" autofocus>
                        </div>
                        <div class="form-group">
                            <input class="form-control" placeholder="请输入密码" name="password" type="password"
                                   value="">
                        </div>
                        <!-- Change this to a button or input when using this as a form -->
                        <a href="javascript:void(0)" class="btn btn-lg btn-success btn-block" id='login_btn'>登录</a>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(function () {
        $("#login_btn").click(function () {
            $.ajax({
                url: "/reservation/identify",
                type: "POST",
                async: false,
                data: $("#login_form").serialize(),
                success: function (result) {
                    if (result.code == 100) {
                        $.cookie('username', $('#username').val(), {path: "/"})
                        $.cookie('is_admin', result.extendInfo.isAdmin, {path: "/"})
                        if (result.extendInfo.isAdmin == 0) {
                            window.location.href = "/reservation/main";
                        } else {
                            window.location.href = "/admin/main";
                        }
                    } else {
                        alert(result.extendInfo.login_error);
                    }
                }
            });
        });
    })
    ;
</script>
</body>
</html>
