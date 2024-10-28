package com.service.impl;

import com.mapper.TeacherCourseMapper;
import com.model.*;
import com.service.TeacherCourseService;
import com.vo.TeacherCourseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/20-11:12
 */
@Service
public class TeacherCourseServiceImpl implements TeacherCourseService {
    @Autowired
    private TeacherCourseMapper teacherCourseMapper;

    @Override
    public int addCourseInfo(TeacherCourseVo teacherCourseVo) {
        return teacherCourseMapper.insertSelective(teacherCourseVo);
    }

    @Override
    public List<TeacherCourseVo> loadTeacherCourse(String searchKey) {
        /*TeacherCourseExample example = new TeacherCourseExample();
        TeacherCourseExample.Criteria criteria = example.createCriteria();
        criteria.andTeacherIdEqualTo()*/
        return teacherCourseMapper.selectByExampleWithTC(searchKey);
    }

    @Override
    public int editCourseInfo(TeacherCourse teacherCourse) {
        int i = teacherCourseMapper.updateByPrimaryKeySelective(teacherCourse);
        return i;
    }

    @Override
    public int delete(TeacherCourseKey teacherCourseKey) {
        return teacherCourseMapper.deleteByPrimaryKey(teacherCourseKey);
    }

    @Override
    public int deleteList(List<Integer> teacherIds,List<Integer> courseIds) {
        int i = 0;

        for (int j = 0; j < teacherIds.size(); j++) {
            TeacherCourseKey teacherCourseKey = new TeacherCourseKey();
            teacherCourseKey.setTeacherId(teacherIds.get(j));
            teacherCourseKey.setCourseId(courseIds.get(j));
            int a = teacherCourseMapper.deleteByPrimaryKey(teacherCourseKey);
            i = i+a;
        }
        return i;
    }

    @Override
    public List<TeacherCourseVo> selectCourseList(Integer id) {
        List<TeacherCourseVo> teacherCourseVos = teacherCourseMapper.selectCourseList(id);
        return teacherCourseVos;
    }

    @Override
    public List<TeacherCourseVo> getCourseListBySid(int isAll, String searchKey, int id) {
        System.out.println(id);
        System.out.println(isAll);
        System.out.println(searchKey);
        return teacherCourseMapper.getCourseList(isAll,searchKey,id);
    }

    @Override
    public void completeCoures(Integer teacherId,Integer courseId) {
        TeacherCourse teacherCourse = new TeacherCourse();
        teacherCourse.setTeacherId(teacherId);
        teacherCourse.setCourseId(courseId);
        teacherCourse.setComplete(1);
        teacherCourseMapper.updateByPrimaryKeySelective(teacherCourse);
    }
}
