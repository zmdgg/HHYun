package main.java.com.hhy.service;


import java.util.List;

import main.java.com.hhy.pojo.Share;
import main.java.com.hhy.pojo.ShareData;

public interface ShareService {
	void addshare(Share share);
	void sharefile(ShareData sharefile, String[] s_type);
	
	Share selectByMagID(String magID);
	
	Share checkpwd(String magID,String sharepwd);
	
	List<ShareData> getShareDataList(String magID);
	

	int checkFolder(String[] cidlist, String[] cnamelist, int cateflag, String id, String recateid);
	int checkfile(String[] fid, String[] fname, int flag, String uid, String recateid);
	//这里仅仅数据库改变，页有文件读写，与fileandfolder区分
	void preservationcate(String id, String[] cidlist, String cate_reid);
	void preservation(String id, String[] fid, String file_cateid);
	
	List<Share> getMyShareList(String userID);
	void cancleShare(ShareData sd);
}
