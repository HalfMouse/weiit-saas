<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/marketing/coupon/couponSendRecord" method="post" >						
<input type="hidden" name="couponId" id="couponId" value="${queryParam.couponId}"/>
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
	<!-- Page header -->
	<div class="page-header">
		<div class="breadcrumb-line">
			<ul class="breadcrumb">
				<li><a href="#"><i class="icon-home2 position-left"></i>营销插件</a></li> 
				<li class="active">优惠券活动</li>
			</ul> 
		</div>
	</div>
	
	<!-- Content area -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
			<div class="panel-heading">
				<h5 class="panel-title text-default text-bold" >优惠券派发记录</h5>
			</div>
			
			<div class="panel-body" style="padding:5px;margin:5px;">
				<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-addon bg-info-300">会员名</span>
						<input type="text" class="form-control" id="userName" name="userName" value="${queryParam.userName}">
					</div>
				</div>  
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>&nbsp;&nbsp;
				<a href="javascript:;" onclick="history()" id="qua1" class="btn btn-default" >返回</a>	
			</div>
				
			<div class="table-responsive">
				<table  id="data-table"  class="table table-striped table-hover table-bordered  nowrap dataTable">
					<thead>
						<tr > 
							<th>头像</th>
							<th>会员名</th>
							<th>优惠描述</th>
							<th>领取时间</th>	
							<th>使用时间</th>		
							<th>领取方式</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${pageInfo.list}" var="info">
	                    <tr>
	                        <td><img src="${info.user_img}" width="40" height="40"/></td>
							<td>${info.user_name }</td>
							<td>
							<c:if test="${info.type==1 }">
								<c:if test="${info.is_condition==-1 }">
									无条件减${info.coupon_price}元
							    </c:if>
							    <c:if test="${info.is_condition==1 }">
									满${info.condition_price}元减${info.coupon_price}元
							    </c:if>
							</c:if>
							<c:if test="${info.type==2 }">
								<c:if test="${info.is_condition==-1 }">
									无条件打${info.coupon_price}折
							    </c:if>
							    <c:if test="${info.is_condition==1 }">
									满${info.condition_price}元打${info.coupon_price}折
							    </c:if>
							</c:if>
							
							</td>
							<td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td><fmt:formatDate value="${info.update_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td style="height: 22px; padding-top: 6px; padding-bottom: 0px;">									
								商家派送												
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
 
function history(){
	window.location="${pageContext.request.contextPath}/center/marketing/coupon/list";	
}
</script>