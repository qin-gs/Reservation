package org.reservation.web;

import org.reservation.entity.Appointment;
import org.reservation.entity.RecordDetail;
import org.reservation.entity.Room;
import org.reservation.enums.ChangePasswordStateEnum;
import org.reservation.service.AppointmentService;
import org.reservation.service.PasswordService;
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
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private PasswordService passwordService;


    @RequestMapping(value = "/main")
    public String mainPage() {
        return "/admin/main";
    }

    @RequestMapping(value = "/chooseStudent")
    public String chooseStudent() {
        return "/admin/getStudentId";
    }

    @RequestMapping(value = "/chooseRoom")
    public ModelAndView chooseRoom() {
        ModelAndView mv = new ModelAndView("/admin/getRoomId");
        List<Room> rooms = appointmentService.queryAllRooms(0, roomService.countRooms());
        mv.addObject("rooms", rooms);
        return mv;
    }

    @RequestMapping(value = "/{studentId}/studentRecord")
    public ModelAndView studentRecords(@PathVariable String studentId,
                                       @RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        ModelAndView mv = new ModelAndView("/admin/studentRecord");
        int limit = 10;
        int offset = (pageNo - 1) * limit;
        List<Appointment> appointments = appointmentService.queryBeforeAppointment(studentId, new Date().getTime(), offset, limit);

        int total = appointmentService.queryBeforeAppointment(studentId, new Date().getTime(), 0, 100).size();
        int tmp = total / limit;
        int totalPages = (total % limit == 0) ? tmp : tmp + 1;
        int curPage = pageNo;

        List<Room> rooms = appointmentService.queryAllRooms(0, roomService.countRooms());

        mv.addObject("rooms", rooms);
        mv.addObject("appointments", appointments);
        mv.addObject("studentId", studentId);
        mv.addObject("totalPages", totalPages);
        mv.addObject("curPage", curPage);
        mv.addObject("totalItems", total);
        System.out.println(appointments);
        return mv;
    }

    @RequestMapping(value = "/{roomId}/roomRecord")
    public ModelAndView roomRecord(@PathVariable String roomId,
                                   @RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        ModelAndView mv = new ModelAndView("/admin/roomRecord");
        int limit = 10;
        int offset = (pageNo - 1) * limit;

        List<RecordDetail> recordDetails = appointmentService.queryRoomAppointment(Integer.valueOf(roomId), offset, limit);

        int total = appointmentService.queryRoomAppointNum(Integer.parseInt(roomId));
        int tmp = total / limit;
        int totalPages = (total % limit == 0) ? tmp : tmp + 1;
        int curPage = pageNo;

        List<Room> rooms = appointmentService.queryAllRooms(0, roomService.countRooms());

        mv.addObject("rooms", rooms);
        mv.addObject("roomId", roomId);
        mv.addObject("recordDetails", recordDetails);
        mv.addObject("totalPages", totalPages);
        mv.addObject("curPage", curPage);
        mv.addObject("totalItems", total);
        return mv;
    }

    @RequestMapping(value = "/addRoom")
    public ModelAndView addRoom() {
        ModelAndView mv = new ModelAndView("/admin/addRoom");
        List<Room> rooms = appointmentService.queryAllRooms(0, roomService.countRooms());
        mv.addObject("rooms", rooms);
        return mv;
    }

    @RequestMapping(value = "/addStudent")
    public String addStudent() {
        return "/admin/addStudent";
    }

    @RequestMapping(value = "/addRoom/{roomId}/{roomNumbers}", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg addARoom(@PathVariable String roomId, @PathVariable String roomNumbers) {
        Room room = appointmentService.queryRoomById(Integer.parseInt(roomId));
        if (room != null) {
            return JsonMsg.fail().addInfo("info", "机房已存在，不要重复添加");
        } else {
            int ans = roomService.addRoom(Integer.parseInt(roomId), Integer.parseInt(roomNumbers));
            if (ans == 1) {
                return JsonMsg.success().addInfo("info", "添加成功");
            } else {
                return JsonMsg.fail().addInfo("info", "添加失败，请重试");
            }
        }
    }

    @RequestMapping(value = "/{roomId}/delete")
    @ResponseBody
    public JsonMsg deleteRoom(@PathVariable String roomId) {
        int ans = roomService.deleteRoom(Integer.valueOf(roomId));
        if (ans == 1) {
            return JsonMsg.success().addInfo("info", "删除机房成功");
        } else {
            return JsonMsg.fail().addInfo("info", "删除机房失败，请重试");
        }
    }

    /**
     * 管理员修改学生密码
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg updatePassword(HttpServletRequest request) {
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        ChangePasswordStateEnum stateEnum = passwordService.changePassword(studentId, password);
        if (stateEnum.getStateCode() == 1) {
            return JsonMsg.success().addInfo("info", stateEnum.getStateInfo());
        } else {
            return JsonMsg.fail().addInfo("info", stateEnum.getStateInfo());
        }
    }


    /**
     * 管理员修改自己密码
     */
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg changePassword(@CookieValue(value = "username", required = true) String userName,
                                  @RequestParam("newPassword") String newPassword,
                                  @RequestParam("oldPassword") String oldPassword) {
        // 调用方法，没有业务逻辑
        ChangePasswordStateEnum stateEnum = passwordService.changePassword(userName, oldPassword, newPassword);
        if (stateEnum.getStateCode() == 1) {
            return JsonMsg.success().addInfo("info", stateEnum.getStateInfo());
        } else {
            return JsonMsg.fail().addInfo("info", stateEnum.getStateInfo());
        }
    }

    @RequestMapping(value = "/changePassword", method = RequestMethod.GET)
    public String changePassword() {
        return "/admin/changePassword";
    }

    @RequestMapping(value = "/{roomId}/exportRoomData", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg exportRoomData(@PathVariable Integer roomId) {
        int ans = appointmentService.exportRoomData(roomId);
        if (ans == -1) {
            return JsonMsg.fail().addInfo("info", "数据导出失败，请重试");
        } else {
            return JsonMsg.success().addInfo("info", "数据导出成功");
        }
    }

    @RequestMapping(value = "/{studentId}/exportStudentData", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg exportStudentData(@PathVariable String studentId) {
        int ans = appointmentService.exportStudentData(studentId);

        if (ans == -1) {
            return JsonMsg.fail().addInfo("info", "数据导出失败，请重试");
        }
        return JsonMsg.success().addInfo("info", "数据导出成功");
    }


}
