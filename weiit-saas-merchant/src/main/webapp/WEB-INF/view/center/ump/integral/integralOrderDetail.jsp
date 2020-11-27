<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
<link href="${pageContext.request.contextPath}/resource/css/style.min.css" rel="stylesheet" />
	
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

	<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			
			<!-- begin invoice -->
			<div class="invoice">
                <div class="invoice-company">
                    <span class="pull-right hidden-print">
                    
                    <a href="javascript:;" onclick="window.print()" class="btn btn-sm btn-success m-b-10"><i class="fa fa-print m-r-5"></i> 打印</a>
                    </span>
                                                                           送货信息
                </div>
                <div class="invoice-header">
                    <div class="invoice-from" style="padding-left: 30px;">
                        <strong>买家信息</strong>
                        <address class="m-t-5 m-b-5">
                            <span>收件人:${order.consignee }</span><br />
                            <span>手机号码：${order.phone }</span><br />
                            <span>收货地址：${order.address } </span><br />  
                        </address>
                    </div>
                   
                        
                    <div class="invoice-from" style="padding-right: 30px;">
						 <strong>物流信息</strong>
						 <address class="m-t-5 m-b-5">
						物流公司名称：${order.express_name }<br>
						配送方式：<c:if test="${order.express_type== 0}">快递</c:if>
						<c:if test="${order.express_type== 1}">货到付款</c:if>
						<c:if test="${order.express_type== 2}">上门取货</c:if><br>
						物流单号：
						<c:if test="${!empty order.express_num }">
							<a href="javascript:;" title="点击查看物流详细信息" 
								onclick="oncheckExpress('${order.express_num}','${order.express_code}')">${order.express_num }</a>
						</c:if>
			         	<br />
				                       物流费用：￥${order.express_price }<br>
                        </address>
                    </div>
                   
                </div>
                <div class="invoice-content">
                    <div class="table-responsive">
						<table class="table table-invoice">
							  <tr style="background:#EAF8FF">
                            		<td colspan="5">订单编号：${order.orderNum }  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                       
                            		                           创建时间：<fmt:formatDate value="${order.createdTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            </tr>
						</table>
                        <table class="table table-invoice">
                            <thead>                    
                                <tr>
                                    <th>商品</th>
                                    <th>单价</th>
                                    <th>兑换所需积分</th>
                                </tr>
                            </thead>
                            <tbody> 
                                <tr>
                                    <td>
                                        <img src="${imageDomain }/${order.product_img }" width="80px;" height="60px;">${order.product_name }
                                    </td>
                                    <td>￥${order.pay_price }</td>
                                    <td>${order.integral }</td>
                                </tr>
                            </tbody>
                        </table>
                    </div> 
                    
                    <div class="invoice-price">
                        <div class="invoice-price-left">
                            <div class="invoice-price-row">
                                <div class="sub-price">
                                    <small>订单金额</small>
                                                                                                                                  ￥${order.pay_price }
                                </div>
                                <div class="sub-price">
                                    <i class="fa fa-plus"></i>
                                </div>
                                <div class="sub-price">
                                    <small>物流费用 </small>
                                                                                                                                 ￥${order.express_price }
                                </div>
                            </div>
                        </div>
                       
                        <div class="invoice-price-right">
                            <small>总共</small> ￥${order.TotalPrice }
                        </div>
                    </div>
                   
                </div>
               
            </div>
			<!-- end invoice -->
		</div>
		<!-- end #content -->
</div>

<!-- 显示物流信息弹出框  -->
<%@include file="../../publics/express.jsp" %>

<%@include file="../../common/footer.jsp" %> 
 

