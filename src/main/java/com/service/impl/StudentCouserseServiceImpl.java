package com.service.impl;

import com.mapper.StudentCourseMapper;
import com.mapper.TeacherCourseMapper;
import com.model.*;
import com.service.StudentCouserseService;
import com.vo.StudentCourseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentCouserseServiceImpl implements StudentCouserseService {
    @Autowired
    private StudentCourseMapper studentCourseMapper;
    @Autowired
    private TeacherCourseMapper teacherCourseMapper;

    @Override
    public int choiceCourse(StudentCourse studentCourse,Integer teacherId) {
        TeacherCourseKey key = new TeacherCourseKey();
        key.setCourseId(studentCourse.getCourseId());
        key.setTeacherId(teacherId);
        TeacherCourse teacherCourse = teacherCourseMapper.selectByPrimaryKey(key);
        if (teacherCourse.getStudentNum() == teacherCourse.getChoiceNum()) {
            // 此课程学生人数已满，选课失败
            return 0;
        }
        System.out.println(teacherCourse.toString());
        // 对所选课程中，choiceNum（已选人数+1）
        teacherCourse.setChoiceNum(teacherCourse.getChoiceNum() + 1);
        teacherCourseMapper.updateByPrimaryKeySelective(teacherCourse);
        return studentCourseMapper.insertSelective(studentCourse);
    }

    @Override
    public int delete(StudentCourseKey studentCourseKey) {
        /*StudentCourseExample studentCourseExample = new StudentCourseExample();
        StudentCourseExample.Criteria criteria = studentCourseExample.createCriteria();
        criteria.and*/
        return studentCourseMapper.deleteByPrimaryKey(studentCourseKey);
    }

    @Override
    public List<StudentCourseVo> getStudentListByTid(Integer teacherId) {
        List<StudentCourseVo> studentCourseVos = studentCourseMapper.getStudentListByTid(teacherId);
        return studentCourseVos;
    }

    @Override
    public int updateScore(StudentCourse studentCourse) {
        return studentCourseMapper.updateByPrimaryKeySelective(studentCourse);
    }

    @Override
    public List<StudentCourseVo> getStudentScoreListBySid(Integer number) {
        return studentCourseMapper.getStudentScoreListBySid(number);
    }

    @Override
    public List<StudentCourseVo> getAllStudentScoreList() {
        return studentCourseMapper.getAllstudentScoureList();
    }

    @Override
    public int updateEv(StudentCourse studentCourse) {
        return studentCourseMapper.updateByPrimaryKeySelective(studentCourse);
    }

    @Override
    public List<StudentCourseVo> getStudentScoreListForM() {
        return studentCourseMapper.getStudentScoreListForM();
    }
}
