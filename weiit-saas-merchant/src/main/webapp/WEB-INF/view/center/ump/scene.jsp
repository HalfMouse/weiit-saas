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
								<li><a href="dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<!--<li  class="active"><a href="scene"><i class="icon-diamond"></i>场景营销</a></li>
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
			
					<div class="row">
						<div class="text-center content-group text-muted content-divider">
							<span class="pt-10 pb-10">我的营销服务</span>
						</div>
						<c:forEach items="${allServiceList }" var="se">
							<c:if test="${se.is_auth=='1' }">
							<div class="col-md-4" style="height:320px;margin-top:20px;">
								<div class="panel panel-body border-top-primary text-center" style="height:320px;">
									<h3>
										<img src="${imageDomain }${se.service_icon }" width="120" height="120">
										<span class="text-bold text-orange">${se.service_name }</span>
									</h3>
									<p class="text-muted content-group-sm">${se.remark }</p>
									<button type="button" class="btn btn-success" onclick="Mget('${se.link_url}')">进入管理</button>
								</div>
							</div>
							</c:if>
						</c:forEach>
					</div>
					<br>
					<br>
					<div class="row">
						<div class="text-center content-group text-muted content-divider">
							<span class="pt-10 pb-10">更多营销服务</span>
						</div>
						<c:forEach items="${allServiceList }" var="se">
							<c:if test="${se.is_auth=='-1' }">
								<div class="col-md-4" style="height:320px;margin-top:20px;">
									<div class="panel panel-body border-top-primary text-center" style="height:320px;">
										<h3>
											<img src="${imageDomain }${se.service_icon }" width="120" height="120">
											<span class="text-bold text-orange">${se.service_name }</span>
										</h3>
										<p class="text-muted content-group-sm">${se.remark }</p>
										<button type="button" class="btn btn-default">未开通</button> 
						                <button type="button" class="btn bg-orange" onclick="Mget('${pageContext.request.contextPath}/center/ump/serviceDetail?service_num=${se.service_num }')">现在开通</button>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
			
				</div>
				<!-- /content area -->
			
			</div>
			
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			
			<script>
			function goCoupons(url){
				window.location.href=url;
			}
			</script>
