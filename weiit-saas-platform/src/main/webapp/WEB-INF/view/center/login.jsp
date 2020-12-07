<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>蜗店-服务商系统</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<meta content="" name="description">
<meta content="" name="author">
<link href="${pageContext.request.contextPath}/favicon.ico" rel="shortcut icon">
<link href="${pageContext.request.contextPath}/resource/css/minified/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resource/css/minified/login.min.css" rel="stylesheet">

</head>
<body class="pace-top" style="background:#707478;">
	<div id="page-loader" class="fade in hide">
		<span class="spinner"></span>
	</div>
	
	<div id="page-container" class="fade in">
		<div class="login login-v2 animated fadeIn"
			data-pageload-addclass="animated fadeIn">
			<div class="login-header"> 
				<div class="brand">
					 蜗店-服务商系统
					 
				</div>
				<div class="icon">
					<i class="fa fa-sign-in"></i>
				</div>
			</div>
			<div class="login-content">
				<form action="${pageContext.request.contextPath}/center/manager/partnerLogin" method="POST" class="margin-bottom-0">
					<div class="form-group m-b-20">
						<input type="text" class="form-control input-lg" name="account_name" placeholder="登录账户">
					</div>
					<div class="form-group m-b-20">
						<input type="password" class="form-control input-lg" name="password" placeholder="登录密码">
					</div>
					<div class="checkbox m-b-20">
						<label> <input type="checkbox"> 记住密码</label>&nbsp;&nbsp;&nbsp;
						<font color='red'>${info }</font>
					</div>
					<div class="login-buttons">
						<button type="submit" class="btn btn-success btn-block btn-lg">登录</button>
					</div>
					 <div class="m-t-20">
						版权企业:
						 <a href="">深圳微邦互联科技有限公司</a>
					</div> 
				</form>
			</div>
		</div>

	</div>

</body>
</html>