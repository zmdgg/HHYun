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

	//创建分享
	@RequestMapping(value="shareCreate")
	@ResponseBody
	public void shareCreate(HttpServletRequest request){
		String id = IDGenerator.genPrimaryKey();
		String userID = request.getParameter("userID");
		String pwd = request.getParameter("sharepwd");
		String magID = request.getParameter("magID");
		//去掉http地址
		magID = magID.split("=")[1];
		//System.out.println(request.getParameter("fidlist"));
		String[] fileIDs = request.getParameter("fidlist").split(",");
		String[] folderIDs =request.getParameter("cateid").split(","); 
		String pretime = request.getParameter("pretime");
		int time = 0;
		if(pretime.equals("7天")){
			time = 7;
		}else if(pretime.equals("1天")){
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
	
	//访问具体页面
	@RequestMapping(value="shareurl")
	public ModelAndView shareurl(HttpServletRequest request){
		String url = request.getParameter("url");
		ModelAndView mv = new ModelAndView();
		//参数是否为空
		if(url!=null){
			//url是否合法
			Share s = shareService.selectByMagID(url);
			if(s!=null){
				//如果合法，判断是否过期
				long t = System.currentTimeMillis();
				if(s.getRemainTime()==0||s.getShareDate().getTime()+s.getRemainTime()*24*3600*1000>=t){
					//如果没过期,再判断是否公开分享
					if(s.getPwd().equals("")||s.getPwd()==null){
						//初始化结果列表
						List<MyFile> fileList = new ArrayList<MyFile>();
						List<Folder> folderList = new ArrayList<Folder>();
						//获得分享文件列表
						List<ShareData> sflist = shareService.getShareDataList(url);
						
						for(int i=0;i<sflist.size();i++){
							//如果是文件夹
							if(sflist.get(i).getIsFolder()== 1){
								//在判断是否存在,sql语句里会判断是否存在（未被删除）
								Folder f = folderService.getRecycleByID(sflist.get(i).getFileOrFolderID(), 0);
								if(f != null){
									folderList.add(f);
								}
							}else{
								//如果是文件,sql语句里会判断是否存在（未被删除）
								MyFile file = fileService.getFileByIDAndState(sflist.get(i).getFileOrFolderID(), 0);
								//在判断是否存在
								if(file != null){
									fileList.add(file);
								}
							}
						}
						//如果分享的文件和文件夹均被删除了
						if(fileList.size() == 0 && folderList.size() == 0){
							mv.setViewName("errorurl");
						}else{
							//否则显示分享页面
							User u = userService.getUserByID(s.getUserID());
							mv.addObject("shareUser", u);
							mv.addObject("filelist", fileList);
							mv.addObject("catelist", folderList);
							mv.addObject("share", s);
							mv.setViewName("share");
						}
						
					}else{
						//加密分享
						User u = userService.getUserByID(s.getUserID());
						mv.addObject("shareUser", u);
						mv.addObject("url",url);
						mv.setViewName("re_index");
					}
				}else{
					//过期
					mv.setViewName("errorurl");
				}
			}else{
				//如果不合法
				mv.setViewName("errorurl");
			}
		}else{
			//如果为空
			mv.setViewName("re_index");
		}
		return mv;
	}
	
	//提取码验证
	@RequestMapping(value="shareLogin")
	public ModelAndView shareLogin(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		String url = request.getParameter("url");
		String sharepwd = request.getParameter("sharepwd");
		if(sharepwd!=null){
			//验证
			Share s = shareService.checkpwd(url, sharepwd);
			if(s!=null){
				//验证成功，初始化结果列表
				List<MyFile> fileList = new ArrayList<MyFile>();
				List<Folder> folderList = new ArrayList<Folder>();
				//获得分享文件列表
				List<ShareData> sflist = shareService.getShareDataList(url);
				
				for(int i=0;i<sflist.size();i++){
					//如果是文件夹
					if(sflist.get(i).getIsFolder()== 1){
						//在判断是否存在,sql语句里会判断是否存在（未被删除）
						Folder f = folderService.getRecycleByID(sflist.get(i).getFileOrFolderID(), 0);
						if(f != null){
							folderList.add(f);
						}
					}else{
						//如果是文件,sql语句里会判断是否存在（未被删除）
						MyFile file = fileService.getFileByIDAndState(sflist.get(i).getFileOrFolderID(), 0);
						//在判断是否存在
						if(file != null){
							fileList.add(file);
						}
					}
				}
				//如果分享的文件和文件夹均被删除了
				if(fileList.size() == 0 && folderList.size() == 0){
					mv.setViewName("errorurl");
				}else{
					//否则显示分享页面
					User u = userService.getUserByID(s.getUserID());
					mv.addObject("shareUser", u);
					mv.addObject("filelist", fileList);
					mv.addObject("catelist", folderList);
					mv.addObject("share", s);
					mv.setViewName("share");
				}
			}else{
				//验证错误
				Share src = shareService.selectByMagID(url);
				User u = userService.getUserByID(src.getUserID());
				mv.addObject("shareUser", u);
				mv.addObject("url",url);
				mv.addObject("errorinfo","提取码错误");
				mv.setViewName("re_index");
			}
		}	
		return mv;
	}
	
	//分享文件夹下一层
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
	
	
	//保存分享的文件和文件夹
	@RequestMapping(value="preservation")
	@ResponseBody
	public String preservation(HttpServletRequest request){
		//有问题，貌似能重名？
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
	
	//我的分享
	@RequestMapping(value="myshare")
	@ResponseBody
	public Map<String, Object> myshare(HttpServletRequest request){
		String userID =request.getParameter("userID");
    	Map<String, Object> map = new HashMap<String, Object>();
    	//获取分享链接
    	List<Share> sharelist =shareService.getMyShareList(userID);
    	List<MyFile> filelist = new ArrayList<MyFile>();
    	List<Folder> catelist = new ArrayList<Folder>();
    	for(int i=0;i<sharelist.size();i++){
    		//再对每个分享遍历
    		List<ShareData> sflist = shareService.getShareDataList(sharelist.get(i).getMagID());
    		for(int j=0;j<sflist.size();j++){
    			//如果是文件夹
    			if(sflist.get(j).getIsFolder() == 1){
    				Folder f = folderService.getFolderByID(sflist.get(j).getFileOrFolderID());
    				if(f != null){
    					//分享时间
    					f.setUpdateDate(sharelist.get(i).getShareDate());
    					//分享时限
    					f.setIsDelete(sharelist.get(i).getRemainTime());
    					//分享标识
    					f.setSuperFolderID(sharelist.get(i).getMagID());
    					catelist.add(f);
    				}
    			}else{
    				MyFile file = fileService.getFileByID(sflist.get(j).getFileOrFolderID());
    				if(file != null){
    					//分享时间
    					file.setUpdateDate(sharelist.get(i).getShareDate());
    					//分享时限
    					file.setIsDelete(sharelist.get(i).getRemainTime());
    					//分享标识
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
	
	//取消分享
	@RequestMapping(value="cancleShare")
	@ResponseBody
	public String cancleShare(HttpServletRequest request){
		String magid = request.getParameter("magid");
		String filecateid = request.getParameter("filecateid");
		System.out.println(magid);
		//分割
    	ShareData sharefile = new ShareData();
    	String[] magidlist = magid.split(",");
    	String[] fcidlist = filecateid.split(",");
    	//根据magID和fileAndFolderID，便利删除
    	for(int i=0;i<fcidlist.length;i++){
    		sharefile.setMagid(magidlist[i]);
    		sharefile.setFileOrFolderID(fcidlist[i]);
    		//直接删除分享的东西，分享链接不会删除（那里会判断是否为空）
    		shareService.cancleShare(sharefile);
    	}
    	return "success";
    }
}
