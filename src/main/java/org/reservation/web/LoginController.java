package org.reservation.web;

import org.reservation.entity.Student;
import org.reservation.service.LoginService;
import org.reservation.util.JsonMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/reservation")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/identify", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg login(HttpServletRequest request) {
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        Student student = loginService.login(userName, password);
        // System.out.println(student);
        if (student == null) {
            return JsonMsg.fail().addInfo("login_error", "账号或密码错误");
        } else {
            return JsonMsg.success().addInfo("isAdmin", student.getIsAdmin());
        }
    }

    @RequestMapping("/main")
    public String test() {
        return "main";
    }

    /**
     * 退出登录：从主页面跳转到登录页面
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout() {
        return "login";
    }

    @RequestMapping(value = "/introduce")
    public String introduce() {
        return "common/introduce";
    }

    @RequestMapping(value = "/rule")
    public String rule() {
        return "common/rule";
    }

}
