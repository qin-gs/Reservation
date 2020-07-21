<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/7
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生预约记录</title>
</head>
<body>
<div  style="height: 100%">
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <div style="position:relative; top:-15px;">
        <%@ include file="leftsidebar.jsp" %>
        <div class="col-sm-10">

            <div class="form-inline">
                <div class="form-group">
                    <h3 for="studentId">输入查询学号：</h3>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control " placeholder="输入学号" id="studentId">
                </div>
                <div class="form-group">
                    <button class="btn btn-default" id="studentRecord">筛选记录</button>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- 尾部 -->
<%@ include file="../common/foot.jsp" %>
</body>

<script>

    $('#studentRecord').click(function () {
        var studentId = $('#studentId').val();
        if (studentId == '') {
            alert("学号不能为空");
        } else {
            window.location.href = "/admin/" + studentId + "/studentRecord";
        }
    });
</script>

</html>
