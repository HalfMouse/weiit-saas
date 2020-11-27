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
					<li><a href="${pageContext.request.contextPath}/center/trade/bill/batchList"><i class="icon-display position-left"></i> 账单汇总</a></li>
				 	<li class="active"><a href="${pageContext.request.contextPath}/center/trade/bill/list"><i class="icon-menu6 position-left"></i> 账单明细</a></li>
				</ul>
				<!-- /tabs --> 
				<div class="row">
					<div class="col-md-12">
						<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/trade/bill/list"  method="post">
						<div class="panel panel-flat">
							<div class="panel-body">
								<div class="col-md-6" >
									<div class="input-group">
										<span class="input-group-addon">起止时间</span>
										<div class="input-group">
											<input type="text" class="form-control pickadate-translated" name="startTime" id="start_time" onchange="judgeDate(1)" value="${queryParam.startTime}">
											<span class="input-group-addon"> 至 </span> 
											<input type="text" class="form-control pickadate-translated" name="endTime" id="end_time" onchange="judgeDate(2)" value="${queryParam.endTime}">
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="input-group">
									<button class="btn" id="but11" type="button" onclick="timeEdit(7)">7天</button>&nbsp;
									<button class="btn" id="but22" type="button" onclick="timeEdit(15)">15天</button>&nbsp;
									<button class="btn" id="but33" type="button" onclick="timeEdit(30)">30天</button>
									</div> 
								</div>
								<br/><br/><br/>
								<div class="col-md-4">
									<div class="input-group">
										<span class="input-group-addon">单号：</span> <input type="text"
											class="form-control" placeholder="订单号" name="order_num" value="${queryParam.order_num}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">类型</span>
										 <select class="select" data-width="100%" name="bill_type" id="bill_type">
											<option value="" <c:if test="${queryParam.bill_type=='' }">selected="selected"</c:if>>--全部--</option>
											<option value="0" <c:if test="${queryParam.bill_type=='0' }">selected="selected"</c:if>>订单入账</option>
											<option value="1" <c:if test="${queryParam.bill_type=='1' }">selected="selected"</c:if>>提现</option>
											<option value="2" <c:if test="${queryParam.bill_type=='2' }">selected="selected"</c:if>>退款</option>
										</select>
									</div>
								</div>
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
											<th>结算时间</th>
											<th>类型|名称|交易号</th>
											<th>金额|明细</th>
											<th>余额(元)</th>
											<th>支付方式|单号</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${pageInfo.list}" var="info">
					                    <tr>
					                        <td><fmt:formatDate value="${info.settlement_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					                        <td>
					                        	<c:if test="${info.bill_type ==0}">订单入账</c:if>
					                           	<c:if test="${info.bill_type ==1}">提现</c:if>
												<c:if test="${info.bill_type ==2}">退款</c:if>
					                        	|${info.bill_name}<br/>(${info.trade_no})</td>
					                        <td>${info.pay_amount}</td>
					                        <td>${info.balance}</td>   
					                        <td>
					                        	<c:if test="${info.payment_type ==0}">余额支付</c:if>
					                           	<c:if test="${info.payment_type ==1}">微信支付</c:if>
												<c:if test="${info.payment_type ==2}">支付宝</c:if>
												<c:if test="${info.payment_type ==3}">网银</c:if>
					                        	|${info.order_num}
					                        </td>
					                        <td>
					                        	<c:if test="${!empty info.order_id}">
												<a href="${pageContext.request.contextPath}/center/order/orderDetail?order_id=${info.order_id}" 
													title="查看详情" >查看</a>
												</c:if>
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
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});
 
function judgeDate(type){
	var startTime = $("#start_time").val();
	var endTime = $("#end_time").val();
    var start=new Date(startTime.replace("-", "/").replace("-", "/"));  	  
    var end=new Date(endTime.replace("-", "/").replace("-", "/"));  
    if(end<start){
    	MAlert("开始时间应不小于结束时间");
    	if(type==1){
    		$("#start_time").val("");
    	}else{
    		$("#end_time").val("");
    	}
       return false;
    }
}

function timeEdit(time){ 
	var date = new Date(); 
	$("#end_time").val( date.pattern("yyyy-MM-dd"));
	
	if(time==7){ 
		var date22=new Date( date.getTime()-86400000*6 );
		$("#start_time").val(date22.pattern("yyyy-MM-dd")); 
		$("#but11").addClass("bg-blue");
		$("#but22").removeClass("bg-blue");
		$("#but33").removeClass("bg-blue");
	}else if(time==15){
		var date22=new Date( date.getTime()-86400000*14 );
		$("#start_time").val(date22.pattern("yyyy-MM-dd")); 
		$("#but22").addClass("bg-blue");
		$("#but11").removeClass("bg-blue");
		$("#but33").removeClass("bg-blue");
	}else if(time==30){
		var date22=new Date( date.getTime()-86400000*29 );
		$("#start_time").val(date22.pattern("yyyy-MM-dd")); 
		$("#but33").addClass("bg-blue");
		$("#but22").removeClass("bg-blue");
		$("#but11").removeClass("bg-blue");
	} 
}
Date.prototype.pattern=function(fmt) {           
    var o = {           
    "M+" : this.getMonth()+1, //月份           
    "d+" : this.getDate(), //日           
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时           
    "H+" : this.getHours(), //小时           
    "m+" : this.getMinutes(), //分           
    "s+" : this.getSeconds(), //秒           
    "q+" : Math.floor((this.getMonth()+3)/3), //季度           
    "S" : this.getMilliseconds() //毫秒           
    };           
    var week = {           
    "0" : "/u65e5",           
    "1" : "/u4e00",           
    "2" : "/u4e8c",           
    "3" : "/u4e09",           
    "4" : "/u56db",           
    "5" : "/u4e94",           
    "6" : "/u516d"          
    };           
    if(/(y+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));           
    }           
    if(/(E+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);           
    }           
    for(var k in o){           
        if(new RegExp("("+ k +")").test(fmt)){           
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));           
        }           
    }           
    return fmt;           
}
  </script>
			
