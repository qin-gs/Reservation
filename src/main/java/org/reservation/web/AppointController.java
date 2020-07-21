package org.reservation.web;

import org.reservation.dto.AppointmentExecution;
import org.reservation.dto.AppointmentResult;
import org.reservation.entity.Appointment;
import org.reservation.entity.Room;
import org.reservation.enums.AppointStateEnum;
import org.reservation.exception.AlreadyAppointException;
import org.reservation.exception.RepeatAppointException;
import org.reservation.service.AppointmentService;
import org.reservation.service.RoomService;
import org.reservation.util.JsonMsg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/appointment")
public class AppointController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private RoomService roomService;

    /**
     * 列出所有的机房, 前端显示机房位置数量 [（101， 70）, (102, 140)]
     */
    @RequestMapping(value = "/listRooms", method = RequestMethod.GET)
    public ModelAndView listRooms(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        ModelAndView mv = new ModelAndView("listRooms");
        int limit = 10;
        int offset = (pageNo - 1) * limit;
        List<Room> list = appointmentService.queryAllRooms(offset, limit);
        int total = roomService.countRooms();
        int tmp = total / limit;
        int totalPages = (total % limit == 0) ? tmp : tmp + 1;
        int curPage = pageNo;
        mv.addObject("rooms", list)
                .addObject("totalItems", total)
                .addObject("totalPages", totalPages)
                .addObject("curPage", curPage);
        return mv;
    }

    /**
     * 选择预约时间
     */
    @RequestMapping(value = "/{roomId}/choose", method = RequestMethod.GET)
    public ModelAndView roomChoose(@PathVariable("roomId") Integer roomId) {
        ModelAndView mv = new ModelAndView("roomChoose");
        List<Room> rooms = appointmentService.queryAllRooms(0, roomService.countRooms());
        mv.addObject("rooms", rooms)
                .addObject("roomId", roomId);
        return mv;
    }

    /**
     * 列出机房的详细预约情况
     */
    @RequestMapping(value = "/{roomId}/{appointTime}/{classNum}/detail")
    public ModelAndView roomDetail(@PathVariable("roomId") Integer roomId,
                                   @PathVariable("appointTime") String time,
                                   @PathVariable("classNum") Integer classNum) throws ParseException {
        ModelAndView mv = new ModelAndView("choosePosition");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        long appointTime = sdf.parse(time).getTime();

        List<Integer> positions = appointmentService.queryUsedPosition(roomId, appointTime, classNum);
        Room room = appointmentService.queryRoomById(roomId);

        List<Room> rooms = appointmentService.queryAllRooms(0, roomService.countRooms());
        mv.addObject("rooms", rooms);
        mv.addObject("roomNum", room.getRoomNumber());
        mv.addObject("usedPosition", positions);
        mv.addObject("roomId", roomId);
        mv.addObject("appointTime", time);
        mv.addObject("classNum", classNum);
        return mv;
    }

    @RequestMapping(value = "/listRecord")
    public ModelAndView listRecord(@CookieValue("username") String username,
                                   @RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        ModelAndView mv = new ModelAndView("listRecord");

        int limit = 10;
        int offset = (pageNo - 1) * limit;
        List<Appointment> list = appointmentService.queryBeforeAppointment(username, new Date().getTime(), offset, limit);
        int total = appointmentService.queryAppointNum(username, new Date().getTime());
        int tmp = total / limit;
        int totalPages = (total % limit == 0) ? tmp : tmp + 1;
        int curPage = pageNo;
        mv.addObject("appoints", list)
                .addObject("totalItems", total)
                .addObject("totalPages", totalPages)
                .addObject("curPage", curPage);
        return mv;
    }

    @RequestMapping(value = "/cancelAppoint")
    public ModelAndView cancelAppoint(@CookieValue("username") String studentId,
                                      HttpServletRequest request,
                                      @RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        ModelAndView mv = new ModelAndView("cancelAppoint");

        int limit = 8;
        int offset = (pageNo - 1) * limit;

        long nowTime = System.currentTimeMillis();
        List<Appointment> list = appointmentService.queryFutureAppointment(studentId, nowTime, offset, limit);

        int total = appointmentService.queryFutureAppointNum(studentId, nowTime);
        int tmp = total / limit;
        int totalPages = (total % limit == 0) ? tmp : tmp + 1;
        int curPage = pageNo;

        mv.addObject("appoints", list)
                .addObject("totalItems", total)
                .addObject("totalPages", totalPages)
                .addObject("curPage", curPage);
        return mv;
    }

    @RequestMapping(value = "/deleteAppoint", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg deleteAppoint(@CookieValue("username") String studentId,
                                 HttpServletRequest request) {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int roomPosition = Integer.parseInt(request.getParameter("roomPosition"));
        long appointTime = Long.parseLong(request.getParameter("appointTime"));
        int classNum = Integer.parseInt(request.getParameter("classNum"));
        long recordTime = Long.parseLong(request.getParameter("recordTime"));

        System.out.println(roomId + " " + roomPosition + " " + appointTime + " " + classNum + " " + recordTime);

        int ans = appointmentService.cancelAppointment(roomId, roomPosition, studentId, classNum, appointTime);
        if (ans == 1) {
            return JsonMsg.success().addInfo("info", "取消预约成功");
        } else {
            return JsonMsg.fail().addInfo("info", "取消预约失败, 请重试");
        }

    }

    @RequestMapping(value = "/appointPosition")
    @ResponseBody
    public AppointmentResult<AppointmentExecution> appointPosition(@CookieValue(value = "username", required = false) String studentId,
                                                                   HttpServletRequest request) throws ParseException {
        if (studentId == null) {
            return new AppointmentResult<>(false, new AppointmentExecution(0, 0, AppointStateEnum.LOGIN_ERROR));
        }

        // 取出参数
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int roomPosition = Integer.parseInt(request.getParameter("position"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        long appointTime = sdf.parse(request.getParameter("appointTime")).getTime();

        int classNum = Integer.parseInt(request.getParameter("classNum"));
        try {
            AppointmentExecution execution = appointmentService.appointment(roomId, roomPosition, studentId, classNum, appointTime, new Date().getTime());
            return new AppointmentResult<>(true, execution);
        } catch (AlreadyAppointException e) {
            AppointmentExecution execution = new AppointmentExecution(roomId, roomPosition, AppointStateEnum.ALREADY_APPOINT);
            return new AppointmentResult<>(false, execution);
        } catch (RepeatAppointException e) {
            AppointmentExecution execution = new AppointmentExecution(roomId, roomPosition, AppointStateEnum.REPEAT_APPOINT);
            return new AppointmentResult<>(false, execution);
        } catch (RuntimeException e) {
            AppointmentExecution execution = new AppointmentExecution(roomId, roomPosition, AppointStateEnum.INNER_ERROR);
            return new AppointmentResult<>(false, execution);
        }


    }


}
