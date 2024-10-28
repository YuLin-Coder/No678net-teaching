package com.service;

import com.model.User;
import com.vo.UserVo;

import java.util.List;

public interface UserService {
	public int addUser(User user);
	/*;



	public List<User>  getUserList(User user, int startrows, int endrows, String order, String sort);
	public int  getUserListCount(User user);
*/

   public List<User> selectByUP(int number, String password);

   public int updateByPrimaryKeySelective(User user);

   public User selectUserById (int id);

   public List<User> selectByExample(UserVo userVo);

   public int updateUser(User user);

   public int deleteBatchUser(Integer []ids);

   public int deleteUsers(int id);
}
