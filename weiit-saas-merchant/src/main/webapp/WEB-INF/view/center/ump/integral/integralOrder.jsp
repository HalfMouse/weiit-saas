<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>营销服务</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->

<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/ump/integral/orderList" method="post" >						
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> 
					<span class="text-semibold">积分商城 </span>
				</h4>
			</div> 
		</div>
	</div>
	
	<!-- Content area -->
	<div class="content">
		<!-- Tabs -->
		<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs"> 
			<li><a href="${pageContext.request.contextPath}/center/ump/integral/list"><i class="icon-home8 position-left"></i>积分商品</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/ump/integral/orderList"><i class="icon-vcard position-left"></i>积分订单</a></li>
			<li><a href="${pageContext.request.contextPath}/center/ump/integral/config"><i class="icon-vcard position-left"></i>积分配置</a></li>
		</ul> 
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
			<div class="panel-heading">
				<div class="heading-elements">
					<ul class="breadcrumb-elements">
						 
					</ul>
				</div>
			</div>
			<div class="panel-body" style="padding:5px;margin:5px;">
				<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-addon bg-info-300">订单编号</span>
						<input type="text" class="form-control" id="orderNum" name="orderNum" value="${queryParam.orderNum}">
					</div>
				</div> 
				<div class="col-md-3">								
					<div class="input-group">
						<span class="input-group-addon bg-info-300">状态</span>
						<select class="bootstrap-select" data-width="100%" name="state" id="state">
							<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--全部--</option>
							<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>待付款</option>
							<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>待发货</option>
							<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>待收货</option>
							<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>交易完成</option>
						</select>
					</div>
				</div> 
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>
			</div>
				
			<div class="table-responsive">
				<table  id="data-table"  class="table table-striped table-hover table-bordered  nowrap dataTable">
					<thead>
						<tr > 
							<th>订单编号</th>
							<th>商品名称</th>
							<th>销售价</th>
							<th>兑换价</th>
							<th>兑换积分</th>
							<th>订单时间</th>
							<th>快递号</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${pageInfo.list}" var="info">
	                    <tr>
	                    	<td><a href="javascript:;" onclick="detail('${info.validate_id}','${info.validate_id_token }')"
	                    		title="点击查看订单详细信息">${info.order_num}</a></td>
	                        <td valign="middle" style="vertical-align: middle;">
								<c:if test="${ !empty info.product_img }">
									<img alt="" src="${imageDomain }/${info.product_img }" width="50px;" >
								</c:if>
								${info.product_name }
	                        </td>
	                        <td>
	                        	￥${info.sale_price}
	                        </td>
	                        <td>￥${info.pay_price }</td>
							<td>${info.integral}</td>
	                        <td><fmt:formatDate value="${info.pay_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	                        <td>
				                <c:if test="${null != info.express_num }">
				                	快递公司:${info.express_name}
				                	<br/>
				                	快递单号:
				                	<a href="javascript:;" title="点击查看物流详细信息" 
											onclick="oncheckExpress('${info.express_num }','${info.express_code}')">${info.express_num }</a>
				                </c:if>
			                </td>
			                <td valign="middle" style="vertical-align: middle;">
								 <c:if test="${info.state==0 }">待付款</c:if>
	                           	 <c:if test="${info.state==1 }">待发货</c:if>
	                           	 <c:if test="${info.state==2 }">待收货</c:if>
								 <c:if test="${info.state==4 }">交易完成</c:if>
							</td>
							<td>
								<c:if test="${info.state==0 }">
	                        		<div class="btn btn-sm btn-danger" style="height: 22px;padding-top: 0px;">未付款</div>
	                        	</c:if>
								<c:if test="${info.state==1 }">
									<a href="javascript:;" class="btn btn-sm btn-info" style="height: 22px;padding-top: 0px;"
									   onclick="expressModal('${info.validate_id}','${info.validate_id_token }','${info.order_type}')">发货</a>
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
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
</form>

<!-- Edit modal -->
<div id="express_modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">订单发货</h2>
			</div> 
			<div class="modal-body">
				<form class="form-horizontal form-validate-jquery" name="updateForm" id="updateForm"  
					action="${pageContext.request.contextPath}/center/ump/integral/editOrderExpress?state=1" method="post" >
					 <input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
					 <input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>   
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-sm-3 control-label text-right "> <span class="text-danger">*</span>物流公司：</label>
							<div class="col-sm-7">
								<select name="express_id"   id="express_id"  class="select-search" data-size="5" required="required"  >
			                          <option value="">请选择</option>
			                          <option value="4">圆通</option>
			                          <c:forEach items="${expressList}" var="info" varStatus="ind">
			                          		<option value="${info.expressId}">${info.expressName}</option>
			                          </c:forEach>
		                        </select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right "><span class="text-danger">*</span>物流单号：</label>
							<div class="col-sm-7">
								 <input type="text" name="express_num" id="express_num" class="form-control input-sm" 
								 	required="required" placeholder="请填写物流单号"></td>
							</div>
						</div>
					</fieldset> 
					<div class="text-center"> 
						<button type="button" class="btn btn-primary" onclick="ship();">提交
							<i class="icon-checkmark3 position-right"></i></button>&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal">取消 
							<i class="icon-cross3 position-right"></i></button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>
<!-- /edit modal -->


<!-- 显示物流信息弹出框  -->
<%@include file="../../publics/express.jsp" %>
	
<%@include file="../../common/footer.jsp" %>
<script>
$(document).ready(function() {
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});

 
function detail(id,token){
	window.location="${pageContext.request.contextPath}/center/ump/integral/orderDetail?validate_id="+id+"&validate_id_token="+token;	
}

function expressModal(id,token,type){
	if(type==0){
		$("#validate_id").val(id);
		$("#validate_id_token").val(token); 
		$("#express_modal").modal("show");
	}else{
		MConfirm("此订单为虚拟订单，无需填写快递信息，是否确认已发货！",'','',function(result) {
			if(result){
				window.location="${pageContext.request.contextPath}/center/ump/integral/editOrderExpress?state=1&validate_id="+id+"&validate_id_token="+token;
			}
		});
	}
}
function ship(){
	 if($("#express_num").val()==""){
		 alert("请填写物流运单号！");
		 return;
	 }
	 $("#updateForm").submit();
}
</script>