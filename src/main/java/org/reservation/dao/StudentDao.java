package org.reservation.dao;

import org.apache.ibatis.annotations.Param;
import org.reservation.entity.Student;

public interface StudentDao {

    /**
     * 修改密码
     */
    int changePassword(@Param("studentId") String studentId,
                       @Param("newPassword") String newPassword,
                       @Param("slat") String slat);


    /**
     * 是否存在该用户(管理员调用)
     */
    Student hasUserAdmin(@Param("studentId") String studentId);

    /**
     * 判断是不是管理员
     */
    int isAdmin(@Param("studentId") String studentId);
}
