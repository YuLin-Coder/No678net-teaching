package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.LoginLog;
import com.vo.LoginLogVo;
import com.service.LoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**记录登录日志
 * @author 丹青
 * @date 2019/12/17-20:28
 */
@Controller
@RequestMapping("/log")
public class LoginLogController {
    @Autowired
    private LoginLogService loginLogService;

    @RequestMapping("/loginLogList")
    public String loginLogList(){
        return "loginLogList";
    }

    @RequestMapping("getLoginLog")
    @ResponseBody
    public Map getLoginLog(LoginLogVo loginLogVo) {
        Map map = new HashMap();
        System.out.println(loginLogVo.getStartTime());
        PageHelper.startPage(loginLogVo.getPage(),loginLogVo.getLimit());
        List<LoginLog> loginLogs = loginLogService.getLoginLog(loginLogVo);
        PageInfo pageInfo = new PageInfo(loginLogs,5);
        map.put("count",pageInfo.getTotal());
        map.put("code",0);
        map.put("data",loginLogs);

        return map;
    }

    @RequestMapping("/deleteLoginLog")
    @ResponseBody
    public Map deleteLoginLog(Integer id){
        Map map = new HashMap();
        int i = loginLogService.deleteLoginLog(id);
        if (i>0) {
            map.put("message","成功删除编号为【"+id+"】的登录日志");
        }else{
            map.put("message","删除失败");//失败后也不会在页面显示
        }
        return map;
    }
    @RequestMapping("/deleteBatchLoginLog")
    @ResponseBody
    public Map deleteBatchTeacher(Integer []ids){
        Map map = new HashMap();
        int count = loginLogService.deleteBatchTeacher(ids);
        if(count == ids.length){
            map.put("msg","删除这些登录数据成功");
        }else {
            map.put("msg","删除这些数据失败");
        }
        return map;
    }

}
