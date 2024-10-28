package com.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.model.LoginLog;
import com.model.User;
import com.vo.UserVo;
import com.service.LoginLogService;
import com.utils.MD5Util;
import com.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userservice;
	@Autowired
	private LoginLogService loginLogService;

	@RequestMapping("/login")
	public String login(){
		return "login";
	}

	//管理员页面
	@RequestMapping("/main")
	public String tomain(){
		return "main";
	}

	//老师页面
	@RequestMapping("/main0")
	public String tomain0(){
		return "main0";
	}

	//学生页面
	@RequestMapping("/main1")
	public String tomain1(){
		return "main1";
	}

	@RequestMapping("/userlist")
	public String userlist(){
		return "userlist";
	}

	@RequestMapping("/welcome")
	public String welcome(){
		return "welcome";
	}

	@RequestMapping("/editpsw")
	public String editpsw(){
		return "editpsw";
	}


	@RequestMapping("/userInfo")
	public String userInfo(){
		return "userInfo";
	}

	@RequestMapping("/logindo")
	@ResponseBody
	public Map<String,Object> Logindo(User user, HttpSession session){
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		int number = user.getNumber();
		String password = MD5Util.digest(user.getPassword());
		System.out.println("用户名："+number+"  密码："+password);
		List<User> userlist = userservice.selectByUP(number, password);
		if(userlist.size() >= 1){
			for (User user1 : userlist) {
				session.setAttribute("currentUser", user1);   // 将用户对象添加到session
				//添加日志到loginLog表
				LoginLog loginLog = new LoginLog();
				loginLog.setLogindate(new Date());
				loginLog.setLoginname(user1.getUsername());
				loginLog.setLoginip(WebUtils.getHttpServletRequest().getRemoteAddr());
				int i = loginLogService.addLoginLog(loginLog);
				System.out.println(i);
				session.setMaxInactiveInterval(1800);   //  设置session的过期时间  单位是秒
				resMap.put("res", "1");
				resMap.put("role",user1.getRole());
			}

		}else{
			resMap.put("res", "0");
			resMap.put("message","用户名或密码错误");
		}
		return resMap;
	}


	@RequestMapping("/logout")
	public String Logout(HttpSession session){
		if(session != null){
			session.invalidate();  // 清除session
		}
		return "login";
	}
	@RequestMapping("/editpswdo")
	@ResponseBody
	public Map<String,Object> editpswdo(int id,String oldpsw,String newpsw,String againpsw){
		Map map = new HashMap();
		//先根据id查询出来原密码
		User user1 = userservice.selectUserById(id);
		if ((user1.getPassword()).equals(MD5Util.digest(oldpsw))) {

			User user = new User();
			if (newpsw.equals(againpsw)) {//后端校验两次输入的密码是否相同
				user.setId(id);
				user.setPassword(MD5Util.digest(newpsw));
			}
			int i = userservice.updateByPrimaryKeySelective(user);
			if (i >= 1) {
				map.put("res", 1);
				map.put("message","【"+user1.getUsername()+"】密码已修改");
			} else {
				map.put("message", "更新失败");
			}
		}else{
			map.put("message","原密码不正确");
		}
		return map;
	}


	@RequestMapping("/getUserlist")
	@ResponseBody
	public Map getUserlist(UserVo userVo) {
		Page<Object> p = PageHelper.startPage(userVo.getPage(),userVo.getLimit());
		p.setOrderBy("id");
		HashMap<String, Object> map = new HashMap<String,Object>();
		List<User> userlist = userservice.selectByExample(userVo);

		PageInfo pageInfo = new PageInfo(userlist,5);
		long count = pageInfo.getTotal();
		map.put("code", 0);
		map.put("count", count);
		map.put("data", pageInfo.getList());
		return map;
		//json封装的数据查出的中文全为？
		/*JSONObject json = new JSONObject();
		long count = pageInfo.getTotal();
		json.put("code", 0);
		json.put("count", count);
		json.put("data", pageInfo.getList());
		return json.toString();*/
	}

	@RequestMapping("/addUser")
	@ResponseBody
	public Map<String,Object> addUser(UserVo userVo){
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		System.out.println(userVo.getNumber());
		User user = new User();
		user.setUsername(userVo.getUsername());
		user.setPassword(MD5Util.digest(userVo.getPassword()));
		user.setNumber(userVo.getNumber());
		user.setBirthday(userVo.getBirthday());
		user.setEmail(userVo.getEmail());
		user.setRole(userVo.getRole());
		user.setSex(userVo.getSex());
		user.setStatus(userVo.getStatus());
		user.setAddress("北京");
		user.setDescription("坤德含弘，至善尚美");
		int res = userservice.addUser(user);
		if(res >=1 ){
			resMap.put("code", 0);
			resMap.put("msg", "添加成功");
		}else{
			resMap.put("code", "1");
			resMap.put("msg", "添加失败");
		}
		return resMap;
	}

	@RequestMapping("/editUser")
	@ResponseBody
	public Map<String,Object> editUser(User user){
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		if(user.getPassword()!=null){
			user.setPassword(MD5Util.digest(user.getPassword()));
		}
		int res = userservice.updateUser(user);
		if(res >=1 ){
			resMap.put("msg", "修改成功");
		}else{
			resMap.put("msg", "修改失败");
		}
		return resMap;
	}

	@RequestMapping("/deleteUser")
	@ResponseBody
	public Map<String,Object> deleteUser(int id){
		HashMap<String,Object> resMap = new HashMap<String,Object>();


		int res = userservice.deleteUsers(id);
		if(res >=1 ){
			resMap.put("res", "ok");
			resMap.put("message", "删除成功");
		}else{
			resMap.put("res", "fail");
			resMap.put("message", "删除失败");
		}
		return resMap;
	}


	@RequestMapping("/deleteBatchUser")
	@ResponseBody
	public Map deleteBatchUser(Integer []ids){
		Map map =  new HashMap();
		int count  = userservice.deleteBatchUser(ids);
		if(count == ids.length){
			map.put("code",0);
			map.put("msg","删除成功！！！");
		}else {
			map.put("msg","删除失败");
		}
		return map;
	}

	@RequestMapping("/selectUser")
	@ResponseBody
	public Map selectUser(int id){
		Map map = new HashMap();
		User user = userservice.selectUserById(id);
		map.put("res",user);
		return map;
	}


}
