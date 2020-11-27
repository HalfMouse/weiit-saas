<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/visualization/echarts/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/charts/echarts/charts.js"></script>

<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title"  style="height:70px;padding-top:20px;">
				<h4><i class="icon-home2 position-left"></i>数据统计</h4>
			</div>

			<div class="heading-elements">
				<div class="heading-btn-group">
					<a href="#" class="btn btn-link btn-float has-text"><i class="icon-bars-alt text-primary"></i><span>数据统计</span></a>
				</div>
			</div>
		</div>
	</div>
	<!-- /page header -->

	<!-- Content area -->
	<div class="content">
		<!-- Tabs -->
		<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
			<li><a href="${pageContext.request.contextPath}/center/analyse/dashboard"><i class="icon-display position-left"></i> 综合统计</a></li>
		 	<li class="active"><a href="${pageContext.request.contextPath}/center/dashboard/shopIndex"><i class="icon-coin-yen position-left"></i> 店铺概况</a></li>
			<li><a href="${pageContext.request.contextPath}/center/dashboard/orderIndex"><i class="icon-coin-yen position-left"></i> 订单概况</a></li>
			<li><a href="${pageContext.request.contextPath}/center/dashboard/userIndex"><i class="icon-users position-left"></i> 客户分析</a></li> 			
		</ul>
		<div class="row">
			<div class="col-md-12">	
				<!-- My messages -->
				<div class="panel panel-flat">
					<div class="panel-heading">
						<h6 class="panel-title">店铺概况</h6> 
					</div>
					<!-- Numbers -->
					<div class="container-fluid">
						<div class="row text-center">
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${empty browseMap?0:browseMap.browseCount}</h6>
									<span class="text-muted text-size-small">昨日浏览量</span>
								</div>
							</div>
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${empty browseMap?0:browseMap.userCount}</h6>
									<span class="text-muted text-size-small">昨日访客数</span>
								</div>
							</div> 
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${empty browseUserMap?0:browseUserMap.browseCount}</h6>
									<span class="text-muted text-size-small">昨日商品浏览量</span>
								</div>
							</div>
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${empty browseUserMap?0:browseUserMap.userCount}</h6>
									<span class="text-muted text-size-small">昨日商品访客数</span>
								</div>
							</div> 
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${empty pageCount?0:pageCount}</h6>
									<span class="text-muted text-size-small">微页面</span>
								</div>
							</div> 
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${empty productCount?0:productCount}</h6>
									<span class="text-muted text-size-small">商品</span>
								</div>
							</div> 
						</div>
					</div>
					<!-- /numbers -->
				</div>
				<!-- /my messages -->
			</div>
			 
		</div>
			
		<div class="col-md-12" style="padding:0px;margin:0px;">
			<!-- Stacked columns -->
			<div class="panel panel-flat">
				<div class="panel-heading" style="background-color:white;">
					<h5 class="panel-title">前10天流量趋势</h5>
					<div class="heading-elements">
						<ul class="icons-list">
							<li><a data-action="collapse"></a></li>
							<li><a data-action="reload"></a></li>
							<li><a data-action="close"></a></li>
						</ul>
					</div>
				</div>
		
				<div class="panel-body" style="padding-top:0px;margin-top:0px;">
					<div class="chart-container">
						<div class="chart has-fixed-height" id="stacked_lines"></div>
					</div>
				</div>
			</div>
			<!-- /stacked columns -->
		</div>
		
		<div class="col-md-12" style="padding:0px;margin:0px;">
			<!-- Stacked columns -->
			<div class="panel panel-flat">
				<div class="panel-heading" style="background-color:white;">
					<h5 class="panel-title">前10天浏览排行</h5>
					<div class="heading-elements">
						<ul class="icons-list">
							<li><a data-action="collapse"></a></li>
							<li><a data-action="reload"></a></li>
							<li><a data-action="close"></a></li>
						</ul>
					</div>
				</div>
		
				<div class="panel-body" style="padding-top:0px;margin-top:0px;">
					<div class="panel panel-flat"> 
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>页面名称</th>
										<th>浏览量</th> 
										<th>访客数</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pageList }" var="pro" varStatus="status">
										<tr>
					                         <td >${pro.page_name }</td> 
					                         <td >${pro.browseCount }</td>
					                         <td >${pro.userCount }</td>
					                    </tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- /stacked columns -->
			</div>
		</div>
 
	</div>  
	<!-- /Content area -->
</div>
<!-- /Main content --> 

<%@include file="../common/footer.jsp" %>
<script>
$(document).ready(function() {
 
	//报表数据结构
	var data={ 
			column:{
				div_id:"stacked_lines",
				label:['浏览量','访客数','商品浏览量','商品访客数'],
				xAxis:${times},
				data:[
	                    {
	                        name: '浏览量',
	                        type: 'line', 
	                        data: ${allDatas}
	                    },
	                    {
	                        name: '访客数',
	                        type: 'line', 
	                        data: ${userDatas}
	                    },
	                    {
	                        name: '商品浏览量',
	                        type: 'line', 
	                        data: ${allProductDatas}
	                    },
	                    {
	                        name: '商品访客数',
	                        type: 'line', 
	                        data: ${userProductDatas}
	                    }
	                ]
			}
	}
	//渲染报表
	combination_connection_chart(data);
});
</script>