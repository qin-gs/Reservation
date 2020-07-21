package org.reservation.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.reservation.entity.Appointment;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class AppointmentDaoTest {

    @Resource
    private AppointmentDao appointmentDao;

    @Test
    public void insertRecord() throws ParseException {
        long appointTime = System.currentTimeMillis();

        long recodeTime = System.currentTimeMillis();

        int ans = appointmentDao.insertRecord(102, 1, "12003990101", 1, appointTime, recodeTime);
        System.out.println(ans);
    }

    @Test
    public void deleteRecord() throws ParseException {
        long appointTime = System.currentTimeMillis();

        int ans = appointmentDao.deleteRecord(102, 1, "12003990101", 1, appointTime);
        System.out.println(ans);
    }

    @Test
    public void queryBeforeAppointment() {
        // long nowTime = System.currentTimeMillis();
        // List<Appointment> list = appointmentDao.queryBeforeAppointment("12003990101", nowTime);
        // System.out.println(list);
    }

    @Test
    public void queryFutureAppointment() throws ParseException {
        // long nowTime = System.currentTimeMillis();
        // // long time = new long();
        // List<Appointment> list = appointmentDao.queryFutureAppointment("12003990101", nowTime);
        // System.out.println(list);
    }

    @Test
    public void queryTwoPosition() throws ParseException {
        String studentId = "12003990101";
        int classNum = 1;
        long appointTime = System.currentTimeMillis();

        int ans = appointmentDao.queryTwoPosition(studentId, classNum, appointTime);
        System.out.println(ans);

    }

    @Test
    public void queryIsAppoint() throws ParseException {
        int roomId = 101;
        int roomPosition = 1;
        int classNum = 1;
        long appointTime = System.currentTimeMillis();
        int ans = appointmentDao.queryIsAppoint(roomId, roomPosition, classNum, appointTime);
        System.out.println(ans);
    }

    @Test
    public void queryUsedPosition() throws ParseException {
        long time = System.currentTimeMillis();
        List<Integer> list = appointmentDao.queryUsedPosition(101, time, 1);
        System.out.println(list);
    }

    @Test
    public void queryRoomAppointment() {
        // int roomId = 101;
        // System.out.println(appointmentDao.queryRoomAppointment(roomId));
    }
}