<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="renderer" content="webkit" />
<title>蜗店-领先的微信社交电商企业服务平台</title>
<meta name="keywords" content="蜗店、微商城,小程序商城,Wstore,门店系统,微店铺,小程序搭建" />
<meta name="description" content="蜗店-领先的微信社交电商企业服务平台" />
<meta http-equiv="Cache-Control" content="no-transform " />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/login/reset.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/login/login.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/icons/icomoon/styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/minified/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/libraries/jquery.min.js"></script>

</head>
<body>
	<div class="login_bg">
		<!--头部logo部分-->
		<div class="logo">
			<a href="http://www.wstore.me"><img src="${pageContext.request.contextPath}/resource/images/login_logo.png" alt="" /></a>
		</div>
		<!--右侧登陆框-->
		<div class="login_box" style="background:white;width:260px;height:290px;padding-top:2px;">
			<p class="login_title" style="color:#444">微信扫码注册</p> 
			<form action="${pageContext.request.contextPath}/center/account/login" method="POST" >
				<ul style="margin-top:-12px;">  
					<li style="width:100%"> 
						<img src="${pageContext.request.contextPath}/resource/images/wd_qrcode.jpg" width="258" height="258">
					</li>
				</ul> 
			</form> 
		</div>
	
		<div class="contact_us">客服服务专线&nbsp;0755-36953215 &nbsp;&nbsp;&nbsp;联系
			<span class="img">
			<img src="${pageContext.request.contextPath}/resource/images/qq.png" alt="">
			<div class="con-qrcode">
				<img src="${pageContext.request.contextPath}/resource/images/qq_qrcode.png" alt="">
				<p>扫码联系我们</p> 
			</div> 
			</span>&nbsp;或
			<span class="img">
				<img src="${pageContext.request.contextPath}/resource/images/wechat.png" alt=""> 
			<div class="con-qrcode">
				<img src="${pageContext.request.contextPath}/resource/images/wx_qrcode.png" alt=""> 
				<p>扫码联系我们</p> 
			</div>
			</span>&nbsp;加入客服服务群
		</div>
		<div class="banquan">
			<p>© 2015 - 2018 wstore.me 深圳微邦互联科技有限公司 版权所有 ICP证：
			<a href="http://www.miitbeian.gov.cn" target="_blank">
				粤ICP备14012549号
			</a>
			</p>
		</div>
		
	</div>
</body>
</html>
<script>
if (top != window)    {
    top.location.href = window.location.href;
}



function changeVerifyCode() {
    var src = "${pageContext.request.contextPath}/center/account/verifyCode?tempstamp="+(new Date()).valueOf();
	var img = $("#verifyCode");
	img.attr("src",src);
}

</script>

