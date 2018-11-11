package main.java.com.hhy.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import main.java.com.hhy.pojo.Folder;
import main.java.com.hhy.pojo.MyFile;
import main.java.com.hhy.pojo.Share;
import main.java.com.hhy.pojo.ShareData;
import main.java.com.hhy.pojo.User;
import main.java.com.hhy.service.FileService;
import main.java.com.hhy.service.FolderService;
import main.java.com.hhy.service.ShareService;
import main.java.com.hhy.service.UserService;
import main.java.com.hhy.util.IDGenerator;

@Controller
public class ShareController {
	@Autowired
	private ShareService shareService;
	@Resource
	private UserService userService;
	@Resource
	private FolderService folderService;
	@Resource
	private FileService fileService;

	//��������
	@RequestMapping(value="shareCreate")
	@ResponseBody
	public void shareCreate(HttpServletRequest request){
		String id = IDGenerator.genPrimaryKey();
		String userID = request.getParameter("userID");
		String pwd = request.getParameter("sharepwd");
		String magID = request.getParameter("magID");
		//ȥ��http��ַ
		magID = magID.split("=")[1];
		//System.out.println(request.getParameter("fidlist"));
		String[] fileIDs = request.getParameter("fidlist").split(",");
		String[] folderIDs =request.getParameter("cateid").split(","); 
		String pretime = request.getParameter("pretime");
		int time = 0;
		if(pretime.equals("7��")){
			time = 7;
		}else if(pretime.equals("1��")){
			time=1;
		}
		Share share = new Share();
		share.setId(id);
		share.setUserID(userID);
		share.setPwd(pwd);
		share.setRemainTime(time);
		share.setMagID(magID);
		
		ShareData sd = new ShareData();
		sd.setMagid(magID);
		if(fileIDs[0].length() == 0){
			if(folderIDs[0].length() == 0){
				//out.print("0");
				;
				
			}else{
				sd.setIsFolder(1);
				shareService.sharefile(sd, folderIDs);
				
			}
		}else{
			if(folderIDs[0].length() == 0){
				sd.setIsFolder(0);
				shareService.sharefile(sd, fileIDs);
				
			}else{
				sd.setIsFolder(1);
				shareService.sharefile(sd, folderIDs);
				sd.setIsFolder(0);
				shareService.sharefile(sd, fileIDs);
				
			}
		}
		shareService.addshare(share);
	}
	
	//���ʾ���ҳ��
	@RequestMapping(value="shareurl")
	public ModelAndView shareurl(HttpServletRequest request){
		String url = request.getParameter("url");
		ModelAndView mv = new ModelAndView();
		//�����Ƿ�Ϊ��
		if(url!=null){
			//url�Ƿ�Ϸ�
			Share s = shareService.selectByMagID(url);
			if(s!=null){
				//����Ϸ����ж��Ƿ����
				long t = System.currentTimeMillis();
				if(s.getRemainTime()==0||s.getShareDate().getTime()+s.getRemainTime()*24*3600*1000>=t){
					//���û����,���ж��Ƿ񹫿�����
					if(s.getPwd().equals("")||s.getPwd()==null){
						//��ʼ������б�
						List<MyFile> fileList = new ArrayList<MyFile>();
						List<Folder> folderList = new ArrayList<Folder>();
						//��÷����ļ��б�
						List<ShareData> sflist = shareService.getShareDataList(url);
						
						for(int i=0;i<sflist.size();i++){
							//������ļ���
							if(sflist.get(i).getIsFolder()== 1){
								//���ж��Ƿ����,sql�������ж��Ƿ���ڣ�δ��ɾ����
								Folder f = folderService.getRecycleByID(sflist.get(i).getFileOrFolderID(), 0);
								if(f != null){
									folderList.add(f);
								}
							}else{
								//������ļ�,sql�������ж��Ƿ���ڣ�δ��ɾ����
								MyFile file = fileService.getFileByIDAndState(sflist.get(i).getFileOrFolderID(), 0);
								//���ж��Ƿ����
								if(file != null){
									fileList.add(file);
								}
							}
						}
						//���������ļ����ļ��о���ɾ����
						if(fileList.size() == 0 && folderList.size() == 0){
							mv.setViewName("errorurl");
						}else{
							//������ʾ����ҳ��
							User u = userService.getUserByID(s.getUserID());
							mv.addObject("shareUser", u);
							mv.addObject("filelist", fileList);
							mv.addObject("catelist", folderList);
							mv.addObject("share", s);
							mv.setViewName("share");
						}
						
					}else{
						//���ܷ���
						User u = userService.getUserByID(s.getUserID());
						mv.addObject("shareUser", u);
						mv.addObject("url",url);
						mv.setViewName("re_index");
					}
				}else{
					//����
					mv.setViewName("errorurl");
				}
			}else{
				//������Ϸ�
				mv.setViewName("errorurl");
			}
		}else{
			//���Ϊ��
			mv.setViewName("re_index");
		}
		return mv;
	}
	
	//��ȡ����֤
	@RequestMapping(value="shareLogin")
	public ModelAndView shareLogin(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		String url = request.getParameter("url");
		String sharepwd = request.getParameter("sharepwd");
		if(sharepwd!=null){
			//��֤
			Share s = shareService.checkpwd(url, sharepwd);
			if(s!=null){
				//��֤�ɹ�����ʼ������б�
				List<MyFile> fileList = new ArrayList<MyFile>();
				List<Folder> folderList = new ArrayList<Folder>();
				//��÷����ļ��б�
				List<ShareData> sflist = shareService.getShareDataList(url);
				
				for(int i=0;i<sflist.size();i++){
					//������ļ���
					if(sflist.get(i).getIsFolder()== 1){
						//���ж��Ƿ����,sql�������ж��Ƿ���ڣ�δ��ɾ����
						Folder f = folderService.getRecycleByID(sflist.get(i).getFileOrFolderID(), 0);
						if(f != null){
							folderList.add(f);
						}
					}else{
						//������ļ�,sql�������ж��Ƿ���ڣ�δ��ɾ����
						MyFile file = fileService.getFileByIDAndState(sflist.get(i).getFileOrFolderID(), 0);
						//���ж��Ƿ����
						if(file != null){
							fileList.add(file);
						}
					}
				}
				//���������ļ����ļ��о���ɾ����
				if(fileList.size() == 0 && folderList.size() == 0){
					mv.setViewName("errorurl");
				}else{
					//������ʾ����ҳ��
					User u = userService.getUserByID(s.getUserID());
					mv.addObject("shareUser", u);
					mv.addObject("filelist", fileList);
					mv.addObject("catelist", folderList);
					mv.addObject("share", s);
					mv.setViewName("share");
				}
			}else{
				//��֤����
				Share src = shareService.selectByMagID(url);
				User u = userService.getUserByID(src.getUserID());
				mv.addObject("shareUser", u);
				mv.addObject("url",url);
				mv.addObject("errorinfo","��ȡ�����");
				mv.setViewName("re_index");
			}
		}	
		return mv;
	}
	
	//�����ļ�����һ��
	@RequestMapping(value="showFolderNext")
	@ResponseBody
	public Map<String, Object> showFolderNext(HttpServletRequest request){
		String folderID = request.getParameter("folderID");
		Map<String, Object> map = new HashMap<String, Object>();
		List<Folder> catelist = folderService.getFolderNext(folderID);
		List<MyFile> filelist = fileService.getFolderNextFile(folderID);
		map.put("catelist", catelist);
		map.put("filelist", filelist);
		return map;
	}
	
	
	//���������ļ����ļ���
	@RequestMapping(value="preservation")
	@ResponseBody
	public String preservation(HttpServletRequest request){
		//�����⣬ò����������
		int result;
		String userID = request.getParameter("userID");
		String insertFolderID = request.getParameter("insertFolderID");
		String[] fid =request.getParameter("fidlist").split(",");
		String[] fname =request.getParameter("fnamelist").split(",");
		String[] cidlist = request.getParameter("cateid").split(",");
		String[] cnamelist =request.getParameter("catename").split(",");
		
		int fileflag = 1,cateflag = 1;
		if(insertFolderID.equals("null")||insertFolderID.equals("")){
			insertFolderID = "";
		}
		if(fid[0].length() == 0){
			if(cidlist[0].length() == 0){
				return null;
			}else{
				cateflag = shareService.checkFolder(cidlist,cnamelist,cateflag,userID,insertFolderID);
				if(cateflag == 1){
					shareService.preservationcate(userID, cidlist, insertFolderID);
					result = 1;
				}else{
					result = 0;
				}
			}
		}else{
			if(cidlist[0].length() == 0){
				fileflag = shareService.checkfile(fid,fname,fileflag,userID,insertFolderID);
				if(fileflag == 1){
					shareService.preservation(userID, fid, insertFolderID);
					result = 1;
				}else{
					result = 0;
				}
			}else{
				fileflag = shareService.checkfile(fid,fname,fileflag,userID,insertFolderID);
				if(fileflag == 0){
					result = 0;
				}
				cateflag = shareService.checkFolder(cidlist,cnamelist,cateflag,userID,insertFolderID);
				if(cateflag == 0){
					result = 0;
				}
				shareService.preservation(userID, fid, insertFolderID);
				shareService.preservationcate(userID, cidlist, insertFolderID);
				result = 1;
			}
		}
		if(result==0)
			return "error";
		else
			return "success";
	}
	
	//�ҵķ���
	@RequestMapping(value="myshare")
	@ResponseBody
	public Map<String, Object> myshare(HttpServletRequest request){
		String userID =request.getParameter("userID");
    	Map<String, Object> map = new HashMap<String, Object>();
    	//��ȡ��������
    	List<Share> sharelist =shareService.getMyShareList(userID);
    	List<MyFile> filelist = new ArrayList<MyFile>();
    	List<Folder> catelist = new ArrayList<Folder>();
    	for(int i=0;i<sharelist.size();i++){
    		//�ٶ�ÿ���������
    		List<ShareData> sflist = shareService.getShareDataList(sharelist.get(i).getMagID());
    		for(int j=0;j<sflist.size();j++){
    			//������ļ���
    			if(sflist.get(j).getIsFolder() == 1){
    				Folder f = folderService.getFolderByID(sflist.get(j).getFileOrFolderID());
    				if(f != null){
    					//����ʱ��
    					f.setUpdateDate(sharelist.get(i).getShareDate());
    					//����ʱ��
    					f.setIsDelete(sharelist.get(i).getRemainTime());
    					//�����ʶ
    					f.setSuperFolderID(sharelist.get(i).getMagID());
    					catelist.add(f);
    				}
    			}else{
    				MyFile file = fileService.getFileByID(sflist.get(j).getFileOrFolderID());
    				if(file != null){
    					//����ʱ��
    					file.setUpdateDate(sharelist.get(i).getShareDate());
    					//����ʱ��
    					file.setIsDelete(sharelist.get(i).getRemainTime());
    					//�����ʶ
    					file.setFolderID(sharelist.get(i).getMagID());
    					filelist.add(file);
    				}
    			}
    		}
    	}
    	
    	map.put("catelist", catelist);
    	map.put("filelist", filelist);
    	return map;
    }
	
	//ȡ������
	@RequestMapping(value="cancleShare")
	@ResponseBody
	public String cancleShare(HttpServletRequest request){
		String magid = request.getParameter("magid");
		String filecateid = request.getParameter("filecateid");
		System.out.println(magid);
		//�ָ�
    	ShareData sharefile = new ShareData();
    	String[] magidlist = magid.split(",");
    	String[] fcidlist = filecateid.split(",");
    	//����magID��fileAndFolderID������ɾ��
    	for(int i=0;i<fcidlist.length;i++){
    		sharefile.setMagid(magidlist[i]);
    		sharefile.setFileOrFolderID(fcidlist[i]);
    		//ֱ��ɾ������Ķ������������Ӳ���ɾ����������ж��Ƿ�Ϊ�գ�
    		shareService.cancleShare(sharefile);
    	}
    	return "success";
    }
}
