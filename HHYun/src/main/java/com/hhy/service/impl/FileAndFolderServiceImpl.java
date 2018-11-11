package main.java.com.hhy.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.com.hhy.mapper.FileMapper;
import main.java.com.hhy.mapper.FolderMapper;
import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.FolderTree;
import main.java.com.hhy.pojo.MyFile;
import main.java.com.hhy.service.FileAndFolderService;
import main.java.com.hhy.util.FileUtils;
import main.java.com.hhy.util.IDGenerator;

@Service
public class FileAndFolderServiceImpl implements FileAndFolderService {
	@Autowired
	FolderMapper folderMapper;
	@Autowired
	FileMapper fileMapper;

	// 获得回收站文件和文件夹
	public Map<String, Object> showRecycle(String userID) {
		// 最终的文件夹列表
		List<Folder> folderList = new ArrayList<Folder>();
		// 先得到所有放入回收站的文件夹
		List<Folder> tempFolderList = folderMapper.getFolderListByIsDelete(1, userID);
		// 遍历
		for (Folder folder : tempFolderList) {
			// 如果该文件夹的父级文件夹为""(即全部文件)，加入列表
			if (folder.getSuperFolderID().equals("")) {
				folderList.add(folder);
			} else {
				// 否则看他的父级文件夹是否也在回收站
				Folder f = folderMapper.getFolderByIsDelete(0, folder.getSuperFolderID());
				// 如果不在回收站，则加入列表
				if (f != null) {
					folderList.add(folder);
				}
			}
		}
		// 最终的文件列表
		List<MyFile> fileList = new ArrayList<MyFile>();
		// 先得到所有放入回收站的文件
		List<MyFile> tempFileList = fileMapper.getFileListByIsDelete(1, userID);
		// System.out.println("123,"+tempFileList.size());
		// 遍历
		for (MyFile file : tempFileList) {
			// 如果该文件的父级文件夹为""(即全部文件)，加入列表
			if (file.getFolderID().equals("")) {
				fileList.add(file);
				// System.out.println("1");
			} else {
				// 否则看他的父级文件夹是否也在回收站
				Folder f = folderMapper.getFolderByIsDelete(0, file.getFolderID());
				// System.out.println(file.getFolderID());
				// 如果不在回收站，则加入列表
				if (f != null) {
					fileList.add(file);
					// System.out.println("2");
				}
			}
		}
		// 做成map结果集
		HashMap<String, Object> recylceMap = new HashMap<String, Object>();
		recylceMap.put("folderList", folderList);
		recylceMap.put("fileList", fileList);
		return recylceMap;
	}

	@Override
	public boolean judgeCateID(String cat_uid, String[] cateids, String aimcateid) {
		// TODO Auto-generated method stub
		for (String cateid : cateids) {
			if (cateid.equals(aimcateid)) {
				return false;
			} else {
				List<FolderTree> listcate = new ArrayList<FolderTree>();
				getSublevelCate(cat_uid, cateid, listcate);
				for (FolderTree cateTree : listcate) {
					if (cateTree.getFolderID().equals(aimcateid)) {
						return false;
					}
				}
			}
		}
		return true;
	}

	/**
	 * 获取所有的子级目录
	 * 
	 * @param cat_uid
	 * @param cate_reid
	 * @return
	 */
	public void getSublevelCate(String cat_uid, String cate_reid, List<FolderTree> listcate) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userID", cat_uid);
		map.put("superFolderID", cate_reid);
		map.put("isDelete", 0);
		List<FolderTree> list = folderMapper.getAllFolder(map);
		if (list != null && list.size() != 0) {
			for (FolderTree catetree : list) {
				listcate.add(catetree);
				getSublevelCate(cat_uid, catetree.getFolderID(), listcate);
			}
		}

	}

	@Override
	public boolean judgeCateName(String cat_uid, String[] cateids, String aimcateid, int flag) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cat_reid", aimcateid);
		map.put("cat_state", 0);
		map.put("cat_uid", cat_uid);
		List<Folder> list = folderMapper.findAllCate(map);
		for (Folder aimcategorie : list) {
			for (String cateid : cateids) {
				Folder categorie;
				if (flag == 0) {
					categorie = folderMapper.getFolderByIsDelete(0, cateid);
				} else {
					categorie = folderMapper.getFolderByIsDelete(1, cateid);
				}
				if (aimcategorie.getFolderName().equals(categorie.getFolderName())) {
					return false;
				}
			}
		}
		return true;
	}

	@Override
	public boolean updateCatereid(String cat_id, String cat_reid) {
		// TODO Auto-generated method stub
		// System.out.println(cat_id);
		// System.out.println(cat_reid);
		return folderMapper.updateCatereid(cat_id, cat_reid);
	}

	@Override
	public boolean judgeFileName(String file_uid, String[] fileids, String aimcatid, int flag) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file_catid", aimcatid);
		map.put("file_deletesign", 0);
		List<MyFile> listids = fileMapper.getFileList(aimcatid, 0, file_uid);
		if (listids != null && listids.size() != 0) {
			for (MyFile netfile1 : listids) {
				for (String fileid : fileids) {
					MyFile netfile2 = fileMapper.getFileByIDAndState(fileid, flag);
					if (netfile2 != null) {
						if (netfile1.getFileName().equals(netfile2.getFileName())) {
							return false;
						}
					}
				}
			}
		}

		return true;
	}

	@Override
	public boolean moveFile(String netFile_id, String cat_id) {
		// TODO Auto-generated method stub
		return fileMapper.moveFile(netFile_id, cat_id);
	}

	/* 保存分享的文件夹 */
	@Override
	public void preservationcate(String id, String[] cidlist, String cate_reid) {
		for (int i = 0; i < cidlist.length; i++) {
			Folder f = folderMapper.getFolderByIsDelete(0, cidlist[i]);
			String cateid = f.getId();
			f.setId(IDGenerator.genPrimaryKey());
			f.setUserID(id);
			f.setSuperFolderID(cate_reid);
			String reid = f.getId();
			// 保存
			folderMapper.insert(f);
			recursion(cateid, reid, id);
		}
	}

	public void recursion(String cateid, String reid, String uid) {
		List<Folder> catelist = folderMapper.getFolderNext(cateid);
		List<MyFile> filelist = fileMapper.getFolderNextFile(cateid);
		if (filelist != null) {
			for (int i = 0; i < filelist.size(); i++) {
				MyFile file = fileMapper.getFileByIDAndState(filelist.get(i).getId(), 0);
				if (file != null) {

					file.setId(IDGenerator.genPrimaryKey());
					file.setUserID(uid);
					file.setFolderID(reid);
					String path = "C:" + File.separatorChar + "hhyDisk" + File.separatorChar + uid + File.separatorChar;
					String filePath = path + file.getId();
					file.setFilePath(filePath);
					// 存到数据库
					fileMapper.insert(file);
				}
			}
		}

		// 再存文件夹
		for (int i = 0; i < catelist.size(); i++) {
			Folder f = folderMapper.getFolderByIsDelete(0, catelist.get(i).getId());
			if (f != null) {

				String cid = f.getId();
				f.setId(IDGenerator.genPrimaryKey());
				f.setUserID(uid);
				f.setSuperFolderID(reid);
				String rid = f.getId();
				folderMapper.insert(f);
				recursion(cid, rid, uid);
			}
		}
	}

	@Override
	public void preservation(String id, String[] fid, String file_cateid) {

		for (int i = 0; i < fid.length; i++) {
			MyFile file = fileMapper.getFileByIsDelete(0, fid[i]);
			if (file != null) {
				file.setId(IDGenerator.genPrimaryKey());
				file.setUserID(id);
				file.setFolderID(file_cateid);
				String path = "C:" + File.separatorChar + "hhyDisk" + File.separatorChar + id + File.separatorChar;
				String filePath = path + file.getId();
				file.setFilePath(filePath);
				// 存到数据库
				fileMapper.insert(file);
			}
		}
	}
}
