package org.reservation.exception;

/**
 * 重复预约异常
 */
public class RepeatAppointException extends AppointmentException {

    public RepeatAppointException(String message) {
        super(message);
    }

    public RepeatAppointException(String message, Throwable cause) {
        super(message, cause);
    }
}
