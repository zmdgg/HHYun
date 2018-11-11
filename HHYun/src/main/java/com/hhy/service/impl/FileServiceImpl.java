package main.java.com.hhy.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.com.hhy.mapper.FileMapper;
import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.MyFile;
import main.java.com.hhy.service.FileService;

@Service
public class FileServiceImpl implements FileService {
	@Autowired
	FileMapper fileMapper;
	
	@Override
	public int add(MyFile file) {
		// TODO Auto-generated method stub
		return fileMapper.insert(file);
	}


	@Override
	public List<MyFile> getFileList(String folderID, int isDelete, String userID) {
		// TODO Auto-generated method stub
		return fileMapper.getFileList(folderID, isDelete, userID);
	}


	@Override
	public MyFile getFileByID(String fileID) {
		// TODO Auto-generated method stub
		return fileMapper.selectByPrimaryKey(fileID);
	}


	@Override
	public int layFileRecycle(String fileID) {
		// TODO Auto-generated method stub
		return fileMapper.layFileRecycle(fileID);
	}


	@Override
	public int reName(String id, String newName) {
		// TODO Auto-generated method stub
		return fileMapper.reName(id, newName);
	}


	@Override
	public int batchLayFile(List<String> fileIDList, int file_deletesign) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", fileIDList);
		map.put("file_deletesign", file_deletesign);
		//System.out.println();
		return fileMapper.batchLayFile(map);
	}


	@Override
	public MyFile getFileByMD5(String md5) {
		// TODO Auto-generated method stub
		return fileMapper.getFileByMD5(md5);
	}


	public List<String> findFileIDByFolderID(String folderID, int state) {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println(folderID);
			map.put("folderID", folderID);
			map.put("file_deletesign", state);
			return fileMapper.findFileIDByFolderID(map);

	}


	@Override
	public int updateIsDelete(String id, int isDelete) {
		// TODO Auto-generated method stub
		return fileMapper.updateIsDelete(id, isDelete);
	}
	
	/**
	 * 判断目标文件夹下有无名字相同的文件
	 */
	public boolean judgeFileName(String userID, String[] fileids,
			String aimcatid,int flag) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file_uid", userID);
		map.put("file_catid", aimcatid);
		map.put("file_deletesign", 0);
		List<MyFile> listids = fileMapper.findAllByUser(map);
		if (listids != null && listids.size() != 0) {
			for (MyFile netfile1 : listids) {
				for (String fileid : fileids) {
					MyFile netfile2 = fileMapper.getFileByIsDelete(flag, fileid);
					if (netfile1.getFileName().equals(netfile2.getFileName())) {
						return false;
					}
				}
			}
		}

		return true;
	}


	@Override
	public MyFile getFileByIDAndState(String fileID, int isDelete) {
		// TODO Auto-generated method stub
		return fileMapper.getFileByIDAndState(fileID, isDelete);
	}


	@Override
	public List<MyFile> getFolderNextFile(String folderID) {
		// TODO Auto-generated method stub
		return fileMapper.getFolderNextFile(folderID);
	}
	
}
