<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>

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
								<li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<%--<li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>--%>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title"  style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 砍价活动记录 </span>
							</h4>
						</div>
					</div> 
				</div>
				<!-- /page header -->
			
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" 
								action="${pageContext.request.contextPath}/center/ump/bargain/bargainNancyList" method="post">

								<a href="${pageContext.request.contextPath}/center/ump/bargain/bargainDetailList?validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}" id="qua1" class="btn btn-rounded btn-default" ><i class="icon-arrow-left7"></i>返回</a>
								<br> <br>
								<div class="table-responsive">
									<table id="data-table" class="table">
										 <thead>
											<tr > 
												<th>编号</th>
												<th>用户</th>
												<th>砍价价格</th>
												<th>砍后价格</th>
												<th>砍价时间</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${pageInfo.list}" var="info" varStatus="ind">
						                    <tr>
						                        <td>${ind.count}</td>
						                        <td><img src="${info.user_img}" width="40" height="40"/>&nbsp;&nbsp;&nbsp;${info.user_name}</td>
						                        <td>${info.bargain_price}</td>
						                        <td>${info.after_price}</td>
						                        <td><fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						                    </tr>
						                </c:forEach>
									</table>
			
								</div>
								<div id="pager" class="panel-body">  
								</div>
							</form>
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			
			<script>
			$(document).ready(function() {
			    $("#pager").pager({ 
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			});
		 	 
			</script>
						
