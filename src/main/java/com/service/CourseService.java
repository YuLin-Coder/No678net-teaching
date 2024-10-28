package com.service;

import com.model.Course;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/18-14:25
 */
public interface CourseService {

    int addCourse(Course course);

    List<Course> search(String name,String id);

    int deleteCourse(String id);

    int deleteBatchCourse(String [] ids);

    int editCourse(Course course);

    List<Course> searchByName(String name);
}
