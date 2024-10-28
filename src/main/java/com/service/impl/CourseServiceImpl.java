package com.service.impl;

import com.mapper.CourseMapper;
import com.model.Course;
import com.model.CourseExample;
import com.service.CourseService;
import javafx.scene.shape.Circle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/18-14:23
 */
@Service
public class CourseServiceImpl implements CourseService{
    @Autowired
    private CourseMapper courseMapper;

    @Override
    public int addCourse(Course course) {
        int i = courseMapper.insert(course);
        return i;
    }

    @Override
    public List<Course> search(String name,String id) {
        CourseExample example = new CourseExample();
        CourseExample.Criteria criteria = example.createCriteria();
        if (id!=null){
            criteria.andIdLike("%"+id+"%");
        }
        if (name!=null){
            criteria.andNameLike("%"+name+"%");
        }
        List<Course> courseList = courseMapper.selectByExample(example);
        return courseList;
    }

    @Override
    public int deleteCourse(String id) {
        int i = courseMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int deleteBatchCourse(String[] ids) {
        int allCount = 0;
        for (String id : ids) {
            int count = courseMapper.deleteByPrimaryKey(id);
            allCount += count;
        }
        return allCount;
    }

    @Override
    public int editCourse(Course course) {
        int i = courseMapper.updateByPrimaryKeySelective(course);
        return i;
    }

    @Override
    public List<Course> searchByName(String name) {
        CourseExample example = new CourseExample();
        CourseExample.Criteria criteria = example.createCriteria();
        criteria.andNameLike("%"+name+"%");
        List<Course> courseList = courseMapper.selectByExample(example);
        return courseList;
    }
}
