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
								<li class="active"><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<li><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="${pageContext.request.contextPath}/center/ump/spread"><i class="icon-sphere3"></i>我要推广</a></li>
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
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> 
								<span class="text-semibold"> 满减送列表 </span>
							</h4>
						</div>
						<div class="heading-elements"> 
							<ul class="breadcrumb-elements"> 
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="couponcolumn1">活动名称</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="couponcolumn4">有效期</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="couponcolumn5">生效条件</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="couponcolumn8">状态</label></li>
									</ul>
								</li>
								<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick="Mget('${pageContext.request.contextPath}/center/ump/reward2/rewardCreate2')" ><i class="icon-add position-left"></i>新建满减送</button></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /page header -->
			
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
								<div class="table-responsive">
									<table id="data-table"
										class="table">
										<thead>
											<tr>
												<th>活动名称</th>
												<th>有效期</th>
												<th>创建时间</th>
												<th>状态</th>
												<th width="80">操作</th>
											</tr>
										</thead>
											<tr>
												<td>xxx</td>
												<td>2018-01-02 至 2018-01-03</td>
												<td>
													2018-01-02
												</td>
												<td>
						                           		<a href="javascript:;" title="点击不生效" class="btn btn-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">生效中</a>
						                           	
												</td>
												<td style="padding:0px;margin:0px;text-align:center;">
												   	<a href="javascript:;" title="编辑"  >
														编辑</a>&nbsp;|&nbsp;
						                       		<a href="javascript:;" title="删除">
														删除</a>
												</td>
											</tr>
											<tr>
												<td>xxx</td>
												<td>2018-01-02 至 2018-01-03</td>
												<td>
													2018-01-02
												</td>
												<td>
						                           		<a href="javascript:;" title="点击不生效" class="btn btn-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">生效中</a>
						                           	
												</td>
												<td style="padding:0px;margin:0px;text-align:center;">
												   	<a href="javascript:;" title="编辑"  >
														编辑</a>&nbsp;|&nbsp;
						                       		<a href="javascript:;" title="删除">
														删除</a>
												</td>
											</tr>	
									</table>
			
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
			    
			});
			
			
			
			
			</script>
						
