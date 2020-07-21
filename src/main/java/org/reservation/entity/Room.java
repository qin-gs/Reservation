package org.reservation.entity;

/**
 * 机房
 */
public class Room {
    private int roomId; // 机房号
    private int roomNumber; // 机房中的座位数

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomId=" + roomId +
                ", number=" + roomNumber +
                '}';
    }
}
