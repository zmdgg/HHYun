<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="main.java.com.hhy.util.IDGenerator" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <head>
    <base href="<%=basePath%>">
    
    <title>主页</title>
    
 <link rel="Shortcut Icon" href="img/logo.png">


<link href="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.staticfile.org/jquery/3.3.1/jquery.min.js"></script>
 <script src="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>



<link rel="stylesheet" type="text/css" href="css/webuploader.css">
<script type="text/javascript" src="js/webuploader.nolog.min.js"></script>

 <link rel="stylesheet" type="text/css" href="css/home.css">
<link rel="stylesheet" type="text/css" href="css/refer.css">
<link rel="stylesheet" type="text/css" href="css/component.css">

<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript" src="js/utils.js"></script>
<!--  
 <link href="css/bootstrap.min.css" rel="stylesheet">
 <script src="js/jquery-3.3.1.min.js"></script>
 <script src="js/bootstrap.min.js"></script>
 
<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css" href="toastrjs/toastr.min.css">
<script type="text/javascript" src="toastrjs/toastr.min.js"></script>

 <link rel="stylesheet" type="text/css" href="videojs/css/video-js.min.css">
<script type="text/javascript" src="videojs/js/video.min.js"></script>

<script type="text/javascript" src="js/spark-md5.min.js"></script>

<link rel="stylesheet" type="text/css" href="viewerjs/viewer.min.css">
<script type="text/javascript" src="viewerjs/viewer.min.js"></script>

-->

<link rel="stylesheet" href="http://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">

 <link rel="stylesheet" href="http://cdn.staticfile.org/video.js/7.1.0/video-js.min.css">
<script type="text/javascript" src="http://cdn.staticfile.org/video.js/7.1.0/video.min.js"></script>

 <!-- 有修改过 -->
<link rel="stylesheet" type="text/css" href="toastrjs/toastr.min.css">
<script type="text/javascript" src="https://cdn.staticfile.org/toastr.js/2.1.4/toastr.min.js"></script>

<script type="text/javascript" src="http://cdn.staticfile.org/spark-md5/3.0.0/spark-md5.min.js"></script>

<link rel="stylesheet" type="text/css" href="http://cdn.staticfile.org/viewerjs/1.3.0/viewer.min.css">
<script type="text/javascript" src="http://cdn.staticfile.org/viewerjs/1.3.0/viewer.min.js"></script>






</head>
<script type="text/javascript">
	//判断登录信息
	var flag ="${user.id}";
	if(flag.length==0||flag==null||flag=='')
		window.location.replace("login.jsp");
	
	$(function(){
		$("#wrap").hide();
		//自适应
		$("#cc").layout({
			fit:true,
		});
		//上方菜单选中状态切换
		$("#topMenu li").click(function() {
	        $(this).siblings('li').removeClass('liactive');  // 删除其他兄弟元素的样式
	        $(this).addClass('liactive');                            // 添加当前元素的样式
	    });
		//带箭头下拉菜单
		$('#user').mouseover(function(){//鼠标滑上去
			$("#wrap").show();
		})
		$('#user').mouseout(function(){//鼠标离开
			$("#wrap").hide();
		})
		//左侧菜单
		$("#leftMenu li").click(function(){
			   $(this).addClass("leftMenuActive").siblings().removeClass("leftMenuActive");
		});
		//文件排序
		$('.lp').mouseover(function(){//鼠标滑上去
			$(".listpal").show();
		})
		$('.lp').mouseout(function(){//鼠标离开
			$(".listpal").hide();
		})
		
	});
</script>
<body>
  	 <div class='top'>	
  	 		<div class="" style="display: inline-block;margin-left:20px;">
				<img src="img/logo.png" style=""/>
				<span style="font-size:20px;">HaHaCloud</span>
			</div>
	
			<div class="" style="display: inline-block;width:45%;">
				<ul id="topMenu">
					<li class="liactive">
						<a href="goindex" onclick="return false">网盘</a>
					</li>
					<li>
						<a href="findAll" onclick="return false">分享</a>
					</li>
					<li>
						<a href="more" onclick="return false">更多</a>
					</li>
					<li>
						<a href="sc" onclick="return false">商城</a>
					</li>
				</ul>
				<a href="#" onclick="return false" style="margin-left:35%;color:#F8645C;text-decoration:underline;">超级会员 超低价</a>
			</div>
			
			<div id="user" class="" style="display:inline-block;">
				<img src="img/photo.jpg" class="photo" />
				<span style="color:#424E67;">${user.userName}</span>
				<img src="img/SVIP.png" style="display: inline-block;margin-bottom:15px;" />
				<em style="display: inline-block;"><img id="selUpDown" class="user-arrow" src="img/downchoose.png" style="margin-bottom:5px;"/></em>
			<div id="wrap" >
				<div id="userMenuTop" >
					<img src="img/photo.jpg" class="photo" style="border:1.5px solid #E8E8E8;margin-left:20px;margin-top:20px;"/>
					<span style="color:#424E67;margin-bottom:20px;">${user.userName}</span>
					<img src="img/SVIP.png" style="display: inline-block;margin-left:5px;" />
				</div>
				<div id="userMenuBottom" >
					<span style="font-size:12px;color:#424E67;margin:10px;">超级会员专享特权：</span>
					<a class="svip">开通超级会员</a>
				<ul id="userMenu">
					<li >
						<a href="goindex" onclick="return false">个人资料</a>
					</li>
					<li>
						<a href="findAll" onclick="return false">设置二级密码</a>
					</li>
					<li>
						<a href="more" onclick="return false">帮助中心</a>
					</li>
					<li>
						<a href="sc" onclick="return false">设置</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/logout.action" >退出</a>
					</li>
				</ul>				
				</div>
			</div>
			</div>
			
		<div class="" style="display: inline-block;">
				<span style="color:#424E67;">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;客户端下载&nbsp;&nbsp;&nbsp;</span>
			<img src="img/notice.png" style="display: inline-block;margin-left:5px;height:20px;width:20px;" />
			<img src="img/feedback.png" style="display: inline-block;margin-left:5px;height:30px;width:30px;" />
			<img src="img/skin.png" style="display: inline-block;margin-left:5px;height:25px;width:25px;" />
			<a class="svip" style="margin-left:10px;">会员中心</a>
		</div>		
	</div>

<div id="cc" class="easyui-layout" style="width:600px;height:100%;">  

	    <div data-options="region:'west',split:false,border:false" class="left" >
	    <br>
	    <ul id="leftMenu">
					<li class="leftMenuActive">
						<a href="goindex" onclick="return false">
						<span class="glyphicon glyphicon-file" style="font-size:18px;"></span>&nbsp;全部文件</a>
					</li>
					<li>
						<a href="findAll" onclick="return false" style="padding-left:50px;">图片</a>
					</li>
					<li>
						<a href="more" onclick="return false" style="padding-left:50px;">文档</a>
					</li>
					<li>
						<a href="sc" onclick="return false" style="padding-left:50px;">视频</a>
					</li>
					<li>
						<a href="sc" onclick="return false" style="padding-left:50px;">种子</a>
					</li>
					<li>
						<a href="sc" onclick="return false" style="padding-left:50px;">音乐</a>
					</li>
					<li>
						<a href="sc" onclick="return false" style="padding-left:50px;">其它</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/goMyShare.action" >
						<span class="glyphicon glyphicon-share" style="font-size:18px;"></span>&nbsp;我的分享</a>
					</li>
					<li>	
						 <a href="${pageContext.request.contextPath}/goRecycle.action" >
						  <span class="glyphicon glyphicon-trash" style="font-size:18px;"></span>&nbsp;回收站</a>
					</li>
			</ul>
	    </div>   
	   
	    <div data-options="region:'center',split:false,border:false" class="center">
	   		<div class="page"  >
	   			<div id="pageTop">
	   				<div class="upfile" style="width: 84px; display: block;margin-left:20px;">
						<div id="picker" style="background:#fff;height:2px;">
						<img src="img/upload.png" style="margin-bottom: 3px;" />&nbsp;上传
						</div>
									
					</div>
					<a class="g_button" id="newonefile">
						<img src="img/newfile.png" style="margin-bottom: 3px;" />&nbsp;新建文件夹</a>
					<a class="g_button" id="mydownload">
						<img src="img/download.png" style="margin-bottom: 3px;" />&nbsp;我的上传</a>
						
					<div class="equip_1">
									<ul class="equi_1">
										<li id="f1" class="sharefile">
										<a href="javascript:;" class="md-trigger" data-modal="modal-4">
										<img src="img/share.png" style="margin-bottom:3px" />分享</a></li>
										<li id='f3'><img src="img/delete.png" style="margin-bottom:3px"/>删除</li>
										<li id='f4'>复制到</li>
										<li id="f2">移动到</li>
									</ul>
					</div>
					<div class="span5" >
						<div class="cs" style="display: inline-block;">
							<form action="" method="post">
								<a class="search"> <input id="search" type="text" value=""
									placeholder="搜索您的文件" class="search_input"
									onfocus="this.placeholder=''"
									onblur="this.placeholder='搜索您的文件'" /> 
									<span class="glyphicon glyphicon-search" id="ser" ></span>
								</a>
							</form>
						</div>
						<div class="ch">
							<div class="lp">
								<a class="list"><img src="img/list.png" /></a>
								<ul class="listpal">
									<li class='listname'><img src="img/ok.png" class="active" />&nbsp;文件名</li>
									<li class='listsize'><img src="img/ok.png" />&nbsp;大小</li>
									<li class='listdate'><img src="img/ok.png" />&nbsp;修改日期</li>
								</ul>
							</div>
							<a class="large"><img src="img/list1.png" /></a>
						</div>
					</div>
					<div class="mypageBodyTop">
						<span class="pull-right" id="fileNums" style="margin-right:18px;">已全部加载，共0个</span>
	   					<div class="Jdh" style="margin-left:19px;" >
								<table id="july_allFile" >
									<tr>
									</tr>
								</table>
						
						</div>
	   				</div>
	   			</div>
	   			<div id="pageBody">
	  
	   				
	   				<div class="Qdh">
						<ul>
							<li style="width:51%; margin-left:14px;"><input
								type="checkbox" class="chk_1"/><span id="n1" style='margin-left: 10px;'>文件名</span><i class="fa fa-arrow-down"></i></li>
							<li>大小<i class="fa fa-arrow-down"></i></li>
							<li style='width: 32%'>修改日期<i class="fa fa-arrow-down"></i></li>
						</ul>
					</div>
					<div class="pageBodyCenter" id="pageBodyCenter">
					<div class="nullfile eefile">
									<p class="ggflie">
										您还没上传过文件哦，点击上传
									</p>
								</div>
	   					<form action="" method="post">
									<table class="table" style="width:100%">
										<tbody id="mytbody">
											<ul class="products"> 
										</ul>
										</tbody>
									</table>
						</form>
	   				</div>
	   			</div>
	   		</div>
    	</div>
</div> 
<!-- 下面是模态弹窗 -->
	<!-- 我的上传弹窗 -->
	<div id="msg">
		<span style="float: left; font-size: 16px; padding-left: 10px;">我的上传</span>
		<span class="fa fa-times"></span> <span class="fa fa-window-maximize"></span>
		<div class="upmagbox">
			<div class="upload_header">
				<div class="file_name">文件（夹）名</div>
				<div class="file_size">大小</div>
				<div class="file_path">上传目录</div>
				<div class="file_status">状态</div>
				<div class="file_operate">操作</div>
			</div>
			<div class="upload_body">
				<ul class="container" id="uploaderList">
				</ul>
			</div>
		</div>
	</div>
	<!-- 文件夹树弹窗（复制和移动用） -->
	<div class="md-modal md-effect-10" id="modal-10" >
   		<div class="md-content" style="height:310px;">
    		<div class="dialog-header dialog-drag">
				<span class="dialog-header-title">复制到 </span>
			</div>
     		<div class="dialog-tree">
       			<div id="menuTree" class="menuTree"></div>        			
     		</div>
			<div class="dialog-footer g-clearfix">
				<a class="g-button g-button-large cancel" href="javascript:void(0);" style="float: right;">
				<span class="g-button-right" style="padding-right: 50px;">
				<span class="text" style="width: auto;">取消</span>
				</span>
				</a>
				<a class="g-button g-button-blue-large surein" href="javascript:void(0);" style="float: right;">
				<span class="g-button-right" style="padding-right: 50px;">
				<span class="text" style="width: auto;">确定</span>
				</span>
				</a>
				<a class="g-button g-button-blue-large suremove" href="javascript:void(0);" style="float: right;display:none">
				<span class="g-button-right" style="padding-right: 50px;">
				<span class="text" style="width: auto;">移动</span>
				</span>
				</a>
			</div>
   		</div>
 	</div>
 	<!-- 文件预览弹窗 -->
	<div class="md-modal md-effect-13" id="modal-13" style="width:100%;height:100%">
		<div class="md-content" style="height: 100%;padding:0px;">
				<div class="dialog-header dialog-drag" id='header-drag' style="height: 40px; line-height: 35px; background: rgb(99,135,133); color: #fff; font-size: 20px; padding: 5px;text-align: center">
					<span class="fname"></span>
					<span class="fa fa-times" style="float:right;top:6px; margin-right: 5px;position: relative;"></span>
				</div>
				<iframe id="pdfIframe" width="100%" height="100%" src="${pageContext.request.contextPath}/loading.html"></iframe> 
			</div>
	</div>
	<!-- 视频预览弹窗 -->
	<div class="md-modal md-effect-13" id="modal-14" style="width: 910px;">
		<div class="md-content" style="height: 100%;padding:0px;">
				<div class="dialog-header dialog-drag" id='header-drag' style="height: 40px; line-height: 35px; background: rgb(99,135,133); color: #fff; font-size: 20px; padding: 5px;text-align: center">
					<span class="fname"></span>
					<span class="fa fa-times" style="float:right;top:6px; margin-right: 5px;position: relative;"></span>
				</div>
				<video width="910" height="500" controls preload="auto" id="video_url" class="video-js vjs-default-skin vjs-big-play-centered">
    				 <source src="http://vjs.zencdn.net/v/oceans.mp4" type="video/mp4">
    				您的浏览器不支持 video 标签。
    			</video>
			</div>
	</div>
	<!-- 分享弹窗 -->
	<div class="md-modal md-effect-4" id="modal-4">
		<div class="md-content">
			<div class="dialog-header dialog-drag">
				<span class="dialog-header-title"></span>
			</div>
			<div class="dialog-body">
				<div class="share-dialog">
					<div class="content" id="_disk_id_1">
						<ul class="tab">
							<li class="share-link current" _idx="0"><em
								class="fa fa-link"></em>链接分享</li>
							<li class="share-friend" _idx="1"><em class="fa fa-users"></em>发给好友</li>
							<li class="share-mail" _idx="2"><em class="fa fa-envelope"></em>发到邮箱</li>
						</ul>
						<div class="cb"></div>
						<div class="tips-placeholder">
							<div class="tips" style="display: none;">
								<em class="icon"></em><span></span><em class="close icon"></em>
							</div>
						</div>
						<ul class="content" style="width: 520px; margin-left: -25px;">
							<li class="share-link" style="display: block;">
								<div class="create-link">
									<table class="validity-section">
										<tbody>
											<tr>
												<td class="first-child">分享形式</td>
												<td>
													<div class="share-method-line">
														<input type="radio" id="share-method-private" name="share-method" value="private" checked="true" style="margin-bottom:-3px;">
														<b style="color: rgb(66, 78, 103);">加密</b><span>仅限拥有密码者可查看，更加隐私安全</span>
													</div>
													<div class="share-method-line share-public-panel" style="color: rgb(139, 144, 158);">
														<input type="radio" id="share-method-public" name="share-method" value="public" style="margin-bottom:-3px;"> 
															<b>公开</b><span>任何人可查看或下载，同时出现在您的
															<a class="share-home-href" href="" target="_blank" style="color: rgb(59, 140, 255);">个人主页</a>
														</span> <span class="share-public-tip" style="display: none;"></span>
													</div>
												</td>
											</tr>
											<tr>
												<td class="first-child">有效期</td>
												<td class="choose-panel">
													<button class="g-button g-button-large-gray choose-value">
														<span class="text" id="datetype">永久有效</span> <em
															class="fa fa-sort-desc"></em>
													</button>
													<ul class="choose-list" style="display: none;">
														<li class="choose-checked" value="0"><em>永久有效</em><span
															class="fa fa-check"></span></li>
														<li value="7"><em>7天</em><span class="fa fa-check"></span></li>
														<li value="1"><em>1天</em><span class="fa fa-check"></span></li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="createlink" style="display: none">
										<div class="create-success" style="padding-bottom: 10px;">
											<span class="public" style="display: none;"> <em
												class="fa fa-check-circle"></em> 成功创建公开链接
											</span> <span class="private"> <em
												class="fa fa-check-circle"></em> 成功创建私密链接
											</span>
										</div>
										<div class="link-info">
											<div class="copy-button-section">
												<a class="copy-button" id="copyShare"> 
													<span class="g-button-right"> 
													<span class="text public" style="display: none" onclick="Copy()">复制链接</span>
													<span class="text private" onclick="myCopy()">复制链接及密码</span>
													</span>
												</a>
												<div class="copy-tips" id="copy-tips">复制链接成功</div>
											</div>
											
											<div class="url">
												<input type="text" spellingcheck="false" readonly="readonly" class="share-url" id="share-url" value="">
												<span class="share-validity-tip">链接永久有效</span>
											</div>
											<div class="password">
												<a>提取密码</a> 
												<input type="text" class="share-password" id="share-password" spellingcheck="false" readonly="readonly" value="">
											</div>
											<div class="description">
												<span class="private">可以将链接发送给你的QQ等好友 </span>
												<span class="public" style="display:none"> 
													1.生成文件下载链接 <br>
													2.把链接通过QQ、微博、人人网、QQ空间等方式分享给好友
												</span>
											</div>
											<input type="text" class="sharelink" id="sharelink" spellingcheck="false" readonly="readonly" value="" style="opacity:0;">
										</div>
									</div>
								</div>
							</li>
						</ul>
						<div class="footer">
							<a class="md-close close" id="end">关闭</a>
							<a href="javascript:;" class="create"> 
								<span class="g-button-right"> 
								<span class="text" id="create">创建链接</span>
							</span>
							</a>
						</div>
						
						<script type="text/javascript">
							$("#end").click(function(){
								/* location.href="index.jsp"; */
							});								
							function shareurl(){
								<%
									String uuid = IDGenerator.genPrimaryKey();
									String pwd = IDGenerator.getUUID(4);
								%>
								var method;
								
								$("#share-url").val('*/HHYun/shareurl.action?url=<%=uuid%>');
								$("#share-password").val('<%=pwd%>');									
								var btns = new Array();
								var cateid = new Array();
								var uuid = $("#share-url").val();
								var time = $("#datetype").text();
								method=null;
								method = $('input[name="share-method"]:checked').val();
								if(method == "private"){
									var pwd = $("#share-password").val();
								}else{
									var pwd = "";
								}
								if($('.table').find('input:checked').length!=0){
									$("input[name='filebox']:checked").each(function(key,value){
									    btns[key] = $(this).val();
									});
									$("input[name='catebox']:checked").each(function(key,value){
									    cateid[key] = $(this).val();
									});
								}else{
									if(iscate){
										cateid[0]=shareid;
									}else{
										btns[0]=shareid;	
									}
								}																											
								if(btns == "" && cateid == ""){
									alert("请选择文件或文件夹进行分享！");
								}else{
									$.ajax({  
							            url:"${pageContext.request.contextPath}/shareCreate.action",
							            type:"post",
							            data:{
							            	"fidlist":btns.join(','),
							            	"cateid":cateid.join(','),
							       			"magID":uuid,
							       			"pretime":time,
							       			"sharepwd":pwd,
							       			"userID":'${user.id}'
							            	
							            },
							            success:function(data){  
							            	toastr.info("分享成功！");
							            },  
							            error:function(){  
							               // alert("分享失败！");  
							               toastr.error("分享失败！");
							            }  
							        });  
								}	
								
							}
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">

var currentFolderName = "全部文件";
var currentFolderID ="";
//$('#msg').show();

// 消息提示框
	toastr.options = {  
       // closeButton: true,                                            
        debug: false,                                                    
      //  progressBar: true,                                        
        positionClass: "my-toast-top-center",              
        onclick: null,                                                    
        showDuration: "300",                                    
        hideDuration: "1000",                                   
        timeOut: "2000",                                          
        extendedTimeOut: "1000",                            
        showEasing: "swing",                                  
        hideEasing: "linear",                                   
        showMethod: "fadeIn",                                  
        hideMethod: "fadeOut"                                   
    };  

//videojs
var options = {
	"poster": "",
	"controls": "true",
	//"techOrder" : ["flash"],
	//倍速
	playbackRates: [0.5, 1, 1.5, 2,5],
	controlBar : {
	       playbackRateMenuButton:true
	}
};
var player = videojs('video_url',options);
//console.log(player)
	
	//文件更多操作
	$('table').on('click','.fa-ellipsis-h',function(){
		$(this).parent().parent('td').find('.menu').css('display','block');
	});
	$('table').on('mouseleave','.menu',function(){
		$('.menu').css('display','none');
	});
	//打开我的上传弹窗
	$('#mydownload').click(function(){
		$('#msg').show();
	});
	//关闭我的上传弹窗
	$('#msg .fa-times').click(function() {
		$(this).parent('div').hide();
	});
	//上传
	var uploader = WebUploader.create({
		//auto:true, //是否自动上传
	    // swf文件路径
	    swf:'js/Uploader.swf',
	    // 文件接收服务端。
	    server: "${pageContext.request.contextPath}/fileUpload.action",

	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#picker',
	    formData:{
	    	'userID':'${user.id}',
	    	'folderID':currentFolderID,
	    	'md5Val':''
	    },
	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false
	});
	//console.log(uploader);
	//console.log('uploader'+currentFolderID);
	//当有文件被加入队列
	uploader.on( 'fileQueued', function( file ) {
			//alert(23);
		var upfilesize=null;//文件大小
		var upsizeflag=null;//文件大小单位
		var type=null;//文件类型
		//console.log(file)
		//判断文件夹里是否有同名文件
		var flag = 0;
		$(".july_fileName").each(function() {
			if ($(this).text() == file.name) {
				flag = 1;
			}
		})
		if(file.size/(1024*1024) < 1 ){
			upfilesize=(file.size/1024).toFixed(1);
			upsizeflag="KB";
		}else if(file.size/(1024*1024)<1024 && file.size/(1024*1024) > 1){
			upfilesize=(file.size/(1024*1024)).toFixed(1);
			upsizeflag="M";
		}else{
			upfilesize=(file.size/(1024*1024*1024)).toFixed(1);
			upsizeflag="G";
		}
		/*判断文件类型*/
		type = judgeFileType(file.ext);
		
		var upfileaddress=$('table tr:eq(0)').find('td:last-child').children('a').text();
		var $str=$("<li class='file-list' id='"+file.id+"'><div class='file_name'title='"
					+ file.name
					+ "'>"
					+ "<img src='"
					+ type
					+ "'width='28px' style='display:inline-block;position:relative;float:left;margin-top:10px;'>"
					+ "<span class='name-text'>"
					+ file.name
					+ "</span></div>"
					+ "<div class='file_size'>"
					+ upfilesize+upsizeflag
					+ "</div><div class='file_path'><span class='server_path'>"
					+ upfileaddress
					+ "</span></div>"
					+"<div class='up_status'>上传中···</div><div class='up_operator'><i class='fa fa-close' id='fa-close' style='margin-top:13px;font-size:18px;'></i></div>"
					+"<div class='progress progress-striped active' style='height:10px;width:700px'>"
	                +"<div class='progress-bar' role='progressbar' style='width: 0%'></div></div></li>");
		if (flag != 1) {
			
			$('#msg').show();
			$('#uploaderList').append($str);
			//进度条
			uploader.on( 'uploadProgress', function( file, percentage ) { 
				//alert(111)
			    var $li = $( '#'+file.id );
			    //console.log($li);
			    var $percent = $li.find('.progress .progress-bar');  
			  	//console.log($percent);
			  	 var $up_status = $li.find('.up_status');  
			    // 避免重复创建  ，如果没有则创建
			    if ( !$percent.length ) {  
			        $percent = $('<div class="progress progress-striped active">' +
			                '<div class="progress-bar" role="progressbar" style="width: 0%">' +
			                '</div>' +
			              '</div>')  
			                .appendTo( $li )  
			                .find('.progress-bar');  
			       
			    }  
			    $up_status.html(10 + (percentage*0.9).toFixed(2) * 100  + '%' );
			    $percent.css( 'width', 10 +percentage * 100 *0.9+ '%' ); 
			});  
			
			//md5校验
			console.log(file.source.source)
			console.log('begin')
			var begin = new Date();
			var blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice,
		        files = file.source.source,
		        chunkSize =20*1024*1024,                             // Read in chunks of 2MB
		        chunks = Math.ceil(file.size / chunkSize),
		        currentChunk = 0,
		        spark = new SparkMD5.ArrayBuffer(),
		        fileReader = new FileReader();
			var $li = $( '#'+file.id );
			var $percent = $li.find('.progress .progress-bar');  
				var $up_status = $li.find('.up_status'); 
			//取消
			var $up_operator = $li.find('.up_operator'); 
			$li.on('click', '.fa-close', function() {
				 	uploader.removeFile( file );
				 	$up_status.html("已取消");
				 	fileReader.abort();
				 	spark.destroy();
				 	$('#' + file.id).find('.progress').remove();
				 	$up_operator.html("<i class='fa fa-repeat' id='fa-close' style='margin-top:13px;font-size:18px;'></i>"); 
				 	//toastr.info("取消成功！");
			})
		    fileReader.onload = function (e) {
		        //console.log('read chunk nr', currentChunk + 1, 'of', chunks);
		        //进度
		        var per = (currentChunk + 1)/chunks;
		
		  		$up_status.html(per.toFixed(1) * 10 + '%' );
			    $percent.css( 'width', per * 10 + '%' );
			    console.log(per)
		        spark.append(e.target.result);                   // Append array buffer
		        currentChunk++;
		        if (currentChunk < chunks) {
		            loadNext();
		        } else {
					//计算完成
					var md5Val = spark.end();
		            console.log('finished loading');
		            console.info('computed hash', md5Val);  // Compute hash
					var end = new Date();
					console.log(end-begin);
					//释放资源
					spark.destroy();
					//检查是否存在
					 $.ajax({
			 				url : "${pageContext.request.contextPath}/md5Check.action",
			 				//dataType : 'json',
			 				type:"post",
			 				data:{
			 					"userID":'${user.id}',
			 					"folderID":categorie,
			 					"md5Val":md5Val,
			 					"fileName":file.name
			 				},
			 				success : function(data) {
			 					var checkResult = data;
			 					//如果没有则上传,这里注意少个==
			 					if(checkResult == "error"){
			 						//修改表单数据
			 						uploader.options.formData.folderID = categorie;
			 						uploader.options.formData.md5Val = md5Val;
			 						//上传
			 						uploader.upload();
			 						//console.log('1');
			 					}else{
			 						//上传成功
			 						var $li = $( '#'+file.id );
			 				   		var $percent = $li.find('.progress .progress-bar');  
			 				   		var $up_status = $li.find('.up_status'); 
						   			$up_status.html('100%' );
			 					    $percent.css( 'width', '100%'  );  
			 					    $('#' + file.id).find('.up_status').html("<i class='fa fa-check' style='color:#5CD992;margin-top:13px;font-size:18px;' ></i>");
			 					    $('#' + file.id).find('.up_operator').html("-------");
			 					    $('#' + file.id).find('.progress').remove();
			 						uploader.removeFile( file );
			 				        showchild(categorie,0);
			 				        toastr.info("上传成功！");
			 				        //console.log('2');
			 					}
			 					
			 				},
			 				error : function() {
			 					 toastr.error("上传失败！");
			 				}
			 			});
		        }
		    };
		 
		    fileReader.onerror = function () {
		        console.warn('oops, something went wrong.');
		    };
		 
		    function loadNext() {
		        var start = currentChunk * chunkSize,
		            end = ((start + chunkSize) >= files.size) ? files.size : start + chunkSize;
		 
		        fileReader.readAsArrayBuffer(blobSlice.call(files, start, end));
		    }
		    loadNext();
		} else {
			uploader.removeFile( file );
			 toastr.warning("文件夹中已经有相同名字的文件！");
		}
		  
	});
	 // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    uploader.on('uploadSuccess', function(file) {
       // $('#' + file.id).addClass('upload-state-done');
    	   toastr.info("上传成功！");
    });
    // 文件上传失败，现实上传出错。
    uploader.on('uploadError', function(file) {
        var $li = $('#' + file.id), $error = $li.find('div.error');
        // 避免重复创建
        if (!$error.length) {
            $error = $('<div class="error"></div>').appendTo($li);
        }
        $error.text('上传失败');
        toastr.success("上传失败！");
    });
    // 完成上传完了，成功或者失败，先删除进度条。
    uploader.on('uploadComplete', function(file) {
    	//移除进度条
        $('#' + file.id).find('.progress').remove();
    	//更新上传状态
        $('#' + file.id).find('.up_status').html("<i class='fa fa-check' style='color:#5CD992;margin-top:13px;font-size:18px;' ></i>");
        $('#' + file.id).find('.up_operator').html("-------");
    	showchild(categorie,0);
        
    });
	//初始加载数据
	show('',0);
	var categorie ="";
	var recycle =null;
	var cateName = null;
	var caterid = "";
	//布局效果
	var flagLayout = false;
	$(".large").click(function() {
		flagLayout = !flagLayout;
	    console.log(flagLayout);
	    showchild(categorie,0);
	});
	function show(categorie_id, recycleflag ) {
		categorie = categorie_id;
		recycle = recycleflag;			
		 if(cateName != null){
			var $head=$("<td><a id='"+caterid+"' class='aa'  style='cursor:pointer;text-decoration:none'> >"+cateName+"</a></td>"); 
			$("#july_allFile tr").append($head)
		}else{
			var $head=$("<td><a id='' class='aa' style='cursor:pointer;color:#333;text-decoration:none ' >全部文件</a></td>"); 
			$("#july_allFile tr").append($head)
		} 			 
		 showchild(categorie_id,recycleflag);
		 //showchildGrid(categorie_id,recycleflag);
	}
	function showchild(categorie_id,recycleflag ) {
		if(flagLayout)
		 	showchildGrid(categorie_id,recycleflag);
		else
			showchildList(categorie_id,recycleflag);
	}
	/* 显示条形菜单 */
	$('#july_allFile').on('click','.aa',function(){
		var caterid=$(this).attr("id");
		if(caterid ==""){
			show("",recycle);
		}else{
		show(caterid,recycle);
		}
		$(this).parent('td').nextAll('td').remove();
	});
	
	/*跳下一级*/
	$('table').on('click','.july_cateName',function(){
		if($(this).hasClass('off')){ // 判断当前元素是否有off的类，如果有则不继续向下执行
	        return;
	    }
		var cateid =$(this).parent('td').find('.reid').val();
		var catestate =$(this).parent('td').find('.restate').val();
		var catename =$(this).parent('td').find('.rename').val();
		cateName = catename;
		caterid = cateid;
		show(cateid,catestate);
	});
	/*显示文件和文件夹*/
	function showchildList(categorie_id,recycleflag){
		//console.log(categorie_id);
		//console.log(currentFolderID);
		$('.addli').remove();
		$(".table tr").remove();
		$("#tw1 :checkbox").prop("checked", false);
		$("#n1").html("文件夹");
		$('#g_button').css('display', 'block');
		$('.equip_1').css('display', 'none');
		$('.Qdh').find('li').nextAll('li').show();
		//清除网格布局
		$(".products li").remove();
		$(".products").hide();
		//$('#mybody').html();
		$.ajax({
			type : "post",
			dataType : "json",
			url : "${pageContext.request.contextPath}/showFileAndFolderList.action?Time="+new Date().getTime(),
			data : {
				'folderID' : categorie_id,
				'userID':'${user.id}'
			},
			success : function(map) {
				//
				currentFolderID = map.currentFolder.id;
				currentFolderName = map.currentFolder.folderName;
				var listFile = map.fileList;
				var listCate = map.folderList;
				//网盘为空
				if(listCate=="" && listFile==""){
					$('.nullfile').show();
				}else{
					$('.nullfile').hide();
				}
				//修改加载的个数
			    var sum=parseInt(listCate.length+listFile.length);
				var $sumhead=$("<span class='j2'>已加载全部,共"+sum+"条</span>");
				$('#fileNums').html($sumhead);   
				//文件夹列表处理
				for (var i = 0; i < listCate.length; i++) {
					
					var $str = $("<tr class='showTr'>"
							+ "<td>"
							+ "<input type='checkbox' name='catebox' value='"+listCate[i].id+"' class='chk_2'/>"
							+ "<img src='img/filepic/category.png' width='28px' style='margin:0 5px 5px 10px;'>"
							+ "<input id='listCateID' class='reid' type='text' style='display:none' value="
							+ listCate[i].id
							+ ">"
							+ "<input id='listCateState' class='restate' type='text' style='display:none' value="
							+ listCate[i].state
							+ ">"
							+ "<input id='listCateName' class='rename' type='text' style='display:none' value="
							+ listCate[i].folderName
							+ ">"
							+ "<a class='july_cateName' >"
							+ listCate[i].folderName
							+ "</a>"
							+ "<div class='more'>"
							+ "<span class='fa fa-share-alt' title='分享'>"
							+ "</span>"
							+ "<span class='fa fa-ellipsis-h' title='更多'></span>"
							+ "<span class='menu' style='width: 96px;'>"
							+ "<a style='display: block;' data-menu-id='b-menu9' class='g-button-menu md-ren' href='javascript:void(0);'>重命名</a>"
							+ "<a style='display: block;' data-menu-id='b-menu10' class='g-button-menu md-copy' href='javascript:void(0);'>复制到</a>"
							+ "<a style='display: block;' data-menu-id='b-menu11' class='g-button-menu md-move' href='javascript:void(0);'>移动到</a>"
							+ "<a style='display: block;' data-menu-id='b-menu4' class='g-button-menu delelecate' id='"+listCate[i].id+"' >删除</a>"
							+ "</span></div></td>"
							+ "<td>--</td>"
							+ "<td>" 
							+ listCate[i].updateDate
							+ "</td>" 
							+ "</tr>");
					$("#mytbody").append($str);
				}
				//文件列表处理
				for (var i = 0; i < listFile.length; i++) {
					var type;
					var size;
					var sizeflag;

					/* 计算文件大小 */
					if(listFile[i].fileSize/(1024*1024) < 1 ){
						size=(listFile[i].fileSize/1024).toFixed(2);
						sizeflag="KB";
					}else if(listFile[i].fileSize/(1024*1024*1024) < 1)
					{
						size=(listFile[i].fileSize/(1024*1024)).toFixed(2);
						sizeflag="M";
					}else{
						size=(listFile[i].fileSize/(1024*1024*1024)).toFixed(2);
						sizeflag="G";
					}
					/*显示图片*/
					type = judgeFileType(listFile[i].fileSuffix)
					
					var $str = $("<tr class='showfileTr'>"
							+ "<td>"
							+ "<input type='checkbox' name='filebox' value='"+listFile[i].id+"' class='chk_2' />"
							+ "<img src='"
							+ type
							+ "'width='28px' style='margin:0 5px 5px 10px;'>"
							+ "<input id='listFileID' class='refileid' type='text' style='display:none' value="
							+ listFile[i].id
							+ ">"
							+ "<input id='listFileType' type='text' style='display:none' value="
							+ listFile[i].fileSuffix
							+ ">"
							+ "<input id='listFileName' class='rename' type='text' style='display:none' value="
							+ listFile[i].fileName
							+ ">"
							+ "<a class='july_fileName'>"
							+ listFile[i].fileName
							+ "</a>"
							+ "<div class='more'>"
							+ "<span class='fa fa-share-alt' title='分享'>"
							+ "</span><span class='fa fa-download' title='下载'  >"
							+ "</span>"
							+ "<span class='fa fa-ellipsis-h' title='更多'></span>"
							+ "</span>"
							+ "<span class='menu' style='width: 96px;'>"
							+ "<a style='display: block;' data-menu-id='b-menu9' class='g-button-menu md-ren' href='javascript:void(0);'>重命名</a>"
							+ "<a style='display: block;' data-menu-id='b-menu10' class='g-button-menu md-copy' href='javascript:void(0);'>复制到</a>"
							+ "<a style='display: block;' data-menu-id='b-menu11' class='g-button-menu md-move' href='javascript:void(0);'>移动到</a>"
							+ "<a style='display: block;' data-menu-id='b-menu4' class='g-button-menu delelefile' id='"+listFile[i].id+"' >删除</a>"
							+ "</span></div></td>" 
							+ "<td>"
							+ size + sizeflag
							+ "</td>" 
							+ "<td>"
							+ listFile[i].updateDate
							+ "</td>"
							+ "</tr>")
					$("#mytbody").append($str);
					
				}
			},
			error : function() {
				toastr.error("查询失败！");
			}						
		});
	}
	/*网格显示*/
	function showchildGrid(categorie_id,recycleflag){
		$(".products").show();
		//console.log(categorie_id);
		//console.log(currentFolderID);
		$('.addli').remove();
		$(".table tr").remove();
		$("#tw1 :checkbox").prop("checked", false);
		$("#n1").html("文件夹");
		$('#g_button').css('display', 'block');
		$('.equip_1').css('display', 'none');
		$('.Qdh').find('li').nextAll('li').show();
		//$('#mybody').html();
		//$('.addli').remove();
		$(".products li").remove();
		
		$.ajax({
			type : "post",
			dataType : "json",
			url : "${pageContext.request.contextPath}/showFileAndFolderList.action?Time="+new Date().getTime(),
			data : {
				'folderID' : categorie_id,
				'userID':'${user.id}'
			},
			success : function(map) {
				//
				currentFolderID = map.currentFolder.id;
				currentFolderName = map.currentFolder.folderName;
				var listFile = map.fileList;
				var listCate = map.folderList;
				//网盘为空
				if(listCate=="" && listFile==""){
					$('.nullfile').show();
				}else{
					$('.nullfile').hide();
				}
				//修改加载的个数
			    var sum=parseInt(listCate.length+listFile.length);
				var $sumhead=$("<span class='j2'>已加载全部,共"+sum+"条</span>");
				$('#fileNums').html($sumhead);  
				
				//var $test = $("<ul class='products'>");
				//$("#mytbody").append($test);
				//文件夹列表处理
				for (var i = 0; i < listCate.length; i++) {
					
					var $str = $("<li><a href='#' class='myfolder'><img src='img/gridpic/folder.png'/>"
							+"<div><p>"+listCate[i].folderName+"</p></div></a></li>");

					$(".products").append($str);
				}
				//文件列表处理
				for (var i = 0; i < listFile.length; i++) {
					var type;
					var size;
					var sizeflag;

					/* 计算文件大小 */
					if(listFile[i].fileSize/(1024*1024) < 1 ){
						size=(listFile[i].fileSize/1024).toFixed(2);
						sizeflag="KB";
					}else if(listFile[i].fileSize/(1024*1024*1024) < 1)
					{
						size=(listFile[i].fileSize/(1024*1024)).toFixed(2);
						sizeflag="M";
					}else{
						size=(listFile[i].fileSize/(1024*1024*1024)).toFixed(2);
						sizeflag="G";
					}
					/*显示图片*/
					type = judgeGridFileType(listFile[i].fileSuffix,listFile[i].userID,listFile[i].id)
					var $str = $("<li><a href='#' class='myfile'><img src='"+type+"'/>"
							+"<div><p>"+listFile[i].fileName+"</p></div></a></li>");
					$(".products").append($str);
					
				}
					//此处可拖拽
					$('.products .myfolder,.myfile').draggable({
						revert:true,
						proxy:'clone',
						cursor:'pointer',
						onStartDrag:function(){
							$(this).draggable('options').cursor = 'not-allowed';
							$(this).draggable('proxy').css('z-index',10);
						},
						onStopDrag:function(){
							$(this).draggable('options').cursor='move';
						}
					});
				
					//此处可放置
					$('.products .myfolder').droppable({
						onDragEnter:function(e,source){
							$(source).draggable('options').cursor='auto';
						},
						onDragLeave:function(e,source){
							$(source).draggable('options').cursor='not-allowed';
						},
						onDrop:function(e,source){
							/*
							var name = $(source).find('p:eq(0)').html();
							var price = $(source).find('p:eq(1)').html();
							addProduct(name, parseFloat(price.split('$')[1]));
							*/
						}
					});
			
				
			},
			error : function() {
				toastr.error("查询失败！");
			}						
		});
	}
	
	/*创建文件夹*/
	$("#newonefile").click(function() {
		$('.table').find('.july_fileName').addClass('off');
		$('.table').find('.july_cateName').addClass('off');
		if($('.sure').length==0){
			//创建tr节点
			var $tr = $("<tr></tr>");
			//遍历获取输入的内容
			var $td = $("<td><input type='checkbox' id='checkbox_a1'/><img src='img/filepic/category.png' width='28px' style='margin:0 5px 5px 10px;'><input type='text' value='新建文件夹' class='filename'><i class='fa fa-check sure'></i><i class='fa fa-times dele'></td><td>-</td><td class='t3'></td>");
			//将内容循环添加到创建好的TD中
			$td.appendTo($tr);
			$tr.prependTo(" .table tbody");
			$('.filename').select();
			$('.nullfile').hide();
			//执行删除操作
			$(".dele").click(function() {
				$('.table').find('.july_fileName').removeClass('off');
				$('.table').find('.july_cateName').removeClass('off');
				$(this).parent().parent().remove();
			});
			
			$('.sure').click(function() {
			    var folderName=$(this).prev().val();
			    var flag = 0;
				$(".july_cateName").each(function() {
					
					if ($(this).text() == folderName) {
						flag = 1;
					}
				})
			   if(flag == 1){
				
					toastr.warning("文件夹中名字不能相同！");
					return ;
				}else{
					$('.table').find('.july_fileName').removeClass('off');
					$('.table').find('.july_cateName').removeClass('off');
					$(this).parent().parent().remove();
					$.ajax({
						url : "${pageContext.request.contextPath}/createFolder.action",
						type : "post",
						//dataType : 'json',
						data:{
							'userID':'${user.id}',
							'folderName':folderName,
							'superFolderID':currentFolderID
						},                   
						success : function(data) {
							console.log(data);
							toastr.info("创建文件夹成功！");
						},
						error : function() {
							//alert("新建文件夹失败！");
							toastr.error("创建文件夹失败！");
						},
						complete: function() {
							showchild(categorie,0);
							console.log(categorie);
						}
					});		
					
				}
			});
		}else{
			//alert("请完成当前文件夹的创建！");
		}
	});
	/*删除当前文件*/
	$('#mytbody').on('click','.delelefile',function(){
		var fileID=$(this).attr("id");
		layFileRecycle(fileID);
	});
	
	/*删除当前文件夹*/
	$('#mytbody').on('click','.delelecate',function(){
		var folderID=$(this).attr("id");
		console.log(folderID);
		layFolderRecycle(folderID);
	});
	/*删除当前文件到回收站*/
	function layFileRecycle(fileID){
		$.ajax({
			url : "${pageContext.request.contextPath}/layFileRecycle.action",
			type : "post",
			data:{
				'fileID':fileID
			},
			success : function(data) {
				/* alert(data); */
				toastr.info("删除成功！");
			},
			error : function() {
				//alert("文件放入回收站失败！");
				toastr.error("文件放入回收站失败！");
			},
			complete: function() {
				showchild(categorie,0);
				console.log(categorie);
			}
		});
		
	}
	/*删除当前文件夹*/
	function layFolderRecycle(folderID){
		console.log(folderID);
		$.ajax({
			url : "${pageContext.request.contextPath}/layFolderRecycle.action",
			type : "post",
			data:{
				'folderID':folderID
			},
			success : function(data) {
				/* alert(data); */
				toastr.info("删除成功！");
			},
			error : function() {
				toastr.error("文件夹放入回收站失败！");
			},
			complete: function() {
				showchild(categorie,0);
				console.log(categorie);
			}
		});
		
	}
	
	/* 文件下载 */
	 $('table').on('click','.fa-download',function(){
	  var fileid =$(this).parent().parent('td').find('.refileid').val();
	  var filename =$(this).parent().parent('td').find('.rename').val();
	  window.location.href="fileDownload.action?fileID="+fileid;
	  //window.event.returnValue=false;
	}); 
	
	 /**
     * 显示遮罩层
     */

     function showOverlay() {
        // 遮罩层宽高分别为页面内容的宽高
        $('.overlay').css({'height':$(window).height(),'width':$(window).width()});
        $('.overlay').show();
    }
	    
	//office文件预览
	$('table').on('click','.july_fileName',function(){
		if($(this).hasClass('off')){ // 判断当前元素是否有off的类，如果有则不继续向下执行
	        return;
	    }
		var fileid =$(this).parent('td').find('#listFileID').val();
		var filetype =$(this).parent('td').find('#listFileType').val();
		var $office=$("<div id='viewerPlaceHolder' style='margin:0px; width: 910px;height: 570px;'></div>");
		if(    // 文件预览 pdf,txt,doc,word,docx,ppt
			filetype == "pdf"|| filetype == "xls" || filetype == "xlsx" 
			|| filetype == "txt" ||filetype == "docx" 
			|| filetype == "doc" || filetype == "ppt" || filetype == "pptx"
		)
		{
			showOverlay();
			$('#modal-13').addClass('md-show');
			$('#header-drag').find('.fname').text("");
			$('.fname').append($(this).text());
			$('#officeview').empty();
			$('.test_mask').show(300);
			$('.test_mask').hide();
			$('#officeview').append($office);
			$("#pdfIframe").attr("src","officeView.action?fileID="+fileid);
			
		}
		if(   //照片预览、jpg、jpeg、png、gif、bmp
			filetype == "jpg" || filetype == "jpeg"
				|| filetype == "png" || filetype == "gif"
				|| filetype == "bmp" 
				)
			{
		        
				$.ajax({
					url : "${pageContext.request.contextPath}/imgView.action",
					type:"post",
					//dataType : 'json',
					data:{
						"fileID":fileid
					},
					success : function(data) {
						var image = new Image();
						 image.src = data;
						 var viewer = new Viewer(image, {
					          hidden: function () {
					            viewer.destroy();
					          },
					          title:false,
					          navbar:false,
					        });
						 //修改图片名字
						 //$(".viewer-title").html("111")
					        // image.click();
					        viewer.show();
						console.log(data);
					},
					error : function() {
						alert("文件预览失败！");
					}
				});
				
			}
			// 视频预览  wmv9，rm，rmvb，asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv
		if(        filetype == "wmv9"  
			    || filetype == "rm" ||filetype == "rmvb" 
				|| filetype == "asx" || filetype == "asf"
				|| filetype == "mpg" || filetype == "wmv"
				|| filetype == "3gp" || filetype == "mp4"
				|| filetype == "mov" || filetype == "avi"
				|| filetype == "flv" ){
			showOverlay();
			$('#modal-14').addClass('md-show');
			$('#header-drag').find('.fname').text("");
			$('.fname').append($(this).text());
			$('#officeview').empty();
			$('.test_mask').show();		
			//$("#video_url").attr("src","videoView.action?fileID="+fileid);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/videoView.action?fileID="+fileid,
				//dataType : 'json',
				success : function(data) {	
					//$("#video_url").attr("src",data);
					//player =  videojs("video_url");  //初始化视频
			        player.src(data.videoPath);  //重置video的src
			        player.poster(data.posterPath);//缩略图
			        player.load(data); 
				},
				error : function() {
					alert("视频预览失败！");
				}
			});
		}
		
	});
 	//关闭文件预览窗
	$('#modal-13 .fa-times').click(function() {
	
		$('.overlay').hide();
		//清空文件名
		$('.fname').empty();
		//清空内容
		$("#pdfIframe").attr("src","${pageContext.request.contextPath}/loading.html");
		//隐藏模态框
		$('#modal-13').removeClass('md-show');
	});
 	//关闭视频预览窗
	$('#modal-14 .fa-times').click(function() {
		$('.overlay').hide();
		$('#officeview').empty();
		//停止播放
		player.pause();
		//清空文件名
		$('.fname').empty();
		//隐藏模态框
		$('#modal-14').removeClass('md-show');
	});
 		// 实现排序功能
 		//按名字排序,仅有升序
 		var n=true;
 		$('.listpal .listname').click(function(){
 			$('.Qdh ul').find('li:eq(1) i').hide();
 			$('.Qdh ul').find('li:eq(2) i').hide();
 			showchild(categorie,0);
 		});
 		//按大小排序
 		var up=true;
 		$('.listpal .listsize').click(function(){
 			if(up){ 
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(1) i').show();
 				$('.Qdh ul').find('li:eq(1) i').attr('class','fa fa-arrow-up');
 				up=false;
 			}else{
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(1) i').show();
 				$('.Qdh ul').find('li:eq(1) i').attr('class','fa fa-arrow-down');
 				up=true;
 			}
 			sortsize();
 		});
 		$('.Qdh li:eq(1)').click(function(){
 			if(up){ 
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(1) i').show();
 				$('.Qdh ul').find('li:eq(1) i').attr('class','fa fa-arrow-up');
 				up=false;
 			}else{
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(1) i').show();
 				$('.Qdh ul').find('li:eq(1) i').attr('class','fa fa-arrow-down');
 				up=true;
 			}
 			sortsize();
 		});
 		function sortsize(){
 			var $trs = $('.table tbody .showfileTr');
 			$trs.sort(function(a,b){
 			    var valueNumOfa = $(a).find('td:eq(1)').text();
 			    var valueNumOfb = $(b).find('td:eq(1)').text();		
 				var atype=valueNumOfa.split(".");
 			    var atype2=atype[1].substr(2);
 			    var btype=valueNumOfb.split(".");
 			    var btype2=btype[1].substr(2);
 			    if(atype2=='KB'){
 			    	valueNumOfa=parseFloat(valueNumOfa)*1024;
 			    }
 			    if(atype2=='M'){
 			    	valueNumOfa=parseFloat(valueNumOfa)*1024*1024;
 			    }
 			    if(atype2=='G'){
 			    	valueNumOfa=parseFloat(valueNumOfa)*1024*1024*1024;
 			    }
 			    if(btype2=='KB'){
 			    	valueNumOfb=parseFloat(valueNumOfb)*1024;
 			    }
 			    if(btype2=='M'){
 			    	valueNumOfb=parseFloat(valueNumOfb)*1024*1024;
 			    }
 			    if(btype2=='G'){
 			    	valueNumOfb=parseFloat(valueNumOfb)*1024*1024*1024;
 			    }
 			    if(up){		    	 
 				    if(valueNumOfa > valueNumOfb) return -1;
 					else return 1;
 			    }else{
 			    	if(valueNumOfa < valueNumOfb) return -1;
 					else return 1;
 			    }		      
 			});
 			$trs.detach().appendTo('.table tbody');
 		}
 		//按日期排序
 		var date=true;
 		$('.listpal .listdate').click(function(){
 			if(date){ 
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(2) i').show();
 				$('.Qdh ul').find('li:eq(2) i').attr('class','fa fa-arrow-up');
 				date=false;
 			}else{
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(2) i').show();
 				$('.Qdh ul').find('li:eq(2) i').attr('class','fa fa-arrow-down');
 				date=true;
 			}
 			sortdate();
 		})
 		$('.Qdh li:eq(2)').click(function(){
 			if(date){ 
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(2) i').show();
 				$('.Qdh ul').find('li:eq(2) i').attr('class','fa fa-arrow-up');
 				date=false;
 			}else{
 				$('.Qdh ul').find('li i').hide();
 				$('.Qdh ul').find('li:eq(2) i').show();
 				$('.Qdh ul').find('li:eq(2) i').attr('class','fa fa-arrow-down');
 				date=true;
 			}
 			sortdate();
 		});
 		function sortdate(){
 			var $trs = $('.table tbody .showTr');	
 			var $ftrs = $('.table tbody .showfileTr');	
 			$trs.sort(function(a,b){
 				var dateOfa = $(a).find('td:eq(2)').text();
 				var dateOfb = $(b).find('td:eq(2)').text();
 				if(date){
 					if(dateOfa > dateOfb) return -1;
 					else return 1;
 				}else{
 					if(dateOfa < dateOfb) return -1;
 					else return 1;
 				}			
 			});
 			$ftrs.sort(function(a,b){
 				var fdateOfa = $(a).find('td:eq(2)').text();
 				var fdateOfb = $(b).find('td:eq(2)').text();
 				if(date){
 					if(fdateOfa > fdateOfb) return -1;
 					else return 1;
 				}else{
 					if(fdateOfa < fdateOfb) return -1;
 					else return 1;
 				}
 			});		
 			$trs.detach().appendTo('.table tbody');							
 			$ftrs.detach().appendTo('.table tbody');	
 		}
 		
 		/* 重命名 */
		$('table').on('click','.md-ren',function() {
			var zz="<div class='reName'><input class='GodName' type='text' value=''><i class='fa fa-check sure'></i><i class='fa fa-times dele'></i></div>";
			$(this).parents('tr').css('background','#F0F8FD');
			$(this).parents('tr').find('a:eq(0)').after(zz);
			var idVal=$(this).parents('tr').find('.reid').length;
			var originVal=$(this).parents('tr').find('a:eq(0)').text();
			var id=$(this).parents('tr').find('input[type=text]').val();			
			$('.GodName').val(originVal);
			$('.GodName').select();
			$('.tw1_body').css('overflow-y','hidden');
			/* 关闭tr触发事件 */
			$('table').off('mouseenter','tr');
			$('table').off('mouseleave','tr');
			$('table').off('click','.july_cateName');
			$('table').find('.july_fileName').addClass('off');
			$('.sure').click(function(){
				var newname=$(this).prev('input').val();
				if(idVal!=0){
					
					var cateid=id; 
				 	var flag = 0;
					$(".july_cateName").each(function() {
						if(originVal!=newname){	
							if ($(this).text() == newname) {
								flag = 1;
							}
						}
					})
				   if(flag == 1){
						//alert("文件夹中名字不能相同")
						toastr.warning("文件夹中名字不能相同！");
						return ;
					}
				
				}else{
				var fileid=id;
				
				var flag = 0;
				$(".july_fileName").each(function() {
					if(originVal!=newname){	
						if ($(this).text() == newname) {
							flag = 1;
						}
					}
				})
			   if(flag == 1){
					//alert("文件中名字不能相同")
					toastr.warning("文件中名字不能相同！");
					return ;
				}
				}
				
		        $.ajax({
					url : "${pageContext.request.contextPath}/rename.action",
					//dataType : 'json',
					type:"post",
					data:{
						"refileid":fileid,
						"refolderid":cateid,
						"rename":newname
					},
					success : function(data) {
						$('tr').css('background','none');
						$('.tw1_body').css('overflow-y','scroll');
						$('.reName').remove();
						$('.table').on('mouseenter','tr',function() {
							$(this).css('background','rgba(220, 200, 200, 0.4)');
							$(this).children().find('.more').css('display', 'inline-block');					
						});
						$('.table').on('mouseleave','tr',function() {
							$(this).css('background','none');
							$(this).children().find('.more').css('display', 'none');
						});
						$('.table').on('click','.july_cateName',function(){
							var cateid =$(this).parent('td').find('.reid').val();
							var catestate =$(this).parent('td').find('.restate').val();
							var catename =$(this).parent('td').find('.rename').val();
							cateName = catename;
							caterid = cateid;
							show(cateid,catestate);
						});
						$('table').find('.july_fileName').removeClass('off');		
						toastr.info("重命名成功！");
					},
					error : function() {
						//alert("重命名失败失败！");
						toastr.error("重命名失败！");
					}
				});
				showchild(categorie,recycle);
			})
			$('.dele').click(function(){
				$('tr').css('background','none');
				$('.tw1_body').css('overflow-y','scroll');
				$('.reName').remove();
				$('.table').on('mouseenter','tr',function() {
					$(this).css('background','rgba(220, 200, 200, 0.4)');
					$(this).children().find('.more').css('display', 'inline-block');					
				});
				$('.table').on('mouseleave','tr',function() {
					$(this).css('background','none');
					$(this).children().find('.more').css('display', 'none');
				});
				$('.table').on('click','.july_cateName',function(){
					var cateid =$(this).parent('td').find('.reid').val();
					var catestate =$(this).parent('td').find('.restate').val();
					var catename =$(this).parent('td').find('.rename').val();
					cateName = catename;
					caterid = cateid;
					show(cateid,catestate);
				});
				$('table').find('.july_fileName').removeClass('off');
			})
		});
		/*批量把文件和文件夹放入回收站*/
		$('#f3').click(function() {
			//alert(123)
			var btns= [];
			var cateids=[];
			var fileids=[];
			var k=0;
			var j=0;
			var i=0;
			$('#mytbody input:checked').each(function(){ 
				 btns[i]=$(this).next().next('input').val();
				 if($(this).next().next('input').hasClass('reid')){	
					 cateids[j++]=btns[i++];
				 }else{
					 fileids[k++] = btns[i++];
				 }
			})
			console.log(fileids);
			console.log(cateids);
			 $.ajax({
					url : "${pageContext.request.contextPath}/batchLayFileandFolder.action",
					//dataType : 'json',
					type:"post",
					data:{
						"fileIDList":fileids.join(','),
						"folderIDList":cateids.join(',')
					},
					success : function(data) {
						show(categorie,recycle);
						var num=$('#mytbody input:checked').length;
						if(num>0&&num<$('#mytbody input:checkbox').length){
							 var msg="已选中"+num+"个文件/文件夹";
							 $('.Qdh').find('span').html(msg);
							 $('#g_button').css('display', 'none');
							 $('.equip_1').css('display', 'block');
							 $('.Qdh').find('li').nextAll('li').hide(); 
						 }else{
							 $('.chk_1').attr('checked',false);
							 $('.Qdh').find('span').html('文件夹');
							 $('.equip_1').css('display', 'none');
							 $('.Qdh').find('li').nextAll('li').show();
						 }
						toastr.info("批量删除成功！");
					},
					error : function() {
						//alert("删除失败！");
						toastr.error("批量删除失败！");
					}
				});
			
			
		})

	//分享
	$('.md-trigger').click(function() {		
		showOverlay();
		$('.md-effect-4').addClass('md-show');
		var che=$('.table').find('input:checked');
		if(che.length>1){
			$('.dialog-header-title').html("分享多个文件(夹)");
		}else{
			shareid=null;				
			if(che.parents('tr').find('.reid').length!=0){				
				shareid=che.parents('tr').find('.reid').val();
				iscate=true;
			}else{
				shareid=che.parents('tr').find('.refileid').val();
				iscate=false;
			}			
			var name=che.parents('tr').find('a:eq(0)').text();
			$('.dialog-header-title').html("分享文件(夹):"+name);
		}
		
	});
	var shareid;
	var iscate=true;
	$('table').on('click','.fa-share-alt',function() {
		shareid=null;
		if($(this).parents('tr').find('.reid').length!=0){				
			shareid=$(this).parents('tr').find('.reid').val();
			iscate=true;
		}else{
			shareid=$(this).parents('tr').find('.refileid').val();
			iscate=false;
		}			
		var name=$(this).parents('tr').find('a:eq(0)').text();	
		showOverlay();
		$('.md-effect-4').addClass('md-show');
		$('.dialog-header-title').html("分享文件(夹):"+name);
	});
	 $('table').on('click','.md-copy',function() {
		$('.md-effect-10').addClass('md-show');
	});
	$('.cancel').click(function(){
		$('.md-effect-10').removeClass('md-show');
	}); 
	/* 判断私密还是公开 */
	$("input[type=radio]").click(function(){
		$("input[name='share-method']:checked").each(function() {
			if ($(this).val() == 'public') {
				$('.share-public-panel').css('color','red');
			} else {
				$('.share-public-panel').css('color','rgb(139, 144, 158)');
			}
		});
	});
	/* 创建链接样式 */
	$('.create').click(function() {
			var pp=$("input[name='share-method']:checked").val();
			if (pp == 'private') {
				$('.validity-section').hide();
				$('.create').hide();
				$('.share').show();
				$('.createlink').show();
				$('.create-success .private').show();
				$('.create-success .public').hide();
				$('.password').show();
				$('.description .private').show();
				$('.description .public').hide();
				$('#copyShare .private').show();
				$('#copyShare .public').hide();
			} else {
				$('.validity-section').hide();
				$('.create').hide();
				$('.share').show();
				$('.createlink').show();
				$('.create-success .private').hide();
				$('.create-success .public').show();
				$('.password').hide();
				$('.description .private').hide();
				$('.description .public').show();
				$('#copyShare .private').hide();
				$('#copyShare .public').show();
			}
			shareurl();
		});
	/* 鼠标滑过选中input-url */
	$('.share-url').mouseover(function(){
		this.select();
	})
	/* 关闭分享 */
	$('#end').click(function() {
		$('.validity-section').show();
		$('.create').show();
		$('.overlay').hide();
		$('.createlink').hide();
		console.log(1)
		$('.md-effect-4').removeClass('md-show');
		//$('#modal-4').hide();
	})
	//分享链接复制
	function myCopy(){
		var url = document.getElementById("share-url");
		var password=document.getElementById("share-password");				
		var link="链接："+url.value+" 密码："+password.value;
		document.getElementById('sharelink').value = link;
		var share=document.getElementById('sharelink');
		share.select();
		document.execCommand("Copy");
		document.getElementById("copy-tips").style.display ="block"; 
	}
	function Copy(){
		var url = document.getElementById("share-url");			
		var link=url.value;
		document.getElementById('sharelink').value = link;
		var share=document.getElementById('sharelink');
		share.select();
		document.execCommand("Copy");
		document.getElementById("copy-tips").style.display ="block"; 
	}
	
	
</script >

<!-- 多选复制 -->
<script>
var cateids=[];
var fileids=[];
var btns=[];
$('.equip_1').off('click','#f4').on('click','#f4',function(){
	showOverlay();
	a=a+1;	
	var j=0;
	var k=0;
	var i=0;
	cateids=[];
	fileids=[];
	btns=[];
	$('.table input:checked').each(function(){ 
		btns[i]=$(this).next().next('input').val();
	if($(this).next().next('input').hasClass('reid')){
		cateids[j++] = btns[i++];
	}else{
		fileids[k++] = btns[i++];
	}
	});
	btnAjax(cb);
});
$('.equip_1').off('click','#f2').on('click','#f2',function(){
	a=a+1;	
	var j=0;
	var k=0;
	var i=0;
	pan=1;
	cateids=[];
	fileids=[];
	btns=[];
	$('.table input:checked').each(function(){ 
		btns[i]=$(this).next().next('input').val();
	if($(this).next().next('input').hasClass('reid')){
		cateids[j++] = btns[i++];
	}else{
		fileids[k++] = btns[i++];
	}
	});
	btnAjax(cb);
});
</script>

<!-- 复制model的树形结构 -->
	<script type="text/javascript">
	
	$('.table').on('click','.fa-ellipsis-h',function(){
		$(this).parent().parent('td').find('.menu').css('display','block');
	});
	$('.table').on('mouseleave','.menu',function(){
		$('.menu').css('display','none');
	});
	
	var a=1;
	var flag=1;
	var thecate;
	var thefile;
	var ree=[];
	var pan=0;
	$('.table').off('click','.md-copy').on('click','.md-copy',function() {
		a=a+1;	
		thecate=null;
		thefile=null;
		ree=null;
		if($(this).parents('tr').find('input[type=text]').hasClass('reid')){
			thecate=$(this).parents('tr').find('.reid').val();
		}
		else{
			thefile=$(this).parents('tr').find('.refileid').val();
		}
		btnAjax(cb);
	});
	$('.table').off('click','.md-move').on('click','.md-move',function() {
		a=a+1;	
		pan=1;
		thecate=null;
		thefile=null;
		ree=null;
		if($(this).parents('tr').find('input[type=text]').hasClass('reid')){
			thecate=$(this).parents('tr').find('.reid').val();
		}
		else{
			thefile=$(this).parents('tr').find('.refileid').val();
		}
		btnAjax(cb);
	});
	function btnAjax(cb) {
		$.ajax({
			url : "${pageContext.request.contextPath}/showAllFolder.action?guid="+new Date().getTime(),
			type:"post",
			data:{
				"userID":'${user.id}'
			},
			success : function(data) {
				//console.log(data);
				var func = callbackFunc(data, cb);
                func()				
			},
			error : function() {
				alert("error");
			}
		});
	}
	function cb(data) {
		$('.menuTree').empty();
		showOverlay();
		$('.md-effect-10').addClass('md-show');		
		if(pan==1){
			$('.dialog-header-title').html('移动到');
			$('.surein').hide();
			$('.suremove').show();
			pan=0;
		}else{
			$('.dialog-header-title').html('复制到');
			$('.surein').show();
			$('.suremove').hide();
		}
    	var json = data;
		var str = "";
		var forTree = function(o){
	 	for(var i=0;i<o.length;i++){
	   		 var urlstr = "";
			 try{
	 				if(typeof o[i]["url"] == "undefined"){
			   	   		urlstr = "<div><i class='fa fa-plus-square-o'></i><img src='img/filepic/category.png' width='20px' style='margin:0 5px 5px 10px;'><span class='treename'>"+o[i]["folderName"]+"</span><input value='"+ o[i]["folderID"] +"' type='text' style='display:none'><ul>";
	 				}else{
	 					urlstr = "<div><i class='fa fa-plus-square-o'></i><img src='img/filepic/category.png' width='20px' style='margin:0 5px 5px 10px;'><span class='treename'>"+o[i]["folderName"]+"</span><input value='"+ o[i]["folderID"] +"' type='text' style='display:none'><ul>"; 
	 				}
	 			str += urlstr;
	 			if(o[i]["list"] != null){
	 				forTree(o[i]["list"]);
	 			}
	   		 str += "</ul></div>";
	 		}catch(e){}
	 }
	 return str;
	}
	/*添加无级树*/
	document.getElementById("menuTree").innerHTML = forTree(json);
	/*树形菜单*/
	var menuTree = function(){
	 //给有子对象的元素加
		 $("#menuTree ul").each(function(index, element) {
	 		var ulContent = $(element).html();
	 		var spanContent = $(element).siblings("span").html();
	 		if(ulContent){
				 $(element).siblings("span").html(spanContent) 
	 		}
		 });

		 $("#menuTree").find("div span").click(function(){
		 	 var ul = $(this).siblings("ul");
			 var spanStr = $(this).html();
		 	 var spanContent = spanStr.substr(3,spanStr.length);
			 if(ul.find("div").html() != null){
				 if(ul.css("display") == "none"){
					 $(this).parent('div').find('i:eq(0)').attr('class','fa fa-minus-square-o');
					 		 
					 ul.show(300);
		 		 }else{
		 			$(this).parent('div').find('i:eq(0)').attr('class','fa fa-plus-square-o');
		 			 ul.hide(300);
		 		 }
		 	}
		 })
		}()	
	}
	 //判断次数，获取返回函数
    function callbackFunc(data, cb) {
        flag++;
        if (a == flag) {
            return function () {
                cb(data);
            }
        } else {
            return function () {
            }
        }
    }
    var insertCate;
    $('.menuTree').off('click','.treename').on('click','.treename',function(){
		insertCate='';
		$(".treename").removeClass("active");  
        $(this).addClass("active");
        insertCate=$('.menuTree .active').next('input[type=text]').val();
	});
    
    $('.surein').unbind("click").click(function(){
    	var file_ids;
    	var cate_ids;
    	var aimcateid;
		if(thecate&&!thefile){			
			//alert("选择文件夹的id:"+thecate+"复制到文件夹："+insertCate);		
			cate_ids=thecate;
			aimcateid=insertCate;
		}else if(!thecate&&thefile){
			//alert("选择文件的id:"+thefile+"复制到文件夹："+insertCate);
			file_ids=thefile;
			aimcateid=insertCate;
		}else if(cateids.length>0&&fileids.length==0){
			//alert("选择文件夹的id:"+cateids+"复制到文件夹："+insertCate);
			cate_ids=cateids;
			aimcateid=insertCate;
		}else if(cateids.length==0&&fileids.length>0){
			//alert("选择文件的id:"+fileids+"复制到文件夹："+insertCate);
			file_ids=fileids;
			aimcateid=insertCate;
		}else{
			//alert("选择文件夹的id:"+cateids+"选择文件的id:"+fileids+"复制到文件夹："+insertCate);
			cate_ids=cateids;
			file_ids=fileids;
			aimcateid=insertCate;
		}
		copyFileAndCate(file_ids,cate_ids,aimcateid);		
    });
    /* 点击移动触发事件 */
    $('.suremove').unbind("click").click(function(){
    	var file_ids;
    	var cate_ids;
    	var aimcateid;
		if(thecate&&!thefile){			
			//alert("选择文件夹的id:"+thecate+"复制到文件夹："+insertCate);		
			cate_ids=thecate;
			aimcateid=insertCate; 
		}else if(!thecate&&thefile){
		//	alert("选择文件的id:"+thefile+"复制到文件夹："+insertCate);
			 file_ids=thefile;
			aimcateid=insertCate; 
		}else if(cateids.length>0&&fileids.length==0){
			//alert("选择文件夹的id:"+cateids+"复制到文件夹："+insertCate);
			 cate_ids=cateids;
			aimcateid=insertCate; 
		}else if(cateids.length==0&&fileids.length>0){
			//alert("选择文件的id:"+fileids+"复制到文件夹："+insertCate);
			file_ids=fileids;
			aimcateid=insertCate; 
		}else{
			//alert("选择文件夹的id:"+cateids+"选择文件的id:"+fileids+"复制到文件夹："+insertCate);
		    cate_ids=cateids;
			file_ids=fileids;
			aimcateid=insertCate; 
		}
		moveFileAndCate(file_ids,cate_ids,aimcateid);
    });
    
	$('.cancel').click(function(){
		$('.menuTree').empty();
		$('.md-effect-10').removeClass('md-show');
		$('.overlay').hide();
	});
	
	function moveFileAndCate(fileids,cateids,aimCateid){
		console.log(fileids);
		console.log(cateids);
		//if(cateids!=null&&cateids!="undefined"&&cateids.)
			
		if(cateids!='undefined'&&cateids!=null&&$.isArray(cateids))
			cateids = cateids.join(',');
		if(fileids!='undefined'&&fileids!=null&&$.isArray(fileids))
			fileids = fileids.join(',');
		 $.ajax({
            url: "${pageContext.request.contextPath}/moveFileAndCate.action",
            type:"post",
			data:{
				/*
				"filelist":JSON.stringify(fileids),
				"catelist":JSON.stringify(cateids),
				*/
				//这里直接用.join会出错，好像是中间变成非数组变量
				"filelist":fileids,
				"catelist":cateids,
				"categorie_id":aimCateid,
				"userID":'${user.id}',
			},
            success: function(data){
            	console.log(data)
            	console.log(data.message)
            	if(data.message=="移动成功!"){
            		toastr.info(data.message);
            	}else{
            		toastr.warning(data.message);
            	}
           	// alert(data);
           	 showchild(categorie,recycle);
           	//toastr.info("移动失败！");
            },
            error : function() {
				//alert("移动失败！");
				toastr.error("移动失败！");
			}
        });
		$('.md-effect-10').removeClass('md-show');
		$('.overlay').hide();
	}
	
	function copyFileAndCate(fileids,cateids,aimCateid){
		if(cateids!='undefined'&&cateids!=null&&$.isArray(cateids))
			cateids = cateids.join(',');
		if(fileids!='undefined'&&fileids!=null&&$.isArray(fileids))
			fileids = fileids.join(',');
		 $.ajax({
             url: "${pageContext.request.contextPath}/copyFileAndCate.action",
             type:"post",
 			data:{
 				/*
 				"filelist":JSON.stringify(fileids),
 				"catelist":JSON.stringify(cateids),
 				*/
 				//这里直接用.join会出错，好像是中间变成非数组变量
 				"filelist":fileids,
 				"catelist":cateids,
 				"categorie_id":aimCateid,
 				"userID":'${user.id}',
 			},
             success: function(data){
            	// alert(data);
            	 if(data.message=="复制成功!"){
             		toastr.info(data.message);
             	}else{
             		toastr.warning(data.message);
             	}
            	 showchild(categorie,recycle);
             },
             error : function() {
 				//alert("复制失败！");
            	 toastr.error("复制失败！");
 			}
         });
		 $('.md-effect-10').removeClass('md-show');
		 $('.overlay').hide();
	}
	</script>
  </body>
</html>
