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
								<li><a href="${pageContext.request.contextPath}/center/trade/tradeIndex"><i class="icon-menu6"></i>我的资产</a></li>
								<li><a href="${pageContext.request.contextPath}/center/trade/list"><i class="icon-paste"></i>交易记录</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/trade/bill/batchList"><i class="icon-library2"></i>对账单</a></li>
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
					<li class="active"><a href="${pageContext.request.contextPath}/center/trade/bill/batchList"><i class="icon-display position-left"></i> 账单汇总</a></li>
				 	<li><a href="${pageContext.request.contextPath}/center/trade/bill/list"><i class="icon-menu6 position-left"></i> 账单明细</a></li>
				</ul>
				<!-- Tabs -->
				
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-flat">
							<div class="panel-heading">
								<h4 class="panel-title text-center">
								<c:if test="${batchInfo.batch_type eq 0}">
	                        		<fmt:formatDate value="${batchInfo.batch_date }" pattern="yyyy年MM月dd"/>
	                        	</c:if>
								<c:if test="${batchInfo.batch_type eq 1}">
									<fmt:formatDate value="${batchInfo.batch_date }" pattern="yyyy年MM月"/>
								</c:if>汇总账单</h4>
							</div>
							<div class="panel-body">
								<div class="col-md-5 text-bold ">
									 店铺名称： ${batchInfo.shop_name}
								</div><br/><br/>
								<div class="col-md-5 text-bold ">
									 起始日期： <fmt:formatDate value="${batchInfo.start_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</div>
								<div class="col-md-5 text-bold ">
									终止日期： <fmt:formatDate value="${batchInfo.end_date }" pattern="yyyy-MM-dd HH:mm:ss"/>
								</div>
								<br/>
								<hr> 
								<div class="table-responsive">
									<table  id="data-table"  class="table table-bordered ">
										<thead>
											<tr style="background: #EAF8FF"> 
												<th>上期余额</th>
												<th>本期收入</th>
												<th>本期支出</th>
												<th>本期余额</th>
											</tr>
										</thead>
										<tbody>
						                    <tr>
						                    	<td>${batchInfo.balance+batchInfo.pay_amount-batchInfo.income_amount}</td>
						                        <td>${batchInfo.income_amount}</td>
						                        <td>${batchInfo.pay_amount}</td>
						                        <td>${batchInfo.balance}</td>
						                    </tr>
										</tbody>
									</table>
								</div>
								<br/>
								<div class="table-responsive col-md-6" style="padding:0px;padding-right:10px;">
									<table  id="data-table"  class="table table-bordered ">
										<thead>
											<tr style="background: #EAF8FF"> 
												<th>本期收入</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${billList}" var="info">
											<c:if test="${info.amount>0}">
						                    <tr>
						                    	<td>
						                    		<div class="col-md-5 text-bold ">
														<c:if test="${info.bill_type ==0}">订单入账</c:if>
							                           	<c:if test="${info.bill_type ==1}">提现</c:if>
														<c:if test="${info.bill_type ==2}">退款</c:if>
													</div>
													<div class="col-md-5 text-bold text-right">
														${info.amount}
													</div>
						                    	</td>   
						                    </tr>
						                	</c:if>
						                </c:forEach>
						                	<tr>
						                    	<td>
						                    		<div class="col-md-5 text-bold ">
														合计收入
													</div>
													<div class="col-md-5 text-bold text-right">
														<span class="text-success">${batchInfo.income_amount}</span>
													</div>
						                    	</td>   
						                    </tr>
										</tbody>
									</table>
								</div>
								<div class="table-responsive col-md-6" style="padding:0px;padding-left:10px;">
									<table  id="data-table"  class="table table-bordered ">
										<thead>
											<tr style="background: #EAF8FF"> 
												<th>本期支出</th>
											</tr>
										</thead>
										<tbody> 
						                <c:forEach items="${billList}" var="info">
											<c:if test="${info.amount<0}">
						                    <tr>
						                    	<td>
						                    		<div class="col-md-5 text-bold ">
														<c:if test="${info.bill_type ==0}">订单入账</c:if>
							                           	<c:if test="${info.bill_type ==1}">提现</c:if>
														<c:if test="${info.bill_type ==2}">退款</c:if>
													</div>
													<div class="col-md-5 text-bold text-right">
														${info.amount}
													</div>
						                    	</td>   
						                    </tr>
						                	</c:if>
						                </c:forEach>
						                	<tr>
						                    	<td>
						                    		<div class="col-md-5 text-bold ">
														合计支出
													</div>
													<div class="col-md-5 text-bold text-right">
														<span class="text-warning">${batchInfo.pay_amount}</span>
													</div>
						                    	</td>   
						                    </tr>
										</tbody>
									</table>
								</div>
							</div>
									
							<div class="text-center">
								<button type="button" onclick="window.print()" class="btn btn-primary">打印</button>
								&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)" id="qua1" class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
							</div>
							<br/><br/><br/>
						</div>
					</div>
				</div>
				
			</div>
			<!-- /content area -->
			
		</div>
		
		<!-- /main content -->
		<%@include file="../common/footer.jsp" %>