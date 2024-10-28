package com.service;

import com.model.Student;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/16-17:37
 */
public interface StudentService {
    
    public int addStudent(Student student);
    
    List<Student> search(String username);

    int deleteStudent(int id);

    int deleteBatchStudent(Integer[] ids);

    int editStudent(Student student);
}
