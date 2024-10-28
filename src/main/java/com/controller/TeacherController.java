package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import com.model.Teacher;

import com.service.TeacherService;
import com.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 丹青
 * @date 2019/12/16-15:17
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {
    @Autowired
    private TeacherService teacherService;

    @RequestMapping("teacherList")
    public String TeacherList(){
        return "teacherList";
    }

    @RequestMapping("/addTeacher")
    @ResponseBody
    public Map addTeacher(int id,String password,String username,String introduce){
        Map map = new HashMap();
        Teacher teacher = new Teacher();
        teacher.setId(id);
        teacher.setIntroduce(introduce);
        teacher.setPassword(MD5Util.digest(password));
        System.out.println(MD5Util.digest(password));
        teacher.setUsername(username);
        int i = teacherService.addTeacher(teacher);
        if(i >= 1){
            map.put("message","生成【"+username+"】老师成功");
        }else {
            map.put("message","生成失败");
        }
        return map;
    }

    /**
     * 老师的模糊查询
     * @param username
     * @param limit
     * @param page
     * @return
     */
    @RequestMapping("getTeacher")
    @ResponseBody
    public Map getTeacher(String username,int limit,int page){
        Map map = new HashMap();
        PageHelper.startPage(page,limit);
        List<Teacher> teacherList = teacherService.search(username);
        PageInfo pageInfo = new PageInfo(teacherList,5);
        map.put("count",pageInfo.getTotal());
        map.put("code",0);
        map.put("data",teacherList);
        return map;
    }

    /**
     * 根据username模糊查询
     * @return
     */
    @RequestMapping("getTeacherList")
    @ResponseBody
    public Map getTeacher(String username){
        Map map = new HashMap();
        List<Teacher> teacherList = teacherService.search(username);
        map.put("data",teacherList);
        return map;
    }

    @RequestMapping("/deleteTeacher")
    @ResponseBody
    public Map deleteTeacher(int id){
        Map map = new HashMap();
        int i = teacherService.deleteTeacher(id);
        if (i>0) {
            map.put("message","成功删除教工号为【"+id+"】的老师");
        }else{
            map.put("message","删除失败");
        }
        return map;
    }

    @RequestMapping("/deleteBatchTeacher")
    @ResponseBody
    public Map deleteBatchTeacher(Integer []ids){
        Map map = new HashMap();
        int count = teacherService.deleteBatchTeacher(ids);
        if(count == ids.length){
            map.put("message","删除这些老师成功");
        }else {
            map.put("message","删除这些老师失败");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/editTeacher")
    public Map editTeacher(Teacher teacher){
        Map map = new HashMap();
        teacher.setPassword(MD5Util.digest(teacher.getPassword()));
        int i = teacherService.editTeacher(teacher);
        if(i>0){
            map.put("message","修改【"+teacher.getUsername()+"】老师成功");
        }else {
            map.put("message","修改失败");
        }
        return map;
    }
}
