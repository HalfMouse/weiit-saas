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
								<li class="active"><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<%--<li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>--%>
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
						<div class="page-title"  style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 砍价活动记录 </span>
							</h4>
						</div>
					</div> 
				</div>
				<!-- /page header -->
			
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" 
								action="" method="post">
								<div style="margin-left: -10px;">
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">订单编号</span> <input type="text" class="form-control" name="order_num" value="${queryParam.order_num }">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>&nbsp;&nbsp;&nbsp;
								<a href="${pageContext.request.contextPath}/center/ump/bargain/bargainList" id="qua1" class="btn btn-default" ><i class="icon-arrow-left7"></i>返回</a>
								<br> <br>
								<div class="table-responsive">
									<table id="data-table" class="table">
										 <thead>
											<tr > 
												<th>用户</th>
												<th>原始价格</th>
												<th>支付金额</th>
												<th>创建时间</th>
												<th>支付时间</th>
												<th>订单编号</th>
												<th>砍价状态</th> 
												<th>操作</th> 
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${pageInfo.list}" var="info">
						                    <tr>
						                        <td><img src="${info.user_img}" width="40" height="40"/>&nbsp;&nbsp;${info.user_name}</td>

						                        <td>￥${info.max_price}</td>
												<td><c:if test="${info.state == 1 }"><span class="text-green">￥${info.pay_price}</span></c:if><c:if test="${info.state == 0}"><span class="text-danger">￥${info.pay_price}</span></c:if></td>
						                        <td><fmt:formatDate value="${info.start_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td><fmt:formatDate value="${info.pay_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td><a href="${pageContext.request.contextPath}/center/order/orderDetail?order_id=${info.order_id}" class="text-blue text-bold">${info.order_num}</a></td>   
												<td>
													<c:if test="${info.state == 0 }"><span class="text-orange-800">砍价中</span></c:if>
													<c:if test="${info.state == 1 }"><span class="text-blue">成功</span></c:if>
						                           	<c:if test="${info.state == -1 }"><span class="text-danger">失败</span></c:if>
												</td>
												<td>
													<a href="${pageContext.request.contextPath}/center/ump/bargain/bargainNancyList?validate_id_token=${queryParam.validate_id_token}&validate_id=${queryParam.validate_id}&b_order_id=${info.validate_id}" title="点击查看详情" >
														查看参与者</a>
												</td>
						                    </tr>
						                </c:forEach>
									</table>
			
								</div>
								<div id="pager" class="panel-body">  
								</div>
							</form>
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			
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
						
