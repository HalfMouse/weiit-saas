<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/header.jsp" %>
<link href="${pageContext.request.contextPath}/resource/css/style.min.css" rel="stylesheet" />

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>客户管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="userList"><i class="icon-users"></i>会员管理</a></li>
								<li><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
								<li class="active"><a href="userCashList"><i class="icon-cash"></i>会员提现</a></li>
								<li><a href="userSet"><i class="icon-gear"></i>会员设置</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4><i class="icon-arrow-left52 position-left"></i>会员提现</h4>
						</div>
					</div>
				</div>
				<!-- /page header --> 
				
	<!-- Content area -->
	<div class="content">
		<!-- Invoice template -->
		<div class="panel panel-white">
			<div class="panel-heading">
				<h6 class="panel-title">会员提现详情</h6> 
			</div>

			<div class="panel-body no-padding-bottom">

				<div class="row">
					<div class="col-md-12 ">
						<span style="font-weight: bold;">提现状态:</span>
						<span class="text-danger">
							<c:if test="${infoMap.state==0 }">待审核</c:if> 
							<c:if test="${infoMap.state==1 }">提现成功</c:if>
							<c:if test="${infoMap.state==-1 }">提现失败</c:if>
						</span>
					</div>
					
					<div class="col-md-5 col-lg-9 content-group">
						<ul class="list-condensed list-unstyled">
							<li><span class="text-bold">提现用户：</span>${infoMap.user_name }</li>
							<li><span class="text-bold">提现账户类型：</span>
								<c:if test="${infoMap.cash_type eq 1}">微信</c:if>
								<c:if test="${infoMap.cash_type eq 2}">支付宝</c:if>
								<c:if test="${infoMap.cash_type eq 3}">银联</c:if>
							</li>
							<li><span class="text-bold">开户银行名称：</span>${infoMap.bank_name }</li>
							<li><span class="text-bold">账户姓名：</span>${infoMap.cash_name }</li>
							<li><span class="text-bold">账号：</span>${infoMap.cash_account }</li>
							<li><span class="text-bold">发票金额：</span>${infoMap.cash_money }</li>
							<li><span class="text-bold">用户备注：</span>${infoMap.remark }</li>
							<li><span class="text-bold">申请时间：</span><fmt:formatDate value="${infoMap.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></li>
							<li><span class="text-bold">审核时间：</span><fmt:formatDate value="${infoMap.update_time }" pattern="yyyy-MM-dd HH:mm:ss"/></li>
							<c:if test="${infoMap.state==-1 }">
								<li><span class="text-bold">用户备注：</span>${infoMap.reason }</li>
							</c:if>
						</ul>
					</div> 
				</div>
			</div>
			<div class="text-center">
				<c:if test="${infoMap.state ==0}">
					<a href="javascript:;" title="点击审核" class="btn btn-success" onclick="checkAuthOK('${infoMap.validate_id}','${infoMap.validate_id_token}')">审核</a>
					<a href="javascript:;" data-toggle="modal" data-target="#authNo_modal" title="点击驳回" class="btn btn-danger"  onclick="checkAuthNO('${infoMap.validate_id}','${infoMap.validate_id_token}')">驳回</a>
				</c:if>
				<a href="javascript:history.back(-1)" id="qua1" class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
			</div>
			<br/><br/>
		</div>
		<!-- /invoice template -->

	</div>
	<!-- end #content -->

	</div>
	<!-- end Main content -->	 

<!-- Edit modal -->
<div id="authNo_modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">维权处理</h2>
			</div>
			<div class="modal-body" style="padding-top:0px;margin-top:0px;">
				<form class="form-horizontal form-validate-jquery" name="updateForm" id="updateForm" 
					action="${pageContext.request.contextPath}/center/user/userCashState?state=-1" method="post" >
					<fieldset class="content-group">
						<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
						<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>  				
						 
						<div class="form-group">
							<label class="col-sm-2 control-label text-right"><br/>驳回理由：</label>
							<div class="col-sm-8"><br/>
								<textarea rows="5" cols="10" name="reason" placeholder="请填写你的拒绝理由" class="form-control validate[required]"
									data-errormessage-value-missing="驳回理由不能为空"></textarea>
							</div>
						</div> 
					</fieldset>
					<div class="text-right">
						<button type="button" class="btn btn-danger" onclick="onAuthNo()"  >拒绝退款</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>
<!-- /edit modal -->

<%@include file="../common/footer.jsp" %> 
 
<script>
$(document).ready(function() { 
    $('#updateForm').validationEngine({ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'formError-white',
		scroll: true,
		showOneMessage: true
	});
});

function checkAuthOK(validate_id,validate_id_token){
	MConfirm('确定审核通过该提现申请吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/user/userCashState?state=1&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
		}
	});	
}
function checkAuthNO(validate_id,validate_id_token){
	$("#validate_id").val(validate_id);
	$("#validate_id_token").val(validate_id_token);
}

function onAuthNo(){ 
	if(!$("#updateForm").validationEngine("validate")){
		return false;
	}
	$("#updateForm").submit();
}
 
</script>
