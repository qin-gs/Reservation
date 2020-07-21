<%--
  Created by IntelliJ IDEA.
  User: qgs
  Date: 2020/5/8
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>添加机房</title>
</head>
<body>
<div >
    <!-- 导航条 -->
    <%@ include file="head.jsp" %>

    <div  style="position:relative; top:-15px;">
        <%@ include file="leftsidebar.jsp" %>
        <div class="col-sm-10">

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
                            <button role="button" class="btn btn-danger delete_room">删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button class="btn btn-primary add_room">添加机房</button>

        </div>


        <div id="roomDetail" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title text-center">
                            <span class="glyphicon glyphicon-studentId"> </span>请输入机房号和机位数量:
                        </h3>
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-8 col-xs-offset-2">
                                <input type="text" name="studentId" id="addRoomId"
                                       placeholder="填写机房号" class="form-control">
                            </div>
                            <div>
                                <br>
                            </div>
                            <div class="col-xs-8 col-xs-offset-2">
                                <input type="text" name="password" id="addRoomNumber"
                                       placeholder="输入机位数量" class="form-control">
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <!--  验证信息 -->
                        <span id="studentMessage" class="glyphicon"> </span>
                        <button type="button" id="addRoomBtn" class="btn btn-success">
                            <span class="glyphicon glyphicon-student"></span>
                            提交
                        </button>
                    </div>
                </div>
            </div>
        </div>


        <!-- 尾部 -->
<%--        <%@ include file="../common/foot.jsp" %>--%>
    </div>
</div>
</body>

<script>

    $(".delete_room").click(function () {
        if (confirm("确认删除该机房吗？删除后不可恢复")) {
            var roomId = $(this).parent().parent().find("td:eq(0)").text();
            $.ajax({
                type: 'POST',
                url: "/admin/" + roomId + "/delete",
                async: false,
                success: function (result) {
                    alert(result.extendInfo.info);
                    window.location.reload();
                }
            });
        }
    });

    $('.add_room').click(function () {
        var roomDetail = $("#roomDetail");
        roomDetail.modal({
            show: true,  // 显示弹出层
            // backdrop: 'static',  // 静止位置关闭
            keyboard: false    // 关闭键盘事件
        });

        $("#addRoomBtn").click(function () {
            var addRoomId = $("#addRoomId").val();
            var addRoomNumber = $('#addRoomNumber').val();

            var regId=/^\d{3}$/
            var regNum = /^\d{2}$/
            if (!addRoomId.match(regId)) {
                alert("请输入正确的机房号 101-699")
            } else if (! addRoomNumber.match(regNum) || regNum < 56) {
                alert("请输入正确的机位数量 56-99");
            } else {
                $.ajax({
                    url: '/admin/addRoom/' + addRoomId + "/" + addRoomNumber,
                    type: 'POST',
                    async: false,
                    success: function (result) {
                        alert(result.extendInfo.info);
                    }
                });
                window.location.reload();
            }
        });
    });

</script>

</html>
