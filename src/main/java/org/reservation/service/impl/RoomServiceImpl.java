package org.reservation.service.impl;

import org.reservation.dao.RoomDao;
import org.reservation.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomDao roomDao;

    @Override
    public int addRoom(Integer roomId, Integer roomNumbers) {
        return roomDao.addRooms(roomId, roomNumbers);
    }

    @Override
    public int countRooms() {
        return roomDao.countRooms();
    }

    @Override
    public int deleteRoom(Integer roomId) {
        return roomDao.deleteRooms(roomId);
    }
}
