package main.java.com.hhy.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.MyFile;
import main.java.com.hhy.service.FileService;
import main.java.com.hhy.service.FolderService;
import main.java.com.hhy.service.UserService;
import main.java.com.hhy.util.ConvertVideo;
import main.java.com.hhy.util.FileUtils;
import main.java.com.hhy.util.IDGenerator;
import main.java.com.hhy.util.OfficeToPdf;
import net.sf.json.JSONObject;

@Controller
public class FileController {
	@Autowired
	private FileService fileService;
	@Resource
	public FolderService folderService;
	
	//md5У��
	@RequestMapping(value="/md5Check")
	public ModelAndView md5Check(HttpServletRequest request, HttpServletResponse response) throws IOException{
		int result = 0;
		String userID = request.getParameter("userID");
		String folderID = request.getParameter("folderID");
		//�ļ�����Ӱ��MD5
		String fileName = request.getParameter("fileName");
		String md5Val = request.getParameter("md5Val");
		MyFile mf = fileService.getFileByMD5(md5Val);
		//System.out.println(md5Val);
		//System.out.println(mf.getMd5());
		//���������ͬMD5,�����ϴ�
		if(mf!=null){
			MyFile newfile = new MyFile();
			//����md5ֵ
			newfile.setMd5(md5Val);
			//����
			String id = IDGenerator.genPrimaryKey();
			newfile.setId(id);
			//�ļ���
			newfile.setFileName(fileName);
	        //��׺��
			newfile.setFileSuffix(mf.getFileSuffix());
			//�ļ�����
			newfile.setFileTypeFlag(0);
			//�û�id
			newfile.setUserID(userID);
			//�ļ�·��
			String path = "C:" + File.separatorChar + "hhyDisk"
					+ File.separatorChar +userID+ File.separatorChar; 
			String filePath = path+id;
			newfile.setFilePath(filePath);
			//�ļ���С
			newfile.setFileSize(mf.getFileSize());
	        //�ļ�����
			newfile.setFloorNum(0);
	        //�ļ���id
	        newfile.setFolderID(folderID);
	        //����
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	        String temp = formatter.format(new Date());
	        Date date;
			try {
				date = formatter.parse(temp);
				newfile.setUpdateDate(date);
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
	        //�Ƿ�ɾ��,0��ʾδɾ����
			newfile.setIsDelete(0);
	        //�����ָ��·��,������
	        fileName = newfile.getId()+"."+newfile.getFileSuffix();
	        String srcPath =  "C:" + File.separatorChar + "hhyDisk"
					+ File.separatorChar +mf.getUserID()+ File.separatorChar; 
	        //Դ�ļ�
	        File src = new File(mf.getFilePath()+"."+mf.getFileSuffix());    
	        //Ŀ���ļ�
	        File dest = new File(newfile.getFilePath()+"."+newfile.getFileSuffix());    
	        //�ж��ļ����Ƿ����
	        /*
	        if(!dest.exists()){  
	        	dest.mkdirs();  
	        }  
	        if(!src.exists()){  
	        	src.mkdirs();  
	        }  */
	        try {
	        	//����
	        	FileUtils.fileChannelCopy(src, dest);
	        	
	    		    if(    newfile.getFileSuffix().equals("wmv9") 
	    				|| newfile.getFileSuffix().equals("rm")
	    				|| newfile.getFileSuffix().equals("rmvb")
	    				|| newfile.getFileSuffix().equals("asx")
	    				|| newfile.getFileSuffix().equals("asf")
	    				|| newfile.getFileSuffix().equals("mpg")
	    				|| newfile.getFileSuffix().equals("wmv")
	    				|| newfile.getFileSuffix().equals("3gp")
	    				|| newfile.getFileSuffix().equals("mp4")
	    				|| newfile.getFileSuffix().equals("mov")
	    				|| newfile.getFileSuffix().equals("avi")
	    				|| newfile.getFileSuffix().equals("flv"))
	    		{
	    		    	//�������mp4��׺������ת����mp4
	    		    if(!newfile.getFileSuffix().equals("mp4")){
	    		    	//Դ�ļ�
	    		        File srcVideo = new File(mf.getFilePath()+".mp4");    
	    		        //Ŀ���ļ�
	    		        File destVideo = new File(newfile.getFilePath()+".mp4");  
	    		        //����
	    		        FileUtils.fileChannelCopy(srcVideo, destVideo);
	 	    		   //ConvertVideo convertVideo = new ConvertVideo(mf.getFilePath()+"."+mf.getFileSuffix());
		    			//convertVideo.start();//��������һ���̣߳�������Ƶת�룻
	    		    }
	    		    //��������ͼ��jpg
    		        File srcPic = new File(mf.getFilePath()+".jpg");    
    		        //Ŀ���ļ�
    		        File destPic = new File(newfile.getFilePath()+".jpg");  
    		        //����
    		        FileUtils.fileChannelCopy(srcPic, destPic);
	    		}

			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}  
	        //�浽���ݿ�
	        result = fileService.add(newfile);
		}
		ModelAndView mv = new ModelAndView();
		if(result==0)
			mv.setViewName("error");
        else
        	mv.setViewName("success");
		return mv;
        	
	}
	
	//�ļ��ϴ�
	@RequestMapping(value="/fileUpload")
	public String fileUpload(MultipartFile file,HttpServletRequest request){
		MyFile mf = new MyFile();
		//��ȡmd5ֵ
		String md5Val = request.getParameter("md5Val");
		mf.setMd5(md5Val);
		//����
		String id = IDGenerator.genPrimaryKey();
		mf.setId(id);
		//�ļ���
        String fileName = file.getOriginalFilename();
        mf.setFileName(fileName);
        //System.out.println(file.getName());
        //System.out.println(file.getOriginalFilename());
        //��׺��
        String fileSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		if (fileSuffix == null) {
			mf.setFileSuffix((file.getContentType().split("/"))[0]); // ��ȡ�ļ�����
		}else{
			mf.setFileSuffix(fileSuffix);
		}
		//System.out.println("type:"+file.getContentType());
		//�ļ�����
		mf.setFileTypeFlag(0);
		//�û�id
		String userID = request.getParameter("userID");
		mf.setUserID(userID);
		//�ļ�·��
		String path = "C:" + File.separatorChar + "hhyDisk"
				+ File.separatorChar +userID+ File.separatorChar; 
		String filePath = path+id;
		mf.setFilePath(filePath);
		//�ļ���С
		mf.setFileSize(file.getSize());
        System.out.println("size��"+String.valueOf(file.getSize()));
        //�ļ�����
        mf.setFloorNum(0);
        //�ļ���id
        String folderID = request.getParameter("folderID");
        System.out.println(folderID);
        mf.setFolderID(folderID);
        //����
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        String temp = formatter.format(new Date());
        Date date;
		try {
			date = formatter.parse(temp);
			mf.setUpdateDate(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
        //�Ƿ�ɾ��,0��ʾδɾ����
        mf.setIsDelete(0);
        //�����ָ��·��,������
        fileName = mf.getId()+"."+mf.getFileSuffix();
        File dir = new File(path,fileName);          
        if(!dir.exists()){  
            dir.mkdirs();  
        }  
        try {
			file.transferTo(dir);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}  
    	/**
		 * ����ϴ�������Ƶ���ͽ���ת�� wmv9��rm��rmvb��asx��asf��mpg��wmv��3gp��mp4��mov��avi��flv��
		 */
		    if(    mf.getFileSuffix().equals("wmv9") 
				|| mf.getFileSuffix().equals("rm")
				|| mf.getFileSuffix().equals("rmvb")
				|| mf.getFileSuffix().equals("asx")
				|| mf.getFileSuffix().equals("asf")
				|| mf.getFileSuffix().equals("mpg")
				|| mf.getFileSuffix().equals("wmv")
				|| mf.getFileSuffix().equals("3gp")
				|| mf.getFileSuffix().equals("mp4")
				|| mf.getFileSuffix().equals("mov")
				|| mf.getFileSuffix().equals("avi")
				|| mf.getFileSuffix().equals("flv"))
		{
			ConvertVideo convertVideo = new ConvertVideo(mf.getFilePath()+"."+mf.getFileSuffix());
			convertVideo.start();//��������һ���̣߳�������Ƶת�룻
		}
		
        //�浽���ݿ�
        int result = fileService.add(mf);
        if(result==0)
        	return "error";
        else
        	return "success";
	}
	
	//�ļ�����
	@RequestMapping(value="/fileDownload")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		//��ѯ
		MyFile f = fileService.getFileByID(fileID);
		//�ļ�������
		if(f==null)
        	;
        else{
        	//�ļ�����·��
        	String path = f.getFilePath()+"."+f.getFileSuffix();
        	//��ȡ������  
            InputStream bis = new BufferedInputStream(new FileInputStream(new File(path)));
            //ת�룬����ļ�����������  
            String fileName = URLEncoder.encode(f.getFileName(),"UTF-8");  
            //�����ļ�����ͷ  
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);    
            //1.�����ļ�ContentType���ͣ��������ã����Զ��ж������ļ�����    
            response.setContentType("multipart/form-data");   
            BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());  
            int len = 0;  
            while((len = bis.read()) != -1){  
                out.write(len);  
                out.flush();  
            }  
            out.close();  
        }
		return;
	}
	
	//�ļ��������վ
	@RequestMapping(value="/layFileRecycle")
	public String layFileRecycle(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		int result = fileService.layFileRecycle(fileID);
	    if(result==0)
	       return "error";
	    else
	       return "success";
	}
	//ɾ���ļ�
	@RequestMapping(value="/deleteFile")
	public String deleteFile(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		int result = fileService.updateIsDelete(fileID, 2);
	    if(result==0)
	       return "error";
	    else
	       return "success";
	}
	
	//��ԭ�ļ�����bug�����ԭ�ļ��б�ɾ�������ڻ���վ��
	@RequestMapping(value="/restoreFile")
	@ResponseBody
	public JSONObject restoreFile(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		MyFile fm = fileService.getFileByID(fileID);
		JSONObject result = new JSONObject();
		//�������
		if(fm!=null){
			String[] file_ids = new String[]{fileID};
			 boolean flag = fileService.judgeFileName(fm.getUserID(), file_ids, fm.getFolderID(),1);
			//���ԭ�ļ�������ͬ���ļ�
			 if(!flag){
				 Folder re_categorie =folderService.getFolderByID(fm.getFolderID());
				 //���ԭ���������ļ�����
				 if(re_categorie == null){
					 result.put("result","���ļ������Ѿ�����ͬ���ֵ��ļ�,���޸����ֺ��ڻ�ԭ��");
				 }else {
					 //�������
					 result.put("result",re_categorie.getFolderName()+"���Ѿ�����ͬ���ֵ��ļ�,���޸����ֺ��ڻ�ԭ��");
				}					
			 }else{
				 //���߾ͻ�ԭ
				 fileService.updateIsDelete(fileID, 0);
				 result.put("result","��ԭ�ļ��ɹ���");
			 }
		}
		return result;
	}
	
	//office�ļ�Ԥ��(ͨ���ַ���)
	@RequestMapping(value="/officeView")
	@ResponseBody
	public void officeView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		//System.out.println(mf);
		//�������
		if(mf!=null){
			File file;
			//�����������pdf
			if(mf.getFileSuffix().equals("pdf"))
				file = new File(mf.getFilePath()+"."+mf.getFileSuffix());
			else{
				//������ǣ��ٿ����Ƿ��Ѿ�Ԥ����
				File temp = new File(mf.getFilePath()+".pdf");
				//���û��Ԥ����
				if(!temp.exists()){
					file = OfficeToPdf.openOfficeToPDF(mf.getFilePath()+"."+mf.getFileSuffix());
				}else{
					//���Ԥ����
					file = new File(mf.getFilePath()+".pdf");
				}
			}
				
			//System.out.println(file.getName());
	        BufferedInputStream br = new BufferedInputStream(new FileInputStream(file));
	        byte[] buf = new byte[1024];
	        int len = 0;
	        response.reset(); // �ǳ���Ҫ
	        response.setContentType("application/pdf");
	        response.setHeader("Content-Disposition",
	                "inline; filename=" + java.net.URLEncoder.encode(file.getName(), "UTF-8"));

	        OutputStream out = response.getOutputStream();
	        while ((len = br.read(buf)) != -1)
	            out.write(buf, 0, len);
	        br.close();
	        out.close();
		}
	}
	/*
	//office�ļ�Ԥ����ֱ�ӷ��ص�ַ����δʵ��
	@RequestMapping(value="/officeView")
	@ResponseBody
	public String officeView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		String path="";
		//System.out.println(mf);
		//�������
		if(mf!=null){
			File file;
			//�����������pdf
			if(mf.getFileSuffix().equals("pdf"))
				file = new File(mf.getFilePath()+"."+mf.getFileSuffix());
			else{
				//������ǣ��ٿ����Ƿ��Ѿ�Ԥ����
				File temp = new File(mf.getFilePath()+".pdf");
				//���û��Ԥ����
				if(!temp.exists()){
					file = OfficeToPdf.openOfficeToPDF(mf.getFilePath()+"."+mf.getFileSuffix());
				}else{
					//���Ԥ����
					file = new File(mf.getFilePath()+".pdf");
				}
			}
			//�˴���Ҫ����tomcat������������·��,��Ϊdisk
			path = "/disk/"+mf.getUserID()+"/"+mf.getId()+".pdf";
			System.out.println(path);
		}
		return path;
	}
	*/
	
	//ͼƬԤ��
	@RequestMapping(value="/imgView")
	@ResponseBody
	public String imgView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		String path="";
		//�������
		if(mf!=null){
			//�˴���Ҫ����tomcat������������·��,��Ϊdisk
			path = "/disk/"+mf.getUserID()+"/"+mf.getId()+"."+mf.getFileSuffix();
			System.out.println(path);
		}
		return path;
	}
	
	//��ƵԤ��
	@RequestMapping(value="/videoView")
	@ResponseBody
	public JSONObject videoView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		JSONObject result = new JSONObject();
		//�������
		if(mf!=null){
			//�˴���Ҫ����tomcat������������·��,��Ϊdisk
			//path = "/disk/"+mf.getUserID()+"/"+mf.getId()+".mp4";
			result.put("videoPath",  "/disk/"+mf.getUserID()+"/"+mf.getId()+".mp4");
			result.put("posterPath",  "/disk/"+mf.getUserID()+"/"+mf.getId()+".jpg");
		}
		return result;
	}
}
