package main.java.com.hhy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import main.java.com.hhy.mapper.FileMapper;
import main.java.com.hhy.mapper.FolderMapper;
import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.FolderTree;
import main.java.com.hhy.service.FolderService;
import main.java.com.hhy.service.impl.FileServiceImpl;
import main.java.com.hhy.service.impl.FolderServiceImpl;
import main.java.com.hhy.util.IDGenerator;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class FolderController {
	@Autowired
	private FolderService folderService;

	//新建文件夹
	@RequestMapping(value="/createFolder")
	public String addFolder(HttpServletRequest request) {
		Folder folder = new Folder();
		//文件夹ID
		folder.setId(IDGenerator.genPrimaryKey());
		//文件夹名
		String folderName = request.getParameter("folderName");
		folder.setFolderName(folderName);
		System.out.println(folderName);
		//用户ID
		String userID = request.getParameter("userID");
		folder.setUserID(userID);
		 //日期
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        String temp = formatter.format(new Date());
        Date date;
		try {
			date = formatter.parse(temp);
			folder.setUpdateDate(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		//父级文件夹ID
		String superFolderID = request.getParameter("superFolderID");
		folder.setSuperFolderID(superFolderID);
		//删除标志
		folder.setIsDelete(0);
		//存入数据库
		int result = folderService.insert(folder);
		System.out.println(result);
		if(result==0)
			return "error";
		else
			return "success";
	}
	
	//把文件夹放入回收站
	@RequestMapping(value="/layFolderRecycle")
	@ResponseBody
	public String layFolderRecycle(HttpServletRequest request) {
		String folderID = request.getParameter("folderID");
		//System.out.println(folderID);
		int result = folderService.layFolderRecycle(folderID, 0);
	    if(result==0)
	       return "error";
	    else
	       return "success";
	}
	
	//删除文件夹
	@RequestMapping(value="/deleteFolder")
	@ResponseBody
	public String deleteFolder(HttpServletRequest request) {
		String folderID = request.getParameter("folderID");
		//System.out.println(folderID);
		// isDelete 0正常，1回收站，2删除
		int result = folderService.updateIsDelete(folderID,2);
	    if(result==0)
	       return "error";
	    else
	       return "success";
	}
	
	//还原文件夹
	@RequestMapping(value="/restoreFolder")
	@ResponseBody
	public JSONObject restoreFolder(HttpServletRequest request){
		JSONObject result = new JSONObject();
		String folderID = request.getParameter("folderID");
		System.out.println(folderID);
		if(folderID != null){
			//
			 Folder folder =folderService.getRecycleByID(folderID, 1);
			 //System.out.println(folder.getFolderName());
			 //System.out.println("123");
			 String[] cateids = new String[]{folderID};
			 boolean flag = folderService.judgeCateName(folder.getUserID(), cateids, folder.getSuperFolderID(),1);
			 //boolean flag = false;
			 System.out.println("789");
			 if(!flag){
				 Folder re_categorie =folderService.getFolderByID(folder.getSuperFolderID());
				 if(re_categorie == null){
					 result.put("result", "主文件夹中已经有相同名字的文件夹,请修改名字后在还原！");
					 
				 }else {
					 result.put("result", re_categorie.getFolderName()+"中已经有相同名字的文件夹,请修改名字后在还原！");
				}
				
			 }else{
				 folderService.layFolderRecycle(folderID, 1);
				 result.put("result","文件夹成功还原！");
			 }
		}
	
		return result;
	}
	
	//显示所有文件夹
	@RequestMapping(value="/showAllFolder")
	@ResponseBody
	public JSONArray showAllFolder(HttpServletRequest request) {
		String userID = request.getParameter("userID");
		System.out.println(userID);
		FolderTree ft = new FolderTree();
		ft.setFolderID("");
		ft.setFolderName("全部文件");
		folderService.getAllFolder(userID, "", ft);
		List<FolderTree> list = new ArrayList<FolderTree>();
		list.add(ft);
		JSONArray result = JSONArray.fromObject(list);
		
		return result;
	
	}
}
