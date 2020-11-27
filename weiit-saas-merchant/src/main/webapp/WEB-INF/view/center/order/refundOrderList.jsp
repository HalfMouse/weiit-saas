<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/header.jsp"%>
 
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
								<li><a href="orderList"><i class="icon-menu6"></i>所有订单</a></li>
								<li class="active"><a href="refundOrderList"><i class="icon-warning"></i>维权订单</a></li>
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
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4><i class="icon-home2 position-left"></i>维权订单</h4>
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
						<li <c:if test="${empty queryParam.state }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList"><i class="icon-grid5 position-left"></i>全部</a></li>
						<li <c:if test="${!empty queryParam.state and queryParam.state==0 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=0"><i class="icon-cart5 position-left"></i>待审核</a></li>
						<li <c:if test="${queryParam.state==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=1"><i class="icon-truck position-left"></i>待退货</a></li>
						<li <c:if test="${queryParam.state==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=2"><i class="icon-file-check position-left"></i>待同意退换</a></li>
						<li <c:if test="${queryParam.state==3 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=3"><i class="icon-file-check position-left"></i>退换完成</a></li>
						<li <c:if test="${queryParam.state==4 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=4"><i class="icon-file-check position-left"></i>已驳回</a></li>
						<li <c:if test="${queryParam.state==-1 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=-1"><i class="icon-cancel-circle2 position-left"></i>退换关闭</a></li>
					</ul>
					<!-- /tabs -->
					<!-- Search field -->
					<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/order/refundOrderList"  method="post">
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<div class="row">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">订单号：</span> <input type="text"
											class="form-control" placeholder="" name="order_num" value="${queryParam.order_num}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">退款号：</span> <input type="text"
											class="form-control" placeholder="" name="refund_num" value="${queryParam.refund_num}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">状态</span>
										 <select class="bootstrap-select" data-width="100%" name="state"id="state">
											<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--全部--</option>
											<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>待审核</option>
											<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>待退货</option>
											<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>待同意退换</option> 
											<option value="3" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>退换完成</option> 
											<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>已驳回</option> 
											<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>退换关闭</option>
										</select>
									</div>
								</div>
								<br>
								<br>
								<br>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">会员号：</span> <input type="text"
											class="form-control" placeholder="" name="user_name" value="${queryParam.user_name}">
									</div>
								</div>
								<div class="col-md-5">
									<div class="input-group">
										<span class="input-group-addon">订单时间</span>
										<div class="input-group">
											<input type="text" class="form-control pickadate-translated" name="startTime" id="startTime" onchange="judgeDate()" value="${queryParam.startTime}">
											<span class="input-group-addon">--</span> 
											<input type="text" class="form-control pickadate-translated" name="endTime" id="endTime" onchange="judgeDate()" value="${queryParam.endTime}">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							</div>
						</div>
					</div>
					<!-- /search field -->
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
						<div class="table-responsive">
							<table id="data-table" class="table">
								<thead>
									<tr>
										<th class="col-xs-3">商品详情</th>
										<th class="col-xs-1">退款金额</th>
										<th class="col-xs-1">用户账户</th> 
										<th class="col-xs-1">服务类型</th>
										<th class="col-xs-1">退款状态</th>
										<th class="col-xs-1">交易操作</th>
									</tr>
								</thead>
								<tbody>
								
								<c:forEach items="${pageInfo.list}" var="info">
									<tr>
										<td colspan="8"  style="border-right:0px;">
										<span class="text-muted">订单编号:&nbsp;${info.order_num }  </span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="text-muted">退款编号:&nbsp;${info.refund_num }  </span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="text-muted">申请时间:</span>&nbsp;<span class="text-success text-bold"> <fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
												<td><img src="${imageDomain }${info.product_img}_300x300" width="80px" height="80px"></td>
												<td>${info.product_name }
													<br/>规格：${info.spec_content }
												</td>
												</tr>
											</table>
										</td>
										<td><span class="text-danger">￥${info.refund_money }</span></td> 
										<td>${info.user_name}</td> 
										<td><span class="text-danger">
											<c:if test="${info.refund_type==1 }">仅退款</c:if> 
											<c:if test="${info.refund_type==2 }">退货退款</c:if></span>
										</td>
										<td><span class="text-success">
											<c:if test="${info.state==0 }">待审核</c:if>
											<c:if test="${info.state==1 }">待退货</c:if>
											<c:if test="${info.state==2 }">待同意退换</c:if>
											<c:if test="${info.state==3 }">退换完成</c:if>
											<c:if test="${info.state==4 }">已驳回</c:if>
											<c:if test="${info.state==-1 }">退换关闭</c:if></span>
										</td>
										<td>
											<a href="${pageContext.request.contextPath}/center/order/refundOrderDetail?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" 
												title="服务详情" class="text-danger">服务详情</a>
										</td>
									</tr> 
								</c:forEach>	 	
										  
								</tbody>
							</table>
			
						</div>
						
						<div id="pager" class="panel-body">												
						</div>
					</div>
					
					</form>
			            
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			 
			<%@include file="../common/footer.jsp"%>
			<script>
			$(document).ready(function() {
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			});
			</script>