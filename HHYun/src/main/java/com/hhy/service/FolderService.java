package main.java.com.hhy.service;

import java.util.List;
import java.util.Map;

import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.FolderTree;

public interface FolderService {
	int insert(Folder record);

	Folder getFolderByID(String folderID);

	List<Folder> getFolderList(String superFolderID, int isDelete, String userID);

	int layFolderRecycle(String folderID, int state);

	int reName(String id, String newName);

	int batchLayFolder(List<String> folderIDList, int folder_deletesign);

	public List<String> findFolderIDBySuperID(String folderID, int state);

	int updateIsDelete(String id, int isDelete);

	Folder getRecycleByID(String folderID, int isDelete);

	boolean judgeCateName(String cat_uid, String[] cateids, String aimcateid, int flag);

	// public Folder get(String cate_id, Integer state);
	List<Folder> findAllCate(Map<String, Object> map);

	Folder get(Map<String, Object> map);

	public void getAllFolder(String userID, String superFolderID, FolderTree ft);

	List<Folder> getFolderNext(String superFolderID);
}
