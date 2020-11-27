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
								<%--<li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="${pageContext.request.contextPath}/center/ump/spread"><i class="icon-sphere3"></i>我要推广</a></li>--%>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->

<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/ump/integral/list" method="post" >
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
			<li class="active"><a href="${pageContext.request.contextPath}/center/ump/integral/list"><i class="icon-home8 position-left"></i>积分商品</a></li>
			<li><a href="${pageContext.request.contextPath}/center/ump/integral/orderList"><i class="icon-vcard position-left"></i>积分订单</a></li>
			<li><a href="${pageContext.request.contextPath}/center/ump/integral/config"><i class="icon-vcard position-left"></i>积分配置</a></li>
		</ul>
		<!-- /tabs -->
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
			<div class="panel-heading">
				<div class="heading-elements">
					<ul class="breadcrumb-elements">
						<li><a onclick="WIADD()" >
							<i class="icon-add position-left"></i> 新增</a></li> 
					</ul>
				</div>
			</div>
			<div class="panel-body" style="padding:5px;margin:5px;">
				<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-addon bg-info-300">商品名称</span>
						<input type="text" class="form-control" id="product_name" name="product_name" value="${queryParam.product_name}">
					</div>
				</div>  
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>
			</div>
				
			<div class="table-responsive">
				<table  id="data-table"  class="table table-striped table-hover table-bordered  nowrap dataTable">
					<thead>
						<tr > 
							<th>积分商品名称</th>
							<th>销售价</th>
							<th>兑换价</th>
							<th>兑换积分</th>
							<th>库存</th>
							<th>发布时间</th>
							<th>状态</th>
							<th width="80">操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${pageInfo.list}" var="info">
	                    <tr>
	                        <td valign="middle" style="vertical-align: middle;">
								<img alt="" width="50px;" src="${imageDomain }/${info.product_img}">
								${info.product_name }
	                        </td> 
	                        <td>
								￥${info.sale_price }
	                        </td>
	                        <td>
								￥${info.integral_price}
	                        </td>
	                        <td>${info.integral}</td>
	                        <td>${info.stock}</td>
	                        <td><fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                        <td>
	                           	<c:if test="${info.state ne -1 }">
	                           		<a href="javascript:;" title="点击下架" class="btn btn-success m-r-5 m-b-5"
										style="height: 22px; padding-top: 0px;"
										onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.product_name}',-1)">销售中</a>
	                           	</c:if>
	                           	<c:if test="${info.state eq -1}">
									<a href="javascript:;" title="点击上架" class="btn btn-warning m-r-5 m-b-5"
										style="height: 22px; padding-top: 0px;"
										onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.productName}',0)">已下架</a>
								</c:if>
	                        </td>
	                        <td>
								<ul class="icons-list">
									<li><a href="javascript:;" title="编辑" onclick="WIedit(${info.validate_id},'${info.validate_id_token}')" >
										<i class="icon-pencil7"></i></a></li>
		                           	<li><a href="javascript:;" title="删除" onclick="WIremove(${info.validate_id},'${info.validate_id_token}','${info.product_name}')" >
										<i class="icon-trash"></i></a></li>
									
								</ul>
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
<%@include file="../../common/footer.jsp" %>
<script>
$(document).ready(function() {
    <%--$("#pager").pager({--%>
        <%--pagenumber: ${pageInfo.pageNum}, --%>
        <%--pagecount: ${pageInfo.pages},--%>
        <%--pagesize: ${pageInfo.pageSize} ,--%>
        <%--pagerecordSize: ${pageInfo.total},--%>
        <%--buttonClickCallback: searchSubmit });--%>
});

function WIADD(){
	window.location="${pageContext.request.contextPath}/center/ump/integral/productAdd?ts="+new Date().getTime();
}
function WIedit(id,token){
	window.location="${pageContext.request.contextPath}/center/ump/integral/edit?validate_id="+id+"&validate_id_token="+token+"&ts="+new Date().getTime();
}

function mUpdate(id,token,name,status){
	var title="";
	if(status=="-1"){
		title='确定要下架积分商品 <label style="color: red;">'+name+'</label> 吗？';
	}
	if(status=="0"){
		title='确定要上架积分商品<label style="color: red;">'+name+'</label> 吗？';
	}
	MConfirm(title,'','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/ump/integral/productStatus?state="+status+"&validate_id="+id+"&validate_id_token="+token;
		}
	});
}
 
function WIremove(id,token,name){
	MConfirm('确定要删除积分商品<label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/ump/integral/remove?validate_id="+id+"&validate_id_token="+token;
		}
	});
} 
</script>