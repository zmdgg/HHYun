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

	//���ȫ���ļ�
	@RequestMapping(value="showFileAndFolderList")
	@ResponseBody
	public JSONObject  showFileAndFolderList(HttpServletRequest request){
		String folderID = request.getParameter("folderID");
		String userID = request.getParameter("userID");
		//System.out.println(folderID);
		JSONObject json=null;
		try{
			//����ļ��б���ļ����б�
			List<MyFile> fileList = fileService.getFileList(folderID, 0,userID);
			List<Folder> folderList = folderService.getFolderList(folderID, 0,userID);
			Map map = new HashMap();
	        map.put("fileList", fileList);
	        map.put("folderList", folderList);
	        //���õ�ǰ���ʵ��б�
	        Folder f = new Folder();
	        if(folderID==""){
	        	f.setFolderName("ȫ���ļ�");
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
	
	//��û���վ�ļ�
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
	
	//��ջ���վ
	@RequestMapping(value="emptyRecycle")
	@ResponseBody
	public String  emptyRecycle(HttpServletRequest request){
		String fileList = request.getParameter("fileList");
		String folderList = request.getParameter("folderList");
		//ǰ�˱������.join(',')����Ϊ������
		System.out.println(fileList);
		//��ɾ���ļ�
		if (fileList != null && !"".equals(fileList)&&!"undefined".equals(fileList)) {
			String[] fileids = fileList.split(",");
			List<String> files = Arrays.asList(fileids);
			fileService.batchLayFile(files, 2);
		}
		//��ɾ���ļ���
		if (folderList != null && !"".equals(folderList)&&!"undefined".equals(folderList)) {
			String[] cateids = folderList.split(",");
			for (String cateid : cateids) {
				folderService.updateIsDelete(cateid, 2);
			}
		}
		return "success";
	}
		
	//������
	@RequestMapping(value="rename")
	@ResponseBody
	public String reName(HttpServletRequest request) {
		//request.setCharacterEncoding("utf-8");
		//��ȡ������
		String rename = request.getParameter("rename");
		System.out.println(rename);
		//�ļ�������
		String refileid = request.getParameter("refileid");
		if (refileid != null && !"undefined".equals(refileid)&& !"".equals(refileid)) {
			fileService.reName(refileid, rename);

		}
		//�ļ���������
		String refolderid = request.getParameter("refolderid");
		if (refolderid != null && !"".equals(refolderid)
				&& !"undefined".equals(refolderid)) {
			folderService.reName(refolderid, rename);

		}
		return "json";
	}
	
	//�ļ����ļ��������������վ
	@RequestMapping(value="batchLayFileandFolder")
	@ResponseBody
	public String batchLayFileandFolder(HttpServletRequest request) {
		//��ȡ������
		String fileIDList = request.getParameter("fileIDList");
		String folderIDList = request.getParameter("folderIDList");
		System.out.println(fileIDList);
		System.out.println(folderIDList);
		//�ȴ����ļ�
		if (fileIDList != null && !"".equals(fileIDList)&&!"undefined".equals(fileIDList)) {
			String[] fileids = fileIDList.split(",");
			List<String> files = Arrays.asList(fileids);
			for (String string : files) {
				System.out.println(string);
			}
			fileService.batchLayFile(files, 1);
		}
		//�ڴ����ļ���
		if (folderIDList != null && !"".equals(folderIDList)&&!"undefined".equals(folderIDList)) {
			String[] cateids = folderIDList.split(",");
			for (String cateid : cateids) {
				folderService.layFolderRecycle(cateid, 0);
			}
		}
		return "json";
	}
	
	//�����ļ����ļ���
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
				result.put("message", "���ܸ��Ƶ������ļ�����!");
				return result;
			}
			flag =fileAndFolderService.judgeCateName(userID, cateids, categorie_id,0);
			if (flag == false) {
				//message = "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ���!";
				result.put("message", "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ���!");
				return result;
			}
			fileAndFolderService.preservationcate(userID, cateids, categorie_id);
		}
		if (filelist != null && !"".equals(filelist)&&!"undefined".equals(filelist)) {
			String[] fileids = filelist.split(",");
			flag =fileAndFolderService.judgeFileName(userID, fileids, categorie_id,0); 
			if (flag == false) {
				//message = "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ�!";
				result.put("message", "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ�!");
				return result;
			}
			fileAndFolderService.preservation(userID, fileids, categorie_id);
		}
		//message = "�ƶ��ɹ�!";
		result.put("message", "���Ƴɹ�!");
		return result;
	}
	
	//�ƶ��ļ����ļ���
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
				//message = "���ܸ��Ƶ������ļ�����!";
				result.put("message", "�����ƶ��������ļ�����!");
				return result;
			}
			flag = fileAndFolderService.judgeCateName(userID, cateids, categorie_id,0);
			if (flag == false) {
				//message = "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ���!";
				result.put("message", "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ���!");
				return result;
			}
			//�ƶ��ļ���
			for (String cateid : cateids) {
				fileAndFolderService.updateCatereid(cateid, categorie_id);
			}
		}
		if (filelist != null && !"".equals(filelist)&&!"undefined".equals(filelist)) {
			//System.out.println("123");
			String[] fileids = filelist.split(",");
			flag = fileAndFolderService.judgeFileName(userID, fileids, categorie_id,0);
			if (flag == false) {
				//message = "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ�!";
				result.put("message", "Ŀ���ļ������Ѿ�������ͬ���ֵ��ļ�!");
				return result;
			}
			//�ƶ��ļ�
			for (String fileid : fileids) {
				//System.out.println(fileids);
				fileAndFolderService.moveFile(fileid, categorie_id);
			}
		}
		//message = "�ƶ��ɹ�!";
		result.put("message", "�ƶ��ɹ�!");
		return result;
	}
}
