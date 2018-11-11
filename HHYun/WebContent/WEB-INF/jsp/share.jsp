<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>HaHa</title>

<link rel="Shortcut Icon" href="img/logo.png">
<link href="css/share.css" rel="stylesheet" />
<link href="css/refershare.css" rel="stylesheet" />
<link href="css/component.css" rel="stylesheet" />
  <link href="css/home.css" rel="stylesheet">
  <script type="text/javascript" src="js/utils.js"></script>
  
  <!-- 
<link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">

 <link href="css/bootstrap.min.css" rel="stylesheet">
 <script src="js/jquery-3.3.1.min.js"></script>
 <script src="js/bootstrap.min.js"></script>
 
  <link rel="stylesheet" type="text/css" href="toastrjs/toastr.min.css">
<script type="text/javascript" src="toastrjs/toastr.min.js"></script>
 -->
 <link rel="stylesheet" href="http://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">

<link href="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.staticfile.org/jquery/3.3.1/jquery.min.js"></script>
 <script src="http://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
 <!-- 有修改过 -->
<link rel="stylesheet" type="text/css" href="toastrjs/toastr.min.css">
<script type="text/javascript" src="https://cdn.staticfile.org/toastr.js/2.1.4/toastr.min.js"></script>

</head>
<script type="text/javascript">

$(function(){
	//控制登录
	var username = '${user.userName}';
	if(username.length > 0){
		$("#login").hide();
		$("#user").show();
	}else{
		$("#login").show();
		$("#user").hide();
	}
	
	$("#wrap").hide();

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
	
		
});

</script>
<body style="background:#EDF1F5">
	<div id="overlay" class="overlay"></div>
	  	 <div class='top' style="background:#EFF4F8;border-bottom:1px solid #DEE9F5;height:70px;">	
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
			<div id="login" style="display:inline-block;text-align: right; font-size: 14px;">
								<a href="#" class="load">登录</a> 
								<a href="register.jsp" class='reg'>注册</a>
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
	
	<div class="clean" style="clear: all; height: 15px;"></div>
	<div class="receivepage">
		<div class="col-lg-9 col-md-9 page2">
			<div class="page2_1">
				<div class="slide-show-left">
					<h2>
						<c:if test="${filelist.size() < 1 }"><img src="img/filepic/category.png" style="margin-left:10px;margin-bottom:5px;" ></c:if>
						<c:if test="${filelist.size() > 1 && catelist.size() < 1 }"><img src="img/cates.png"  style="margin-left:10px;margin-bottom:5px;" ></c:if>
						<c:if test="${filelist.size() >=1 && catelist.size() >=1 }"><img src="img/cates.png"  style="margin-left:10px;margin-bottom:5px;" ></c:if>
						
						<c:if test="${filelist.size() == 1 && catelist.size() < 1 }">
							<c:choose>
								    <c:when test="${filelist[0].fileSuffix == 'zip' || filelist[0].fileSuffix == 'rar' || filelist[0].fileSuffix == '7z'}">
								       <img src='img/filepic/ZIP_2.png'>
								    </c:when>
								    <c:when test="${filelist[0].fileSuffix == 'mp4' || filelist[0].fileSuffix == 'rmvb' || filelist[0].fileSuffix=='avi' || filelist[0].fileSuffix == 'mkv' || filelist[0].fileSuffix=='wmv' || filelist[0].fileSuffix=='wmv' ||  filelist[0].fileSuffix=='mov'}">
								       <img src='img/filepic/video.png'>
								    </c:when>
								     <c:when test="${filelist[0].fileSuffix == 'png' || filelist[0].fileSuffix == 'jpg'}">
								      <img src='img/filepic/pic.png'>
								    </c:when>
								     <c:when test="${filelist[0].fileSuffix == 'gif' || filelist[0].fileSuffix == 'bmp' || filelist[0].fileSuffix == 'psd'  || filelist[0].fileSuffix == 'ai' || filelist[0].fileSuffix == 'svg' }">
								       <img src='img/filepic/picture1.png'>
								    </c:when>
								     <c:when test="${filelist[0].fileSuffix == 'docx' || filelist[0].fileSuffix == 'doc' }">
								       <img src='img/filepic/word.png'>
								    </c:when>
								    <c:when test="${filelist[0].fileSuffix == 'txt' }">
								       <img src='img/filepic/text.png'>
								    </c:when>
								    
								     <c:when test="${filelist[0].fileSuffix == 'xls' || filelist[0].fileSuffix == 'xlsx' }">
								       <img src='img/filepic/xls.png'>
								    </c:when>
								     <c:when test="${filelist[0].fileSuffix == 'pdf' }">
								       <img src='img/filepic/pdf.png'>
								    </c:when>
								     <c:when test="${filelist[0].fileSuffix == 'html' }">
										<img src='img/filepic/html.png'>
								    </c:when>
								    <c:when test="${filelist[0].fileSuffix == 'mp3' || filelist[0].fileSuffix == 'wav' || filelist[0].fileSuffix == 'mod' }">
										<img src='img/filepic/music.png'>
								    </c:when>
								    <c:otherwise>
								       <img src='img/filepic/others.png'>
								    </c:otherwise>
								</c:choose>
						</c:if>
						<c:forEach items="${catelist }" var="c" varStatus="stat">
							<c:if test="${!stat.last}">${c.folderName }、</c:if>
							<c:if test="${stat.last}">${c.folderName }</c:if>
						</c:forEach> 
						<c:forEach items="${filelist }" var="f"  varStatus="stat">
							<c:if test="${!stat.last}">${f.fileName }、</c:if>
							<c:if test="${stat.last}">${f.fileName }</c:if>
						</c:forEach>
					</h2>
				</div>
				<div class="slide-show-right">
					<div class="module-share-top-bar g-clearfix">
						<div class="bar" style="white-space: nowrap; position: relative;">
							<div class="button-box" style="position: absolute; top: 0px; padding-top: 0px; line-height: normal;right:10px;">
								<a class="g-button g-button-blue" href="javascript:void(0);">
									<span class="g-button-right">
									<em class="fa fa-save" title="保存到网盘"></em>
									<span class="text" style="width: auto; margin-left: 5px;" id="pres">保存到网盘</span>
									</span> 
								</a>
							</div>
						</div>
					</div>
				</div>
				
				<script type="text/javascript">
					$("#pres").click(function(){
						var name = '${user.userName}';
						//console.log(name)
						if(name.length < 1){
							//alert("请先登陆！");
							toastr.error("请先登录！");
							return ;
						}
						var fid = new Array();
						var fname = new Array();
						var cateid = new Array();
						var catename = new Array();
						var uid = $("#uid").val();
						$("input[name='filebox']:checked").each(
								function(key, value) {
									fid[key] = $(this).val();
									fname[key] = $(this).parent().find("span")
											.text();
								});
						$("input[name='catebox']:checked").each(
								function(key, value) {
									cateid[key] = $(this).val();
									catename[key] = $(this).parent().find("span")
											.text();
								});				
						if (fid == "" && cateid == "") {
							//alert("请选择文件进行保存！");
							toastr.warning("请选择文件进行保存！");
						} else {
							
							showOverlay();
							a=a+1;
							btnAjax(cb);
							
							
						} 
					});
				</script>
				
				
				<div class="cb"></div>
				<div class="slide-show-other-infos">
					<div class="share-file-info" style="font-size: 14px;">
						<span class="fa fa-clock-o" style="font-size: 18px;"></span>&nbsp;<fmt:formatDate value="${share.shareDate }" pattern="yyyy-MM-dd  HH:mm:ss" /> 
					</div>
					<div class="share-valid-check" style='margin-left:30px;color:#666666;'>失效时间：
						<c:if test="${share.remainTime == 0 }">永久有效</c:if>
						<c:if test="${share.remainTime == 7 }">七天</c:if>
						<c:if test="${share.remainTime == 1 }">一天</c:if>
					</div>
					<div class="slide-show-other-cns clearfix">
						<span class="title-funcs"> <span class="funcs-share-area">
						</span>
						</span>
					</div>
					<div class="cb"></div>
				</div>
			</div>

			<div class="tw1_body" style="width: 100%; margin: 0px auto; height: 410px; overflow-y: auto; border: none;">
				<div class="Jdh">
					<table id="july_allFile" style="display: inline">
						<tr>
							 <td><a id='null' class='frist'
								style='cursor: pointer; color: #333; text-decoration: none;padding-left:2px;'>全部文件</a></td>
						</tr>
					</table>
					<span class="Sdh" style="float: right; display: inline-block;"></span>
				</div>
				<div class="Qdh">
					<ul class='head'>
						<li style="width: 50%;padding-left: 5px;"><input
							type="checkbox" class="ck1" /><span id="n3" style='margin-left: 10px;'>文件名</span></li>
						<li style="width: 25%;">大小</li>
						<li style="width: 25%;">修改日期</li>
					</ul>
					<div id="qdh">
					<c:forEach items="${catelist }" var="c">
						<ul>
							<li style="width: 50%; padding-left: 5px;">
							<input type="checkbox" class="cateid" name="catebox" value="${c.id }" />
								<img src='img/filepic/category.png' width='28px' style='margin:0 5px 5px 0px;'>
								<span id="" class="cate">${c.folderName }</span>
								<input type="hidden" value="${c.id }" />
								</li>
							<li style="width: 25%;">---</li>
							<li style="width: 25%;">${c.updateDate}</li>
						</ul>
					</c:forEach>
					<c:forEach items="${filelist }" var="f">
						<ul>
							<li style="width: 50%; padding-left: 5px;" class="downhover">
							<input type="checkbox" class="filebox" name="filebox" value="${f.id }" />								
								<c:choose>
								    <c:when test="${f.fileSuffix == 'zip' }">
								       <img src='img/filepic/ZIP_2.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								    <c:when test="${f.fileSuffix == 'mp4' || f.fileSuffix == 'rmvb' || f.fileSuffix=='avi' || f.fileSuffix == 'mkv' || f.fileSuffix=='wmv' || f.fileSuffix=='wmv' ||  f.fileSuffix=='mov'}">
								       <img src='img/filepic/video.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								     <c:when test="${f.fileSuffix == 'png' || f.fileSuffix == 'jpg' }">
								      <img src='img/filepic/pic.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								     <c:when test="${f.fileSuffix == 'gif' || f.fileSuffix == 'bmp' || f.fileSuffix == 'psd'  || f.fileSuffix == 'ai' || f.fileSuffix == 'svg' }">
								       <img src='img/filepic/picture1.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								     <c:when test="${f.fileSuffix == 'docx' || f.fileSuffix == 'doc' }">
								       <img src='img/filepic/word.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								    <c:when test="${f.fileSuffix == 'txt' }">
								       <img src='img/filepic/text.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								    
								     <c:when test="${f.fileSuffix == 'xls' }">
								       <img src='img/filepic/xls.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								     <c:when test="${f.fileSuffix == 'pdf' }">
								       <img src='img/filepic/pdf.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								     <c:when test="${f.fileSuffix == 'html' }">
										<img src='img/filepic/html.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								    <c:when test="${f.fileSuffix == 'mp3' || f.fileSuffix == 'wav' || f.fileSuffix == 'mod' }">
										<img src='img/filepic/music.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:when>
								    <c:otherwise>
								       <img src='img/filepic/others.png' width='28px' style='margin:0 5px 5px 0px;'>
								    </c:otherwise>
								</c:choose>
								
								<span id="n1">${f.fileName }</span><span class='fa fa-download' title='下载' ></span></li>
							<li style="width: 25%;"><span><c:if test="${f.fileSize/1024 < 1}">${f.fileSize }B</c:if>
								<c:if test="${f.fileSize/1024 >=1 && (f.fileSize/1024)/1024 < 1}">
									<f:formatNumber type="number" value="${f.fileSize/1024 }"
										pattern="0.00" maxFractionDigits="2" />K</c:if> <c:if
									test="${(f.fileSize/1024)/1024 >= 1}">
									<f:formatNumber type="number" value="${f.fileSize/1024/1024 }"
										pattern="0.00" maxFractionDigits="2" />M</c:if></span></li>
							<li style="width: 25%;">${f.updateDate}</li>
						</ul>
					</c:forEach>
					</div>
					<div id="str"></div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		$(function(){
			$(".cate").click(function(){
				console.log(1);
				var cateid = $(this).next().attr("value");
				var catename = $(this).text();
				$("input[name='catebox']").removeAttr("checked");
				$("input[name='filebox']").removeAttr("checked");
				$("#july_allFile tr").empty();
				var $head=$("<td><a id='null' class='frist'  style='cursor: pointer; color: #333; text-decoration: none'> 全部文件</a></td><td><a id='"+cateid+"' class='aa'  style='cursor:pointer;text-decoration:none'> >"+catename+"</a></td>"); 
				$("#july_allFile tr").append($head);
				shownext(cateid); 
				$("#qdh").hide();
			});
				function shownext(cateid){
					
					$(".showcate").remove();
					$.ajax({
						url : "${pageContext.request.contextPath}/showFolderNext.action",
						//dataType : 'json',
						//async : false,
						type:"post",
						data:{
							"folderID":cateid
						},
						success : function(map) {
							console.log(map);
							$("#frist").remove();
							$(".showTr").remove();
							var listFile = map.filelist;
							var listCate = map.catelist;
							for(var i=0;i<listCate.length;i++){
								
								var $str = ("<ul class='showcate'>"
										+ "<li style='width: 50%; padding-left: 5px;'>"
										+ "<input type='checkbox' name='catebox' class='cateid' value='"
										+ listCate[i].id
										+ "' />"
										+ "<img src='img/filepic/category.png' width='28px' style='margin:0 5px 5px 10px;'>"
										+ "<span id='n1' class='n2' >"
										+ listCate[i].folderName
										+ "</span></li>"
										+ "<li style='width: 25%;'>---</li>"
										+ "<li  style='width: 25%;'>"
										+  listCate[i].updateDate
										+ "</li></ul>"
								);
								$("#str").append($str);
							}
							for(var i=0;i<listFile.length;i++){
								var type = judgeFileType(listFile[i].fileSuffix);
								var filesize;
								var sizeflag;

								/* 计算文件大小 */
								if(listFile[i].fileSize/(1024*1024) < 1 ){
									filesize=(listFile[i].fileSize/1024).toFixed(2);
									sizeflag="KB";
								}else
								{
									filesize=(listFile[i].fileSize/(1024*1024)).toFixed(2);
									sizeflag="M";
								}

								var $str = ("<ul class='showcate'>"
										+ "<li style='width: 50%; padding-left: 5px;' class='downhover'>"
										+ "<input type='checkbox' name='filebox' class='filebox' value='"
										+ listFile[i].id
										+ "' />"
										+ "<img src='"
										+ type
										+ "'width='28px' style='margin:0 5px 5px 10px;'>"
										+ "<span id='n1' onclick='shownext("
										+ listFile[i].id
										+ ")'>"
										+ listFile[i].fileName
										+ "</span><span class='fa fa-download' title='下载'></span></li>"
										+ "<li style='width: 25%;'><span>"
										+ filesize + sizeflag
										+ "</span></li>"
										+ "<li  style='width: 25%;'>"
										+ listFile[i].updateDate
										+ "</li></ul>"
								)
								$("#str").append($str);
							}
						},
						error : function(){
							alert("false");
						}
					});
				}
				
				
				$('#str').on('click','.n2',function(){
					var cateid = $(this).parent('li').find('.cateid').val();
					var catename = $(this).text();
					 var $head=$("<td><a id='"+cateid+"' class='aa'  style='cursor:pointer;text-decoration:none'> >"+catename+"</a></td>"); 
	 				 $("#july_allFile tr").append($head);
					shownext(cateid);
				});
				$('.tw1_body').on('click','.frist',function(){
					 $("#july_allFile tr").find('.aa').empty();
					$(".showcate").remove();
					$("#qdh").show();
				});
				$('.tw1_body').on('click','.aa',function(){
					var cateid=$(this).attr("id");
					var catename = $(this).text();
					var $head=$("<td><a id='"+cateid+"' class='aa'  style='cursor:pointer;text-decoration:none'>"+catename+"</a></td>"); 
	 				$("#july_allFile tr").append($head);
					shownext(cateid);
	 				$(this).parent('td').nextAll('td').remove();
				});
		
				
		});
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				var size = new Array();
				$("input[name='filebox']").each(
						function(key, value) {
							size[key] = $("input[name='filebox']").parent().next().find("span").text();
						});
						/* alert(size); */
			
			});
		</script>
		<div class="col-lg-3 col-md-3 page3" >
			<div class="module-aside aside" id="layoutAside">
				<div class="module-share-person-info">
					<div class="share-person-inner global-clearfix haha">
						<div class="share-person-avatar">
							<a href="#" target="_blank" title="去Ta的分享主页" class="person-icon">
								<img alt="" src="img/photo.jpg"
								width="60px">
							</a>
						</div>
						<div class="share-person-data" style="margin-top:15px;">
							<div class="share-person-data-top">
								<a href="#" target="_blank" title="去Ta的分享主页"
									class="share-person-username">${shareUser.userName }</a> 
								<em class="fa fa-vimeo"></em>
							</div>
							
						</div>
						
					</div>
					<div class="share-person-intro" title="">
						<span style="color:#666666;margin-top:20px;">说明：Ta很懒什么也没留下。</span>
					</div>
				</div>
			</div>
		</div>		
	</div>
	<div class="md-modal md-effect-13" id="modal-13" >
    		<div class="md-content" style="height:310px;">
     			<div class="dialog-header dialog-drag">
					<span class="dialog-header-title">保存到 </span>
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
      			</div>
    		</div>
  	</div>
	<div class="md-modal md-effect-10" id="modal-10" style="width: 440px;">
		<div class="md-content" style="height: 310px;">
			<div class="dialog-header dialog-drag" style="height:40px;line-height:35px; background: #77afff;color:#fff;font-size:20px;padding:5px;">
				<img src="img/logo.png" width="30px" style="margin-top:-7px;margin-right:5px;"><span class="dialog-header-title" style="display: inline">登录July账号</span>
			</div>
			<div class="dialog-tree" style="border: none;height: 245px;overflow: hidden;">
				
					<div class="logininput">
						<input type="text" name="username" class="loginusername" id="name" placeholder="用户名" onblur="this.placeholder='用户名'" onfocus="this.placeholder=''"/> 
						<input type="password" class="userpassword" id="passWord" placeholder="密码" onBlur="this.placeholder='密码';" onFocus="this.placeholder='';"/>
					</div>
					<div class="loginbtn">
						<div class="loginsubmit fl" id="login">
							<input type="submit" value="登录" />
						</div>
						<div class="quxiao cancel">
							<span>取消</span>
						</div>
						<div class="logcheckbox" style='margin-top:-20px;'>
							<input id="bcdl" type="checkbox" checked="true" /> 保持登录
							<a href="#" style="float:right;text-decoration: none;color:#979696;">忘记密码?</a>
						</div>
					</div>
				
			</div>
		</div>

	</div>

	
	
	<script type="text/javascript">
		$("#login").click(function(){
			var name = $("#name").val();
			var passWord = $("#passWord").val();
			$.ajax({
				url : "sharelogin?name=" + name+"&passWord="+passWord,
				dataType : 'json',
				async : false,
				success : function(map) {
					var user = map.user;
					$("#modal-10").hide();					
					$(".login").hide();
					$(".username").append(user.name);
					$('#uid').val(user.id);
					$("#username").append(user.name);
					$(".photo").attr("src","showphoto?uid="+user.id);
					$(".sev").show();
					$('.overlay').hide();
				},
				error : function(){
					alert("登陆失败！");
				}
			});
		});
	</script>
	
</body>
<script src="js/classie.js"></script>
<script src="js/modalEffects.js"></script>
<script>
/*界面全选反选*/
$(".ck1").click(function() {
	if(this.checked) {
		$("#qdh :checkbox").prop("checked", true);
		$("#n3").html("已选中" + $('#qdh input:checkbox').length + "个文件/文件夹");
	} else {
		$("#qdh :checkbox").prop("checked", false);
		$("#n3").html("文件夹");
	}
});
	$('.fa-plus').click(function() {
		$(this).hide();
		$('.fa-minus').show();
	});
	$('.fa-minus').click(function() {
		$(this).hide();
		$('.fa-plus').show();
	});
	$('body').on('click', '.load', function() {
		showOverlay();
		$('.md-effect-10').addClass('md-show');
	});
	$('.cancel').click(function() {
		$('.overlay').hide();
		$('.md-effect-10').removeClass('md-show');
	});
	$('.receivepage').on('mouseenter','ul li.downhover',function(){
		$(this).children('.fa-download').show();
	})
	$('.receivepage').on('mouseleave','ul li.downhover',function(){
		$(this).children('.fa-download').hide();
	})
	//文件下载
	$('.receivepage').on('click','ul li.downhover .fa-download',function(){
		var Tfileid=$(this).parent('li').find('.filebox').val();
		var Tfilename=$(this).parent('li').find('#n1').text();
		 window.location.href="fileDownload.action?fileID="+Tfileid;
	})
	var a=1;
	var flag=1;
	var cateids=[];
	var fileids=[];
	var btns=[];
	$('.aaa').click(function(){
		showOverlay();
		a=a+1;	
		var j=0;
		var k=0;
		var i=0;
		cateids=[];
		fileids=[];
		btns=[];
		$('.showcate input:checked').each(function(){ 
			btns[i]=$(this).val();
		if($(this).hasClass('cateid')){
			cateids[j++] = btns[i++];
		}else{
			fileids[k++] = btns[i++];
		}
		alert(fileids);
		});
		btnAjax(cb);
	})
	/* 选择保存到文件夹 */
	//封装ajax事件
	function btnAjax(cb) {
		//查询所有的文件夹
		$.ajax({
			url : "${pageContext.request.contextPath}/showAllFolder.action?guid="+new Date().getTime(),
			//dataType : 'json',
			type:"post",
			data:{
				"userID":'${user.id}'
			},
			success : function(data) {
				console.log(data)
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
		$('.md-effect-13').addClass('md-show');			
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
	/* 取消保存 */
    $('.cancel').click(function(){
		$('.menuTree').empty();
		$('.md-effect-13').removeClass('md-show');
		$('.overlay').hide();
	});
    var insertCate;
    $('.menuTree').off('click','.treename').on('click','.treename',function(){
		insertCate='';
		$(".treename").removeClass("active");  
        $(this).addClass("active");
        insertCate=$('.menuTree .active').next('input[type=text]').val();
	});
    $('.surein').unbind("click").click(function(){
    	
    	var fid = new Array();
		var fname = new Array();
		var cateid = new Array();
		var catename = new Array();
		//登录用户的ID
		var userID = '${user.id}';
		$("input[name='filebox']:checked").each(
				function(key, value) {
					fid[key] = $(this).val();
					fname[key] = $(this).parent().find("span")
							.text();
				});
		$("input[name='catebox']:checked").each(
				function(key, value) {
					cateid[key] = $(this).val();
					catename[key] = $(this).parent().find("span")
							.text();
				});	
		//console.log(uid)
		//console.log(insertCate)
    	
	    $.ajax({
			url : "${pageContext.request.contextPath}/preservation.action",
			//dataType : 'json',	
			//async : false,
			type:"post",
			data:{
				"fidlist":fid.join(','),
				"fnamelist":fname.join(','),
				"cateid":cateid.join(','),
				"catename":catename.join(','),
				"userID":userID,
				"insertFolderID":insertCate
			},
			success : function(data) {
				if (data == "success") {
					//alert("保存成功！");
					toastr.info("保存成功！");
					return ;
				} else if (data == "error") {
					toastr.warning("文件或文件夹已存在！");
				}
			},
			error : function() {
				toastr.error("保存失败！");
			}
		}); 	
    	
    });
</script>
<script type="text/javascript">
    /**
     * 显示遮罩层
     */

     function showOverlay() {
        // 遮罩层宽高分别为页面内容的宽高
        $('.overlay').css({'height':$(window).height(),'width':$(window).width()});
        $('.overlay').show();
    }
    </script>
    
</html>
