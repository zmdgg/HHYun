package main.java.com.hhy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.FolderTree;
import main.java.com.hhy.pojo.MyFile;

public interface FolderMapper {
	int deleteByPrimaryKey(String id);

	int insert(Folder record);

	int insertSelective(Folder record);

	Folder selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(Folder record);

	int updateByPrimaryKey(Folder record);

	List<Folder> getFolderList(String superFolderID, int isDelete, String userID);

	int layFolderRecycle(String folderID);

	int reName(String id, String newName);

	int batchLayFile(Map<String, Object> map);

	public List<String> findFolderIDBySuperID(Map<String, Object> map);

	public int updateFolder(Map<String, Object> map);

	List<Folder> getFolderListByIsDelete(int isDelete, String userID);

	Folder getFolderByIsDelete(int isDelete, String id);

	int updateIsDelete(String id, int isDelete);

	Folder getRecycleByID(String folderID, int isDelete);

	/*
	 * boolean judgeCateName(String cat_uid, String[] cateids, String
	 * aimcateid,int flag);
	 */
	List<Folder> findAllCate(Map<String, Object> map);

	List<FolderTree> getAllFolder(Map<String, Object> map);

	Folder get(Map<String, Object> map);

	List<Folder> getFolderNext(String superFolderID);

	boolean updateCatereid(String cat_id, String cat_reid);
}