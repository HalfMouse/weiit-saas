<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/marketing/coupon/couponSend" method="post" >						
<input type="hidden" name="validate_id" id="validate_id" value="${queryParam.validate_id}"/>
<input type="hidden" name="validate_id_token" id="validate_id_token" value="${queryParam.validate_id_token}"/>
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
	<!-- Page header -->
	<div class="page-header">
		<div class="breadcrumb-line">
			<ul class="breadcrumb">
				<li><a href="#"><i class="icon-home2 position-left"></i>营销插件</a></li> 
				<li class="active">优惠券活动</li>
			</ul> 
		</div>
	</div>
	
	<!-- Content area -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
			<div class="panel-heading">
				<h5 class="panel-title text-default text-bold" >优惠券派发用户列表</h5>
			</div>
			
			<div class="panel-body" style="padding:5px;margin:5px;">
				<div class="col-sm-3">
					<div class="input-group">
						<span class="input-group-addon bg-info-300">会员名</span>
						<input type="text" class="form-control" id="user_name" name="user_name" value="${queryParam.user_name}">
					</div>
				</div>  
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>&nbsp;&nbsp;
				<a href="javascript:;" onclick="history()" id="qua1" class="btn btn-default" >返回</a>	
			</div>
				
			<div class="table-responsive">
				<table  id="data-table"  class="table table-striped table-hover table-bordered  nowrap dataTable">
					<thead>
						<tr > 
							<th>
								<input type="checkbox" name="allCheck" onclick="allCheckClick(this)" value="" />
							</th>
							<th>头像</th>
							<th>会员名</th>
							<th>手机号</th>
							<th>注册时间</th>	
							<th>上次登录时间</th>	
							<th width="80">操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${pageInfo.list}" var="info">
	                    <tr>
	                    	<td><input type="checkbox"  name="ids"  value="${info.user_id}"/></td>
	                        <td><img src="${info.user_img}" width="40" height="40"/></td>
							<td>${info.user_name}</td> 
							<td>${info.user_phone}</td>
							<td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td><fmt:formatDate value="${info.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>						 
							<td>
								<a href="javascript:;" onclick="sendCoupon('${info.user_id}','${info.user_name }')" 
									class="btn btn-danger btn-xs m-r-5" style="height: 22px; padding-top: 0px;" >
									 派发 
								</a>
							</td>
	                    </tr>
	                </c:forEach>
					</tbody>
				</table>
			</div>
 
			<div id="pager" class="panel-body">
				<button type="button" class="btn btn-default" onclick="BatchCoupon()"><i class="icon-paperplane"></i> 批量派发</button>
				<button type="button" class="btn btn-default" onclick="allCoupon()"><i class="icon-paperplane"></i> 全部派发</button>
			</div>
			
		</div> 
		<!-- /bordered striped table -->
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
</form>
<%@include file="../common/footer.jsp" %>
<script>
$(document).ready(function() {
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});
 
 
function allCoupon(id,name){
	MConfirm('确定要给查询全部用户派送吗？','','',function(result) {
		if(result){
			var url="${pageContext.request.contextPath}/center/marketing/coupon/couponSendSave?type=2";
			$('#searchform').attr("action",url);
			$('#searchform').submit();
		}
	});
}
function BatchCoupon(){
	var idStr="";
	var idsCheck = $("#data-table input[name='ids']");
	idsCheck.each(function(i){
		if ($(this).prop("checked") ) {		
			if(idStr==""){
				idStr=$(this).val();
			}else{
				idStr=idStr+","+$(this).val();
			}
		}
    });
	if(idStr==""){
		MAlert('请至少选择一个用户进行派送！');
		return;
	}
	MConfirm('确认对选择用户批量派送优惠券吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/marketing/coupon/couponSendSave?type=1&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&userIds="+idStr ;
		}
	});
}
 
function sendCoupon(userId,userName){
	MConfirm('确定要给用户<label style="color: red;">'+userName+'</label> 派送优惠券吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/marketing/coupon/couponSendSave?type=0&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&user_id="+userId;
		}
	});
}

function history(){
	window.location="${pageContext.request.contextPath}/center/marketing/coupon/list";	
}

</script>