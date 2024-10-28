package com.model;

import java.io.PipedReader;
import java.util.List;

public class Student {
    private Integer id;
    private String password;
    private String username;
    private String jionDate;
    private String major;
    private String grdate;
    private List<Course> list;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getJionDate() {
        return jionDate;
    }

    public void setJionDate(String jionDate) {
        this.jionDate = jionDate;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getGrdate() {
        return grdate;
    }

    public void setGrdate(String grdate) {
        this.grdate = grdate;
    }

    public List<Course> getList() {
        return list;
    }

    public void setList(List<Course> list) {
        this.list = list;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", password='" + password + '\'' +
                ", username='" + username + '\'' +
                ", jionDate='" + jionDate + '\'' +
                ", major='" + major + '\'' +
                ", grdate='" + grdate + '\'' +
                ", list=" + list +
                '}';
    }
    // public List<Course> getList() {
    //     return list;
    // }
    //
    // public void setList(List<Course> list) {
    //     this.list = list;
    // }
    //
    // public Integer getId() {
    //     return id;
    // }
    //
    // public void setId(Integer id) {
    //     this.id = id;
    // }
    //
    // public String getPassword() {
    //     return password;
    // }
    //
    // public void setPassword(String password) {
    //     this.password = password == null ? null : password.trim();
    // }
    //
    // public String getUsername() {
    //     return username;
    // }
    //
    // public void setUsername(String username) {
    //     this.username = username == null ? null : username.trim();
    // }
    //
    // public String getJionDate() {
    //     return jionDate;
    // }
    //
    // public void setJionDate(String jionDate) {
    //     this.jionDate = jionDate == null ? null : jionDate.trim();
    // }
    //
    // public String getMajor() {
    //     return major;
    // }
    //
    // public void setMajor(String major) {
    //     this.major = major == null ? null : major.trim();
    // }
    //
    // public String getGrdate() {
    //     return grdate;
    // }
    //
    // public void setGrdate(String grdate) {
    //     this.grdate = grdate == null ? null : grdate.trim();
    // }
}