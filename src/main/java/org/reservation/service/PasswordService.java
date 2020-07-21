package org.reservation.service;

import org.reservation.enums.ChangePasswordStateEnum;

public interface PasswordService {

    /**
     * 学生修改密码
     */
    public ChangePasswordStateEnum changePassword(String studentId, String oldPassword, String newPassword);

    /**
     * 管理员修改密码(管理员调用)
     */
    public ChangePasswordStateEnum changePassword(String studentId, String password);

}
