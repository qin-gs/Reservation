package org.reservation.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class StudentDaoTest {

    @Resource
    private StudentDao studentDao;

    @Test
    public void changePassword() {
        int ans = studentDao.changePassword("12003990101",
                "123456", "654321");
        System.out.println(ans);

    }

    @Test
    public void hasUser() {
        String studentId = "12003990102";
        String password = "123456";
        // System.out.println(studentDao.hasUser(studentId, password));
    }
}