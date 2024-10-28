package com.vo;

import com.model.StudentCourse;

/**
 * @author 丹青
 * @date 2020/1/1-13:31
 */
public class ForStudentCourseVo extends StudentCourse {
    private String name;
    private String username;
    private String testModel;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTestModel() {
        return testModel;
    }

    public void setTestModel(String testModel) {
        this.testModel = testModel;
    }

}
