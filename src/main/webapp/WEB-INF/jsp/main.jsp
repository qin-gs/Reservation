<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>重庆理工大学学生机房预约系统</title>
</head>
<body>
<div>
    <!-- 导航条 -->
    <%@ include file="./common/head.jsp" %>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div style="position:relative; top:-15px;">

        <!-- 左侧栏 -->
        <%@ include file="./common/leftsidebar.jsp" %>

        <!-- 中间轮播图内容 -->
        <div class="col-sm-10">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3 style="text-align: center;">欢迎进入重庆理工大学机房预约系统！</h3>
                </div>
                <div class="panel-body" style="position:relative; top:-15px;">
                    <div id="demo" class="carousel slide" data-ride="carousel">
                        <%--指示符--%>
                        <ol class="carousel-indicators">
                            <li data-target="#demo" data-slide-to="0" class="active"></li>
                            <li data-target="#demo" data-slide-to="1"></li>
                            <li data-target="#demo" data-slide-to="2"></li>
                        </ol>
                        <%--轮播图片--%>
                        <div class="carousel-inner" role="listbox">
                            <div class="item active" style="text-align: center;">
                                <img class="img-responsive center-block" src="/static/img/company1.jpg" alt="company1">
                                <div class="carousel-caption">
                                    <h3>漂亮崭新的机房</h3>
                                </div>
                            </div>
                            <div class="item">
                                <img class="img-responsive center-block" src="/static/img/company2.jpg" alt="company2">
                                <div class="carousel-caption">
                                    <h3>休闲的放松场所</h3>
                                </div>
                            </div>
                            <div class="item">
                                <img class="img-responsive center-block" src="/static/img/company3.jpg" alt="company3">
                                <div class="carousel-caption">
                                    <h3>舒适的学习环境</h3>
                                </div>
                            </div>
                        </div>

                        <!-- 左右切换按钮 -->
                        <a class="left carousel-control" href="#demo" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#demo" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- 尾部 -->
    <%@ include file="./common/foot.jsp" %>
</div>

</body>
</html>
