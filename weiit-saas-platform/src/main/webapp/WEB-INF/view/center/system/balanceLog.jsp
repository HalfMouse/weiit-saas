<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>

<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<div class="panel panel-flat">
					<div class="panel-heading">
						<h6 class="panel-title">可用余额</h6>
						<h1 class="text-bold text-muted">
							<fmt:formatNumber type="number" value="${sessionScope.last_balance }" pattern="0.00" maxFractionDigits="2"/>元 <a href="${pageContext.request.contextPath}/center/manager/balanceRecharge"  class="btn bg-orange"> 立即充值</a>
						</h1>
					</div>

				</div>

				<div class="panel panel-flat">
					<div class="panel-heading">
						<h5 class="panel-title">收支明细</h5>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" name="searchform" id="searchform"
							action="${pageContext.request.contextPath}/center/manager/balanceLog"
							method="post">

							<div class="table-responsive">
								<table id="data-table" class="table">
									<thead>
										<tr>
											<th>编号</th>
											<th>变动金额</th>
											<th>变动后金额</th>
											<th>类型</th>
											<th>时间</th>
											<th>明细</th>
										</tr>
									</thead>
									<c:forEach items="${balanceList }" var="b">
										<tr>
											<td>${b.num }</td>
											<td><c:if test="${b.state==1 }">
													<span class='text-success text-bold'>+${b.balance }</span>
												</c:if> 
												<c:if test="${b.state==-1 }">
													<span class='text-danger text-bold'>-${b.balance }</span>
												</c:if>
											</td>
											<td><span class='text-success text-bold'>${b.last_balance }</span></td>
											<td><c:if test="${b.type=='1' }">预存</c:if> 
												<c:if test="${b.type=='2' }">消费</c:if> 
												<c:if test="${b.type=='3' }">充值</c:if>
											</td>
											<td>${b.create_time }</td>
											<td>${b.remark }</td>
										</tr>
									</c:forEach>


								</table>

							</div>
							<br>
							<br>
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- /page header -->

</div>
<!-- /main content -->

<%@include file="../common/footer.jsp"%>

