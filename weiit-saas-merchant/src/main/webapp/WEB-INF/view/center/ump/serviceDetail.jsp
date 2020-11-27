<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

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
								<li class="active"><a href="dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<!--<li><a href="scene"><i class="icon-diamond"></i>场景营销</a></li>
								 <li><a href="spread"><i class="icon-sphere3"></i>我要推广</a></li> -->
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

					<div class="panel">
						<div class="panel-body">
							<div class="form-group">
								<label class="col-md-3" style="width:210px;"> 
								<img src="${imageDomain }${serviceDetail.service_logo }_200x200" class="" width="200" height="200" />
								</label>
								<form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/ump/servicePay" method="POST" >
								<div class="col-md-8" style="margin-left: 5rem;">
									<h3><span class="text-bold text-default">${serviceDetail.service_name }</span></h3>
									<span class="text-muted">${serviceDetail.remark }</span><br><br>
									<span class="text-muted">&nbsp;&nbsp;原&nbsp;&nbsp;&nbsp;&nbsp;价：</span><del class="text-warning" style="font-size:20px;">￥${serviceDetail.service_smarket_price }</del>&nbsp;/<span class="text-muted">1年期</span><br><br>
									<span class="text-muted">&nbsp;&nbsp;活动价：</span><span class="text-warning" style="font-size:20px;">￥${serviceDetail.service_price }</span>&nbsp;/<span class="text-muted">1年期</span><br><br>
									<span class="text-muted">订购时长：</span>
									<c:forEach items="${orderTimeList }" var="orderTime">
										<c:if test="${orderTime.day>31 }">
											<c:if test="${orderTime.order_time_name=='6_month' }"><button type="button" class="btn btn-default orderTime" value="6_month">&nbsp;&nbsp;6个月&nbsp;&nbsp;</button>&nbsp;&nbsp;</c:if>
											<c:if test="${orderTime.order_time_name=='12_month' }"><button type="button" class="btn btn-default orderTime" value="12_month">&nbsp;&nbsp;12个月&nbsp;&nbsp;</button>&nbsp;&nbsp;</c:if>
										</c:if>
									</c:forEach>
									<span class="text-danger text-bold" id="error"></span>
									<br><br> 
									<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" name="order_time_name" id="order_time_name" value=""/>
									<input type="hidden" name="service_num" id="service_num" value="${serviceDetail.service_num }"/>
									<button type="button" onclick="pay()" class="btn btn-primary">&nbsp;&nbsp;&nbsp;立即订购&nbsp;&nbsp;&nbsp;</button>
									<button type="button" class="btn border-slate text-slate-800 btn-flat">&nbsp;&nbsp;&nbsp;我要免费开通</button>
									</h5>
								</div> 
								</form>
							</div>
			
						</div>
					</div> 


					<div class="row">
						<div class="col-md-12">
							<!-- Tabs -->
							<ul class="nav  nav-tabs"> 
								<li class="active"><a href="" style="border-left:0px;border-top:0px;">应用详情</a></li>
								<li><a href="">使用教程</a></li>
								<li class="pull-right">
									<a href="tel:0755-36953215">应用服务专线：0755-36953215，服务时间：10:00-18:00</a>
								</li>
							</ul> 
							<!-- /tabs --> 
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								
								<div class="panel-body">
								${serviceDetail.service_desc }
								</div>
							</div>
						</div>
					 </div>
				</div>
				<!-- /content area -->
			
			</div>
			
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			
			<script>
			$(function(){
				
				
				$(".orderTime").click(function(){
					$("#error").html("");
					$(".orderTime").each(function(){
						$(this).attr("class","btn btn-default orderTime");
					});
					$(this).attr("class","btn border-slate orderTime");
					$("#order_time_name").attr("value",$(this).val());
				});
			});
			
			function pay(){
				if($("#order_time_name").val()==""){
					$("#error").html("请选择订购时长");
				}else{
					FullScreenShow("数据提交中，请稍后！");
					$("#infoForm").submit();
				}
			}
			</script>
			
