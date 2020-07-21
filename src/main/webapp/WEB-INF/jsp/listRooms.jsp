<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/25
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>可用机房列表</title>
</head>
<body>
<div>
    <!-- 导航条 -->
    <%@ include file="./common/head.jsp" %>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div style="position:relative; top:-15px;">

        <!-- 左侧栏 -->
        <%@ include file="./common/leftsidebar.jsp" %>

        <!-- 中间员工表格信息展示内容 -->
        <div class="col-sm-10">

            <div class="panel panel-success">
                <!-- 路径导航 -->
                <div class="panel-heading">
                    <ol class="breadcrumb">
                        <li><a href="#">机房详情展示</a></li>
                    </ol>
                </div>
                <!-- Table -->
                <table class="table table-bordered table-hover" >
                    <thead>
                    <th>机房号</th>
                    <th>机位数量</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${rooms}" var="room">
                        <tr>
                            <td>${room.roomId}</td>
                            <td>${room.roomNumber}</td>
                            <td>
                                <button role="button" class="btn btn-primary room_detail">预约
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="panel-body">
                    <div class="table_items">
                        当前第<span class="badge">${curPage}</span>页，共有<span class="badge">${totalPages}</span>页，总记录数<span
                            class="badge">${totalItems}</span>条。
                    </div>
                    <nav aria-label="Page navig ation" class="pull-right">
                        <ul class="pagination">
                            <li><a href="/appointment/listRooms?pageNo=1">首页</a></li>
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
                                    <li class="active"><a
                                            href="/appointment/listRooms?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                                <c:if test="${curPage != itemPage}">
                                    <li><a href="/appointment/listRooms?pageNo=${itemPage}">${itemPage}</a></li>
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
                            <li><a href="/appointment/listRooms?pageNo=${totalPages}">尾页</a></li>
                        </ul>
                    </nav>
                </div>
            </div><!-- /.panel panel-success -->
        </div>

        <!-- 尾部 -->
        <%@ include file="./common/foot.jsp" %>
    </div>
</div>

<script>
    $(function () {
        //上一页
        var curPage = ${curPage};
        var totalPages = ${totalPages};
        $(".prePage").click(function () {
            if (curPage > 1) {
                var pageNo = curPage - 1;
                $(this).attr("href", "/appointment/listRooms?pageNo=" + pageNo);
            }
        });
        //下一页
        $(".nextPage").click(function () {
            if (curPage < totalPages) {
                var pageNo = curPage + 1;
                $(this).attr("href", "/appointment/listRooms?pageNo=" + pageNo);
            }
        });
    })

    <!-- ==========================选择机房预约=================================== -->
    $(".room_detail").click(function () {
        var roomId = $(this).parent().parent().find("td:eq(0)").text();
        // $(this).attr("href", "/appointment/" + roomId + "/choose");
        window.location.href = "/appointment/" + roomId + "/choose";
    });


</script>
</body>
</html>

