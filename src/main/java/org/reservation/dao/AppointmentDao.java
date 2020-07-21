package org.reservation.dao;

import org.apache.ibatis.annotations.Param;
import org.reservation.entity.Appointment;
import org.reservation.entity.RecordDetail;

import java.util.List;

public interface AppointmentDao {
    /**
     * 插入预约记录
     */
    int insertRecord(@Param("roomId") int roomId,
                     @Param("roomPosition") int roomPosition,
                     @Param("studentId") String studentId,
                     @Param("classNum") int classNum,
                     @Param("appointTime") long appointTime,
                     @Param("recordTime") long recodeTime);

    /**
     * 删除预约记录
     */
    int deleteRecord(@Param("roomId") int roomId,
                     @Param("roomPosition") int roomPosition,
                     @Param("studentId") String studentId,
                     @Param("classNum") int classNum,
                     @Param("appointTime") long appointTime);

    /**
     * 查看自己的曾经预约记录
     */
    List<Appointment> queryBeforeAppointment(@Param("studentId") String studentId,
                                             @Param("nowTime") long nowTime,
                                             @Param("offset") int offset,
                                             @Param("limit") int limit);

    /**
     * 查看将来的预约记录
     */
    List<Appointment> queryFutureAppointment(@Param("studentId") String studentId,
                                             @Param("nowTime") long nowTime,
                                             @Param("offset") Integer offset,
                                             @Param("limit") Integer limit);

    /**
     * 查询将来的预约记录个数
     */
    int queryFutureAppointNum(@Param("studentId") String studentId,
                              @Param("nowTime") long nowTime);

    /**
     * 查看某天，某节课 同一个人是否预约了两个座位
     */
    int queryTwoPosition(@Param("studentId") String studentId,
                         @Param("classNum") int classNum,
                         @Param("appointTime") long appointTime);

    /**
     * 查询某一天某一节课某个机房某个位置是否已经被预约
     */
    int queryIsAppoint(@Param("roomId") int roomId,
                       @Param("roomPosition") int roomPosition,
                       @Param("classNum") int classNum,
                       @Param("appointTime") long appointTime);

    /**
     * 查询机房所有已经被预约的位置
     */
    List<Integer> queryUsedPosition(@Param("roomId") int roomId,
                                    @Param("appointTime") long appointTime,
                                    @Param("classNum") int classNum);

    /**
     * 查询所有的预约记录
     */
    List<Appointment> queryAllAppointment(@Param("studentId") String studentId,
                                          @Param("offset") Integer offset,
                                          @Param("limit") Integer limit,
                                          @Param("nowTime")long nowTime);

    /**
     * 查询学生预约记录
     */
    int queryAppointNum(@Param("studentId") String studentId,
                        @Param("nowTime")long nowTime);

    /**
     * 查询机房的预约记录(管理员查询)
     */
    List<RecordDetail> queryRoomAppointment(@Param("roomId") Integer roomId,
                                            @Param("offset") Integer offset,
                                            @Param("limit") Integer limit);

    /**
     * 查询预约记录(管理员查询)
     */
    List<Appointment> queryAdminAppointment(@Param("roomId") int roomId,
                                            @Param("roomPosition") int roomPosition,
                                            @Param("studentId") String studentId,
                                            @Param("classNum") int classNum,
                                            @Param("appointTime") long appointTime);

    /**
     * 查询某个机房的预约记录个数
     */
    int queryRoomAppointNum(@Param("roomId") int roomId);
}