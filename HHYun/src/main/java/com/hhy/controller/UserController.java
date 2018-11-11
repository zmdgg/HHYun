package main.java.com.hhy.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import main.java.com.hhy.pojo.User;
import main.java.com.hhy.service.UserService;
import main.java.com.hhy.util.IDGenerator;
import net.sf.json.JSONObject;

@Controller
//@RequestMapping("/user") 
public class UserController {
	@Autowired
	private UserService userService;
	
	//��¼
	@RequestMapping(value="/login")
	public ModelAndView login(HttpServletRequest request,HttpSession session){
		ModelAndView mv = new ModelAndView();
		String userName = request.getParameter("loginName");
		String password = request.getParameter("loginPwd");
		//System.out.println(userName);
		//System.out.println("123");
		try{
			User user = userService.login(userName,password);
			//System.out.println(user.getUserName());
			//��½�ɹ�
			if(user!=null){
				//System.out.println("y");
				mv.setViewName("success");
				session.setAttribute("user", user);
				//mv.addObject("user", user);
			}
			//��¼ʧ��
			else{
				//System.out.println("n");
				mv.setViewName("error");
				//mv.addObject("user", user);
			}

		} catch(Exception e){
            e.printStackTrace();
		}
		return mv;
	}
	/*
	//���ajax
	@RequestMapping(value="/login")
	public void login(HttpServletRequest request,HttpServletResponse response){
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		JSONObject data ;	
		try{
			User user = userService.login(userName,password);
			//System.out.println(user.getUserName());
			//��½�ɹ�
			if(user!=null){
				System.out.println("y");
				//mv.setViewName("home");
				//data.addObject("user", user);
			}
			//��¼ʧ��
			else{
				System.out.println("n");
				//mv.setViewName("error");
				//mv.addObject("user", user);
			}
			HttpSession session = request.getSession(true);
			session.setAttribute("user", user);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
		} catch(Exception e){
            e.printStackTrace();
		}
	}
	*/
	
	//��ת������ҳ
	@RequestMapping(value="/home")
	public String home(HttpServletRequest request,HttpSession session){
		ModelAndView mv = new ModelAndView();
		//String userName = request.getParameter("loginName");
		//String password = request.getParameter("loginPwd");
		//System.out.println(userName);
		try{
			//User user = userService.login(userName,password);
			//System.out.println(user.getUserName());
			//mv.setViewName("redirect:WEB-INF/jsp/home");
			//mv.setViewName("redirect:user/home");
			//mv.setViewName("redirect:/home");
			//request.setAttribute("user", user);
			//session.setAttribute("user", user);
			//System.out.println(user.getUserName());	
			//request.getSession().setAttribute("user", user);
			//mv.addObject("user", user);
		} catch(Exception e){
            e.printStackTrace();
		}
		return "home";
	}
	
	//�˳���¼
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request){
		//session.getSessionContext().getSession("").se
		request.getSession().removeAttribute("user");
		return "redirect:/login.jsp";
	}
	
	//ע��ʱ���ж��û����Ƿ����
	@RequestMapping(value="/isExistUserName")
	public ModelAndView isExistUserName(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		String userName = request.getParameter("registerName");
		System.out.println(userName);
		try{
			User user = userService.getUserByName(userName);
			//�Ѿ�ע���
			if(user!=null){
				System.out.println(user.getId());
				mv.setViewName("error");
			}else{
				//��ûע��
				mv.setViewName("success");
			}

		} catch(Exception e){
            e.printStackTrace();
		}
		return mv;
	}
	//ע��
	@RequestMapping(value="/register")
	public ModelAndView register(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		String userName = request.getParameter("registerName");
		String password = request.getParameter("registerPwd");
		String realName = request.getParameter("registerRealName");
		String id = IDGenerator.genPrimaryKey();
		//System.out.println(userName);
		//System.out.println(password);
		//System.out.println(id);
		try{
			User user = new User();
			user.setId(id);
			user.setPassword(password);
			user.setUserName(userName);
			user.setRealName(realName);
			int result = userService.add(user);
			//System.out.println(user.getUserName());
			//ע��ɹ�
			if(result==1){
				//�����洢·��
				String savePath =  "C:" + File.separatorChar + "hhyDisk"
						+ File.separatorChar +user.getId()+ File.separatorChar; 
				File file = new File(savePath);
				if(!file.exists())
					file.mkdir();
				mv.setViewName("success");
			}
			//ע��ʧ��
			else{
				mv.setViewName("error");
			}

		} catch(Exception e){
            e.printStackTrace();
		}
		return mv;
	}
		
	//��ת����վ
	@RequestMapping(value="/goRecycle")
	public String goRecycle(HttpServletRequest request,HttpSession session){
		//��ȡ��¼session
		User user = (User)request.getSession().getAttribute("user");
		//System.out.println(user.getUserName());
		if(user!=null)
			return "recycle";
		else
			return "redirect:/login.jsp";
	}
	//��ת����ҳ
	@RequestMapping(value="/goMyShare")
	public String goMyShare(HttpServletRequest request,HttpSession session){
		//��ȡ��¼session
		User user = (User)request.getSession().getAttribute("user");
		//System.out.println(user.getUserName());
		if(user!=null)
			return "myshare";
		else
			return "redirect:/login.jsp";
	}
	
	//�û��б�
	@RequestMapping(value="showUserList")
	@ResponseBody
	public JSONObject  list(HttpServletRequest request){
		JSONObject json=null;
		try{
			List<User> l = userService.list();
			for(User u:l){
				System.out.println(u.getUserName());
			}
			  Map map = new HashMap();
		         
	          map.put("data", l);
	          json = JSONObject.fromObject(map);
	        //json = JSONObject.fromObject(map);
			//json.put("l", l);
		} catch(Exception e){
            e.printStackTrace();
		}
		return json;
	}
	//�û�����
	@RequestMapping(value="count")
	public ModelAndView count(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		try{
			int l = userService.count();
			System.out.println(l);
			mv.setViewName("index");
			mv.addObject("var", l);
		} catch(Exception e){
            e.printStackTrace();
		}
		return mv;
	}
	
}
