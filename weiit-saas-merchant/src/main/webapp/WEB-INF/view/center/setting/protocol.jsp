<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-credit-card"></i>支付/交易</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/expressList"><i class="icon-truck"></i>物流配送</a></li>
								<li><a href="${pageContext.request.contextPath}/center/account/password"><i class="icon-key"></i> 修改密码</a></li>
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
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">

								<div class="panel-body">
									<div class="profile">
										<form class="form-horizontal" action="" method="post"  enctype="multipart/form-data">
											<fieldset class="content-group">
												<legend class="text-bold"><h5>服务协议</h5></legend>
											</fieldset>
											<!-- Info blocks -->
											<div class="row"> 
												<c:forEach items="${protocolList}" var="info">
												<div class="col-md-4">
													<div class="panel">
														<div class="panel-body text-center">
															<div class="icon-object border-info-400 text-info"><i class="icon-file-text2"></i></div>
															<h5 class="text-semibold">${info.protocol_title}</h5>
															<p class="mb-15 text-muted">
															${info.protocol_content}
															</p>
															<a href="protocolEdit?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" title="编辑" class="btn btn-primary m-r-5 m-b-5"
																style="height: 22px; padding-top: 0px;" >编辑</a>
														</div>
													</div>
												</div>
												</c:forEach>
												
											</div>
											<!-- /info blocks -->
										</form>
									</div>
								</div>
							</div>
							<!-- /form validation -->
						</div>
					 </div>
					
					
				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
