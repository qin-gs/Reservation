package org.reservation.exception;

/**
 * 已经被预约了异常
 */
public class AlreadyAppointException extends AppointmentException {
    public AlreadyAppointException(String message) {
        super(message);
    }

    public AlreadyAppointException(String message, Throwable cause) {
        super(message, cause);
    }
}
