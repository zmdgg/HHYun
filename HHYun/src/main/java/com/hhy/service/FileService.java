package main.java.com.hhy.service;

import java.util.List;
import java.util.Map;

import main.java.com.hhy.pojo.MyFile;

public interface FileService {
	//上传
	int add(MyFile file);
	//根据id获得MyFile
	MyFile getFileByID(String fileID);
	
	List<MyFile> getFileList(String folderID, int isDelete, String userID);

	int layFileRecycle(String fileID);
	
	int reName(String id, String newName);

	int batchLayFile(List<String> fileIDList, int file_deletesign);

	MyFile getFileByMD5(String md5);

	List<String> findFileIDByFolderID(String folderID, int state);

	int updateIsDelete(String id, int isDelete);

	public boolean judgeFileName(String file_uid, String[] fileids, String aimcatid, int flag);

	MyFile getFileByIDAndState(String fileID, int isDelete);

	List<MyFile> getFolderNextFile(String folderID);
}
