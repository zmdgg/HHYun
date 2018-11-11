package main.java.com.hhy.mapper;

import java.util.List;
import java.util.Map;

import main.java.com.hhy.pojo.MyFile;

public interface FileMapper {
	int deleteByPrimaryKey(String id);

	int insert(MyFile record);

	int insertSelective(MyFile record);

	MyFile selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(MyFile record);

	int updateByPrimaryKey(MyFile record);

	// 其实有folderID就够了，因为folderID本身就唯一
	List<MyFile> getFileList(String folderID, int isDelete, String userID);

	int layFileRecycle(String fileID);

	int reName(String id, String newName);

	int batchLayFile(Map<String, Object> map);

	MyFile getFileByMD5(String md5);

	public List<String> findFileIDByFolderID(Map<String, Object> map);

	List<MyFile> getFileListByIsDelete(int isDelete, String userID);

	MyFile getFileByIsDelete(int isDelete, String id);

	int updateIsDelete(String id, int isDelete);

	List<MyFile> findAllByUser(Map<String, Object> map);

	MyFile getFileByIDAndState(String fileID, int isDelete);

	List<MyFile> getFolderNextFile(String folderID);

	boolean moveFile(String netFile_id, String cat_id);
}