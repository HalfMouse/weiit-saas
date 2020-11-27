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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/minified/core.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/minified/components.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/libraries/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/libraries/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/forms/selects/bootstrap_select.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/app.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/pages/form_bootstrap_select.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/base.js"></script> 
<style>
ul, ol{
padding-left:0px;
}
</style>
</head>
<body>
	<div class="login_bg">
		<!--头部logo部分-->
		<div class="logo">
			<a href="http://www.wstore.me"><img src="${pageContext.request.contextPath}/resource/images/login_logo.png" alt="" /></a>
		</div>
		<!--右侧登陆框-->
		<div class="login_box">
			<p class="login_title">初始化店铺信息</p>
			<form action="${pageContext.request.contextPath}/center/account/shopInitSave" id="shop_form" method="POST">
				<ul>
					<li>
						<input type="text" placeholder="店铺名称" name="shop_name" class="login_num" value="" >
						<div class="form-control-text">
							<i class="icon-store text-muted"></i> 
						</div>
					</li>
					<li>
						<select class="bootstrap-select" name="business_id" id="business_id" data-width="100%">
							<c:forEach items="${businessList}" var="info">
								<option value="${info.business_id}">${info.business_name}</option>
							</c:forEach>
						</select>
					</li>
					
					<li class="account_col">
						<div class="account_box fn-clear"> 
							<br>
							<font color='red' class="error_info">${error_info }</font> 
						</div>
						 
					</li>
					<li> 
						<button class="login_button" type="button" onclick="init()">进入控制台</button>  
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
$(function(){
	
	$(".login_num").blur(function(){  
		if($(".login_num").val().length<1){
			$(".error_info").html("店铺名称不能为空");
		}else if($(".login_num").val().length>30){ 
			$(".error_info").html("店铺名称太长，不符合要求");
		}else{
			$(".error_info").html("");
		}
	});
	
});
function init(){
	if($(".login_num").val().length<1){
		$(".error_info").html("店铺名称不能为空");
		return;
	}else if($(".login_num").val().length>30){
		$(".error_info").html("店铺名称太长，不符合要求");
		return; 
	}else{
		$(".error_info").html("");
		FullScreenShow("店铺创建数据初始化中，请稍后！");
		$("#shop_form").submit();
	}
	
}
</script>
