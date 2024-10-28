package com.vo;

import com.model.User;

/**
 * @author 丹青
 * @date 2019/12/13-23:55
 */
public class UserVo extends User {
    private int limit;
    private int page;
    private String code;

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
