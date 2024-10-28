package com.service.impl;

import com.mapper.LoginLogMapper;
import com.model.LoginLog;
import com.model.LoginLogExample;
import com.vo.LoginLogVo;
import com.service.LoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author 丹青
 * @date 2019/12/17-20:28
 */
@Service
public class LoginLogServiceImpl implements LoginLogService {
    @Autowired
    private LoginLogMapper loginLogMapper;

    @Override
    public int addLoginLog(LoginLog loginLog) {
        return loginLogMapper.insert(loginLog);
    }

    @Override
    public List<LoginLog> getLoginLog(LoginLogVo loginLogVo) {
        LoginLogExample example = new LoginLogExample();
        LoginLogExample.Criteria criteria = example.createCriteria();
        if(loginLogVo.getLoginname()!=null){
            criteria.andLoginnameLike("%"+loginLogVo.getLoginname()+"%");
        }
        if (loginLogVo.getLoginip()!=null){
            criteria.andLoginipLike("%"+loginLogVo.getLoginip()+"%");
        }
        if (loginLogVo.getLoginip()!=null){
            criteria.andLoginipLike("%"+loginLogVo.getLoginip()+"%");
        }
        if(loginLogVo.getEndTime()!=null||loginLogVo.getStartTime()!=null){
            if(loginLogVo.getStartTime()==null){
                loginLogVo.setStartTime(new Date());
            }
            if (loginLogVo.getStartTime()==null)
            {
                loginLogVo.setEndTime(new Date());
            }
            criteria.andLogindateBetween(loginLogVo.getStartTime(),loginLogVo.getEndTime());
        }
        return loginLogMapper.selectByExample(example);
    }

    @Override
    public int deleteLoginLog(Integer id) {
        return loginLogMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteBatchTeacher(Integer[] ids) {
        int allCount = 0;
        for (Integer id : ids) {
            int count = loginLogMapper.deleteByPrimaryKey(id);
            allCount += count;
        }
        return allCount;
    }
}
