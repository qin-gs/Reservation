package org.reservation.service.impl;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.reservation.dao.AppointmentDao;
import org.reservation.dao.RedisDao;
import org.reservation.dao.RoomDao;
import org.reservation.dao.StudentDao;
import org.reservation.dto.AppointmentExecution;
import org.reservation.entity.Appointment;
import org.reservation.entity.RecordDetail;
import org.reservation.entity.Room;
import org.reservation.enums.AppointStateEnum;
import org.reservation.exception.AlreadyAppointException;
import org.reservation.exception.RepeatAppointException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.List;

@Service
public class AppointmentServiceImpl implements org.reservation.service.AppointmentService {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private AppointmentDao appointmentDao;
    @Autowired
    private RoomDao roomDao;
    @Autowired
    private StudentDao studentDao;
    @Autowired
    private RedisDao redisDao;

    public List<Room> queryAllRooms(int offset, int limit) {
        return roomDao.queryAllRooms(offset, limit);
    }

    @Override
    @Transactional
    public AppointmentExecution appointment(int roomId, int roomPosition, String studentId, int classNum, long appointTime, long recodeTime) {
        try {

            // 只能学生预约
            int isAdmin = studentDao.isAdmin(studentId);
            if (isAdmin == 1) {
                throw new RuntimeException(AppointStateEnum.INNER_ERROR.getStateInfo());
            }

            // 获取当天0点的时间
            // long n = Instant.now().toEpochMilli();
            long now = LocalDate.now().atTime(0, 0, 0).toInstant(ZoneOffset.of("+8")).toEpochMilli();// 当前时间
            // 第六天的零点（可预约的最后时间）
            long fiveDayLater = LocalDate.now().plusDays(6).atTime(0, 0, 0).toInstant(ZoneOffset.of("+8")).toEpochMilli();
            // 时间在可预约范围内
            if (appointTime < now && appointTime > fiveDayLater) {
                throw new RuntimeException(AppointStateEnum.INNER_ERROR.getStateInfo());
            }

            // 判断机房以及位置存在
            // Room room = roomDao.queryRoomById(roomId);
            // if (room == null || room.getRoomNumber() < roomPosition) {
            //     throw new RuntimeException();
            // }
            Room room = redisDao.getRoom(roomId);
            if (room == null) {
                room = roomDao.queryRoomById(roomId);
                if (room != null) {
                    redisDao.putRoom(room);
                }
            }
            if (room == null || room.getRoomNumber() < roomPosition) {
                throw new RuntimeException();
            }

            // 判断同一个人同一节课是否预约了两个座位
            int isBoth = appointmentDao.queryTwoPosition(studentId, classNum, appointTime);
            if (isBoth > 0) {
                throw new RepeatAppointException(AppointStateEnum.REPEAT_APPOINT.getStateInfo());
            }
            // 判断这个位置是否已经被预约
            int isAppoint = appointmentDao.queryIsAppoint(roomId, roomPosition, classNum, appointTime);
            if (isAppoint > 0) {
                throw new AlreadyAppointException(AppointStateEnum.ALREADY_APPOINT.getStateInfo());
            }
            // 执行预约
            int insertAppoint = appointmentDao.insertRecord(roomId, roomPosition, studentId, classNum, appointTime, recodeTime);
            if (insertAppoint <= 0) {
                throw new RepeatAppointException(AppointStateEnum.REPEAT_APPOINT.getStateInfo());
            } else {
                return new AppointmentExecution(roomId, roomPosition, AppointStateEnum.SUCCESS);
            }
        } catch (RepeatAppointException | AlreadyAppointException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public int cancelAppointment(int roomId, int roomPosition, String studentId, int classNum, long appointTime) {
        return appointmentDao.deleteRecord(roomId, roomPosition, studentId, classNum, appointTime);
    }

    public List<Appointment> queryBeforeAppointment(String studentId, long nowTime, int offset, int limit) {
        return appointmentDao.queryBeforeAppointment(studentId, nowTime, offset, limit);
    }

    public List<Appointment> queryFutureAppointment(String studentId, long nowTime, int offset, int limit) {
        return appointmentDao.queryFutureAppointment(studentId, nowTime, offset, limit);
    }

    @Override
    public int queryFutureAppointNum(String studentId, long nowTime) {
        return appointmentDao.queryFutureAppointNum(studentId, nowTime);
    }

    @Override
    public int changePassword(String studentId, String oldPassword, String newPassword) {
        return studentDao.changePassword(studentId, oldPassword, newPassword);
    }

    @Override
    public List<Integer> queryUsedPosition(int roomId, long appointTime, int classNum) {
        return appointmentDao.queryUsedPosition(roomId, appointTime, classNum);
    }

    @Override
    public Room queryRoomById(int roomId) {
        return roomDao.queryRoomById(roomId);
    }


    @Override
    public int queryAppointNum(String studentId, long nowTime) {
        return appointmentDao.queryAppointNum(studentId, nowTime);
    }


    @Override
    public List<RecordDetail> queryRoomAppointment(Integer roomId, int offset, int limit) {
        return appointmentDao.queryRoomAppointment(roomId, offset, limit);
    }


    @Override
    public int queryRoomAppointNum(int roomId) {
        return appointmentDao.queryRoomAppointNum(roomId);
    }

    @Override
    public int exportRoomData(int roomId) {
        List<RecordDetail> details = queryRoomAppointment(roomId, 0, Integer.MAX_VALUE);

        HSSFWorkbook book = new HSSFWorkbook(); // 创建一个excel
        HSSFSheet sheet = book.createSheet(); // 创建一个sheet

        String[] columns = {"列号", "机房号", "机房位置", "学号", "预约使用时间", "课时", "记录插入时间", "姓名", "性别"};
        HSSFRow headRow = sheet.createRow(0); // 设置标题栏
        for (int i = 0; i < columns.length; i++) {
            sheet.setColumnWidth(i, 31 * 150);
            headRow.createCell(i).setCellValue(columns[i]);
        }

        for (int i = 1; i <= details.size(); i++) {
            HSSFRow row = sheet.createRow(i); // 创建一行
            RecordDetail rd = details.get(i - 1);
            for (int j = 0; j < columns.length; j++) {
                row.createCell(0).setCellValue(i); // 设置该行中的数值
                row.createCell(1).setCellValue(rd.getRoomId()); // 设置该行中的数值
                row.createCell(2).setCellValue(rd.getRoomPosition());
                row.createCell(3).setCellValue(rd.getStudentId());

                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
                String at = sdf1.format(rd.getAppointTime());
                row.createCell(4).setCellValue(at);

                row.createCell(5).setCellValue(rd.getClassNum());

                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String rt = sdf2.format(rd.getRecordTime());
                row.createCell(6).setCellValue(rt);

                row.createCell(7).setCellValue(rd.getName());
                row.createCell(8).setCellValue(rd.getGender());
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            FileOutputStream fos = new FileOutputStream("E:\\IdeaProjects\\Reservation\\" + "机房号_" + roomId + "_" + sdf.format(new Date().getTime()) + "导出记录.xlsx");
            book.write(fos);
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }

        return 1;

    }

    @Override
    public int exportStudentData(String studentId) {
        List<Appointment> appointments = queryFutureAppointment(studentId, new Date().getTime(), 0, Integer.MAX_VALUE);

        HSSFWorkbook book = new HSSFWorkbook();
        HSSFSheet sheet = book.createSheet();

        HSSFRow headRow = sheet.createRow(0);
        String[] columns = {"列号", "机房号", "机房位置", "学号", "预约使用时间", "课时", "记录插入时间"};
        for (int i = 0; i < columns.length; i++) {
            sheet.setColumnWidth(i, 31 * 150);
            headRow.createCell(i).setCellValue(columns[i]);
        }

        for (int i = 1; i <= appointments.size(); i++) {
            Appointment a = appointments.get(i - 1);
            HSSFRow row = sheet.createRow(i);
            for (int j = 0; j < columns.length; j++) {
                row.createCell(0).setCellValue(i);
                row.createCell(1).setCellValue(a.getRoomId());
                row.createCell(2).setCellValue(a.getRoomPosition());
                row.createCell(3).setCellValue(a.getStudentId());

                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
                String at = sdf1.format(a.getAppointTime());
                row.createCell(4).setCellValue(at);

                row.createCell(5).setCellValue(a.getClassNum());

                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String rt = sdf2.format(a.getRecordTime());
                row.createCell(6).setCellValue(rt);
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            FileOutputStream fos = new FileOutputStream("E:\\IdeaProjects\\Reservation\\" + "学号_" + studentId + "_" + sdf.format(new Date().getTime()) + "_导出记录.xlsx");
            book.write(fos);
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
        return 1;
    }


}
