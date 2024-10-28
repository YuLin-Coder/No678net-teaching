package com.vo;

import com.model.TeacherCourse;

/**
 * @author 丹青
 * @date 2019/12/19-23:48
 */
public class TeacherCourseVo extends TeacherCourse {
    /**
     * 分页参数
     */
    private Integer page;
    private Integer limit;
    private String username;
    private String name;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }
}
