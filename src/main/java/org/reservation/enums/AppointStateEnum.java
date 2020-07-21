package org.reservation.enums;

/**
 * 各种预约状态
 */
public enum AppointStateEnum {
    SUCCESS(1, "预约成功"),
    REPEAT_APPOINT(-1, "请勿同一时间重复预约两个座位"),
    ALREADY_APPOINT(-2, "该座位已经被预约"),
    INNER_ERROR(-3, "内部错误"),
    LOGIN_ERROR(-4, "未登录");

    private int stateCode;
    private String stateInfo;

    AppointStateEnum(int state, String stateInfo) {
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

    public static AppointStateEnum stateOf(int index) {
        for (AppointStateEnum state : values()) {
            if (state.getStateCode() == index)
                return state;
        }
        return null;
    }
}
