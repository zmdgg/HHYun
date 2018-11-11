package main.java.com.hhy.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.com.hhy.mapper.FileMapper;
import main.java.com.hhy.mapper.FolderMapper;
import main.java.com.hhy.mapper.UserMapper;
import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.FolderTree;
import main.java.com.hhy.service.FileService;
import main.java.com.hhy.service.FolderService;

@Service
public class FolderServiceImpl implements FolderService {
	@Autowired
	FolderMapper folderMapper;
	@Autowired
	FileMapper fileMapper;
	//必须用@Resource，不然会抛nullpointexception

	@Resource
	FileServiceImpl fileServiceImpl;
	@Resource
	FolderServiceImpl folderServiceImpl;

	/*
	@Resource
	FileService fileServiceImpl;
	@Resource
	FolderService folderServiceImpl;
*/
	
	@Override
	public int insert(Folder record) {
		// TODO Auto-generated method stub
		return folderMapper.insert(record);
	}


	@Override
	public Folder getFolderByID(String folderID) {
		// TODO Auto-generated method stub
		return folderMapper.selectByPrimaryKey(folderID);
	}


	@Override
	public List<Folder> getFolderList(String superFolderID, int isDelete, String userID) {
		// TODO Auto-generated method stub
		return folderMapper.getFolderList(superFolderID, isDelete,userID);
	}


	@Override
	public int layFolderRecycle(String folderID,int state) {
		
		//先删除该文件夹下的所有文件
		List <String>  listfile = fileServiceImpl.findFileIDByFolderID(folderID, state);
		if(listfile != null && listfile.size() !=0){
			System.out.println(listfile.size());
			if(state==0){
				fileServiceImpl.batchLayFile(listfile, 1);
			}else {
				fileServiceImpl.batchLayFile(listfile, 0);
			}
		}
		//再递归删除该文件夹下的所有文件夹
		List<String> listcate = folderServiceImpl.findFolderIDBySuperID(folderID, state);
		if( listcate != null && listcate.size() !=0 ){
			for (String newcat_id : listcate) {
				layFolderRecycle(newcat_id, state);
			}
		}
		//最后把自己删了
		Map<String, Object> map = new HashMap<String, Object>();
		if(state==0){
			map.put("state",1);
		}else {
			map.put("state",0);
		}
		map.put("id", folderID);
		
		return folderMapper.updateFolder(map);
	}

	/**
	 * 根据cat_reid 和 cat_state 来查找文件夹ID
	 * @param cat_reid
	 * @param cat_state
	 * @return
	 */
	public List<String> findFolderIDBySuperID(String superID,Integer state){
		Map<String, Object> map =new HashMap<String, Object>();
		map.put("superID", superID);
		map.put("state", state);
		return folderMapper.findFolderIDBySuperID(map);
	}
	@Override
	public int reName(String id, String newName) {
		// TODO Auto-generated method stub
		return folderMapper.reName(id, newName);
	}


	@Override
	public int batchLayFolder(List<String> folderIDList, int folder_deletesign) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", folderIDList);
		map.put("folder_deletesign", folder_deletesign);
		//System.out.println();
		return folderMapper.batchLayFile(map);
	}


	@Override
	public List<String> findFolderIDBySuperID(String folderID, int state) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("superFolderID", folderID);
		map.put("state", state);
		// TODO Auto-generated method stub
		return folderMapper.findFolderIDBySuperID(map);
	}


	@Override
	public int updateIsDelete(String id, int isDelete) {
	
	//先删除该文件夹下的所有文件
		List <String>  listfile = fileServiceImpl.findFileIDByFolderID(id, 1);
		if(listfile != null && listfile.size() !=0){
			fileServiceImpl.batchLayFile(listfile, 2);
		}
		//再递归删除该文件夹下的所有文件夹
		List<String> listcate = folderServiceImpl.findFolderIDBySuperID(id, 1);
		if( listcate != null && listcate.size() !=0 ){
			for (String newcat_id : listcate) {
				updateIsDelete(newcat_id, 2);
			}
		}
		return folderMapper.updateIsDelete(id, 2);
	}


	@Override
	public Folder getRecycleByID(String folderID, int isDelete) {
		//System.out.println("getRecycleByID");
		// TODO Auto-generated method stub
		return folderMapper.getRecycleByID(folderID, isDelete);
	}

	/**
	 * 判读同级目录下是否有相同名字的文件夹
	 * @param cateids
	 * @param aimcateid
	 * @return
	 */
	public boolean judgeCateName(String cat_uid,String[] cateids,String aimcateid,int flag){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cat_uid", cat_uid);
		map.put("cat_reid", aimcateid);
		map.put("cat_state", 0);
		System.out.println("456");
	    List<Folder> list =folderServiceImpl.findAllCate( map);
		for (Folder aimcategorie : list) {
			for (String cateid : cateids) {
				Folder categorie;
				Map<String, Object> t = new HashMap<String, Object>();
				t.put("cat_id", cateid);
			
				if(flag == 0){
					t.put("cat_state", 0);
					 categorie = folderServiceImpl.get(t);
				}else {
					t.put("cat_state", 1);
					 categorie =  folderServiceImpl.get(t);
				}
				if(aimcategorie.getFolderName().equals(categorie.getFolderName())){
					return false;
				}
				
			}
		}
		return true;
	}/**
	 * 根据ID查询一个文件夹，区分是否有deleteSign ，0 ，1；
	 * @return
	 */
	public Folder get(String cate_id, Integer state) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cat_id", cate_id);
		map.put("cat_state", state);
		
		return folderMapper.get(map);
	}


	@Override
	public List<Folder> findAllCate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return folderMapper.findAllCate(map);
	}


	@Override
	public Folder get(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return folderMapper.get(map);
	}


	@Override
	public void getAllFolder(String userID, String superFolderID, FolderTree ft) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userID", userID);
		map.put("superFolderID", superFolderID);
		map.put("isDelete", 0);
		List<FolderTree> list = folderMapper.getAllFolder(map);
		if(list!=null && list.size() != 0){
			for (FolderTree folderTree : list) {
				getAllFolder(userID,folderTree.getFolderID(),folderTree);
			}
			ft.setList(list);
		}
	}


	@Override
	public List<Folder> getFolderNext(String superFolderID) {
		// TODO Auto-generated method stub
		return folderMapper.getFolderNext(superFolderID);
	}
	

}
