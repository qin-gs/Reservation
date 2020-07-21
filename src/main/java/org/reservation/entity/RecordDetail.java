package org.reservation.entity;

public class RecordDetail {
    private int roomId; // 机房号
    private int roomPosition; // 机房位置
    private String studentId; // 学号
    private long appointTime; // 预约时间  yyyy-MM-dd
    private int classNum; // 第几节课
    private long recordTime; // 记录插入时间 yyyy-MM-dd HH:mm:ss
    private String name; // 姓名
    private String gender; // 性别

    @Override
    public String toString() {
        return "RecordDetail{" +
                "roomId=" + roomId +
                ", roomPosition=" + roomPosition +
                ", studentId='" + studentId + '\'' +
                ", appointTime=" + appointTime +
                ", classNum=" + classNum +
                ", recordTime=" + recordTime +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                '}';
    }

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
