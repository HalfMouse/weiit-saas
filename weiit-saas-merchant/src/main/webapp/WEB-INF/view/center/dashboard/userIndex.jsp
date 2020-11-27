<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/visualization/echarts/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/charts/echarts/charts.js"></script>

<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title"  style="height:70px;padding-top:20px;">
				<h4><i class="icon-home2 position-left"></i>数据统计</h4>
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
			<li><a href="${pageContext.request.contextPath}/center/analyse/dashboard"><i class="icon-display position-left"></i> 综合统计</a></li>
		 	<li><a href="${pageContext.request.contextPath}/center/dashboard/shopIndex"><i class="icon-coin-yen position-left"></i> 店铺概况</a></li>
			<li><a href="${pageContext.request.contextPath}/center/dashboard/orderIndex"><i class="icon-coin-yen position-left"></i> 订单概况</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/dashboard/userIndex"><i class="icon-users position-left"></i> 客户分析</a></li> 			
		 	 
		</ul>
		<div class="row">
			<div class="col-md-12">	
				<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/dashboard/userIndex"  method="post">
			         		
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<div class="row">
								<div class="col-md-5" style="margin-left:50px;">
									<div class="input-group">
										<span class="input-group-addon">时间筛选</span>
										<div class="input-group">
											<input type="text" class="form-control pickadate-translated" name="startTime" id="start_time" onchange="judgeDate(1)" value="${queryParam.startTime}">
											<span class="input-group-addon"> 至 </span> 
											<input type="text" class="form-control pickadate-translated" name="endTime" id="end_time" onchange="judgeDate(2)" value="${queryParam.endTime}">
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<button class="btn" id="but11" type="button" onclick="timeEdit(7)">7天</button>&nbsp;
									<button class="btn" id="but22" type="button" onclick="timeEdit(15)">15天</button>&nbsp;
									<button class="btn" id="but33" type="button" onclick="timeEdit(30)">30天</button>
									&nbsp;&nbsp;&nbsp;
									<button class="btn bg-blue" type="button" onclick="searchButton()">查询</button>
								</div> 
							</div>
			            
						</div>
					</div>
					<!-- /search field -->
				</form>
			
				<!-- My messages -->
				<div class="panel panel-flat">
					<div class="panel-heading">
						<h6 class="panel-title">客户分析</h6> 
					</div>
					<!-- Numbers -->
					<div class="container-fluid">
						<div class="row text-center">
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${userInfo.log_user_count}</h6>
									<span class="text-muted text-size-small">访客数</span>
								</div>
							</div>
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${userInfo.user_count}</h6>
									<span class="text-muted text-size-small">新增粉丝数</span>
								</div>
							</div> 
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${userInfo.all_user_count}</h6>
									<span class="text-muted text-size-small">累计粉丝数</span>
								</div>
							</div>
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${userInfo.card_user_count}</h6>
									<span class="text-muted text-size-small">新增会员数</span>
								</div>
							</div> 
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${userInfo.all_card_user_count}</h6>
									<span class="text-muted text-size-small">累计会员数</span>
								</div>
							</div> 
							<div class="col-md-2">
								<div class="content-group">
									<h6 class="text-semibold no-margin"><i class="icon-stats-bars2 position-left text-slate"></i> ${userInfo.pay_user_count}</h6>
									<span class="text-muted text-size-small">成交客户数</span>
								</div>
							</div> 
						</div>
					</div>
					<!-- /numbers -->
				</div>
				<!-- /my messages -->
			</div>
			 
		</div>
			
		<div class="col-md-12" style="padding:0px;margin:0px;">
			<!-- Stacked columns -->
			<div class="panel panel-flat">
				<div class="panel-heading" style="background-color:white;">
					<h5 class="panel-title">时段分布趋势</h5>
					<div class="heading-elements">
						<ul class="icons-list">
							<li><a data-action="collapse"></a></li>
							<li><a data-action="reload"></a></li>
							<li><a data-action="close"></a></li>
						</ul>
					</div>
				</div>
		
				<div class="panel-body" style="padding-top:0px;margin-top:0px;">
					<div class="chart-container">
						<div class="chart has-fixed-height" id="stacked_lines"></div>
					</div>
				</div>
			</div>
			<!-- /stacked columns -->
		</div>
		 
	</div>  
	<!-- /Content area -->
</div>
<!-- /Main content --> 

<%@include file="../common/footer.jsp" %>
<script>
$(document).ready(function() {
 
	//报表数据结构
	var data={ 
			column:{
				div_id:"stacked_lines",
				label:['平均访客数','平均浏览量'],
				xAxis:${times},
				data:[
	                    {
	                        name: '平均访客数',
	                        type: 'line', 
	                        data: ${allDatas}
	                    },
	                    {
	                        name: '平均浏览量',
	                        type: 'line', 
	                        data: ${userDatas}
	                    }
	                ]
			}
	}
	//渲染报表
	combination_connection_chart(data);
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
	var today = new Date(); 
	var date = new Date( today.getTime()-86400000*1 ); 
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

function searchButton(){
	var startTime = $("#start_time").val();
	var endTime = $("#end_time").val();
	if(startTime=="" || endTime==""){
		MAlert("时间筛选的日期不能为空！");
		return ;
	}
	searchSubmit(1);
}

</script>