<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HaHa</title>
<link rel="Shortcut Icon" href="img/logo.png">
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

<style type="text/css">
body{
	background: #fff
}
.recyclebin-empty {
	display:none;
    position: absolute;
    left: 50%;
    top: 50%;
    margin: -175px 0 0 -176px;
}
.recyclebin-empty .img {
    display: inline-block;
    background: url(img/emptypic.png) center no-repeat;
    margin-left:100px;
    width: 130px;
    height: 160px;
}
.recyclebin-empty .text {
    font-size: 14px;
    line-height: 25px;
    margin-top: 30px;
    color: #8e99b3;
    text-align: center;
    margin-left: -60px;
}
</style>
</head>
<body>



		<div class="recyclebin-empty" style="display: block">
			<p class="img records records-17"></p>
			<p class="text">
			啊哦，你来晚了，分享的文件已经被取消或者分享地址不存在，下次要早点哟。
			</p>
		</div>
</body>
</html>