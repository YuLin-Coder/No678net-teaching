package com.service;

import com.model.StudentCourse;
import com.model.StudentCourseKey;
import com.vo.StudentCourseVo;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/21-20:00
 */
public interface StudentCouserseService {
    int choiceCourse(StudentCourse studentCourse, Integer teacherId);

    int delete(StudentCourseKey studentCourseKey);

    List<StudentCourseVo> getStudentListByTid(Integer number);

    int updateScore(StudentCourse studentCourse);

    List<StudentCourseVo> getStudentScoreListBySid(Integer number);

    List<StudentCourseVo> getAllStudentScoreList();

    int updateEv(StudentCourse studentCourse);

    List<StudentCourseVo> getStudentScoreListForM();
}
