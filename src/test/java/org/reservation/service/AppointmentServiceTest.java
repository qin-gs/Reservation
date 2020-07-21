package org.reservation.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.ParseException;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml", "classpath:spring/spring-service.xml"})
public class AppointmentServiceTest {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private AppointmentService appointmentService;

    @Test
    public void queryAllRooms() {
        // List<Room> rooms = appointmentService.queryAllRooms(0, room);
        // System.out.println(rooms);
    }

    @Test
    public void appointment() throws ParseException {
        // (101, 1, '12003990101', 1, '2020-04-17', '2020-04-16 10:11:12');
        // long appointmentTime = System.currentTimeMillis();
        // long recodeTime = System.currentTimeMillis();
        // try {
        //     AppointmentExecution ans = appointmentService.appointment(101, 1, "12003990101", 1, appointmentTime, recodeTime);
        //     System.out.println(ans);
        // } catch (Exception e) {
        //     e.printStackTrace();
        // }
    }

    @Test
    public void cancelAppointment() throws ParseException {
        // (101, 1, '12003990101', 1, '2020-04-17', '2020-04-16 10:11:12')
        long appointmentTime = System.currentTimeMillis();
        int ans = appointmentService.cancelAppointment(101, 1, "12003990101", 1, appointmentTime);
        System.out.println(ans);
    }

    @Test
    public void queryBeforeAppointment() {
        // long nowTime = System.currentTimeMillis();
        // List<Appointment> list = appointmentService.queryBeforeAppointment("12003990101", nowTime);
        // System.out.println(list);
    }

    @Test
    public void queryFutureAppointment() throws ParseException {
        // SimplelongFormat sdf = new SimplelongFormat("yyyy-MM-dd");
        // long nowTime = sdf.parse(String.valueOf(new long()));
        // List<Appointment> list = appointmentService.queryFutureAppointment("12003990101", System.currentTimeMillis());
        // System.out.println(list);
    }

    @Test
    public void changePassword() {
        // int ans = appointmentService.changePassword("12003990101", "654321", "123456");
        // System.out.println(ans);
    }

}