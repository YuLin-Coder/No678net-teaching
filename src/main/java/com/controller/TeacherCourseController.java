package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.*;
import com.service.TeacherCourseService;
import com.vo.TeacherCourseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 丹青
 * @date 2019/12/19-20:49
 */
@Controller
@RequestMapping("teacherCourse")
public class TeacherCourseController {
    @Autowired
    private TeacherCourseService teacherCourseService;

    @RequestMapping("/courseManage")
    public String courseManage(){
        return "courseManage";
    }

    /**
     * 跳到老师课程页面
     * @return
     */
    @RequestMapping("/teacherCourseList")
    public String teacherCourseList(){
        return "teacher/courseList";
    }
    /**
     * 跳到学生课程页面
     * @return
     */
    @RequestMapping("/studentCourseList")
    public String studentCourseList(){
        return "student/courseList";
    }

    @RequestMapping("/addCourseInfo")
    @ResponseBody
    public Map addCourseInfo(TeacherCourseVo teacherCourseVo){
        teacherCourseVo.setComplete(0);//把初始的状态设为0
        teacherCourseVo.setChoiceNum(0);//把初始人数设为0
        Map map = new HashMap();
        int i = teacherCourseService.addCourseInfo(teacherCourseVo);
        if(i>0) {
            map.put("message", "给编号为" + teacherCourseVo.getTeacherId() + "的老师添加编号为" + teacherCourseVo.getCourseId() + "的课程成功");
            map.put("code", 1);
        }else {
            map.put("message", "添加失败");
            map.put("code", 0);
        }
        return map;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map delete(TeacherCourseKey teacherCourseKey){
        Map map = new HashMap();
        int i = teacherCourseService.delete(teacherCourseKey);
        if(i>0) {
            map.put("message", "删除课程成功");
            map.put("code", 1);
        }else {
            map.put("message", "删除失败");
            map.put("code", 0);
        }
        return map;
    }

    @RequestMapping("/deleteList")
    @ResponseBody
    public Map deleteList(String teacherId,String courseId){

        Map map = new HashMap();
        String[] str_TId = teacherId.split("-");//分割成数组
        List<Integer> teacherIds = new ArrayList<>();
        for (String id : str_TId) {
            teacherIds.add(Integer.parseInt(id));
        }
        String[] str_CId = courseId.split("-");//分割成数组
        List<Integer> courseIds = new ArrayList<>();
        for (String id : str_CId) {
            courseIds.add(Integer.parseInt(id));
        }
        int i = teacherCourseService.deleteList(teacherIds,courseIds);
        if(i==teacherIds.size()) {
            map.put("message", "删除这些课程成功");
            map.put("code", 1);
        }else {
            map.put("message", "删除失败");
            map.put("code", 0);
        }
        return map;
    }

    @RequestMapping("/loadTeacherCourse")
    @ResponseBody
    public Map loadTeacherCourse(Integer limit,Integer page, String searchKey){
        PageHelper.startPage(page,limit);
        Map map = new HashMap();
        List<TeacherCourseVo> teacherCourseVos =  teacherCourseService.loadTeacherCourse(searchKey);
        PageInfo pageInfo = new PageInfo(teacherCourseVos,5);
        map.put("data",teacherCourseVos);
        map.put("code",0);
        map.put("count",pageInfo.getTotal());
        return map;
    }

    @RequestMapping("/editCourseInfo")
    @ResponseBody
    public Map editCourseInfo(TeacherCourse teacherCourse){
        Map map = new HashMap();
        int i = teacherCourseService.editCourseInfo(teacherCourse);
        if(i>0) {
            map.put("message", "修改了编号为" + teacherCourse.getTeacherId() + "的老师的编号为" + teacherCourse.getCourseId() + "的课程");
            map.put("code", 1);
        }else {
            map.put("message", "添加失败");
            map.put("code", 0);
        }
        return map;
    }


    /**
     * 返回教师自己教的课程列表
     */
    @ResponseBody
    @RequestMapping(value="/getMyCourse")
    public Map getMyCourse(int page, int limit, HttpSession session) {
        Map map = new HashMap();
        PageHelper.startPage(page,limit);
        User user = (User)session.getAttribute("currentUser");
        Integer id = user.getNumber();
        List<TeacherCourseVo> teacherCourseVos = teacherCourseService.selectCourseList(id);
        PageInfo pageInfo = new PageInfo(teacherCourseVos,5);
        map.put("count",pageInfo.getTotal());
        map.put("data",teacherCourseVos);
        map.put("code",0);
        return map;
    }

    /**
     * 返回可选课程列表（可选：人数未满、课程开始时间在当前时间之后）
     * @param searchKey
     * @return
     */
    @ResponseBody
    @RequestMapping("/choiceList")
    public Map getCourseChoiceList(int page,int limit, int isAll,
                   String searchKey, HttpSession session) {
       User user = (User) session.getAttribute("currentUser");
       PageHelper.startPage(page,limit);
       Integer id = user.getNumber();
       Map map = new HashMap();
       List<TeacherCourseVo> teacherCourseVos =  teacherCourseService.getCourseListBySid(isAll,searchKey,id);
       PageInfo pageInfo = new PageInfo(teacherCourseVos,5);
       map.put("count",pageInfo.getTotal());
       map.put("code",0);
       map.put("data",teacherCourseVos);
       return map;
    }
    /* Pagination<Course> page = new Pagination<Course>();
        String sId = ((Student) session.getAttribute(StrUtil.USER)).getId();

        page.setTotalItemsCount(courseService.getTotalItemsCountBySid(isAll, searchKey, sId));
        page.setPageSize(nums);
        page.setPageNum(curr);

        List<Course> list = courseService.getCourseListBySid(page, isAll, searchKey, sId);

        String jsonStr = StrUtil.RETURN_JONS_PRE_STR
                + page.getTotalItemsCount()
                + StrUtil.RETURN_JONS_MID_STR
                + JSON.toJSONString(list)
                + StrUtil.RETURN_JONS_END_STR;
        System.out.println(isAll+"sid"+sId);
        System.out.println(jsonStr);
        return jsonStr;*/
    /**
     * 结束课程
     */
    @ResponseBody
    @RequestMapping("/completeCourse")
    public Map completeCourse(Integer teacherId,Integer courseId){
        Map map = new HashMap();
        try {
            teacherCourseService.completeCoures(teacherId,courseId);
            map.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("code",400);
        }
        return map;
    }
}
