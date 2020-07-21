package org.reservation.service;

import org.reservation.entity.Student;

public interface LoginService {
    /**
     * 通过传过来的账号密码进行登录
     */
    public Student login(String userName, String password);
}
