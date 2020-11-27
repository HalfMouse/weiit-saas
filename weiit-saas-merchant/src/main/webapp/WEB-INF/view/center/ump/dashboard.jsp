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
								<!--<li><a href="scene"><i class="icon-diamond"></i>场景营销</a></li>-->
								 <li><a href="enterPoint"><i class="icon-sphere3"></i>入口设置</a></li>
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
										<img src="${imageDomain }${se.service_icon }" width="130" height="120">
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
				
					<!--  
					<div class="row">
						<div class="col-md-12">
							<div class="my">
								<form class="form-horizontal" >
									
									<c:forEach items="${allServiceList }" var="se">
										<div class="form-group" style="background: #F7F7F7">
											<div class="col-md-9" style="margin-left: 20px; border-right: 1px solid white;">
												<br>
												<h3>
													<img src="${imageDomain }${se.service_icon }" width="120" height="120"/>
													<span class="text-bold text-orange">${se.service_name }</span>
												</h3>
												<br>
												<br> <span class="text-bold text-muted">${se.remark }</span><br><br>
												<span class="text-bold text-muted">是否开通:</span>
												<c:if test="${se.is_auth=='1' }">
													<span class="text-bold text-success">已开通</span>
												</c:if>
												<c:if test="${se.is_auth=='-1' }">
													<span class="text-bold text-danger">未开通</span>
												</c:if>
												 <br>
												<br>
												<br>
				
											</div>
											<div class="col-md-2" style="margin-left: 20px; width:200px;" >
												<br>
												<br>
												<br> 
												<c:if test="${se.is_auth=='1' }">
													<button class="btn bg-blue btn-block btn-float btn-float-lg"
														type="button" onclick="Mget('${se.link_url}')">
														<i class="icon-gear"></i> <span>马上设置</span>
													</button>
												</c:if>
												<c:if test="${se.is_auth=='-1' }">
													<button class="btn bg-pink btn-block btn-float btn-float-lg"
														type="button" onclick="Mget('${pageContext.request.contextPath}/center/ump/serviceDetail?service_num=${se.service_num }')">
														<i class="icon-price-tags2"></i> <span>马上订购</span>
													</button>
												</c:if>
											</div>
										</div>
									</c:forEach>
									
								</form>
							</div>
						</div>
					</div>-->
			
				</div>
				<!-- /content area -->
			
			</div>
			
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			
			
			
