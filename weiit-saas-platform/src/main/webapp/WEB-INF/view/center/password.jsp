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

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Content area -->
				<div class="content">

					<!-- Simple login form -->
					<form class="login-form" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/manager/updatePassword" method="post">
						<div class="panel panel-body login-form">
							<div class="text-center">
								<div class="icon-object border-slate-300 text-slate-300"><i class="icon-reading"></i></div>
								<h5 class="content-group">修改密码</h5>
							</div>

							<div class="form-group has-feedback has-feedback-left">
								<input type="password" class="form-control" name="oldPassword" id="oldPassword" value="" placeholder="请输入旧密码">
								<div class="form-control-feedback">
									<i class="icon-lock2 text-muted"></i>
								</div>
							</div>

							<div class="form-group has-feedback has-feedback-left">
								<input type="password" class="form-control" name="newPassword" id="newPassword" value="" placeholder="请输入新密码">
								<div class="form-control-feedback">
									<i class="icon-lock2 text-muted"></i>
								</div>
							</div>
							
							<div class="form-group has-feedback has-feedback-left" style="padding-bottom:5px;margin-bottom: 0px;">
								<input type="password" class="form-control" name="confirmPassword" id="confirmPassword" value="" placeholder="请再次输入新密码">
								<div class="form-control-feedback">
									<i class="icon-lock2 text-muted"></i>
								</div>
							</div>
							<label>
	                            <font color="red" id="message" ></font>
	                        </label>
							<div class="form-group"  style="padding-top:5px;">
								<button type="button" onclick="savePassButton()" class="btn btn-primary btn-block">确认修改 <i class="icon-checkmark3 position-right"></i></button>
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

<script>

function savePassButton(){
	var oldPassword = $("#oldPassword").val();
	var newPassword =$("#newPassword").val();
	var confirmPassword =$("#confirmPassword").val();
	if(oldPassword==""){
		$("#message").html("请输入旧密码和新密码!");
		return false;
	}
	if(newPassword != confirmPassword){
		$("#message").html("确认密码不相同,请重新输入!");
		return false;
	}
	
	var url="${pageContext.request.contextPath}/center/manager/updatePassword?oldPassword="+
			oldPassword+"&newPassword="+newPassword;	
	$.post(url,  null ,
   		function (result){
   	 	  try{
   	 		var date= eval("("+result+")"); 
   	 		if(date.code=='0'){
   	 			MAlert("密码修改成功,请使用新密码登录！","","",function(){
   	   	 			window.location.href="${pageContext.request.contextPath}/center/manager/password";
   	 			});
   	 	     }else{
   	 	    	$("#message").html(date.message);
   	 	     }
    	  }catch(oException){
        	  alert("和服务器交互失败:" + oException.message);
    	  }
	}); 
	
}

</script>

</body>
</html>
