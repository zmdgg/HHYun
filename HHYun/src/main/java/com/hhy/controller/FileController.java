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
	
	//md5校验
	@RequestMapping(value="/md5Check")
	public ModelAndView md5Check(HttpServletRequest request, HttpServletResponse response) throws IOException{
		int result = 0;
		String userID = request.getParameter("userID");
		String folderID = request.getParameter("folderID");
		//文件名不影响MD5
		String fileName = request.getParameter("fileName");
		String md5Val = request.getParameter("md5Val");
		MyFile mf = fileService.getFileByMD5(md5Val);
		//System.out.println(md5Val);
		//System.out.println(mf.getMd5());
		//如果存在相同MD5,不用上传
		if(mf!=null){
			MyFile newfile = new MyFile();
			//设置md5值
			newfile.setMd5(md5Val);
			//主键
			String id = IDGenerator.genPrimaryKey();
			newfile.setId(id);
			//文件名
			newfile.setFileName(fileName);
	        //后缀名
			newfile.setFileSuffix(mf.getFileSuffix());
			//文件类型
			newfile.setFileTypeFlag(0);
			//用户id
			newfile.setUserID(userID);
			//文件路径
			String path = "C:" + File.separatorChar + "hhyDisk"
					+ File.separatorChar +userID+ File.separatorChar; 
			String filePath = path+id;
			newfile.setFilePath(filePath);
			//文件大小
			newfile.setFileSize(mf.getFileSize());
	        //文件层数
			newfile.setFloorNum(0);
	        //文件夹id
	        newfile.setFolderID(folderID);
	        //日期
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	        String temp = formatter.format(new Date());
	        Date date;
			try {
				date = formatter.parse(temp);
				newfile.setUpdateDate(date);
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
	        //是否删除,0表示未删除，
			newfile.setIsDelete(0);
	        //输出到指定路径,并改名
	        fileName = newfile.getId()+"."+newfile.getFileSuffix();
	        String srcPath =  "C:" + File.separatorChar + "hhyDisk"
					+ File.separatorChar +mf.getUserID()+ File.separatorChar; 
	        //源文件
	        File src = new File(mf.getFilePath()+"."+mf.getFileSuffix());    
	        //目标文件
	        File dest = new File(newfile.getFilePath()+"."+newfile.getFileSuffix());    
	        //判断文件夹是否存在
	        /*
	        if(!dest.exists()){  
	        	dest.mkdirs();  
	        }  
	        if(!src.exists()){  
	        	src.mkdirs();  
	        }  */
	        try {
	        	//复制
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
	    		    	//如果不是mp4后缀，复制转码后的mp4
	    		    if(!newfile.getFileSuffix().equals("mp4")){
	    		    	//源文件
	    		        File srcVideo = new File(mf.getFilePath()+".mp4");    
	    		        //目标文件
	    		        File destVideo = new File(newfile.getFilePath()+".mp4");  
	    		        //复制
	    		        FileUtils.fileChannelCopy(srcVideo, destVideo);
	 	    		   //ConvertVideo convertVideo = new ConvertVideo(mf.getFilePath()+"."+mf.getFileSuffix());
		    			//convertVideo.start();//开启另外一个线程，进行视频转码；
	    		    }
	    		    //复制缩略图，jpg
    		        File srcPic = new File(mf.getFilePath()+".jpg");    
    		        //目标文件
    		        File destPic = new File(newfile.getFilePath()+".jpg");  
    		        //复制
    		        FileUtils.fileChannelCopy(srcPic, destPic);
	    		}

			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}  
	        //存到数据库
	        result = fileService.add(newfile);
		}
		ModelAndView mv = new ModelAndView();
		if(result==0)
			mv.setViewName("error");
        else
        	mv.setViewName("success");
		return mv;
        	
	}
	
	//文件上传
	@RequestMapping(value="/fileUpload")
	public String fileUpload(MultipartFile file,HttpServletRequest request){
		MyFile mf = new MyFile();
		//获取md5值
		String md5Val = request.getParameter("md5Val");
		mf.setMd5(md5Val);
		//主键
		String id = IDGenerator.genPrimaryKey();
		mf.setId(id);
		//文件名
        String fileName = file.getOriginalFilename();
        mf.setFileName(fileName);
        //System.out.println(file.getName());
        //System.out.println(file.getOriginalFilename());
        //后缀名
        String fileSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		if (fileSuffix == null) {
			mf.setFileSuffix((file.getContentType().split("/"))[0]); // 截取文件类型
		}else{
			mf.setFileSuffix(fileSuffix);
		}
		//System.out.println("type:"+file.getContentType());
		//文件类型
		mf.setFileTypeFlag(0);
		//用户id
		String userID = request.getParameter("userID");
		mf.setUserID(userID);
		//文件路径
		String path = "C:" + File.separatorChar + "hhyDisk"
				+ File.separatorChar +userID+ File.separatorChar; 
		String filePath = path+id;
		mf.setFilePath(filePath);
		//文件大小
		mf.setFileSize(file.getSize());
        System.out.println("size，"+String.valueOf(file.getSize()));
        //文件层数
        mf.setFloorNum(0);
        //文件夹id
        String folderID = request.getParameter("folderID");
        System.out.println(folderID);
        mf.setFolderID(folderID);
        //日期
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        String temp = formatter.format(new Date());
        Date date;
		try {
			date = formatter.parse(temp);
			mf.setUpdateDate(date);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
        //是否删除,0表示未删除，
        mf.setIsDelete(0);
        //输出到指定路径,并改名
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
		 * 如果上传的是视频，就进行转码 wmv9，rm，rmvb，asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等
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
			convertVideo.start();//开启另外一个线程，进行视频转码；
		}
		
        //存到数据库
        int result = fileService.add(mf);
        if(result==0)
        	return "error";
        else
        	return "success";
	}
	
	//文件下载
	@RequestMapping(value="/fileDownload")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		//查询
		MyFile f = fileService.getFileByID(fileID);
		//文件不存在
		if(f==null)
        	;
        else{
        	//文件物理路径
        	String path = f.getFilePath()+"."+f.getFileSuffix();
        	//获取输入流  
            InputStream bis = new BufferedInputStream(new FileInputStream(new File(path)));
            //转码，免得文件名中文乱码  
            String fileName = URLEncoder.encode(f.getFileName(),"UTF-8");  
            //设置文件下载头  
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);    
            //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型    
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
	
	//文件放入回收站
	@RequestMapping(value="/layFileRecycle")
	public String layFileRecycle(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		int result = fileService.layFileRecycle(fileID);
	    if(result==0)
	       return "error";
	    else
	       return "success";
	}
	//删除文件
	@RequestMapping(value="/deleteFile")
	public String deleteFile(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		int result = fileService.updateIsDelete(fileID, 2);
	    if(result==0)
	       return "error";
	    else
	       return "success";
	}
	
	//还原文件，有bug（如果原文件夹被删除或者在回收站）
	@RequestMapping(value="/restoreFile")
	@ResponseBody
	public JSONObject restoreFile(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String fileID = request.getParameter("fileID");
		MyFile fm = fileService.getFileByID(fileID);
		JSONObject result = new JSONObject();
		//如果存在
		if(fm!=null){
			String[] file_ids = new String[]{fileID};
			 boolean flag = fileService.judgeFileName(fm.getUserID(), file_ids, fm.getFolderID(),1);
			//如果原文件加下有同名文件
			 if(!flag){
				 Folder re_categorie =folderService.getFolderByID(fm.getFolderID());
				 //如果原来是在主文件夹下
				 if(re_categorie == null){
					 result.put("result","主文件夹中已经有相同名字的文件,请修改名字后在还原！");
				 }else {
					 //如果不是
					 result.put("result",re_categorie.getFolderName()+"中已经有相同名字的文件,请修改名字后在还原！");
				}					
			 }else{
				 //否者就还原
				 fileService.updateIsDelete(fileID, 0);
				 result.put("result","还原文件成功！");
			 }
		}
		return result;
	}
	
	//office文件预览(通过字符流)
	@RequestMapping(value="/officeView")
	@ResponseBody
	public void officeView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		//System.out.println(mf);
		//如果存在
		if(mf!=null){
			File file;
			//如果本来就是pdf
			if(mf.getFileSuffix().equals("pdf"))
				file = new File(mf.getFilePath()+"."+mf.getFileSuffix());
			else{
				//如果不是，再看看是否已经预览过
				File temp = new File(mf.getFilePath()+".pdf");
				//如果没有预览过
				if(!temp.exists()){
					file = OfficeToPdf.openOfficeToPDF(mf.getFilePath()+"."+mf.getFileSuffix());
				}else{
					//如果预览过
					file = new File(mf.getFilePath()+".pdf");
				}
			}
				
			//System.out.println(file.getName());
	        BufferedInputStream br = new BufferedInputStream(new FileInputStream(file));
	        byte[] buf = new byte[1024];
	        int len = 0;
	        response.reset(); // 非常重要
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
	//office文件预览（直接返回地址），未实现
	@RequestMapping(value="/officeView")
	@ResponseBody
	public String officeView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		String path="";
		//System.out.println(mf);
		//如果存在
		if(mf!=null){
			File file;
			//如果本来就是pdf
			if(mf.getFileSuffix().equals("pdf"))
				file = new File(mf.getFilePath()+"."+mf.getFileSuffix());
			else{
				//如果不是，再看看是否已经预览过
				File temp = new File(mf.getFilePath()+".pdf");
				//如果没有预览过
				if(!temp.exists()){
					file = OfficeToPdf.openOfficeToPDF(mf.getFilePath()+"."+mf.getFileSuffix());
				}else{
					//如果预览过
					file = new File(mf.getFilePath()+".pdf");
				}
			}
			//此处需要现在tomcat里面配置虚拟路径,如为disk
			path = "/disk/"+mf.getUserID()+"/"+mf.getId()+".pdf";
			System.out.println(path);
		}
		return path;
	}
	*/
	
	//图片预览
	@RequestMapping(value="/imgView")
	@ResponseBody
	public String imgView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		String path="";
		//如果存在
		if(mf!=null){
			//此处需要现在tomcat里面配置虚拟路径,如为disk
			path = "/disk/"+mf.getUserID()+"/"+mf.getId()+"."+mf.getFileSuffix();
			System.out.println(path);
		}
		return path;
	}
	
	//视频预览
	@RequestMapping(value="/videoView")
	@ResponseBody
	public JSONObject videoView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileID = request.getParameter("fileID");
		System.out.println(fileID);
		MyFile mf = fileService.getFileByID(fileID);
		JSONObject result = new JSONObject();
		//如果存在
		if(mf!=null){
			//此处需要现在tomcat里面配置虚拟路径,如为disk
			//path = "/disk/"+mf.getUserID()+"/"+mf.getId()+".mp4";
			result.put("videoPath",  "/disk/"+mf.getUserID()+"/"+mf.getId()+".mp4");
			result.put("posterPath",  "/disk/"+mf.getUserID()+"/"+mf.getId()+".jpg");
		}
		return result;
	}
}
