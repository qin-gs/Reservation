package org.reservation.enums;

/**
 * 修改密码的状态
 */
public enum ChangePasswordStateEnum {
    SUCCESS(1, "密码修改成功"),
    NO_USER(-1, "用户不存在"),
    PASSWORD_ERROR(-2, "原始密码错误"),
    PERMISSION_ERROR(-3, "权限错误"),
    INNER_ERROR(-4, "服务器内部错误");

    private int stateCode;
    private String stateInfo;

    ChangePasswordStateEnum(int state, String stateInfo) {
        this.stateCode = state;
        this.stateInfo = stateInfo;
    }

    public int getStateCode() {
        return stateCode;
    }

    public void setStateCode(int stateCode) {
        this.stateCode = stateCode;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public void setStateInfo(String stateInfo) {
        this.stateInfo = stateInfo;
    }

    public static ChangePasswordStateEnum stateOf(int index) {
        for (ChangePasswordStateEnum state : values()) {
            if (state.getStateCode() == index)
                return state;
        }
        return null;
    }
}
