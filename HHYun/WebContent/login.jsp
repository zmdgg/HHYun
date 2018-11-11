<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*,java.net.*" %>
 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<link rel="Shortcut Icon" href="img/logo.png">
<link rel="stylesheet" href="css/login.css">

<!-- 
<link href="css/bootstrap.min.css" rel="stylesheet">
 <script src="js/jquery-3.3.1.min.js"></script>
 <script src="js/bootstrap.min.js"></script>
-->
 <!-- 预加载一遍 -->
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>


<link href="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.staticfile.org/jquery/3.3.1/jquery.min.js"></script>
 <script src="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
 

<%
  //记住登录
  String un="";
  String up="";
  Cookie cookie[]=request.getCookies();
  if(cookie!=null)
  {
	  for(Cookie ck:cookie)
	  {
		  if("username".equals(ck.getName()))
		  {
			  un=URLDecoder.decode(ck.getValue(), "utf-8");
		  }
		  if("password".equals(ck.getName()))
		  {
			  up=ck.getValue();
		  }
	  }
  }



%>
<style>
.carousel-inner a >img {
	width:100%;
}

</style>
	</head>
<body>
<div class="login-container">
    <div id="myCarousel" class="carousel slide">
	<!-- 轮播（Carousel）指标 -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
	</ol>   
	<!-- 轮播（Carousel）项目 -->
	<div class="carousel-inner">
		<div class="item active" >
			<a><img src="user/img/bg1.jpg" alt="First slide"></a>
			<div class="body-content">
			<p>
		    <span ><img src="user/img/leftquote.png"></span>
			<span>安全存储</span>
			</p>
			<p>
    		<span>生活仅仅有条</span>
			<span><img src="user/img/rightquote.png"></span>
			</p>
			</div>
		</div>
		<div class="item" >
			<a><img src="user/img/bg2.jpg" alt="Second slide"></a>
			<div class="body-content">
			<p>
			<span ><img src="user/img/leftquote.png"></span>
			<span>在线预览</span>
			</p>
			<p>
			<span>文件即开即看</span>
			<span><img src="user/img/rightquote.png"></span>
			</p>
			</div>
		</div>
		<div class="item" >
			<a><img src="user/img/bg3.jpg" alt="Third slide"></a>
			<div class="body-content">
			<p>
			<span><img src="user/img/leftquote.png"></span>
			<span>多端并用</span>
			</p>
			<p>
			<span>数据随身携带</span>
			<span><img src="user/img/rightquote.png"></span>
			</p>
			</div>
		</div>
		<div class="item" >
			<a><img src="user/img/bg3.jpg" alt="Third slide"></a>
			<div class="body-content">
			<p>
			<span><img src="user/img/leftquote.png"></span>
			<span>好友分享</span>
			</p>
			<p>
			<span>共度幸福时光</span>
			<span><img src="user/img/rightquote.png"></span>
			</p>
			</div>		
		</div>
	</div>
</div> 
<div class="logo"><img src="user/img/cloud.png" ><span> 哈哈云盘</span></div>
			<div id="login-middle">
			<div class="login_title">
				<h4>账号密码登录</h4>
			</div>
			 
			<div class="login_form">

			  <form action="${pageContext.request.contextPath}/home.action" method="post" >

				<div class="form_user">
					<input type="text" placeholder="  用户名/手机/邮箱" name="loginName" id="loginName" value="<%=un%>"/>
				</div>
				<div class="form_password">
					<input type="password" placeholder="   密 码"  name="loginPwd" id="loginPwd" value="<%=up%>"/>
				</div>
				
				<div class="form_check">
					<input type="checkbox"  name="check" id="check"/>
					<span>记住密码&nbsp; </span><span id="error_login" style='color: red;'></span>
				</div>
				<div class="form_login">
				 
					<input type="button" value="登录" id="my_login"  onclick="login()" />
					<input type="submit" class="hidden" id='sub' name="submit"></input>
				</div>
				<div class="form_href" id="question">
					<a href="goforget">忘记密码？</a>
				</div>
				<div class="form_href" id="number">
					<a href="#">海外手机号</a>
				</div>
			   <input type="hidden" id="success" value="${message}" > 
              </form>
             
			</div>
			
			<div class="login_bottom">
				<div class="bottom_href">
					<ul>	
				    	<li> <a href="#"><input type="submit" value="扫一扫登录" id="scan_login"/></a></li>
				    	<li> <a href="#"><img src="user/img/weibo.png"/></a></li>
				    	<li> <a href="#"><img src="user/img/qq.png"/></a></li>
				    	<li><a href="#"><input type="button" value="立即注册" id="goRegister"/></a></li>
					</ul>
				</div>
			</div>

		</div>
		
		<div id="register-middle">
			<div class="login_title">
				<h4>用户注册</h4>
			</div>
			 
			<div class="login_form">

			  <form action="" method="post" id="login">

				<div class="form_user">
					<input type="text" placeholder="   用户名/手机/邮箱" id="registerName" name="registerName" />
				</div>
				<div class="form_password">
					<input type="text" placeholder="   真 实 姓 名" id="registerRealName" name="registerRealName" />
				</div>
				<div class="form_password">
					<input type="password" placeholder="   密 码" id="registerPwd1" name="registerPwd1" />
				</div>
				<div class="form_password">
					<input type="password" placeholder="   确 认 密 码" id="registerPwd2" name="registerPwd2" />
				</div>				
				<div class="form_check">
					<input type="checkbox"  name="check"/>
					<span>阅读并接受<a href="#">《哈哈云盘用户协议》</a></span>
					<span id="error_register" style='color: red;'></span>
				</div>
				<div class="form_register">
				 	<input type="button" value="返回" id="cancle" />
					<input type="button" value="注册" onclick="register()" style="margin-left:30px;"/>
				</div>
			   <input type="hidden" id="reSuccess" value="${message}" > 
              </form>
             
			</div>
			

		</div>
</div>
<script type="text/javascript">
$(document).ready(function(){ 
	//隐藏注册框	
	$('#register-middle').hide();
	//用户点击去注册
 	$("#goRegister").click(function(){
 		$('#login-middle').hide();
 		$('#register-middle').show();
 	});
 	//不注册
 	$("#cancle").click(function(){
   		$('#register-middle').hide();
  		$('#login-middle').show();
  	});
 	//轮播图
 	$('.carousel').carousel({
 		  interval:3000
    });
 });
 
    //登录验证
   /*
	$(document).ready(function(){
		var successmassge = $("#success").val();
	    if(successmassge=="error"){
			//alert("用户名或密码错误！");
			
			location.href="login.jsp";
			document.getElementById("error_login").innerHTML = "用户名或密码错误";
		}
	*/
	function login() {
		var loginName = $("#loginName").val();
		var loginPwd = $("#loginPwd").val();
		var check = $("#check").val();
		$("#my_login").val("登录中...");
		//alert(loginName);
		$.ajax({
			url : "${pageContext.request.contextPath}/login.action",
			type : "post",
			data : {
				"loginName" : loginName,
				"loginPwd" : loginPwd,
				//"check" : check
			},
			success : function(data) {
				var result = data;
				//alert(data);
				//console.log(data);
				if (result == 'error'){
					document.getElementById("error_login").innerHTML = "用户名或密码错误";
				}
				else{
					//$("#login").attr('action','${pageContext.request.contextPath}/usergologin');
					//$("#sub").click(); 
					//window.location.replace("${pageContext.request.contextPath}/home.action");
					window.location.href="${pageContext.request.contextPath}/home.action";
				}
				
			},
			error : function() {
				alert("error!");
			}
		});
		$("#my_login").val("登录");
	}       
         
	var flag = true;
  	//异步判断,用户名是否注册
	$("#registerName").blur(function() {
  		var registerName = $("#registerName").val();
  		if (registerName != '') {
	  		//判断用户名是否存在
	  	  	$.ajax({
				url : "${pageContext.request.contextPath}/isExistUserName.action",
				type : "post",
				data : {
					"registerName" : registerName,
				},
				success : function(data) {
					var result = data;
					//alert(data);
					console.log(result);
					if (result == 'error'){
						document.getElementById("error_register").innerHTML = "用户名已存在";
						flag = false;
					}
					else{
						document.getElementById("error_register").innerHTML = "";
						flag = true;
					}
				},
				error : function() {
					alert("error!");
				}
			});
  		}
  	});
    function register() {
 		var registerName = $("#registerName").val();
 		var registerRealName = $("#registerRealName").val();
 		var registerPwd1 = $("#registerPwd1").val();
 		var registerPwd2 = $("#registerPwd2").val();
 		console.log(registerPwd1);
 		console.log(registerPwd2);	
 		if(registerName==""){
 			document.getElementById("error_register").innerHTML = "用户名不为空";
 			return;
 		}else if(registerRealName==""){
 			document.getElementById("error_register").innerHTML = "姓名不能为空";
 			return;
 		}
 		else if(registerPwd1==""){
 			document.getElementById("error_register").innerHTML = "密码不能为空";
 			return;
 		}
 		else if(registerPwd1!=registerPwd2){
 			document.getElementById("error_register").innerHTML = "密码不一致";
 			return;
 		}else if(!flag){
 			return;
 		}
 		else{
	 		//注册
			$.ajax({
				url : "${pageContext.request.contextPath}/register.action",
				type : "post",
				data : {
					"registerName" : registerName,
					"registerPwd" : registerPwd1,
					"registerRealName":registerRealName
				},
				success : function(data) {
					var result = data;
					if (result == 'error'){
						document.getElementById("error_reg").innerHTML = "注册失败";
					}
					else{
						document.getElementById("error_login").innerHTML = "注册成功，请登录";
				   		$('#register-middle').hide();
				  		$('#login-middle').show();
					}
					
				},
				error : function() {
					alert("error!");
				}
			});
 		}
 	}
	</script>
</body>
</html>
