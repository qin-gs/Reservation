package org.reservation.dao;

import org.apache.ibatis.annotations.Param;
import org.reservation.entity.Room;

import java.util.List;

public interface RoomDao {

    /**
     * 列出可用机房
     */
    List<Room> queryAllRooms(@Param("offset") Integer offset,
                             @Param("limit") Integer limit);

    /**
     * 统计机房个数
     */
    int countRooms();

    /**
     * 根据id查询机房
     */
    Room queryRoomById(@Param("roomId") int roomId);

    /**
     * 增加机房(管理员调用)
     */
    int addRooms(@Param("roomId") int roomId,
                 @Param("roomNumber") int roomNumber);

    /**
     * 删除机房(管理员调用)
     */
    int deleteRooms(@Param("roomId") int roomId);
}
