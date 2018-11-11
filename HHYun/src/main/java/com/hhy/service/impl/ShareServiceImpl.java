package main.java.com.hhy.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.com.hhy.mapper.FileMapper;
import main.java.com.hhy.mapper.FolderMapper;
import main.java.com.hhy.mapper.ShareDataMapper;
import main.java.com.hhy.mapper.ShareMapper;
import main.java.com.hhy.mapper.UserMapper;
import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.MyFile;
import main.java.com.hhy.pojo.Share;
import main.java.com.hhy.pojo.ShareData;
import main.java.com.hhy.service.ShareService;
import main.java.com.hhy.util.FileUtils;
import main.java.com.hhy.util.IDGenerator;
@Service
public class ShareServiceImpl implements ShareService {
	@Autowired
	ShareDataMapper shareDataMapper;
	@Autowired
	ShareMapper shareMapper;
	@Autowired
	FolderMapper folderMapper;
	@Autowired
	FileMapper fileMapper;
	@Override
	public void sharefile(ShareData sharefile, String[] s_type) {
		// TODO Auto-generated method stub
		 for(int i=0;i<s_type.length;i++){
			 sharefile.setId(IDGenerator.genPrimaryKey());
			 sharefile.setFileOrFolderID(s_type[i]);
			 shareDataMapper.insert(sharefile);
		 }
		
	}
	@Override
	public void addshare(Share share) {
		// TODO Auto-generated method stub
		shareMapper.insert(share);
	}
	@Override
	public Share selectByMagID(String magID) {
		// TODO Auto-generated method stub
		return shareMapper.selectByMagID(magID);
	}
	@Override
	public Share checkpwd(String magID, String sharepwd) {
		// TODO Auto-generated method stub
		return shareMapper.checkpwd(magID, sharepwd);
	}
	@Override
	public List<ShareData> getShareDataList(String magID) {
		// TODO Auto-generated method stub
		return shareDataMapper.getShareDataList(magID);
	}
	@Override
	/*����ļ����Ƿ��Դ���*/
	public int checkFolder(String[] cidlist, String[] cnamelist, int cateflag, String id, String recateid) {

		List<Folder> cate = new ArrayList<Folder>();
		cate = folderMapper.getFolderList(recateid, 0, id);

		for(int i=0;i<cate.size();i++){
			for(int j=0;j<cnamelist.length;j++){
				if(cnamelist[j].equals(cate.get(i).getFolderName()) && cate.get(i).getIsDelete() == 0){
					cateflag = 0;
				}
			}
		}
		return cateflag;
	}
	/*���������ļ���*/
	@Override
	public void preservationcate(String id, String[] cidlist, String cate_reid) {
		for(int i=0;i<cidlist.length;i++){
			Folder f = folderMapper.getFolderByIsDelete(0, cidlist[i]);
			String cateid = f.getId();
			f.setId(IDGenerator.genPrimaryKey());
			f.setUserID(id);
			f.setSuperFolderID(cate_reid);
			String reid = f.getId();
			//����
			folderMapper.insert(f);
			recursion(cateid,reid,id);
		}
	}
	public void recursion(String cateid,String reid,String uid){
		List<Folder> catelist = folderMapper.getFolderNext(cateid);
		List<MyFile> filelist = fileMapper.getFolderNextFile(cateid);
		if(filelist != null){
			for(int i=0;i<filelist.size();i++){
				MyFile file = fileMapper.getFileByIDAndState(filelist.get(i).getId(), 0);
				if(file != null){
					//ԭ·��
					String srcPath = file.getFilePath()+".";
					file.setId(IDGenerator.genPrimaryKey());
					file.setUserID(uid);
					file.setFolderID(reid);
					//��Ҫ���ļ�Ǩ�ƹ�ȥ
					String path = "C:" + File.separatorChar + "hhyDisk"
							+ File.separatorChar +uid+ File.separatorChar; 
					String filePath = path+file.getId();
					file.setFilePath(filePath);
					//Ŀ��·��
					String destPath = file.getFilePath()+".";
			        //Դ�ļ�
			        File src = new File(srcPath+file.getFileSuffix());    
			        //Ŀ���ļ�
			        File dest = new File(destPath+file.getFileSuffix());    
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
			        	
			    		    if(    file.getFileSuffix().equals("wmv9") 
			    				|| file.getFileSuffix().equals("rm")
			    				|| file.getFileSuffix().equals("rmvb")
			    				|| file.getFileSuffix().equals("asx")
			    				|| file.getFileSuffix().equals("asf")
			    				|| file.getFileSuffix().equals("mpg")
			    				|| file.getFileSuffix().equals("wmv")
			    				|| file.getFileSuffix().equals("3gp")
			    				|| file.getFileSuffix().equals("mp4")
			    				|| file.getFileSuffix().equals("mov")
			    				|| file.getFileSuffix().equals("avi")
			    				|| file.getFileSuffix().equals("flv"))
			    		{
			    		    	//�������mp4��׺������ת����mp4
			    		    if(!file.getFileSuffix().equals("mp4")){
			    		    	//Դ�ļ�
			    		        File srcVideo = new File(srcPath+"mp4");    
			    		        //Ŀ���ļ�
			    		        File destVideo = new File(destPath+"mp4");  
			    		        //����
			    		        FileUtils.fileChannelCopy(srcVideo, destVideo);
			    		    }
			    		    //��������ͼ��jpg
		    		        File srcPic = new File(srcPath+"jpg");    
		    		        //Ŀ���ļ�
		    		        File destPic = new File(destPath+"jpg");  
		    		        //����
		    		        FileUtils.fileChannelCopy(srcPic, destPic);
			    		}

					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}  
			        //�浽���ݿ�
			       fileMapper.insert(file);
				}
				}
			}
		
			//�ٴ��ļ���
			for(int i=0;i<catelist.size();i++){
				Folder f = folderMapper.getFolderByIsDelete(0,  catelist.get(i).getId());
				if(f != null){
					
					String cid = f.getId();
					f.setId(IDGenerator.genPrimaryKey());
					f.setUserID(uid);
					f.setSuperFolderID(reid);
					String rid = f.getId();
					folderMapper.insert(f);
					recursion(cid,rid,uid);
				}
			}
	}
	@Override
	public int checkfile(String[] fid, String[] fname, int flag, String uid, String recateid) {
		MyFile file = new MyFile();
		file.setFolderID(recateid);
		file.setUserID(uid);
		List<MyFile> f = new ArrayList<MyFile>();
		f = fileMapper.getFileList(recateid, 0, uid);
	
		for(int i=0;i<f.size();i++){
			for(int j=0;j<fname.length;j++){
				if(fname[j].equals(f.get(i).getFileName()) && f.get(i).getIsDelete() == 0){
					flag = 0;
				}
			}
		}
		return flag;
	}
	@Override
	public void preservation(String id, String[] fid, String file_cateid) {

		for(int i=0;i<fid.length;i++){
			MyFile file = fileMapper.getFileByIsDelete(0, fid[i]);
			if(file != null){
				//ԭ·��
				String srcPath = file.getFilePath()+".";
				file.setId(IDGenerator.genPrimaryKey());
				file.setUserID(id);
				file.setFolderID(file_cateid);
				//��Ҫ���ļ�Ǩ�ƹ�ȥ
				String path = "C:" + File.separatorChar + "hhyDisk"
						+ File.separatorChar +id+ File.separatorChar; 
				String filePath = path+file.getId();
				file.setFilePath(filePath);
				//Ŀ��·��
				String destPath = file.getFilePath()+".";
		        //Դ�ļ�
		        File src = new File(srcPath+file.getFileSuffix());    
		        //Ŀ���ļ�
		        File dest = new File(destPath+file.getFileSuffix());    
		        try {
		        	//����
		        	FileUtils.fileChannelCopy(src, dest);
		        	
		    		    if(    file.getFileSuffix().equals("wmv9") 
		    				|| file.getFileSuffix().equals("rm")
		    				|| file.getFileSuffix().equals("rmvb")
		    				|| file.getFileSuffix().equals("asx")
		    				|| file.getFileSuffix().equals("asf")
		    				|| file.getFileSuffix().equals("mpg")
		    				|| file.getFileSuffix().equals("wmv")
		    				|| file.getFileSuffix().equals("3gp")
		    				|| file.getFileSuffix().equals("mp4")
		    				|| file.getFileSuffix().equals("mov")
		    				|| file.getFileSuffix().equals("avi")
		    				|| file.getFileSuffix().equals("flv"))
		    		{
		    		    	//�������mp4��׺������ת����mp4
		    		    if(!file.getFileSuffix().equals("mp4")){
		    		    	//Դ�ļ�
		    		        File srcVideo = new File(srcPath+"mp4");    
		    		        //Ŀ���ļ�
		    		        File destVideo = new File(destPath+"mp4");  
		    		        //����
		    		        FileUtils.fileChannelCopy(srcVideo, destVideo);
		    		    }
		    		    //��������ͼ��jpg
	    		        File srcPic = new File(srcPath+"jpg");    
	    		        //Ŀ���ļ�
	    		        File destPic = new File(destPath+"jpg");  
	    		        //����
	    		        FileUtils.fileChannelCopy(srcPic, destPic);
		    		}

				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}  
		        //�浽���ݿ�
		       fileMapper.insert(file);
			}
		}
	}
	@Override
	public List<Share> getMyShareList(String userID) {
		// TODO Auto-generated method stub
		return shareMapper.getMyShareList(userID);
	}
	@Override
	public void cancleShare(ShareData sd) {
		// TODO Auto-generated method stub
		shareDataMapper.cancleShare(sd);
	}
}
