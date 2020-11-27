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
				
				<ul class="nav nav-lg nav-tabs">
					<li class="<c:if test="${ empty queryParam.flag}">active</c:if>"><a href="${pageContext.request.contextPath}/center/trade/bill/batchList"> 日汇总</a></li>
				 	<li class="<c:if test="${ !empty queryParam.flag}">active</c:if>"><a href="${pageContext.request.contextPath}/center/trade/bill/batchList?flag=1"> 月汇总</a></li>
				</ul>
				<!-- /tabs --> 
				<div class="row">
					<div class="col-md-12">
						<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/trade/bill/batchList?flag=${queryParam.flag}"  method="post">
						<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
							<div class="panel-body">
								<c:if test="${ empty queryParam.flag}">
								<div class="col-md-4" >
									<div class="input-group">
										<span class="input-group-addon">月</span>
										<input type="text" class="form-control pickadate-translatedaa" name="batch_date" id="batch_date" value="${queryParam.batch_date}">
									</div>
								</div>
								</c:if>
								<c:if test="${ !empty queryParam.flag}">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">年</span>
										 <select class="select" data-width="100%" name="batch_date" id="batch_date">
											<option value="2018" <c:if test="${queryParam.batch_date=='2018' }">selected="selected"</c:if>>2018</option>
											<option value="2019" <c:if test="${queryParam.batch_date=='2019' }">selected="selected"</c:if>>2019</option>
											<option value="2020" <c:if test="${queryParam.batch_date=='2020' }">selected="selected"</c:if>>2020</option>
											<option value="2021" <c:if test="${queryParam.batch_date=='2021' }">selected="selected"</c:if>>2021</option>
											<option value="2022" <c:if test="${queryParam.batch_date=='2022' }">selected="selected"</c:if>>2022</option>
										</select>
									</div>
								</div>
								</c:if>
								<div class="col-md-1">
									<div class="input-group">
									<button class="btn bg-blue" type="submit">查询</button>
									</div>
								</div>
							</div>
							<div class="table-responsive">
								<table  id="data-table"  class="table">
									<thead>
										<tr > 
											<th>
												<c:if test="${ empty queryParam.flag}">结算日期</c:if>
												<c:if test="${ !empty queryParam.flag}">结算月份</c:if>
											</th>
											<th>收入笔数（元）</th>
											<th>收入金额（元）</th>
											<th>支出笔数（元）</th>
											<th>支出金额（元）</th>
											<th>余额（元）</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${batchlist}" var="info">
					                    <tr>
					                        <td>
					                        	<c:if test="${ empty queryParam.flag}">
					                        		<fmt:formatDate value="${info.batch_date }" pattern="yyyy-MM-dd"/>
					                        	</c:if>
												<c:if test="${ !empty queryParam.flag}">
													<fmt:formatDate value="${info.batch_date }" pattern="yyyy-MM"/>
												</c:if>
					                        </td>
					                        <td>${info.income_count}</td>
					                        <td>${info.income_amount}</td>
					                        <td>${info.pay_count}</td> 
					                        <td>${info.pay_amount}</td>
					                        <td>${info.balance}</td>
					                        <td>
												<a href="${pageContext.request.contextPath}/center/trade/bill/batchDetail?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" 
													title="查看详情" >详情</a>
											</td>
					                    </tr>
					                </c:forEach>
									</tbody>
								</table>
							</div>
							<div id="pager" class="panel-body"></div>
						</div>
						<!-- /form validation -->
						</form>
					</div>
				</div>
				
			</div>
			<!-- /content area -->
			
		</div>
		
		<!-- /main content -->
		<%@include file="../common/footer.jsp" %>
<script> 
$(document).ready(function() {
	
    $('.pickadate-translatedaa').pickadate({
    	format: 'yyyy-mm',
        monthsFull: ['01月', '02月', '03月', '04月', '05月', '06月', '07月', '08月', '09月', '10月', '11月', '12月'],
        weekdaysShort: ['日', '一', '二', '三', '四', '五', '六'],
        today: '今天',
        clear: '清除',
		close:'关闭',
		labelMonthSelect: '选择月份',
        labelYearSelect: '选择年份',
		labelMonthNext: '下一月',
        labelMonthPrev: '上个月',
        formatSubmit: 'yyyy/mm',
		selectYears: true,
        selectMonths: true
    });
     
}); 
 
  </script>
			
