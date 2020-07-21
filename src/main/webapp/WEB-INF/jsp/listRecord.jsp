<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/4/27
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="dateValue" class="java.util.Date"/>

<html>
<head>
    <title>预约记录</title>
</head>
<body>
<div >
    <!-- 导航条 -->
    <%@ include file="./common/head.jsp" %>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div  style="position:relative; top:-15px;">

        <!-- 左侧栏 -->
        <%@ include file="./common/leftsidebar.jsp" %>

        <!-- 中间员工表格信息展示内容 -->
        <div class="col-sm-10">

            <div class="panel panel-success">
                <!-- 路径导航 -->
                <div class="panel-heading">
                    <ol class="breadcrumb">
                        <li><a href="#">机房预约记录</a></li>
                    </ol>
                </div>
                <!-- Table -->
                <table class="table table-bordered table-hover" id="emp_table">
                    <thead>
                    <th>机房号</th>
                    <th>机房位置</th>
                    <th>使用时间</th>
                    <th>课时</th>
                    <th>预约时间</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${appoints}" var="appoint">
                        <tr>
                            <td>${appoint.roomId}</td>
                            <td>${appoint.roomPosition}</td>

                            <jsp:setProperty name="dateValue" property="time" value="${appoint.appointTime}"/>
                            <td>
                                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>
                            </td>

                            <td>${appoint.classNum}</td>

                            <jsp:setProperty name="dateValue" property="time" value="${appoint.recordTime}"/>
                            <td>
                                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
                    <nav aria-label="Page navigation" class="pull-right">
                        <ul class="pagination">
                            <li><a href="/appointment/listRecord?pageNo=1">首页</a></li>
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
                                            href="/appointment/listRecord?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                                <c:if test="${curPage != itemPage}">
                                    <li><a href="/appointment/listRecord?pageNo=${itemPage}">${itemPage}</a></li>
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
                            <li><a href="/appointment/listRecord?pageNo=${totalPages}">尾页</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
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
                $(this).attr("href", "/appointment/listRecord?pageNo=" + pageNo);
            }
        });
        //下一页
        $(".nextPage").click(function () {
            if (curPage < totalPages) {
                var pageNo = curPage + 1;
                $(this).attr("href", "/appointment/listRecord?pageNo=" + pageNo);
            }
        });
    })

</script>
</body>
</html>

