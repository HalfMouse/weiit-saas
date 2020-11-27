<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

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
					<li class="active"><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-menu6"></i>我的资产</a></li>
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
						<li><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-display position-left"></i> 我的收入</a></li>
					 	<li><a href="${pageContext.request.contextPath}/center/trade/account/logList"><i class="icon-menu6 position-left"></i> 提现记录</a></li>
					 	<li class="active"><a href="${pageContext.request.contextPath}/center/trade/account/list"><i class="icon-credit-card position-left"></i> 提现账户</a></li>
					</ul>
					<!-- /tabs -->
				
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">
								<div class="panel-body">
									<div style="float:left;">
										<a href="${pageContext.request.contextPath}/center/trade/account/add" class="btn bg-blue">新增账户</a>
									</div> 	
								</div>
								<form class="form-horizontal"  name="searchform" id="searchform" action="" method="post" >	
									<div class="table-responsive">
										<table  id="data-table"  class="table">
											<thead>
												<tr > 
													<th>账户类型</th>
													<th>名称</th>
													<th>账户账号</th>
													<th>备注</th>
													<th width="80">操作</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${pageInfo.list}" var="info">
							                    <tr>
							                        <td>
								                        <c:if test="${info.type ==1}">微信</c:if>
							                           	<c:if test="${info.type ==2}">支付宝</c:if>
														<c:if test="${info.type ==3}">银行卡</c:if>
													</td>
							                        <td>${info.account_name}</td>  
							                        <td>${info.account}</td>
							                        <td>${info.remark}</td>
							                        <td>
														<ul class="icons-list">
															<li><a href="${pageContext.request.contextPath}/center/trade/account/edit?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" title="编辑" >
																<i class="icon-pencil7"></i></a></li>
								                           	<li><a href="javascript:;" title="删除" onclick="WIremove('${info.validate_id}','${info.validate_id_token}','${info.contact_name}')" >
																<i class="icon-trash"></i></a></li>
														</ul>
													</td>
							                    </tr>
							                </c:forEach>
											</tbody>
										</table>
									</div>
									<div id="pager" class="panel-body"></div>
								 </form>
							</div>
							<!-- /form validation -->
						</div>
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
 
 
function WIremove(id,validate_id_token,name){
	MConfirm('确定要删除账户 <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/trade/account/remove?validate_id="+id+"&validate_id_token="+validate_id_token;
		}
	});
}

  </script>
			
