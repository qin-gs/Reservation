<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/7
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>学生预约记录</title>
</head>
<body>
<div style="height: 100%">
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <div style="position:relative; top:-15px;">
        <%@ include file="leftsidebar.jsp" %>
        <div class="col-sm-10">

            <div class="form-inline">
                <div class="form-group">
                    <h3>选择机房号：</h3>
                </div>
                <div class="form-group">
                    <select class="form-control" id="roomNum">
                        <c:forEach items="${rooms}" var="room">
                            <option value=${room.roomId}> ${room.roomId} </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <button class="btn btn-default" id="roomRecord">筛选记录</button>
                </div>
            </div>

        </div>
        <!-- 尾部 -->
    </div>
</div>
<%@ include file="../common/foot.jsp" %>
</body>

<script>

    $('#roomRecord').click(function () {
        var roomNum = $('#roomNum').val();
        if (roomNum == '') {
            alert("机房号不能为空");
        } else {
            window.location.href = "/admin/" + roomNum + "/roomRecord";
        }
    });
</script>

</html>
