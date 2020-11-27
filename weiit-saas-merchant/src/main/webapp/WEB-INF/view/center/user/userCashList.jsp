<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

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
						<div class="heading-elements" >
							<ul class="breadcrumb-elements">
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn1">订单编号</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn2">公司抬头</label></li>
										<!-- <li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn3">项目内容</label></li> -->
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn4">发票金额</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn5">发票性质</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn6">发票类型</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="userinvoicecolumn7">操作</label></li>
									</ul>						
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /page header --> 
				
				<!-- Content area -->
				<div class="content">
					<!-- Tabs -->
					<ul class="nav  nav-tabs"> 
						<li <c:if test="${empty queryParam.state }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/user/userCashList"><i class="icon-grid5 position-left"></i>全部</a></li>
						<li <c:if test="${!empty queryParam.state and queryParam.state==0 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/user/userCashList?state=0"><i class="icon-flag7 position-left"></i>待审核</a></li>
						<li <c:if test="${!empty queryParam.state and queryParam.state==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/user/userCashList?state=1"><i class="icon-file-check position-left"></i>提现成功</a></li>
						<li <c:if test="${!empty queryParam.state and queryParam.state==-1 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/user/userCashList?state=-1"><i class="icon-cancel-circle2 position-left"></i>提现失败</a></li>
					</ul>
					<!-- /tabs -->
								
					<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/user/userCashList" method="post">
					<input type="hidden" name="state" value="${queryParam.state}">	
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<div class="row">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">申请人</span> <input type="text"
											class="form-control" placeholder="" name="user_name" value="${queryParam.user_name}">
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							</div>
						</div>
				 
						 
							<div class="table-responsive">
								<table id="data-table"
									class="table">
									<thead>
										<tr> 
											<th>申请时间</th>
											<th>申请人</th>  
											<th>提现账户</th>
											<th>提现金额(元)</th> 
											<th>状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${pageInfo.list}" var="info">
										<tr>
					                        <td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					                        <td>${info.user_name}</td>
											<td>
					                        	<c:if test="${info.cash_type ==1}">微信</c:if>
					                           	<c:if test="${info.cash_type ==2}">支付宝</c:if>
												<c:if test="${info.cash_type ==3}">银行卡</c:if>
					                        	|${info.cash_name}<br/>(${info.cash_account})</td>
					                        <td>${info.cash_money}</td>  
					                        <td>
					                           	<c:if test="${info.state ==0}">
					                           		<span class="label label-warning">申请中</span> 
					                           	</c:if>
					                           	<c:if test="${info.state ==1}">
													<span class="label label-info">提现成功</span>
												</c:if>
												<c:if test="${info.state ==-1}">
													<span class="label label-default">提现失败</span>
												</c:if>
					                        </td>
					                        <td>
												<a href="userCashDetail?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" title="点击查看详情" class="btn btn-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" >详情</a>
												<c:if test="${info.state ==0}">
					                           		<a href="javascript:;" title="点击审核" class="btn btn-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="checkAuthOK('${info.validate_id}','${info.validate_id_token}')">审核</a>
													<a href="javascript:;" data-toggle="modal" data-target="#authNo_modal" title="点击驳回" class="btn btn-danger m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="checkAuthNO('${info.validate_id}','${info.validate_id_token}')">驳回</a>										
												</c:if>
											</td> 
										</tr>
									</c:forEach>
									</tbody>
								</table>
		
							</div>
							<div id="pager" class="panel-body"></div>
						 
					</div> 
					<!-- /bordered striped table -->
					</form>
				</div>
				<!-- /content area -->
			</div>
 
<!-- Edit modal -->
<div id="authNo_modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">审批驳回</h2>
			</div>
			<div class="modal-body" style="padding-top:0px;margin-top:0px;">
				<form class="form-horizontal form-validate-jquery" name="updateForm" id="updateForm" 
					action="${pageContext.request.contextPath}/center/user/userCashState?state=-1" method="post" >
					<fieldset class="content-group">
						<input type="hidden" name="validate_id" id="validate_id" value=""/>
						<input type="hidden" name="validate_id_token" id="validate_id_token" value=""/>  				
						 
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
 
 
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
<script>
$(document).ready(function() {
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
    
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