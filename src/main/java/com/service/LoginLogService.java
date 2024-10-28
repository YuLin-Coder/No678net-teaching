package com.service;

import com.model.LoginLog;
import com.vo.LoginLogVo;

import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/17-20:26
 */
public interface LoginLogService {

    int addLoginLog(LoginLog loginLog);

    List<LoginLog> getLoginLog(LoginLogVo loginLogVo);

    int deleteLoginLog(Integer id);

    int deleteBatchTeacher(Integer[] ids);
}
