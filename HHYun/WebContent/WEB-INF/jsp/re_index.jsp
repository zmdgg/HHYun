   <%@ page language="java" contentType="text/html; charset=UTF-8"  
        pageEncoding="UTF-8"%>  

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>HaHa云盘</title>
		<link rel="stylesheet" href="css/re_index.css" /> 
		<link rel="Shortcut Icon" href="img/logo.png">
	</head>
	<body >
		<div class="content">
	        <div class="logo">
	        	<img src="img/logo.png" class="logo-p"/>
	        	<span class="logoName">HaHa云盘</span>
	        </div>
		    <div class="content-form">
		    	<div class="content-head">
		    		<img src="img/photo.jpg"  class="head-img">
		    		<span class="span-name">
		    			${shareUser.userName }
                    </span>
		    		<span class="span-file">给您分享了文件</span>
		    	</div>
		    	<form action="${pageContext.request.contextPath}/shareLogin.action" method="post" onsubmit ="return check();">
		    	<div class="content-fonter">
		    		<div class="re-pwd">
		    		<input type="hidden" value="${url }" name="url" id="url">
		    			<div><p>请输入提取密码:</p></div>
		    			<div><input type="text" class="text" name="sharepwd" id="sharepwd"><input type="submit" class="button" value="提取文件" ></div>
		    		</div>
		    			<span id="error_login" style='color: red;padding-top:20px;padding-right:300px;'>${errorinfo }</span>
		    	</div>
		    	</form>
		    </div>
		</div>
		</div>
		<div class="cloud-bg">
			<div class="bg1"></div>
			<div class="bg2"></div>
			<div class="bg3"></div>
		</div>
		<div class="init-footer">
<div class="footer" id="footer" style="height: 40px;">
<div class="footer-txt">
<div xmlns="http://www.w3.org/1999/xhtml">&copy;2018Baidu<a class="b-lnk-gy" href="//pan.baidu.com/platform/home" target="_blank">移动开放平台</a>|<a class="b-lnk-gy" href="/disk/duty/" target="_blank">服务协议</a>|<a class="b-lnk-gy" href="//yun.baidu.com/disk/privacy" target="_blank">权利声明</a>|<span class="hp-footer-link"><a class="b-lnk-gy" href="http://yun.baidu.com/disk/version" target="_blank">版本更新</a>|<a class="b-lnk-gy" href="http://yun.baidu.com/disk/help" target="_blank">帮助中心</a>|<a class="b-lnk-gy" href="http://help.baidu.com/newadd?prod_id=29&category=2&ptype=48" target="_blank">问题反馈</a>|<a class="b-lnk-gy" href="http://copyright.baidu.com/index.php/index/complaint" target="_blank">版权投诉</a></div>
</div>
</div></div>
<script type="text/javascript">
 function check() {
		var sharepwd =document.getElementById("sharepwd").value;
		if(sharepwd==""||sharepwd==null){
			document.getElementById("error_login").innerHTML = "提取码为空";
			return false;
		}else
			return true;
			
	}       
	</script>
	</body>
</html>
