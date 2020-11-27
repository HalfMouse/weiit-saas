<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/visualization/echarts/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/charts/echarts/charts.js"></script>

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
					<li class="active"><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-coin-yen"></i>我的资产</a></li>
					<li><a href="${pageContext.request.contextPath}/center/trade/list"><i class="icon-paste"></i>交易记录</a></li>
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
			<li class="active"><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-display position-left"></i> 我的收入</a></li>
		 	<li ><a href="${pageContext.request.contextPath}/center/trade/account/logList"><i class="icon-menu6 position-left"></i> 提现记录</a></li>
		 	<li ><a href="${pageContext.request.contextPath}/center/trade/account/list"><i class="icon-credit-card position-left"></i> 提现账户</a></li>
		</ul>
		<div class="row">
			<div class="col-md-12">	
				<!-- My messages -->
				<div class="panel panel-flat">
					<div class="panel-heading">
						<h6 class="panel-title">店铺收入</h6>
					</div>
					<!-- Numbers -->
					<div class="container-fluid">
						<div class="row text-center">
							<div class="col-md-3">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${orderInfo.income_amount}</h6>
									<span class="text-muted text-size-small">七天收入</span>
								</div>
							</div>
							<div class="col-md-3">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${orderInfo.settlement_amount}</h6>
									<span class="text-muted text-size-small">待结算</span>
								</div>
							</div> 
							<div class="col-md-3">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${orderInfo.shop_amount}</h6>
									<span class="text-muted text-size-small">可用余额</span>
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
					<h5 class="panel-title">近期交易记录</h5>
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
				label:['每日交易额'],
				xAxis:${times},
				data:[
	                    {
	                        name: '每日交易额',
	                        type: 'line', 
	                        data: ${allDatas}
	                    }
	                ]
			}
	}
	//渲染报表
	combination_connection_chart(data);
});
</script>