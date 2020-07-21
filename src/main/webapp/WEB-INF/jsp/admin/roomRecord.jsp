<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/7
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="dateValue" class="java.util.Date"/>

<html>
<head>
    <title>机房预约记录</title>

</head>
<body>
<div>
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <div style="position:relative; top:-15px; height: 100%;">
        <%@ include file="leftsidebar.jsp" %>

        <div class="col-sm-10">
            <div class="form-inline">
                <div class="form-group">
                    <h3>选择机房号：</h3>
                </div>
                <div class="form-group">
                    <select class="form-control  " id="roomNum">
                        <c:forEach items="${rooms}" var="room">
                            <c:if test="${room.roomId == roomId}">
                                <option value=${room.roomId} selected='selected'> ${room.roomId} </option>
                            </c:if>
                            <c:if test="${room.roomId != roomId}">
                                <option value=${room.roomId}> ${room.roomId} </option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <button class="btn btn-default" id="roomRecord">筛选记录</button>
                </div>
            </div>
        </div>


        <div class="col-sm-10">
            <div class="panel panel-success">
                <table class="table table-bordered table-hover" id="data">
                    <thead>
                    <th>机房号</th>
                    <th>机位</th>
                    <th>课时</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>使用时间</th>
                    <th>记录时间</th>
                    </thead>

                    <tbody>
                    <c:forEach items="${recordDetails}" var="recordDetail">
                        <tr>
                            <td>${recordDetail.roomId}</td>
                            <td>${recordDetail.roomPosition}</td>
                            <td>${recordDetail.classNum}</td>
                            <td>${recordDetail.studentId}</td>
                            <td>${recordDetail.name}</td>
                            <td>${recordDetail.gender}</td>

                            <jsp:setProperty name="dateValue" property="time" value="${recordDetail.appointTime}"/>
                            <td>
                                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>
                            </td>

                            <jsp:setProperty name="dateValue" property="time" value="${recordDetail.recordTime}"/>
                            <td>
                                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>


            <div class="panel-body">
                <div class="table_items">
                    当前第<span class="badge">${curPage}</span>页，共有<span class="badge">${totalPages}</span>页，总记录数<span
                        class="badge">${totalItems}</span>条。
                </div>
                <nav aria-label="Page navigation" class="pull-right">
                    <ul class="pagination">
                        <li><a href="javascript:void(0)" onclick="geturl(1)">首页</a></li>
                        <c:if test="${curPage==1}">
                            <li class="disabled">
                                <a href="#" aria-label="Previous" class="prePage">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${curPage!=1}">
                            <li>
                                <a href="#" aria-label="Previous" class="prePage">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages<5?totalPages:5}" step="1" var="itemPage">
                            <c:if test="${curPage == itemPage}">
                                <li class="active"><a href="javascript:void(0)" onclick="geturl(${itemPage})"
                                >${itemPage}</a></li>
                            </c:if>
                            <c:if test="${curPage != itemPage}">
                                <li><a href="javascript:void(0)" onclick="geturl(${itemPage})"
                                >${itemPage}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${curPage==totalPages}">
                            <li class="disabled" class="nextPage">
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${curPage!=totalPages}">
                            <li>
                                <a href="#" aria-label="Next" class="nextPage">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="javascript:void(0)" onclick="geturl(${totalPages})">尾页</a></li>
                    </ul>
                </nav>
            </div>


            <button class="btn btn-default" onclick="exportData()">导出记录</button>

        </div>
        <!-- 尾部 -->
        <%@ include file="../common/foot.jsp" %>
    </div>
</div>
</body>

<script>

    $(function () {
        //上一页
        var curPage = ${curPage};
        var totalPages = ${totalPages};
        var roomNum = $('#roomNum').val()
        $(".prePage").click(function () {
            if (curPage > 1) {
                var pageNo = curPage - 1;
                $(this).attr("href", geturl(pageNo));
            }
        });
        //下一页
        $(".nextPage").click(function () {
            if (curPage < totalPages) {
                var pageNo = curPage + 1;
                $(this).attr("href", geturl(pageNo));
            }
        });
    })

    function studentRecord() {
        var roomNum = $('#roomNum').val();
        if (roomNum == '') {
            alert("机房号不能为空");
        } else {
            window.location.href = "/admin/" + roomNum + "/roomRecord";
        }
    }

    $('#roomRecord').click(function () {
        var roomNum = $('#roomNum').val();
        if (roomNum == '') {
            alert("机房号不能为空");
        } else {
            window.location.href = "/admin/" + roomNum + "/roomRecord";
        }
    });

    function geturl(page) {
        window.location.href = '/admin/' + $('#roomNum').val() + "/roomRecord?pageNo=" + page;
    }

    function exportData() {
        var roomNum = $('#roomNum').val();
        // window.location.href = "/admin/" + roomNum + "/exportRoomData";
        $.ajax({
            url: "/admin/" + roomNum + "/exportRoomData",
            type: "POST",
            async: false,
            success: function (result) {
                alert(result.extendInfo.info);
            }
        });
    }

</script>

</html>
