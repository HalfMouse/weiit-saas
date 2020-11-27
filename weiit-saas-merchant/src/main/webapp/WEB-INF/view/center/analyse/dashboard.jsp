<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/plugins/visualization/echarts/echarts.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/charts/echarts/charts.js"></script>
<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height: 70px; padding-top: 20px;">
				<h4>
					<i class="icon-home2 position-left"></i>数据统计
				</h4>
			</div>

			<div class="heading-elements">
				<div class="heading-btn-group">
					<a href="#" class="btn btn-link btn-float has-text"><i
						class="icon-bars-alt text-primary"></i><span>数据统计</span></a>
				</div>
			</div>
		</div>
	</div>
	<!-- /page header -->

	<!-- Content area -->
	<div class="content">
		<!-- Tabs -->
		<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
			<li class="active"><a
				href="${pageContext.request.contextPath}/center/analyse/dashboard"><i
					class="icon-display position-left"></i> 综合统计</a></li>
			<li><a
				href="${pageContext.request.contextPath}/center/dashboard/shopIndex"><i
					class="icon-coin-yen position-left"></i> 店铺概况</a></li>
			<li><a
				href="${pageContext.request.contextPath}/center/dashboard/orderIndex"><i
					class="icon-coin-yen position-left"></i> 订单概况</a></li>
			<li><a
				href="${pageContext.request.contextPath}/center/dashboard/userIndex"><i
					class="icon-users position-left"></i> 客户分析</a></li>
		</ul>
		<!-- /tabs -->
		<div class="row">
			<div class="col-md-3">
				<!-- Members online -->
				<div class="panel bg-teal-400">
					<div class="panel-body">
						<div class="heading-elements">
							<span class="heading-text badge bg-teal-800">+53,6%</span>
						</div>
						<h3 class="no-margin">${baseReport.user_total }个</h3>
						会员用户
						<div class="text-muted text-size-small">注册用户总数</div>
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
						<h3 class="no-margin">￥${baseReport.sale_total }元</h3>
						交易总额
						<div class="text-muted text-size-small">交易订单总额</div>
					</div>
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
						<h3 class="no-margin">${baseReport.order_total }笔</h3>
						交易笔数
						<div class="text-muted text-size-small">支付成功的订单</div>
					</div>
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

						<h3 class="no-margin">${baseReport.current_month_deal}笔</h3>
						交易笔数
						<div class="text-muted text-size-small">单月成交笔数</div>
					</div>

				</div>
				<!-- /today's revenue -->
			</div>
		</div>

		<!-- User profile -->
		<div class="row">
			<div class="col-md-12">
				<div class="tabbable">
					<div class="tab-content">
						<div class="tab-pane fade in active" id="activity">

							<!-- Combination and connection -->
							<div class="panel panel-flat">
								<div class="panel-heading">
									<h5 class="panel-title">整体数据统计</h5>
									<div class="heading-elements">
										<ul class="icons-list">
											<li><a data-action="collapse"></a></li>
											<li><a data-action="reload"></a></li>
											<li><a data-action="close"></a></li>
										</ul>
									</div>
								</div>

								<div class="panel-body">
									<div class="row">
										<div class="col-md-12">
											<div class="chart-container">
												<div class="chart has-fixed-height" id="connect_column"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- /combination and connection -->
							
							<!-- Combination and connection -->
							<div class="panel panel-flat">
								<div class="panel-heading">
									<h5 class="panel-title">排名统计</h5>
									<div class="heading-elements">
										<ul class="icons-list">
											<li><a data-action="collapse"></a></li>
											<li><a data-action="reload"></a></li>
											<li><a data-action="close"></a></li>
										</ul>
									</div>
								</div>

								<div class="panel-body">
									<div class="row">

										<div class="col-md-12">
											<!-- Hover rows -->
											<div class="panel panel-flat">
												<div class="panel-heading">
													<h5 class="panel-title">交易排名</h5>
												</div>
												<div class="table-responsive">
													<table class="table table-hover">
														<thead>
															<tr>
																<th>排序</th>
																<th>交易内容</th>
																<th>真实销售</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${hotProductList }" var="pro"
																varStatus="status">
																<tr>
																	<td>${status.index+1 }</td>
																	<td>${pro.product_name }</td>
																	<td>${pro.true_sale_total }</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
											<!-- /hover rows -->
										</div>

									</div>
								</div>
							</div>
							<!-- /combination and connection -->


						</div>

					</div>
				</div>
			</div>


		</div>
		<!-- /user profile -->



	</div>
	<!-- /content area -->

</div>

<!-- /main content -->
<%@include file="../common/footer.jsp"%>
<script>
			$(document).ready(function() {
				
				//报表数据结构
				var data={ 
						column:{
							div_id:"connect_column",
							label:['用户数','订单总额'],
							xAxis:['一月份','二月份','三月份','四月份','五月份','六月份','七月份','八月份','九月份','十月份','十一月','十二月'],
							data:[
				                    {
				                        name: '用户数',
				                        type: 'bar',
				                        stack: 'Total',
				                        data: [
				                               ${registerUserArray[0]},
				                               ${registerUserArray[1]},
				                               ${registerUserArray[2]},
				                               ${registerUserArray[3]},
				                               ${registerUserArray[4]},
				                               ${registerUserArray[5]},
				                               ${registerUserArray[6]},
				                               ${registerUserArray[7]},
				                               ${registerUserArray[8]},
				                               ${registerUserArray[9]},
				                               ${registerUserArray[10]},
				                               ${registerUserArray[11]}
				                              ]
				                    },
				                    {
				                        name: '订单总额',
				                        type: 'bar',
				                        stack: 'Total',
				                        data: [
				                               ${saleTotalArray[0]},
				                               ${saleTotalArray[1]},
				                               ${saleTotalArray[2]},
				                               ${saleTotalArray[3]},
				                               ${saleTotalArray[4]},
				                               ${saleTotalArray[5]},
				                               ${saleTotalArray[6]},
				                               ${saleTotalArray[7]},
				                               ${saleTotalArray[8]},
				                               ${saleTotalArray[9]},
				                               ${saleTotalArray[10]},
				                               ${saleTotalArray[11]}
				                              ]
				                    }
				                ]
						}
				}
				//渲染报表
				combination_connection_chart(data);
			});
			</script>
