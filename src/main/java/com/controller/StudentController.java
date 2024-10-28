package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.Student;
import com.service.StudentService;
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
 * @date 2019/12/16-17:35
 */
@Controller
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private StudentService studentService;

    @RequestMapping("/studentList")
    public String studentList(){
        return "studentList";
    }
    @RequestMapping("/addStudent")
    @ResponseBody
    public Map addstudent(int id,String username,String password,String major,String joinDate,String grdade){
        Map map = new HashMap();
        System.out.println(id);
        Student student = new Student();
        student.setId(id);
        student.setUsername(username);
        student.setPassword(password);
        student.setMajor(major);
        student.setGrdate(grdade);
        student.setJionDate(joinDate);
        int i = studentService.addStudent(student);
        if(i>0){
            map.put("message","添加【"+username+"】学生成功");
        }else {
            map.put("message","添加学生失败");
        }
        return map;
    }
    @RequestMapping("getStudent")
    @ResponseBody
    public Map getStudent(String username,int limit,int page){
        Map map = new HashMap();
        System.out.println(username);
        PageHelper.startPage(page,limit);
        List<Student> studentList = studentService.search(username);
        PageInfo pageInfo = new PageInfo(studentList,5);
        map.put("count",pageInfo.getTotal());
        map.put("code",0);
        map.put("data",studentList);
        return map;
    }

    @RequestMapping("/deleteStudent")
    @ResponseBody
    public Map deleteStudent(int id){
        Map map = new HashMap();
        int i = studentService.deleteStudent(id);
        if (i>0) {
            map.put("message","成功删除学号为【"+id+"】的学生");
        }else{
            map.put("message","删除失败");
        }
        return map;
    }

    @RequestMapping("/deleteBatchStudent")
    @ResponseBody
    public Map deleteBatchStudent(Integer []ids){
        Map map = new HashMap();
        int count = studentService.deleteBatchStudent(ids);
        if(count == ids.length){
            map.put("message","删除这些学生成功");
        }else {
            map.put("message","删除这些学生失败");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/editStudent")
    public Map editStudent(Student student){
        Map map = new HashMap();
        student.setPassword(MD5Util.digest(student.getPassword()));
        int i = studentService.editStudent(student);
        if(i>0){
            map.put("message","修改【"+student.getUsername()+"】学生成功");
        }else {
            map.put("message","修改失败");
        }
        return map;
    }
}
