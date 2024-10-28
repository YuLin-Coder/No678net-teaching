package com.vo;

/**
 * @author 丹青
 * @date 2019/12/22-10:33
 */
public class StudentCourseVo{
    private Integer studentId;
    private Integer courseId;
    private String username;
    private String grdate;
    private String result;
    private Integer score;
    private String name;

    public Integer getStudentId() {
        return studentId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getGrdate() {
        return grdate;
    }

    public void setGrdate(String grdate) {
        this.grdate = grdate;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
