package org.reservation.service;

public interface RoomService {
    /**
     * 增加机房 (管理员调用)
     */
    int addRoom(Integer roomId, Integer roomNumbers);

    /**
     * 统计机房个数
     */
    int countRooms();

    /**
     * 移除机房
     */
    int deleteRoom(Integer roomId);
}
