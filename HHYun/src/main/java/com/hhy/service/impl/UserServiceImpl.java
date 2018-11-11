package main.java.com.hhy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.com.hhy.mapper.UserMapper;
import main.java.com.hhy.pojo.User;
import main.java.com.hhy.service.UserService;


@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper userMapper;
    public User login(String userName,String password){
        return userMapper.login(userName,password);
    }
    public List<User> list(){
        return userMapper.list();
    }
    public int count(){
    	return userMapper.count();
    }
    public int add(User user){
    	return userMapper.add(user);
    }
	@Override
	public User getUserByName(String userName) {
		// TODO Auto-generated method stub
		return userMapper.getUserByName(userName);
	}
	@Override
	public User getUserByID(String id) {
		// TODO Auto-generated method stub
		return userMapper.getUserByID(id);
	}
}
