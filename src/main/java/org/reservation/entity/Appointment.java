package org.reservation.entity;

/**
 * 预约记录
 */
public class Appointment {
    private int roomId; // 机房号
    private int roomPosition; // 机房位置
    private String studentId; // 学号
    private long appointTime; // 预约时间  yyyy-MM-dd
    private int classNum; // 第几节课
    private long recordTime; // 记录插入时间 yyyy-MM-dd HH:mm:ss

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getRoomPosition() {
        return roomPosition;
    }

    public void setRoomPosition(int roomPosition) {
        this.roomPosition = roomPosition;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public long getAppointTime() {
        return appointTime;
    }

    public void setAppointTime(long appointTime) {
        this.appointTime = appointTime;
    }

    public int getClassNum() {
        return classNum;
    }

    public void setClassNum(int classNum) {
        this.classNum = classNum;
    }

    public long getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(long recordTime) {
        this.recordTime = recordTime;
    }

    @Override
    public String toString() {
        return "Appointment{" +
                "roomId=" + roomId +
                ", roomPosition=" + roomPosition +
                ", studentId='" + studentId + '\'' +
                ", appointTime=" + appointTime +
                ", classNum=" + classNum +
                ", recodeTime=" + recordTime +
                '}';
    }
}
