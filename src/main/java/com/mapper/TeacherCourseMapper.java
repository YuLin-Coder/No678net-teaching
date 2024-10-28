package com.mapper;

import com.model.TeacherCourse;
import com.model.TeacherCourseExample;
import com.model.TeacherCourseKey;
import java.util.List;

import com.vo.TeacherCourseVo;
import org.apache.ibatis.annotations.Param;

public interface TeacherCourseMapper {
    long countByExample(TeacherCourseExample example);

    int deleteByExample(TeacherCourseExample example);

    int deleteByPrimaryKey(TeacherCourseKey key);

    int insert(TeacherCourse record);

    int insertSelective(TeacherCourse record);

    List<TeacherCourse> selectByExample(TeacherCourseExample example);

    List<TeacherCourseVo> selectByExampleWithTC(@Param(value = "searchKey") String searchKey);

    TeacherCourse selectByPrimaryKey(TeacherCourseKey key);

    int updateByExampleSelective(@Param("record") TeacherCourse record, @Param("example") TeacherCourseExample example);

    int updateByExample(@Param("record") TeacherCourse record, @Param("example") TeacherCourseExample example);

    int updateByPrimaryKeySelective(TeacherCourse record);

    int updateByPrimaryKey(TeacherCourse record);

    List<TeacherCourseVo> selectCourseList(@Param(value = "teacherId") Integer id);

    List<TeacherCourseVo> getCourseList(int isAll,String searchKey,int id);
}