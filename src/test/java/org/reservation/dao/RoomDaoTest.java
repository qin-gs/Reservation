package org.reservation.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.reservation.entity.Room;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class RoomDaoTest {

    @Resource
    private RoomDao roomDao;

    @Test
    public void queryAllRooms() {
        List<Room> rooms = roomDao.queryAllRooms(0, roomDao.countRooms());
        System.out.println(rooms);
    }
}