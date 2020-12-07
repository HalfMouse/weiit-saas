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
				<h4><i class="icon-home2 position-left"></i>首页概况</h4>
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
	
		<div class="row">
			<div class="col-md-3">
				<!-- Members online -->
				<div class="panel bg-teal-400">
					<div class="panel-body">
						<div class="heading-elements">
							<ul class="icons-list">
					              <li><a data-action="reload"></a></li>
					        </ul>
				        </div>
						<h3 class="no-margin">${empty countMap?0:countMap.shop_count}个</h3>
						入驻商家
						<div class="text-muted text-size-small">入驻商家总数</div>
					</div>
					<div class="container-fluid">
						<div id="members-online"></div>
					</div>
				</div>
				<!-- /members online -->
			</div>
			
			<div class="col-md-3">
				<!-- Today's revenue -->
				<div class="panel bg-blue-400">
					<div class="panel-body">
						<div class="heading-elements">
							<ul class="icons-list">
					              <li><a data-action="reload"></a></li>
					        </ul>
				        </div>
						<h3 class="no-margin">￥${empty countMap?0:countMap.user_count}个</h3>
						会员用户
						<div class="text-muted text-size-small">商家会员总数</div>
					</div>
					<div id="today-revenue"></div>
				</div>
				<!-- /today's revenue -->
			</div>
			
			<div class="col-md-3">
				<!-- Today's revenue -->
				<div class="panel bg-pink-400">
					<div class="panel-body">
						<div class="heading-elements">
							<ul class="icons-list">
					              <li><a data-action="reload"></a></li>
					        </ul>
				        </div>
						<h3 class="no-margin">${empty countMap?0:countMap.order_count}笔</h3>
						交易笔数
						<div class="text-muted text-size-small">商家交易笔数</div>
					</div>
					<div id="today-revenue"></div>
				</div>
				<!-- /today's revenue -->
			</div>

			<div class="col-md-3">
				<!-- Today's revenue -->
				<div class="panel bg-orange-400">
					<div class="panel-body">
						<div class="heading-elements">
							<ul class="icons-list">
					              <li><a data-action="reload"></a></li>
					        </ul>
				        </div>
						<h3 class="no-margin">${empty countMap.price_sum?0:countMap.price_sum}元</h3>
						交易总额
						<div class="text-muted text-size-small">交易交易总额</div>
					</div>
					<div id="today-revenue"></div>
				</div>
				<!-- /today's revenue -->
			</div>
		</div>
			
		<div class="col-md-12" style="padding:0px;margin:0px;">
			<!-- Stacked columns -->
			<div class="panel panel-flat">
				<div class="panel-heading" style="background-color:white;">
					<h5 class="panel-title">前10天交易趋势</h5>
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
					<h5 class="panel-title">近30天商户交易前10排行</h5>
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
										<th>序号</th>
										<th>商家名称</th>
										<th>交易笔数</th> 
										<th>交易金额</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${shopList }" var="pro" varStatus="status">
										<tr>
											<td >${status.count }</td> 
					                         <td >${pro.shop_name }</td> 
					                         <td >${pro.payCount }</td>
					                         <td >${pro.paySum }</td>
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
				label:['付款订单','付款金额'],
				xAxis:${times},
				data:[
	                    {
	                        name: '付款订单',
	                        type: 'line', 
	                        data: ${countDatas}
	                    },
	                    {
	                        name: '付款金额',
	                        type: 'line', 
	                        data: ${sumDatas}
	                    }
	                ]
			}
	}
	//渲染报表
	combination_connection_chart(data);
});
</script>