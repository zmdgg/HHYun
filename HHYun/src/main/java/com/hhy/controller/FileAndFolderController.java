package main.java.com.hhy.controller;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.MyFile;
import main.java.com.hhy.pojo.User;
import main.java.com.hhy.service.FileAndFolderService;
import main.java.com.hhy.service.FileService;
import main.java.com.hhy.service.FolderService;
import main.java.com.hhy.service.UserService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class FileAndFolderController {


	@Autowired
	private FileAndFolderService fileAndFolderService;
	
	@Autowired
	private FileService fileService;
	@Autowired
	private FolderService folderService;

	//获得全部文件
	@RequestMapping(value="showFileAndFolderList")
	@ResponseBody
	public JSONObject  showFileAndFolderList(HttpServletRequest request){
		String folderID = request.getParameter("folderID");
		String userID = request.getParameter("userID");
		//System.out.println(folderID);
		JSONObject json=null;
		try{
			//获得文件列表和文件夹列表
			List<MyFile> fileList = fileService.getFileList(folderID, 0,userID);
			List<Folder> folderList = folderService.getFolderList(folderID, 0,userID);
			Map map = new HashMap();
	        map.put("fileList", fileList);
	        map.put("folderList", folderList);
	        //设置当前访问的列表
	        Folder f = new Folder();
	        if(folderID==""){
	        	f.setFolderName("全部文件");
	        	f.setId("");
	        	f.setIsDelete(0);
	        	f.setSuperFolderID("");
	        	f.setUserID("");
	        	f.setUpdateDate(new Date());
	        }else{
	        	f = folderService.getFolderByID(folderID);
	        }
			map.put("currentFolder", f);
	        json = JSONObject.fromObject(map);
		} catch(Exception e){
           e.printStackTrace();
		}
		return json;
	}
	
	//获得回收站文件
	@RequestMapping(value="showRecycleList")
	@ResponseBody
	public JSONObject  showRecycleList(HttpServletRequest request){
		String folderID = request.getParameter("folderID");
		String userID = request.getParameter("userID");
		JSONObject json=null;
		try{
			Map<String, Object> map = fileAndFolderService.showRecycle(userID);
	        json = JSONObject.fromObject(map);
		} catch(Exception e){
          e.printStackTrace();
		}
		return json;
	}
	
	//清空回收站
	@RequestMapping(value="emptyRecycle")
	@ResponseBody
	public String  emptyRecycle(HttpServletRequest request){
		String fileList = request.getParameter("fileList");
		String folderList = request.getParameter("folderList");
		//前端必须加上.join(',')，因为是数组
		System.out.println(fileList);
		//先删除文件
		if (fileList != null && !"".equals(fileList)&&!"undefined".equals(fileList)) {
			String[] fileids = fileList.split(",");
			List<String> files = Arrays.asList(fileids);
			fileService.batchLayFile(files, 2);
		}
		//再删除文件夹
		if (folderList != null && !"".equals(folderList)&&!"undefined".equals(folderList)) {
			String[] cateids = folderList.split(",");
			for (String cateid : cateids) {
				folderService.updateIsDelete(cateid, 2);
			}
		}
		return "success";
	}
		
	//重命名
	@RequestMapping(value="rename")
	@ResponseBody
	public String reName(HttpServletRequest request) {
		//request.setCharacterEncoding("utf-8");
		//获取新名字
		String rename = request.getParameter("rename");
		System.out.println(rename);
		//文件重命名
		String refileid = request.getParameter("refileid");
		if (refileid != null && !"undefined".equals(refileid)&& !"".equals(refileid)) {
			fileService.reName(refileid, rename);

		}
		//文件夹重命名
		String refolderid = request.getParameter("refolderid");
		if (refolderid != null && !"".equals(refolderid)
				&& !"undefined".equals(refolderid)) {
			folderService.reName(refolderid, rename);

		}
		return "json";
	}
	
	//文件和文件夹批量放入回收站
	@RequestMapping(value="batchLayFileandFolder")
	@ResponseBody
	public String batchLayFileandFolder(HttpServletRequest request) {
		//获取新名字
		String fileIDList = request.getParameter("fileIDList");
		String folderIDList = request.getParameter("folderIDList");
		System.out.println(fileIDList);
		System.out.println(folderIDList);
		//先处理文件
		if (fileIDList != null && !"".equals(fileIDList)&&!"undefined".equals(fileIDList)) {
			String[] fileids = fileIDList.split(",");
			List<String> files = Arrays.asList(fileids);
			for (String string : files) {
				System.out.println(string);
			}
			fileService.batchLayFile(files, 1);
		}
		//在处理文件夹
		if (folderIDList != null && !"".equals(folderIDList)&&!"undefined".equals(folderIDList)) {
			String[] cateids = folderIDList.split(",");
			for (String cateid : cateids) {
				folderService.layFolderRecycle(cateid, 0);
			}
		}
		return "json";
	}
	
	//复制文件和文件夹
	@RequestMapping(value="copyFileAndCate")
	@ResponseBody
	public JSONObject copyFileAndCate(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		Boolean flag;
		String message="";
		String userID = request.getParameter("userID");
		String filelist = request.getParameter("filelist");
		String catelist = request.getParameter("catelist");
		String categorie_id = request.getParameter("categorie_id");
		if (catelist != null && !"".equals(catelist)&&!"undefined".equals(catelist)) {
			String[] cateids = catelist.split(",");
			flag =fileAndFolderService.judgeCateID(userID, cateids, categorie_id);
			if (flag == false) {
				result.put("message", "不能复制到其子文件夹下!");
				return result;
			}
			flag =fileAndFolderService.judgeCateName(userID, cateids, categorie_id,0);
			if (flag == false) {
				//message = "目标文件夹中已经含有相同名字的文件夹!";
				result.put("message", "目标文件夹中已经含有相同名字的文件夹!");
				return result;
			}
			fileAndFolderService.preservationcate(userID, cateids, categorie_id);
		}
		if (filelist != null && !"".equals(filelist)&&!"undefined".equals(filelist)) {
			String[] fileids = filelist.split(",");
			flag =fileAndFolderService.judgeFileName(userID, fileids, categorie_id,0); 
			if (flag == false) {
				//message = "目标文件夹下已经含有相同名字的文件!";
				result.put("message", "目标文件夹下已经含有相同名字的文件!");
				return result;
			}
			fileAndFolderService.preservation(userID, fileids, categorie_id);
		}
		//message = "移动成功!";
		result.put("message", "复制成功!");
		return result;
	}
	
	//移动文件和文件夹
	@RequestMapping(value="moveFileAndCate")
	@ResponseBody
	public JSONObject moveFileAndCate(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		Boolean flag;
		String message="";
		String userID = request.getParameter("userID");
		String filelist = request.getParameter("filelist");
		String catelist = request.getParameter("catelist");
		String categorie_id = request.getParameter("categorie_id");
		//JSONArray test = JSONArray.fromObject(filelist);
		System.out.println(filelist);
		/*
		System.out.println(userID);
		System.out.println(filelist);
		System.out.println(catelist);
		System.out.println(categorie_id);
		*/

		if (catelist != null && !"".equals(catelist)&&!"undefined".equals(catelist)) {
			String[] cateids = catelist.split(",");
			flag = fileAndFolderService.judgeCateID(userID, cateids, categorie_id);
			if (flag == false) {
				//message = "不能复制到其子文件夹下!";
				result.put("message", "不能移动到其子文件夹下!");
				return result;
			}
			flag = fileAndFolderService.judgeCateName(userID, cateids, categorie_id,0);
			if (flag == false) {
				//message = "目标文件夹中已经含有相同名字的文件夹!";
				result.put("message", "目标文件夹中已经含有相同名字的文件夹!");
				return result;
			}
			//移动文件夹
			for (String cateid : cateids) {
				fileAndFolderService.updateCatereid(cateid, categorie_id);
			}
		}
		if (filelist != null && !"".equals(filelist)&&!"undefined".equals(filelist)) {
			//System.out.println("123");
			String[] fileids = filelist.split(",");
			flag = fileAndFolderService.judgeFileName(userID, fileids, categorie_id,0);
			if (flag == false) {
				//message = "目标文件夹下已经含有相同名字的文件!";
				result.put("message", "目标文件夹下已经含有相同名字的文件!");
				return result;
			}
			//移动文件
			for (String fileid : fileids) {
				//System.out.println(fileids);
				fileAndFolderService.moveFile(fileid, categorie_id);
			}
		}
		//message = "移动成功!";
		result.put("message", "移动成功!");
		return result;
	}
}
