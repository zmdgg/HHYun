package main.java.com.hhy.mapper;

import java.util.List;

import main.java.com.hhy.pojo.Share;

public interface ShareMapper {
    int deleteByPrimaryKey(String id);

    int insert(Share record);

    int insertSelective(Share record);

    Share selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Share record);

    int updateByPrimaryKey(Share record);
    
    
    Share selectByMagID(String magID);
    Share checkpwd(String magID,String sharepwd);
    
    List<Share> getMyShareList(String userID);
}