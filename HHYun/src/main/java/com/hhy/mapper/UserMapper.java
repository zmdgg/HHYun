package main.java.com.hhy.mapper;

import java.util.List;

import main.java.com.hhy.pojo.User;

public interface UserMapper {
	public int add(User user); 
    
    public void delete(int id); 
        
    public User get(int id); 
      
    public int update(User category);  
        
    public List<User> list();
     
    public int count(); 
    
    public User login(String userName,String password);
    public User getUserByName(String userName); 
    public User getUserByID(String id);
}
