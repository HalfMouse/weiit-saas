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
							<span>订单管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="orderList"><i class="icon-menu6"></i>所有订单</a></li>
								<li><a href="refundOrderList"><i class="icon-warning"></i>维权订单</a></li>
								<li><a href="starOrderList"><i class="icon-flag7"></i>加星订单</a></li>
								<li><a href="orderSet"><i class="icon-gear"></i>订单设置</a></li>
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
						<div class="page-title">
							<h4><i class="icon-home2 position-left"></i>所有订单</h4>
						</div>
			
						<div class="heading-elements">
							<div class="heading-btn-group">
								<a href="#" class="btn btn-link btn-float has-text"><i class="icon-bars-alt text-primary"></i><span>数据统计</span></a>
							</div>
						</div>
					</div>
				</div>
				<!-- /page header -->

	<!-- begin #content -->
	<div id="content" class="content">
		<!-- Invoice template -->
		<div class="panel panel-white">
			<div class="panel-heading">
				<h6 class="panel-title">订单详情</h6>
				<div class="heading-elements">
					<button type="button" class="btn btn-default btn-xs heading-btn">
						<a href="javascript:;" onclick="window.print()">
						<i class="fa fa-print m-r-5"></i> 打印</a>
					</button>
				</div>
			</div> 
			
			<div class="panel-body no-padding-bottom"> 
				<div class="row">
					<div class="col-md-12 ">
						<span style="font-weight: bold;">交易状态:</span>
						<span class="text-danger">
							<c:if test="${order.state==0 }">待付款</c:if> 
							<c:if test="${order.state==1 }">待发货</c:if>
							<c:if test="${order.state==2 }">待收货</c:if> 
							<c:if test="${order.state==3 }">待评价</c:if> 
							<c:if test="${order.state==4 }">交易完成</c:if> 
							<c:if test="${order.state==-1 }">交易取消</c:if>
						</span>
					</div>
					
					<div class="col-md-12 " style="margin-top:5px;">
						<span style="font-weight: bold;">订单信息:</span>
					</div> 
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						订单编号:${order.order_num }
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						用户下单时间:<fmt:formatDate value="${order.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						商品合计:${order.total_price }元
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						运费:${order.express_money }元
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						用户支付总价:${order.pay_price }元
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						优惠券: -${order.total_price-order.pay_price }元
					</div>
					<div class="text-muted col-md-12 " style="margin-top:5px;">
						用户支付方式： 
						<c:if test="${order.payment_type eq 0}">微信支付</c:if>
						<c:if test="${order.payment_type eq 1}">余额支付</c:if>
						<c:if test="${order.payment_type eq 2}">支付宝</c:if>
						<c:if test="${order.payment_type eq 3}">信用卡支付</c:if>
						<c:if test="${order.payment_type eq 4}">其他</c:if>
					</div> 
					
					<div class="col-md-12 " style="margin-top:5px;">
						<span style="font-weight: bold;">收货人信息:</span>
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						收货人:${order.consignee }
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						收货人手机号:${order.phone }
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						收货地址:${order.address }
					</div>
					
					<div class="col-md-12 " style="margin-top:5px;">
						<span style="font-weight: bold;">配送方式:</span>
						<c:if test="${order.express_type eq 0}">物流快递</c:if>
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						快递:${order.express_name }
					</div>
					<div class="text-muted col-md-6 " style="margin-top:5px;">
						物流单号:<a href="javascript:;" title="点击查看物流详细信息" 
							onclick="oncheckExpress('${order.express_num}','${order.express_code}')">
							${order.express_num}</a>
					</div> 
					
				</div>
			</div>

			<div class="table-responsive">
				<table class="table table-lg">
					<thead>
						<tr>
							<th>商品信息</th>
							<th class="col-sm-2">规格</th> 
							<th class="col-sm-1">市场价</th>
							<th class="col-sm-1">销售价</th>
							<th class="col-sm-1">数量</th>		
							<th class="col-sm-1">小计</th>
						</tr>
					</thead>
					<tbody>
					 <c:forEach items="${detail }" var="info">
						<tr>
							<td>
								<table>
									<tr>
									<td><img src="${imageDomain }${info.product_img}_300x300" width="80px" height="80px"></td>
									<td>${info.product_name }&nbsp;
										<c:if test="${info.state eq 0}"><span class="text-danger">(待审核)</span></c:if>
										<c:if test="${info.state eq 1 }"><span class="text-danger">(退换中)</span></c:if>
										<c:if test="${info.state eq 2 }"><span class="text-danger">(售后成功)</span></c:if> 
										<c:if test="${info.state eq -1 }"><span class="text-danger">(售后关闭)</span></c:if>
									</td>
									</tr>
								</table>
							</td>
							<td><span class="text-muted">规格:${info.spec_content }</span></td> 
							<td>￥${info.smarket_price }</td>
							<td>￥${info.sale_price }</td>
							<td>${info.count }</td>
							<td>￥${info.totalPrice }</td>
						</tr>
						 </c:forEach>
						
					</tbody>
				</table>
			</div>

			<div class="panel-body">
				<div class="row invoice-payment">
					

					<div class="col-sm-12">
						<div class="content-group">
							<div class="text-right">
								<h5 class="text-semibold">实际支付:<span class="text-semibold text-danger">￥${order.pay_price }</span></h5>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /invoice template -->

	</div>
	<!-- end #content -->

	</div>
	<!-- end Main content -->

<!-- 显示物流信息弹出框  -->
<%@include file="../publics/express.jsp" %>	
<%@include file="../common/footer.jsp" %> 
	
	
</body>
</html>

