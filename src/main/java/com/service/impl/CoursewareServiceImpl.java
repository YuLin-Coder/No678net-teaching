package com.service.impl;

import com.mapper.CoursewareMapper;
import com.model.Courseware;
import com.model.CoursewareExample;
import com.service.CoursewareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 丹青
 * @date 2020/7/29-21:19
 */
@Service
public class CoursewareServiceImpl implements CoursewareService {

    @Autowired
    CoursewareMapper coursewareMapper;

    @Override
    public List<Courseware> search(int number) {
        CoursewareExample coursewareExample = new CoursewareExample();
        CoursewareExample.Criteria criteria = coursewareExample.createCriteria();
        criteria.andNumberEqualTo(number);
        return coursewareMapper.selectByExample(coursewareExample);
    }

    @Override
    public int addCourseware(Courseware courseware) {
        return coursewareMapper.insert(courseware);
    }

    @Override
    public int edit(Courseware courseware) {
        return coursewareMapper.updateByPrimaryKeySelective(courseware);
    }

    @Override
    public int del(int id) {
        return coursewareMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Courseware> searchForM() {
        return coursewareMapper.selectByExample(null);
    }

    @Override
    public int editForM(Courseware courseware) {
        return coursewareMapper.updateByPrimaryKeySelective(courseware);
    }
}
