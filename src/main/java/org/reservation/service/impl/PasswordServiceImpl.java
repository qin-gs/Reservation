package org.reservation.service.impl;

import org.reservation.dao.StudentDao;
import org.reservation.entity.Student;
import org.reservation.enums.ChangePasswordStateEnum;
import org.reservation.service.PasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

@Service
public class PasswordServiceImpl implements PasswordService {

    @Autowired
    private StudentDao studentDao;


    @Override
    public ChangePasswordStateEnum changePassword(String studentId, String oldPassword, String newPassword) {
        Student student = studentDao.hasUserAdmin(studentId); // 判断是否存在用户
        if (student == null) // 用户不存在
            return ChangePasswordStateEnum.NO_USER;
        // 原始密码不对
        if (!getMd5(oldPassword, student.getSlat()).equals(student.getPassword())) {
            return ChangePasswordStateEnum.PASSWORD_ERROR;
        }
        String slat = getSlat();
        int ans = studentDao.changePassword(studentId, getMd5(newPassword, slat), slat);
        if (ans == 1) {
            return ChangePasswordStateEnum.SUCCESS;
        } else {
            return ChangePasswordStateEnum.INNER_ERROR;
        }
    }

    /**
     * 随机生成盐值
     */
    private String getSlat() {
        String all = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuffer sb = new StringBuffer(16);
        for (int i = 0; i < 16; i++) {
            sb.append(all.charAt((int) (Math.random() * all.length())));
        }
        return sb.toString();
    }

    /**
     * 生成md5
     */
    private String getMd5(String password, String slat) {
        String s = password + slat;
        String md5 = DigestUtils.md5DigestAsHex(s.getBytes());
        return md5;
    }

    @Override
    public ChangePasswordStateEnum changePassword(String studentId, String password) {
        Student student = studentDao.hasUserAdmin(studentId);
        if (student == null) { // 用户不存在
            return ChangePasswordStateEnum.NO_USER;
        }
        if (student.getIsAdmin() == 1) { // 权限错误
            return ChangePasswordStateEnum.PERMISSION_ERROR;
        }

        String slat = getSlat();
        int ans = studentDao.changePassword(studentId, getMd5(password, slat), slat);
        if (ans == 1) {
            return ChangePasswordStateEnum.SUCCESS;
        } else {
            return ChangePasswordStateEnum.INNER_ERROR;
        }
    }


}
