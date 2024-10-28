package com.service.impl;

import com.mapper.TeacherMapper;
import com.model.Teacher;
import com.model.TeacherExample;
import com.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/16-15:17
 */
@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;
    @Override
    public int addTeacher(Teacher teacher) {
        int i = teacherMapper.insert(teacher);
        return i;
    }

    @Override
    public List<Teacher> search(String username) {
        TeacherExample example = new TeacherExample();
        TeacherExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameLike("%"+username+"%");
        List<Teacher> teacherList = teacherMapper.selectByExample(example);
        return teacherList;
    }

    @Override
    public int deleteTeacher(int id) {
        int i = teacherMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int deleteBatchTeacher(Integer[] ids) {
        int allCount = 0;
        for (Integer id : ids) {
            int count = teacherMapper.deleteByPrimaryKey(id);
            allCount += count;
        }
        return allCount;
    }

    @Override
    public int editTeacher(Teacher teacher) {
        int i = teacherMapper.updateByPrimaryKeySelective(teacher);
        return i;
    }
}
