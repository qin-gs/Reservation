<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/25
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>机房预约详情</title>
</head>
<body>

<div>
    <!-- 导航条 -->
    <%@ include file="./common/head.jsp" %>

    <div style="position:relative; top:-15px;">
        <%@ include file="./common/leftsidebar.jsp" %>

        <div class="form-inline">
            <div class="form-group">
                <span>机房号</span>
                <select class="form-control" id="roomNum">
                    <c:forEach items="${rooms}" var="room">
                        <c:if test="${room.roomId == roomId}">
                            <option value=${room.roomId} selected="selected"> ${room.roomId} </option>
                        </c:if>
                        <c:if test="${room.roomId != roomId}">
                            <option value=${room.roomId}> ${room.roomId} </option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <span>预约时间</span>
                <select class="form-control" id="appointTime">
                    <option class="first"></option>
                    <option class="second"></option>
                    <option class="third"></option>
                    <option class="forth"></option>
                    <option class="fifth"></option>
                    <option class="sixth"></option>
                </select>
            </div>
            <div class="form-group">
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <span>预约课时</span>
                <select class="form-control" id="classNum">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
            </div>

            <div class="form-group">
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <button class="btn btn-primary getPositions">筛选</button>
            </div>


        </div>

    </div>

    <!-- 尾部 -->
<%--    <%@ include file="./common/foot.jsp" %>--%>
</body>

<script>
    /*获取当天日期*/
    function getStartDay() {
        var mydate = new Date();
        var y = mydate.getFullYear();
        var m = mydate.getMonth() + 1;
        var d = mydate.getDate();
        if (m < 10) {
            m = "0" + m;
        }
        if (d < 10) {
            d = "0" + d;
        }
        return y + "-" + m + "-" + d;
    }

    /*获取后面日期*/
    function getNextDay(d, n) {
        d = new Date(d);
        d = +d + 1000 * 60 * 60 * 24 * n;
        d = new Date(d);
        var y = d.getFullYear();
        var m = d.getMonth() + 1;
        d = d.getDate();
        if (m < 10) {
            m = "0" + m;
        }
        if (d < 10) {
            d = "0" + d;
        }
        return y + "-" + m + "-" + d;
    }

    $('.first').text(getStartDay());
    $('.second').text(getNextDay(getStartDay(), 1));
    $('.third').text(getNextDay(getStartDay(), 2));
    $('.forth').text(getNextDay(getStartDay(), 3));
    $('.fifth').text(getNextDay(getStartDay(), 4));
    $('.sixth').text(getNextDay(getStartDay(), 5));

    $('.getPositions').click(function () {
        var roomId = $("#roomNum").val();
        var classNums = $("#classNum").val();
        var appointTime = $("#appointTime").val();
        window.location.href = "/appointment/" + roomId + "/" + appointTime + "/" + classNums + "/detail";
    });


</script>

</html>
