package com.service.impl;

import java.util.List;

import com.mapper.UserMapper;
import com.model.User;
import com.model.UserExample;
import com.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.UserService;

@Service("userservice")
public class UserServiceImpl implements UserService {

    @Autowired
	private UserMapper userMapper;



    @Override
    public int addUser(User user) {
//        String id = UUID.randomUUID().toString();  //设置id:随机字符串
//        user.setId(id);
    	return userMapper.insert(user);
    }


    @Override
    public int deleteUsers(int id) {
        return userMapper.deleteByPrimaryKey(id);
    }





    @Override
    public List<User> selectByUP(int number, String password) {
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andNumberEqualTo(number);
        criteria.andPasswordEqualTo(password);
        return userMapper.selectByExample(userExample);
    }

    @Override
    public int updateByPrimaryKeySelective(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public User selectUserById(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<User> selectByExample(UserVo userVo) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();

        criteria.andUsernameLike("%"+userVo.getUsername()+"%");
        criteria.andAddressLike("%"+userVo.getAddress()+"%");
        if(userVo.getSex() != null){
            criteria.andSexEqualTo(userVo.getSex());
        }
        if (userVo.getRole() != null) {
            criteria.andRoleEqualTo(userVo.getRole());
        }
        if(userVo.getStatus() != null){
            criteria.andStatusEqualTo(userVo.getStatus());
        }

        return userMapper.selectByExample(example);
    }

    @Override
    public int deleteBatchUser(Integer []ids) {
        int totalCount = 0;
        for (Integer id : ids) {
            int count = userMapper.deleteByPrimaryKey(id);
            totalCount += count;
        }
        return totalCount;
    }

    @Override
    public int updateUser(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }
}
