package org.reservation.service.impl;

import org.reservation.dao.StudentDao;
import org.reservation.entity.Student;
import org.reservation.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private StudentDao studentDao;

    /**
     * 数据库并不保存明文，只保存md5值
     */
    @Override
    public Student login(String userName, String password) {

        Student student = studentDao.hasUserAdmin(userName);
        if (student == null)
            return null;
        if (getMd5(password, student.getSlat()).equals(student.getPassword())) {
            return student;
        } else {
            return null;
        }
    }

    private String getMd5(String password, String slat) {
        String s = password + slat;
        String md5 = DigestUtils.md5DigestAsHex(s.getBytes());

        System.out.print(slat);
        System.out.println(" " + md5);
        return md5;
    }
}
