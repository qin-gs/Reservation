package org.reservation.service;

import org.reservation.dto.AppointmentExecution;
import org.reservation.entity.Appointment;
import org.reservation.entity.RecordDetail;
import org.reservation.entity.Room;
import org.reservation.exception.AlreadyAppointException;
import org.reservation.exception.RepeatAppointException;

import java.util.List;

/**
 * Service层主要负责业务模块的逻辑应用设计
 * 站在使用者的角度设计(经验不足，有待优化)
 */
public interface AppointmentService {

    /**
     * 列出所有可用机房
     */
    List<Room> queryAllRooms(int offset, int limit);

    /**
     * 执行预约功能
     */
    AppointmentExecution appointment(int roomId,
                                     int roomPosition,
                                     String studentId,
                                     int classNum,
                                     long appointTime,
                                     long recodeTime)
            throws RepeatAppointException, AlreadyAppointException, RuntimeException;

    /**
     * 取消预约
     */
    int cancelAppointment(int roomId,
                          int roomPosition,
                          String studentId,
                          int classNum,
                          long appointTime);

    /**
     * 查看自己的曾经预约记录
     */
    List<Appointment> queryBeforeAppointment(String studentId,
                                             long nowTime,
                                             int offset,
                                             int limit);

    /**
     * 查看将来的预约记录
     */
    List<Appointment> queryFutureAppointment(String studentId,
                                             long nowTime,
                                             int offset,
                                             int limit);

    /**
     * 查看将来的预约记录个数
     */
    int queryFutureAppointNum(String studentId,
                              long nowTime);

    /**
     * 修改密码
     */
    int changePassword(String studentId,
                       String oldPassword,
                       String newPassword);

    /**
     * 查询机房所有已经被预约的位置
     */
    List<Integer> queryUsedPosition(int roomId,
                                    long appointTime,
                                    int classNum);

    /**
     * 根据机房id查询机房
     */
    Room queryRoomById(int roomId);

    /**
     * 查询学生预约记录
     */
    int queryAppointNum(String studentId, long nowTime);

    /**
     * 查询某个机房的所有预约情况(管理员调用)
     */
    public List<RecordDetail> queryRoomAppointment(Integer roomId, int offset, int limit);

    /**
     * 查询机房预约记录个数
     */
    int queryRoomAppointNum(int roomId);

    /**
     * 导出机房记录
     */
    int exportRoomData(int roomId);

    /**
     * 导出学生预约记录
     */
    int exportStudentData(String studentId);


}
