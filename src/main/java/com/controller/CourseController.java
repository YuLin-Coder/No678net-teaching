package com.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.Course;
import com.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**课程控制器
 * @author 丹青
 * @date 2019/12/18-14:21
 */
@RequestMapping("/course")
@Controller
public class CourseController {
   
    @Autowired
    private CourseService courseService;

    @RequestMapping("courseList")
    public String CourseList() {
        return "courseList";
    }

    @RequestMapping("/addCourse")
    @ResponseBody
    public Map addCourse(String id,String name, String introduce) {
        Map map = new HashMap();
        Course course = new Course();
        course.setId(id);
        course.setIntroduce(introduce);
        course.setName(name);
        int i = courseService.addCourse(course);
        if (i >= 1) {
            map.put("message", "添加【" + name + "】课程成功");
        } else {
            map.put("message", "我永远不会被执行的");
        }
        return map;
    }

    /**
     * 课程的模糊查询
     *
     * @param id
     * @param limit
     * @param page
     * @return
     */
    @RequestMapping("getCourse")
    @ResponseBody
    public Map getCourse(String id,String name, int limit, int page) {
        Map map = new HashMap();
        PageHelper.startPage(page, limit);
        List<Course> courseList = courseService.search(id,name);
        PageInfo pageInfo = new PageInfo(courseList, 5);
        map.put("count", pageInfo.getTotal());
        map.put("code", 0);
        map.put("data", courseList);
        return map;
    }

    /**
     * 根据name模糊查询
     * @param name
     * @return
     */
    @RequestMapping("getCourseList")
    @ResponseBody
    public Map getCourse(String name) {
        Map map = new HashMap();
        List<Course> courseList = courseService.searchByName(name);
        map.put("data", courseList);
        return map;
    }

    @RequestMapping("/deleteCourse")
    @ResponseBody
    public Map deleteCourse(String id) {
        Map map = new HashMap();
        int i = courseService.deleteCourse(id);
        if (i > 0) {
            map.put("message", "成功删除课程编号为【" + id + "】的课程");
        } else {
            map.put("message", "删除失败");
        }
        return map;
    }

    @RequestMapping("/deleteBatchCourse")
    @ResponseBody
    public Map deleteBatchCourse(String [] ids) {
        Map map = new HashMap();
        int count = courseService.deleteBatchCourse(ids);
        if (count == ids.length) {
            map.put("message", "删除这些课程成功");
        } else {
            map.put("message", "删除这些课程失败");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/editCourse")
    public Map editCourse(Course course) {
        Map map = new HashMap();
        int i = courseService.editCourse(course);
        if (i > 0) {
            map.put("message", "修改【" + course.getName() + "】课程成功");
        } else {
            map.put("message", "修改失败");
        }
        return map;
    }


}
