package main.java.com.hhy.mapper;

import java.util.List;

import main.java.com.hhy.pojo.ShareData;

public interface ShareDataMapper {
    int deleteByPrimaryKey(String id);

    int insert(ShareData record);

    int insertSelective(ShareData record);

    ShareData selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ShareData record);

    int updateByPrimaryKey(ShareData record);
    
	List<ShareData> getShareDataList(String magID);
	
	void cancleShare(ShareData sd);
}