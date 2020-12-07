<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 订单列表 </span>
							</h4>
						</div>
					</div>  
				</div>
				<!-- /page header -->
				
				<!-- Content area -->
				<div class="content">
				 	<!-- Search field -->
					<div class="panel panel-flat" >
						<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/order/orderList"  method="post">
					
							<div class="panel-body"> 
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">商户名称</span> <input type="text"
											class="form-control" placeholder="" name="shop_name" value="${queryParam.shop_name}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">订单号</span> <input type="text"
											class="form-control" placeholder="" name="order_num" value="${queryParam.order_num}">
									</div>
								</div> 
								<div class="col-md-5">
									<div class="input-group">
										<span class="input-group-addon">订单时间</span>
										<div class="input-group">
											<input type="text" class="form-control pickadate-translated" name="startTime" id="startTime" value="${queryParam.startTime}">
											<span class="input-group-addon">--</span> 
											<input type="text" class="form-control pickadate-translated" name="endTime" id="endTime" value="${queryParam.endTime}">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							</div>
					 
							<div class="table-responsive">
								<table  id="data-table"  class="table">
									<thead>
										<tr > 
											<th>订单编号</th> 
											<th>下单时间</th> 
											<th>付款时间</th>
											<th>订单状态</th>
											<th>订单总额</th>
											<th>支付总额</th>
											<th>商户名称</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${pageInfo.list}" var="info">
					                    <tr>
					                        <td>${info.order_num}</td>
					                        <td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					                        <td><fmt:formatDate value="${info.pay_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					                        <td>
					                        	<c:if test="${info.state==0 }">待付款</c:if> 
												<c:if test="${info.state==1 }">待发货</c:if>
												<c:if test="${info.state==2 }">待收货</c:if> 
												<c:if test="${info.state==3 }">待评价</c:if>
												<c:if test="${info.state==4 }">交易完成</c:if>
												<c:if test="${info.state==-1 }">交易取消</c:if>
											</td>
					                        <td>${info.total_price}</td>
					                        <td>${info.pay_price}</td>
					                        <td>${info.shop_name}</td>
					                    </tr>
					                </c:forEach>
									</tbody>
								</table> 
								<div id="pager" class="panel-body"></div> 
							</div>
						</form>
					</div>
					
				</div>
				<!-- /content area -->
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
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
			
