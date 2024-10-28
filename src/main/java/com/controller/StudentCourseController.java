package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.*;
import com.service.StudentCouserseService;
import com.vo.StudentCourseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 丹青
 * @date 2019/12/21-19:52
 */
@Controller
@RequestMapping("/studentCourse")
public class StudentCourseController {
    @Autowired
    private StudentCouserseService studentCouserseService;

    /**
     * 老师管理成绩界面
     * @return
     */
    @RequestMapping("/studentCourseList")
    public String  StudentCourseList(){
        return "teacher/studentCourse";
    }

    @RequestMapping("/studentScore")
    public String  studentScore(){
        return "student/studentScore";

    }
    @RequestMapping("/allStudentEv")
    public String  allStudentEv(){
        return "allStudentEv";
    }

    @RequestMapping("/allStudentCourse")
    public String  allStudentCourse(){
        return "stucj";
    }

    /**
     * 转到学生评教页面
     * @return
     */
    @RequestMapping("/studentCourseEv")
    public String  studentCourseEv(){
        return "student/studentCourseEv";
    }

    /**
     * 转到管理员查看学生学习情况
     * @return
     */
    @RequestMapping("/allStudentCourseForM")
    public String  allStudentCourseForM(){
        return "studentCourse";
    }


    /**
     * 学生选课
     * @param session
     * @param courseId
     * @return
     */
    @RequestMapping("/choiceCourse")
    @ResponseBody
    public Map choiceCourse(HttpSession session, Integer courseId, Integer teacherId) {
            Map map = new HashMap();
            User user = (User) session.getAttribute("currentUser");
            StudentCourse studentCourse = new StudentCourse();
            studentCourse.setStudentId(user.getNumber());
            studentCourse.setCourseId(courseId);
            int res = studentCouserseService.choiceCourse(studentCourse,teacherId);
            if (res > 0){
                map.put("code",1);
                map.put("message","选课成功");
            }else {
                map.put("code",0);
                map.put("message","课程人已满");
            }
       return map;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map delete(HttpSession session, Integer courseId) {
        Map map = new HashMap();
        User user = (User) session.getAttribute("currentUser");
        StudentCourseKey studentCourseKey = new StudentCourse();
        studentCourseKey.setStudentId(user.getNumber());
        studentCourseKey.setCourseId(courseId);
        int res = studentCouserseService.delete(studentCourseKey);
        if (res > 0){
            map.put("code",1);
            map.put("message","退选成功");
        }else {
            map.put("code",0);
            map.put("message","退选失败");
        }
        return map;
    }

    /**
     * 返回选修了某个老师课程的学生列表
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/stulist")
    public Map getMyStudentList(int page,int limit,
              HttpSession session) {
        Map map = new HashMap();
        PageHelper.startPage(page,limit);
        User user = (User)session.getAttribute("currentUser");
        List<StudentCourseVo> studentCourseVos = studentCouserseService.getStudentListByTid(user.getNumber());
        PageInfo pageInfo = new PageInfo(studentCourseVos,5);
        map.put("code",0);
        map.put("data",studentCourseVos);
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
       return map;
    }


    /**老师给学生添加成绩
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/updateScore")
    public Map updateScore(StudentCourse studentCourse) {
        Map map = new HashMap();
        studentCourse.setTime(new Date());
        int i = studentCouserseService.updateScore(studentCourse);
        if(i>0){
            map.put("code",1);
            map.put("message","添加成绩成功");
        }else {
            map.put("code",0);
            map.put("message","失败");
        }
        return map;
    }

    /**
     * 用于学生查看自己的成绩
     * @param page
     * @param limit
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/studentScoreList")
    public Map studentScoreList(int page,int limit,
                                HttpSession session) {
        Map map = new HashMap();
        PageHelper.startPage(page,limit);
        User user = (User)session.getAttribute("currentUser");
        List<StudentCourseVo> studentCourseVos = studentCouserseService.getStudentScoreListBySid(user.getNumber());
        PageInfo pageInfo = new PageInfo(studentCourseVos,5);
        map.put("code",0);
        map.put("data",studentCourseVos);
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        return map;
    }

    /**
     * 管理员查看教学评分
     * @param page
     * @param limit
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/studentScoreListForM")
    public Map studentScoreListForM(int page,int limit,
                                HttpSession session) {
        Map map = new HashMap();
        PageHelper.startPage(page,limit);
        List<StudentCourseVo> studentCourseVos = studentCouserseService.getStudentScoreListForM();
        PageInfo pageInfo = new PageInfo(studentCourseVos,5);
        map.put("code",0);
        map.put("data",studentCourseVos);
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        return map;
    }

    /**
     * 用于管理员查看所有学生的成绩
     * @param page
     * @param limit
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/allStudentScoreList")
    public Map allStudentScoreList(int page,int limit,
                                HttpSession session) {
        Map map = new HashMap();
        PageHelper.startPage(page,limit);
        List<StudentCourseVo> studentCourseVos = studentCouserseService.getAllStudentScoreList();
        PageInfo pageInfo = new PageInfo(studentCourseVos,5);
        map.put("code",0);
        map.put("data",studentCourseVos);
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        return map;
    }

    @ResponseBody
    @RequestMapping(value="/editStudentCourse")
    public Map editStudentCourse(StudentCourse studentCourse,HttpSession session) {
        Map map = new HashMap();
        User user = (User)session.getAttribute("currentUser");
        studentCourse.setStudentId(user.getNumber());
        studentCourse.setEvTime(new Date());
        int i = studentCouserseService.updateEv(studentCourse);
        if(i>0){
            map.put("code",1);
            map.put("message","添加评价成功");
        }else {
            map.put("code",0);
            map.put("message","失败");
        }
        return map;
    }
}
