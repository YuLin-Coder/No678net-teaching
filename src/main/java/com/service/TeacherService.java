package com.service;

import com.model.Teacher;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/16-15:17
 */
public interface TeacherService {

    int addTeacher(Teacher teacher);

    List<Teacher> search(String username);

    int deleteTeacher(int id);

    int deleteBatchTeacher(Integer[] ids);

    int editTeacher(Teacher teacher);
}
