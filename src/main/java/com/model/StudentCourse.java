package com.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class StudentCourse extends StudentCourseKey {
    private Integer score;

    private String result;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date time;

    private String evaluate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date evTime;

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result == null ? null : result.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(String evaluate) {
        this.evaluate = evaluate == null ? null : evaluate.trim();
    }

    public Date getEvTime() {
        return evTime;
    }

    public void setEvTime(Date evTime) {
        this.evTime = evTime;
    }
}