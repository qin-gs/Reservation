package org.reservation.dto;

import org.reservation.entity.Appointment;
import org.reservation.enums.AppointStateEnum;

/**
 * 预约执行后的结果
 */
public class AppointmentExecution {

    private int roomId;
    private int roomPosition;

    private AppointStateEnum state;
    private String stateInfo;
    private Appointment appointment;

    public AppointmentExecution(int roomId, int roomPosition, AppointStateEnum state) {
        this.roomId = roomId;
        this.roomPosition = roomPosition;
        this.state = state;
        this.stateInfo = state.getStateInfo();
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

    public AppointStateEnum getState() {
        return state;
    }

    public void setState(AppointStateEnum state) {
        this.state = state;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public void setStateInfo(String stateInfo) {
        this.stateInfo = stateInfo;
    }

    @Override
    public String toString() {
        return "AppointmentExecution{" +
                "roomId=" + roomId +
                ", roomPosition=" + roomPosition +
                ", state=" + state +
                ", stateInfo='" + stateInfo + '\'' +
                '}';
    }
}
