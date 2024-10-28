package com.service.impl;

import com.mapper.StudentMapper;
import com.model.Student;
import com.model.StudentExample;
import com.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/16-17:37
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public int addStudent(Student student) {
        int i = studentMapper.insert(student);
        return i;
    }
    @Override
    public List<Student> search(String username) {
        StudentExample example = new StudentExample();
        StudentExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameLike("%"+username+"%");
        List<Student> studentList = studentMapper.selectByExample(example);
        return studentList;
    }

    @Override
    public int deleteStudent(int id) {
        int i = studentMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int deleteBatchStudent(Integer[] ids) {
        int allCount = 0;
        for (Integer id : ids) {
            int count = studentMapper.deleteByPrimaryKey(id);
            allCount += count;
        }
        return allCount;
    }

    @Override
    public int editStudent(Student student) {
        int i = studentMapper.updateByPrimaryKeySelective(student);
        return i;
    }
}
