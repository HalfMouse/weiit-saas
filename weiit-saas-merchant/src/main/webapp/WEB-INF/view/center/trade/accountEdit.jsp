<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
	<div class="sidebar-content">
		<!-- Sub navigation -->
		<div class="sidebar-category">
			<div class="category-title">
				<span><h6>资产中心</h6></span>
			</div>
			<div class="category-content no-padding">
				<ul class="navigation navigation-alt navigation-accordion">
					<li class="active"><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-menu6"></i>我的资产</a></li>
					<li><a href="${pageContext.request.contextPath}/center/trade/account/logList"><i class="icon-paste"></i>交易记录</a></li>
					<li><a href="${pageContext.request.contextPath}/center/trade/bill/batchList"><i class="icon-library2"></i>对账单</a></li>
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
					<!-- Tabs -->
					<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
						<li><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-display position-left"></i> 我的收入</a></li>
					 	<li><a href="${pageContext.request.contextPath}/center/trade/account/logList"><i class="icon-menu6 position-left"></i> 提现记录</a></li>
					 	<li class="active"><a href="${pageContext.request.contextPath}/center/trade/account/list"><i class="icon-credit-card position-left"></i> 提现账户</a></li>
					</ul>
					<!-- /tabs -->
				
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat"> 
								<div class="panel-body">
								<form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/trade/account/save" method="post" >
									<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
									<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
									<fieldset class="content-group">
										<legend class="text-bold" style="padding-top:0px;"><h5>${title}</h5></legend>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>账户类型： </label>
											<div class="col-sm-4">
												<select  name="type" id="type" 
													class="form-control validate[required]" data-errormessage-value-missing="请选择账户类型">
													<option value="">--请选择省--</option>
													<option value="1" <c:if test="${infoMap.type=='1' }">selected="selected"</c:if>>微信</option>
													<option value="2" <c:if test="${infoMap.type=='2' }">selected="selected"</c:if>>支付宝</option>
													<option value="3" <c:if test="${infoMap.type=='3' }">selected="selected"</c:if>>银行卡</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>名称： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-rounded validate[required]" name="account_name" id="account_name" 
													data-errormessage-value-missing="名称不能为空" value="${infoMap.account_name}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>账户账号： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-rounded validate[required]" data-errormessage-value-missing="请输入账户账号" name="account" id="account" value="${infoMap.account}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> 备注： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-rounded" placeholder="备注说明或银行卡"  name="remark" id="remark" value="${infoMap.remark}">
											</div>
										</div>
									</fieldset> 
									<div class="text-center">
										<button type="button" onclick="saveButton(this,'数据提交中，请稍后！')" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
										&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)" id="qua1" class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
									</div>
								</form>
								</div>
							</div>
							<!-- /form validation -->
						</div>
					 </div>
					
					
				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
<script> 
$(document).ready(function() { 
	
	$('#infoForm').validationEngine({ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'formError-white',
		scroll: true,
		showOneMessage: true
	});
});
 
  </script>
			
