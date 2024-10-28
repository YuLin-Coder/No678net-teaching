package com.mapper;

import com.model.Courseware;
import com.model.CoursewareExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CoursewareMapper {
    long countByExample(CoursewareExample example);

    int deleteByExample(CoursewareExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Courseware record);

    int insertSelective(Courseware record);

    List<Courseware> selectByExample(CoursewareExample example);

    Courseware selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Courseware record, @Param("example") CoursewareExample example);

    int updateByExample(@Param("record") Courseware record, @Param("example") CoursewareExample example);

    int updateByPrimaryKeySelective(Courseware record);

    int updateByPrimaryKey(Courseware record);
}