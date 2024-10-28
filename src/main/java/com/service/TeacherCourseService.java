package com.service;

import com.model.TeacherCourse;
import com.model.TeacherCourseKey;
import com.vo.TeacherCourseVo;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/20-11:12
 */
public interface TeacherCourseService {
    int addCourseInfo(TeacherCourseVo teacherCourseVo);

    List<TeacherCourseVo> loadTeacherCourse(String searchKey);

    int editCourseInfo(TeacherCourse teacherCourse);

    int delete(TeacherCourseKey teacherCourseKey);

    int deleteList(List<Integer> teacherIds,List<Integer> courseIds);

    List<TeacherCourseVo> selectCourseList(Integer id);

    List<TeacherCourseVo> getCourseListBySid(int isAll, String searchKey, int id);

    void completeCoures(Integer teacherId, Integer courseId);
}
