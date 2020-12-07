<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>

		<div class="content-wrapper">

				<!-- Content area -->
				<div class="content">

					<!-- Error wrapper -->
					<div class="container-fluid text-center">
						<c:if test="${state=='again' }"><h5 class="text-success text-bold content-group">${info }</h5></c:if>
						<c:if test="${state=='fail' }"><h5 class="text-danger text-bold content-group">${info }</h5></c:if>
						<c:if test="${state=='success' }"><h5 class="text-success text-bold content-group">${info }</h5></c:if>
						<div class="row">
							<div class="col-lg-4 col-lg-offset-4 col-sm-6 col-sm-offset-3">

									<div class="row">
										<div class="col-sm-12">
											<a href="${pageContext.request.contextPath}/center/index" class="btn btn-primary btn-block content-group"><i class="icon-circle-left2 position-left"></i>返回主页</a>
										</div>
									</div>
							</div>
						</div>
					</div>
					<!-- /error wrapper --> 



				</div>
				<!-- /content area -->

			</div>

<!-- /main content -->
<%@include file="../common/footer.jsp"%>

