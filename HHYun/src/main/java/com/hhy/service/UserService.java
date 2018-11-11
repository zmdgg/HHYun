package main.java.com.hhy.service;

import java.util.List;

import main.java.com.hhy.pojo.User;

public interface UserService {
	//获得用户列表
	List<User> list();
	//获得用户数量
	int count();
	
	//登陆判断
	User login(String userName,String password);
	//根据用户名获取User
	User getUserByName(String userName);
	//用户注册
	int add(User user);
	//根据ID获取User
	public User getUserByID(String id);
}
