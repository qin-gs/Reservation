package org.reservation.web;

import org.reservation.enums.ChangePasswordStateEnum;
import org.reservation.service.PasswordService;
import org.reservation.util.JsonMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PasswordController {

    @Autowired
    private PasswordService passwordService;

    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg changePassword(@CookieValue(value = "username", required = true) String userName,
                                  @RequestParam("newPassword") String newPassword,
                                  @RequestParam("oldPassword") String oldPassword) {

        System.out.println(userName + " " + oldPassword + " " + newPassword);

        ChangePasswordStateEnum stateEnum = passwordService.changePassword(userName, oldPassword, newPassword);
        if (stateEnum.getStateCode() == 1) {
            return JsonMsg.success().addInfo("info", stateEnum.getStateInfo());
        } else {
            return JsonMsg.fail().addInfo("info", stateEnum.getStateInfo());
        }
    }


    @RequestMapping(value = "/changePassword", method = RequestMethod.GET)
    public String changePassword() {
        return "changePassword";
    }
}
