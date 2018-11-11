<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    
    <title>回收站</title>
    
 <link rel="Shortcut Icon" href="img/mylogo.png">
 
<link href="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.staticfile.org/jquery/3.3.1/jquery.min.js"></script>
 <script src="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
 
  <link rel="stylesheet" type="text/css" href="css/home.css">
<link rel="stylesheet" type="text/css" href="css/refer.css">
<link rel="stylesheet" type="text/css" href="css/referRecycle.css">

<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript" src="js/utils.js"></script>



<!--  
 <link href="css/bootstrap.min.css" rel="stylesheet">
 <script src="js/jquery-3.3.1.min.js"></script>
 <script src="js/bootstrap.min.js"></script>
    
<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">


<script type="text/javascript" src="toastrjs/toastr.min.js"></script>
-->

 <link rel="stylesheet" href="http://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">


 <!-- 有修改过 -->
<link rel="stylesheet" type="text/css" href="toastrjs/toastr.min.css">
<script type="text/javascript" src="https://cdn.staticfile.org/toastr.js/2.1.4/toastr.min.js"></script>


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
					<li >
						<a href="${pageContext.request.contextPath}/home.action" >
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
					<li class="leftMenuActive">	
						 <a href="${pageContext.request.contextPath}/goRecycle.action" >
						  <span class="glyphicon glyphicon-trash" style="font-size:18px;"></span>&nbsp;回收站</a>
					</li>
			</ul>
	    </div>   
	   
	    <div data-options="region:'center',split:false,border:false" class="center">
	    <div class="page">
		<div class="page-container">
			<div class="module_link" style="border:none">
				<span>提示：回收站不占用网盘空间，文件保存10天后将被自动清除。<a style="color: #28A4C9;">开通会员</a>
					延长至15天，<a style="color: #28A4C9;">开通超级会员</a>延长至30天
				</span>
				<div class="cleanbox pull-right" >
					<span class="fa fa-trash">清空回收站</span>
				</div>
			</div>
			<div class="sharebox">
				<div class="name">
					<input type="checkbox" id="checkbox_a1" class="chk" /><label for="checkbox_a1"></label> 
					<span style="color: #5E5E5E;">文件名</span>
					<a class='recbtn'><i class='fa fa-refresh' title='还原'></i>还原</a>
				</div>
				<div class="fufH">
					<span style="color: #5E5E5E;">大小</span>
				</div>
				<div class="fufHs">
					<span style="color: #5E5E5E;">删除时间</span>
				</div>
				<div class="fufH">
					<span style="color: #5E5E5E;">有效时间</span>
				</div>
			</div>
		</div>
		<div class="reclist">
			<script type="text/javascript">
			// 消息提示框
			toastr.options = {  
		       // closeButton: true,                                            // 是否显示关闭按钮，（提示框右上角关闭按钮）
		        debug: false,                                                    // 是否使用deBug模式
		      //  progressBar: true,                                            // 是否显示进度条，（设置关闭的超时时间进度条）
		        positionClass: "my-toast-top-center",              // 设置提示款显示的位置
		        onclick: null,                                                     // 点击消息框自定义事件 
		        showDuration: "300",                                      // 显示动画的时间
		        hideDuration: "1000",                                     //  消失的动画时间
		        timeOut: "2000",                                             //  自动关闭超时时间 
		        extendedTimeOut: "1000",                             //  加长展示时间
		        showEasing: "swing",                                     //  显示时的动画缓冲方式
		        hideEasing: "linear",                                       //   消失时的动画缓冲方式
		        showMethod: "fadeIn",                                   //   显示时的动画方式
		        hideMethod: "fadeOut"                                   //   消失时的动画方式
		    };  
			 $(function(){
				 recycle();
			 })
			 //显示回收站
				 function recycle(){
					 $(".listshare").remove();
					 $.ajax({
						    
							url : "${pageContext.request.contextPath}/showRecycleList.action?Time="+new Date().getTime(),
							dataType : 'json',
							type:"post",
							data : {
								'userID':'${user.id}',
								'folderID':''
							},
							success : function(map) {
								var listCate = map.folderList;
								var listFiles = map.fileList;
								if(listCate=="" && listFiles==""){
									$('.recyclebin-empty').show();
								}else{
									$('.recyclebin-empty').hide();
								}
								//文件夹处理
								for (var i = 0; i < listCate.length; i++) {
									var $str=$("<div class='listshare'  id='listFileandCate'><span class='showRecycle'>"
									+"<div class='name'>"
									+"<input type='checkbox' id='checkbox_a1' /><img src='img/filepic/category.png' width='28px' style='margin:0 5px 5px 10px;'>"
									+ "<input id='listCateID' class='reid' type='text' style='display:none' value="
									+ listCate[i].id
									+ ">"
									+"<a class='file-name'>"+listCate[i].folderName +"</a>"
								    +"<i class='fa fa-trash' title='删除'></i><i class='fa fa-refresh' title='还原'></i></div>"
								    +"<div class='fufH'>"
									+"<span style='color: #5E5E5E;'>"+ "--"+"</span>"
								    +"</div>"
							        +"<div class='fufHs'>"
									+"<span style='color: #5E5E5E;'>"+ listCate[i].updateDate+"</span>"
								    +"</div>"
								    +"<div class='fufH'style='margin-left:10px;'>"
									+"<span style='color: #5E5E5E;'>永久有效</span>"
								    +"</div>"
								    +"</span></div>");
									$(".reclist").append($str);
								}		
								//文件处理
								for (var i = 0; i < listFiles.length; i++) {
									
									/* 计算文件大小 */
									if(listFiles[i].fileSize/(1024*1024) < 1 ){
										filesize=(listFiles[i].fileSize/1024).toFixed(2);
										sizeflag="KB";
									}else if(listFiles[i].fileSize/(1024*1024*1024) < 1)
									{
										filesize=(listFiles[i].fileSize/(1024*1024)).toFixed(2);
										sizeflag="M";
									}else{
										filesize=(listFiles[i].fileSize/(1024*1024*1024)).toFixed(2);
										sizeflag="G";
									}
									
									type = judgeFileType(listFiles[i].fileSuffix);
									var $str=$("<div class='listshare'id='listFileandCate'><span class='showRecycle'>"
									+"<div class='name'>"
									+"<input type='checkbox' id='checkbox_a1'/>"
									+ "<img src='"
									+ type
									+ "'width='28px' style='margin:0 5px 5px 10px;'>"
									+ "<input id='listFilesID' class='refileid' type='text' style='display:none' value="
									+ listFiles[i].id
									+ ">"
									+"<a class='file-name'>"+listFiles[i].fileName +"</a>"
								    +"<i class='fa fa-trash'title='删除'></i><i class='fa fa-refresh' title='还原'></i></div>"
								    +"<div class='fufH'>"
									+"<span style='color: #5E5E5E;'>"+ filesize+sizeflag+"</span>"
								    +"</div>"
							        +"<div class='fufHs'>"
									+"<span style='color: #5E5E5E;'>"+listFiles[i].updateDate+"</span>"
								    +"</div>"
								    +"<div class='fufH'style='margin-left:10px;'>"
									+"<span style='color: #5E5E5E;'>永久有效</span>"
								    +"</div>"
								    +"</span></div>");
									$(".reclist").append($str);
								}
								
							},
							error : function() {
								alert("查询失败！");
							}
						}); 
				 }
		
			 /* 全选反选 */
			 $('.chk').click(function(){				 
					 if(this.checked){						 
						 $('.reclist :checkbox').prop('checked',true);
						 var filenum=$('.reclist input:checked').length;
						 var message="已选中"+filenum+"个文件/文件夹";
						 $('.sharebox .name').find('span').html(message);
						 $('.name .recbtn').css('display','inline-block');
						 $('.sharebox').find('.name').nextAll('div').hide();							 
					 }else{
						 $('.reclist :checkbox').prop('checked',false);
						 $('.sharebox .name').find('span').html('文件夹');
						 $('.name .recbtn').css('display','none');
						 $('.sharebox').find('.name').nextAll('div').show();						 
					 }	
			 });
			 $('.reclist').on('click',':checkbox',function() {
				 var num=$('.reclist input:checked').length;
				 if(num>0&&num<$('.reclist :text').length){
					 var msg="已选中"+num+"个文件/文件夹";
					 $('.sharebox .name').find('span').html(msg);
					 $('.name .recbtn').css('display','inline-block');
					 $('.sharebox').find('.name').nextAll('div').hide(); 
				 }else if(num==$('.reclist :text').length){
					 $('.chk').prop('checked',true);
					 var msg="已选中"+num+"个文件/文件夹";
					 $('.sharebox .name').find('span').html(msg);					 					 
				 }else{
					 $('.chk').attr('checked',false);
					 $('.sharebox .name').find('span').html('文件夹');
					 $('.name .recbtn').css('display','none');
					 $('.sharebox').find('.name').nextAll('div').show();
				 }			 
			 })
			 /* 清空回收站 */
			 $('.cleanbox').click(function(){
				 
				 var msg = "你确认清空回收站吗？清除后不可恢复！"
					 if (confirm(msg)==true){
						 var btns= [];
						 var catelist = [];
						 var filelist = [];
						 var i=0;
						 var j=0;
						 var k=0;
						 $('.reclist :text').each(function(){ 
							 btns[i]=$(this).val();
							 if($(this).hasClass('reid')){	
								 //文件夹id
								 catelist[j++] = btns[i++];
							 }else{
								 //文件id
								 filelist[k++] = btns[i++];
							 }						
						 })
						 emptyRecycle(catelist,filelist)
					 }
			 })
			 /* 一键还原 */
			 $('.name .recbtn').click(function(){
				 var btns= [];
				 var cateids=[];
				 var fileids=[];
				 var j=0;
				 var k=0;
				 var i=0;
				 $('.reclist input:checked').each(function(){ 
					 btns[i]=$(this).next().next('input').val();
					 if($(this).next().next('input').hasClass('reid')){	
						 cateids[j++] = btns[i++];
					 }else{
						 fileids[k++] = btns[i++];
					 }						
				 })
				 restoreCateandfile(cateids,fileids);
			 });
			 
			 /* 还原文件 */
			 $('.reclist').on('click','.fa-refresh',function() {
				/*  判断是否为文件夹 */
				 if($(this).parent('div').find('.reid').length!=0){
					 var cateid=$(this).parent('div').find('.reid').val();
					
					 restorecate(cateid);
				 }else{
					 var fileid=$(this).parent('div').find('.refileid').val();
					 restorefile(fileid);
				 }				
					
				});
			 
			 /* 删除文件 */
			 $('.reclist').on('click','.fa-trash',function() {
				 var msg = "你确认删除吗？删除后不可恢复！"
						 if (confirm(msg)==true){ 
							 /*  判断是否为文件夹 */
							 if($(this).parent('div').find('.reid').length!=0){
								 var cateid=$(this).parent('div').find('.reid').val();
								 deletecate(cateid);
							 }else{
								 var fileid=$(this).parent('div').find('.refileid').val();
								 deletefile(fileid); 
							 }
						 }else{ 
						  return false; 
						 } 
				});
			 
			 /* 删除文件 */
			 function deletefile(fileID){
				 $.ajax({
						url : "${pageContext.request.contextPath}/deleteFile.action",
						//dataType : 'json',
						type:"post",
						data:{
							"fileID":fileID
						},
						success : function(data) {
							/* alert(data); */
							 recycle();
							toastr.info("删除文件成功！");
						},
						error : function() {
							//alert("删除文件失败！");
							toastr.error("删除文件失败！");
						}
					});
			 }
			 /* 删除文件夹 */
			 function deletecate(folderID){
				 $.ajax({
						url : "${pageContext.request.contextPath}/deleteFolder.action",
						//dataType : 'json',
						type:"post",
						data:{
							"folderID":folderID
						},
						success : function(data) {
							/* alert(data); */
							 recycle();
							 toastr.info("删除文件夹成功！");
						},
						error : function() {
							toastr.error("删除文件夹失败！");
						}
					});
			 }
			 /* 还原文件 */
			 function restorefile(fileID){
				 $.ajax({
						url : "${pageContext.request.contextPath}/restoreFile.action",
						//dataType : 'json',
						type:"post",
						data:{
							"fileID":fileID,
							//"userID":""
						},
						success : function(data) {
							var result = data.result;
							if(result=="还原文件成功！")
								toastr.info("还原文件成功！");
							else{
								toastr.error(result);
							}
							 //console.log(result); 
							 recycle();
							 //toastr.info("还原文件成功！");
						},
						error : function() {
							//alert("还原文件失败！");
							toastr.error("还原文件失败！");
						}
					});
			 }
			 
			 /* 还原文件夹 */
			 function restorecate(folderID){
				 $.ajax({
						url : "${pageContext.request.contextPath}/restoreFolder.action",
						//dataType : 'json',
						type:"post",
						data:{
							"folderID":folderID,
						},
						success : function(data) {
							var result = data.result;
							if(result=="文件夹成功还原！"){
								toastr.info("文件夹成功还原！");
							}else{
								toastr.error(result);
							}
							//alert(data);
							 recycle();
						},
						error : function() {
							//alert("还原文件夹失败！");
							toastr.error("还原文件夹失败！");
						}
					});
				 
			 }
			 /* 还原文件夹和文件 */
			 function restoreCateandfile(folderIDList,fileIDList){
				 $.ajax({
						url : "${pageContext.request.contextPath}/restoreFileAndFolder.action",
						//dataType : 'json',
						type:"post",
						data:{
							"folderIDList":folderIDList,
							"fileIDList":fileIDList
						},
						success : function(data) {
							alert(data);
							 recycle();
							 var num=$('.reclist input:checked').length;
							 if(num>0&&num<$('.reclist :text').length){
								 var msg="已选中"+num+"个文件/文件夹";
								 $('.sharebox .name').find('span').html(msg);
								 $('.name .recbtn').css('display','inline-block');
								 $('.sharebox').find('.name').nextAll('div').hide(); 
							 }else{
								 $('.chk').attr('checked',false);
								 $('.sharebox .name').find('span').html('文件夹');
								 $('.name .recbtn').css('display','none');
								 $('.sharebox').find('.name').nextAll('div').show();
							 }
						},
						error : function() {
							//alert("还原文件夹失败！");
							toastr.error("还原失败！");
						}
					});
			 }
			 
			 /* 清空回收站 */
			 function emptyRecycle(folderList,fileList){
				 console.log(folderList);
				 console.log(fileList);
				  $.ajax({
						url : "${pageContext.request.contextPath}/emptyRecycle.action",
						//dataType : 'json',
						type:"post",
						data:{
							"fileList":fileList.join(','),
							"folderList":folderList.join(',')
						},
						success : function(data) {
							 $('.chk').attr('checked',false);
							 $('.sharebox .name').find('span').html('文件夹');
							 $('.name .recbtn').css('display','none');
							 $('.sharebox').find('.name').nextAll('div').show();
							 recycle();
							 toastr.info("清空回收站成功！");
						},
						error : function() {
							//alert("清空回收站失败！");
							toastr.error("清空回收站失败！");
						}
					});
				 
			 }
			 
			/*  出现还原，删除选项 */
			 $('.reclist').on('mouseenter','.listshare',function() {
					$(this).children().find('i').css('display','inline-block');
					$(this).children().find('i').css('cursor','pointer');
				});
			 $('.reclist').on('mouseleave','.listshare',function() {
					$(this).children().find('i').css('display','none');
				});
			</script>
		</div>
		<div class="recyclebin-empty">
			<p class="img records records-17"></p>
			<p class="empty-word">您的回收站为空噢～</p>
			<p class="text">
			回收站为你保存10天内删除的文件，想要延长保存时间？<br>
			开通会员<a title="开通会员" data-type="vip" target="_blank">延长至15天</a>
			开通超级会员<a target="_blank" title="开通超级会员">延长至30天</a>
			</p>
		</div>		
	</div>
	   	</div>
  </body>
</html>
