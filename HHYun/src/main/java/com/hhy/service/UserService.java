package main.java.com.hhy.service;

import java.util.List;

import main.java.com.hhy.pojo.User;

public interface UserService {
	//����û��б�
	List<User> list();
	//����û�����
	int count();
	
	//��½�ж�
	User login(String userName,String password);
	//�����û�����ȡUser
	User getUserByName(String userName);
	//�û�ע��
	int add(User user);
	//����ID��ȡUser
	public User getUserByID(String id);
}
