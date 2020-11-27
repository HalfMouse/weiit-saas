<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>移动电商-服务中心系统</title>

	<%@include file="./common/css.jsp" %>
    <%@include file="./common/js.jsp" %>

</head>

<body>
 
	<!-- Page container -->
	<div class="page-container login-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-credit-card"></i>支付/交易</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/expressList"><i class="icon-truck"></i>物流配送</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/account/password"><i class="icon-key"></i> 修改密码</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Content area -->
				<div class="content">

					<!-- Simple login form -->
					<form class="login-form" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/account/passwordEdit" method="post">
						<div class="panel panel-body login-form">
							<div class="text-center">
								<div class="icon-object border-slate-300 text-slate-300"><i class="icon-lock"></i></div>
								<h5 class="content-group">修改密码</h5>
							</div>

							<div class="form-group has-feedback has-feedback-left">
								<input type="password" class="form-control validate[required,maxSize[16]]" name="oldPassword" id="oldPassword" value="" placeholder="请输入旧密码" data-errormessage-value-missing="请输入旧密码" data-errormessage-range-overflow="密码最多支持16个字符">
								<div class="form-control-feedback">
									<i class="icon-lock2 text-muted"></i>
								</div>
							</div>

							<div class="form-group has-feedback has-feedback-left">
								<input type="password" class="form-control validate[required,maxSize[16]]" name="password" id="password" value="" placeholder="请输入新密码" data-errormessage-value-missing="请输入新密码" data-errormessage-range-overflow="密码最多支持16个字符">
								<div class="form-control-feedback">
									<i class="icon-lock2 text-muted"></i>
								</div>
							</div>
							
							<div class="form-group has-feedback has-feedback-left" style="padding-bottom:5px;margin-bottom: 0px;">
								<input type="password" class="form-control validate[required,maxSize[16],funcCall[checkPassword]]" name="confirmPassword" id="confirmPassword" value="" placeholder="请再次输入新密码" data-errormessage-value-missing="请再次输入新密码" data-errormessage-range-overflow="密码最多支持16个字符" >
								<div class="form-control-feedback">
									<i class="icon-lock2 text-muted"></i>
								</div>
							</div>
							<label>
	                            <font color="red" id="message" ></font>
	                        </label>
							<div class="form-group"  style="padding-top:5px;">
								<input type="hidden" name="validate_id" value="${sessionScope.merchant.validate_id }"/>
								<input type="hidden" name="validate_id_token" value="${sessionScope.merchant.validate_id_token }"/>
								<button type="button" id="commit" class="btn btn-primary btn-block">确认修改 <i class="icon-checkmark3 position-right"></i></button>
							</div>
						</div>
					</form>
					<!-- /simple login form -->

				</div>
				<!-- /content area -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->



</body>
</html>
<!-- 提示内容 -->
<c:if test="${isPNotify eq true }">
<script>
 $(function(){
	 new PNotify({title: '提示操作',text: '${text}',addclass: 'bg-info'});
	 }
);
</script>
</c:if>

<c:if test="${isError eq true }">
<script>
 $(function(){
	 new PNotify({title: '提示操作',text: '${text}',addclass: 'bg-danger'});
	 }
);
</script>
</c:if>

<script>
$(document).ready(function() {
	/*默认监听表单onbulr验证*/
	$('#infoForm').validationEngine("attach",{ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'blackPopup formError-small',
		scroll: true,
		showOneMessage: true
	}); 
	
	$("#commit").click(function(){
		if(!$('#infoForm').validationEngine("validate")){
			return false;
		}else{
			$("#infoForm").submit();
		}
		
	});
});

function checkPassword(){  
	var pwd1=$("#password").val();
	var pwd2=$("#confirmPassword").val();
	if(pwd1!=pwd2){
		 return "两次密码不一致";  
	}
}  
</script>