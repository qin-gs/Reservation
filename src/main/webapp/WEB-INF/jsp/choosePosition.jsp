<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/29
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>选择机房位置</title>
</head>
<body>

<div class="hrms_container">
    <!-- 导航条 -->
    <%@ include file="./common/head.jsp" %>

    <div class="hrms_body" style="position:relative; top:-15px;">
        <%@ include file="./common/leftsidebar.jsp" %>

        <div class="form-inline panel-success col-sm-10" style="margin-top: 20px;">
            <div class="form-group">
                <span for="name">机房号</span>
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
                <span for="name">预约时间</span>
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
                <span for="name">预约课时</span>
                <select class="form-control" id="classNum">
                    <option value="1" class="classNum1">1</option>
                    <option value="2" class="classNum2">2</option>
                    <option value="3" class="classNum3">3</option>
                    <option value="4" class="classNum4">4</option>
                    <option value="5" class="classNum5">5</option>
                </select>
            </div>

            <div class="form-group">
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <button class="btn btn-primary get_position">筛选</button>
            </div>
        </div>

        <div class="position col-sm-10">
            <h3>选择座位:</h3>
            <c:if test="${roomNum <= 60}">
                <c:forEach begin="1" end="${roomNum}" var="x">
                    <c:if test="${(x-1) % 8 == 0}">
                        <br><br>第
                        <fmt:formatNumber type="number" value="${(x - 1) / 8 + 1}" maxFractionDigits="0"/>
                        行:
                    </c:if>
                    <c:if test="${(x - 1) % 4 == 0}">
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    </c:if>
                    <c:if test="${usedPosition.contains(x)}">
                        <c:if test="${x < 10}">
                            <button class="btn btn-default" disabled>0${x}</button>
                        </c:if>
                        <c:if test="${x >= 10}">
                            <button class="btn btn-default" disabled>${x}</button>
                        </c:if>
                    </c:if>
                    <c:if test="${!usedPosition.contains(x)}">
                        <c:if test="${x < 10}">
                            <button class="btn btn-default" id="choose_position" onclick="appointPosition(this)"
                                    value="${x}">0${x}</button>
                        </c:if>
                        <c:if test="${x >= 10}">
                            <button class="btn btn-default" id="choose_position" onclick="appointPosition(this)"
                                    value="${x}">${x}</button>
                        </c:if>

                    </c:if>

                </c:forEach>
            </c:if>

            <c:if test="${roomNum > 60}">
                <c:forEach begin="1" end="${roomNum}" var="x">
                    <c:if test="${(x-1) % 10 == 0}">
                        <br><br>第
                        <fmt:formatNumber type="number" value="${(x - 1) / 8 + 1}" maxFractionDigits="0"/>
                        行:
                    </c:if>
                    <c:if test="${(x - 1) % 5 == 0}">
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    </c:if>
                    <c:if test="${usedPosition.contains(x)}">
                        <c:if test="${x < 10}">
                            <button class="btn btn-default" disabled>0${x}</button>
                        </c:if>
                        <c:if test="${x >= 10}">
                            <button class="btn btn-default" disabled>${x}</button>
                        </c:if>
                    </c:if>
                    <c:if test="${!usedPosition.contains(x)}">
                        <c:if test="${x < 10}">
                            <button class="btn btn-default" id="choose_position" onclick="appointPosition(this)"
                                    value="${x}">0${x}</button>
                        </c:if>
                        <c:if test="${x >= 10}">
                            <button class="btn btn-default" id="choose_position" onclick="appointPosition(this)"
                                    value="${x}">${x}</button>
                        </c:if>

                    </c:if>

                </c:forEach>
            </c:if>

        </div>
        <%--        </div>--%>

    </div>

    <!-- 尾部 -->
    <%@ include file="./common/foot.jsp" %>
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
        var d = d.getDate();
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

    if (getStartDay() == "${appointTime}") {
        document.getElementsByClassName("first")[0].setAttribute("selected", "true");
    }
    if (getNextDay(getStartDay(), 1) == "${appointTime}") {
        document.getElementsByClassName("second")[0].setAttribute("selected", "true");
    }
    if (getNextDay(getStartDay(), 2) == "${appointTime}") {
        document.getElementsByClassName("third")[0].setAttribute("selected", "true");
    }
    if (getNextDay(getStartDay(), 3) == "${appointTime}") {
        document.getElementsByClassName("forth")[0].setAttribute("selected", "true");
    }
    if (getNextDay(getStartDay(), 4) == "${appointTime}") {
        document.getElementsByClassName("fifth")[0].setAttribute("selected", "true");
    }
    if (getNextDay(getStartDay(), 5) == "${appointTime}") {
        document.getElementsByClassName("sixth")[0].setAttribute("selected", "true");
    }


    if ($('.classNum1').text() == ${classNum}) {
        document.getElementsByClassName("classNum1")[0].setAttribute("selected", "true");
    }
    if ($('.classNum2').text() == ${classNum}) {
        document.getElementsByClassName("classNum2")[0].setAttribute("selected", "true");
    }
    if ($('.classNum3').text() == ${classNum}) {
        document.getElementsByClassName("classNum3")[0].setAttribute("selected", "true");
    }
    if ($('.classNum4').text() == ${classNum}) {
        document.getElementsByClassName("classNum4")[0].setAttribute("selected", "true");
    }
    if ($('.classNum5').text() == ${classNum}) {
        document.getElementsByClassName("classNum5")[0].setAttribute("selected", "true");
    }


    $('.get_position').click(function () {
        var roomId = $("#roomNum").val();
        var classNums = $("#classNum").val();
        var appointTime = $("#appointTime").val();
        window.location.href = "/appointment/" + roomId + "/" + appointTime + "/" + classNums + "/detail";
    });

    function appointPosition_(t) {
        var x = t.value;
        var roomId = $("#roomNum").val();
        var appointTime = $("#appointTime").val();
        var classNums = $("#classNum").val();
        // alert(x + " " + roomId + " " + appointTime + " " + classNums);

        if (confirm("确认预约该座位吗？")) {

            $.ajax({
                url: "/appointment/appointPosition",
                type: 'POST',
                async: false,
                data: {"position": x, "roomId": roomId, "appointTime": appointTime, "classNum": classNums},
                success: function (result) {
                    if (result['data']['state'] == "LOGIN_ERROR") {
                        alert("请先登录再进行操作");
                        window.location.href = "/reservation/logout";
                    } else {
                        alert(result['data']['stateInfo']);
                        window.location.reload();
                    }
                }
            });
        }
    }


    function appointPosition(t) {

        if (document.cookie.indexOf("username") == -1) {
            alert("请先登录再进行操作");
            window.location.href = "/reservation/logout";
            return;
        }

        if (confirm("确认预约该座位吗？")) {

            var x = t.value;
            var roomId = $("#roomNum").val();
            var appointTime = $("#appointTime").val();
            var classNums = $("#classNum").val();

            $.ajax({
                url: "/appointment/appointPosition",
                type: 'POST',
                async: false,
                data: {
                    "position": x,
                    "roomId": roomId,
                    "appointTime": appointTime,
                    "classNum": classNums,
                },
                success: function (result) {
                    if (result['stateInfo'] == "LOGIN_ERROR") {
                        alert("请先登录再进行操作");
                        window.location.href = "/reservation/logout";
                    } else {
                        alert(result['data']['stateInfo']);
                        window.location.reload();
                    }
                }
            });
        }
    }

</script>

</html>
