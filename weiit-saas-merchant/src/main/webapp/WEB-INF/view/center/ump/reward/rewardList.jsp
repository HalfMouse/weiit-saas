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
								<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick="WIADD()" ><i class="icon-add position-left"></i>新建满减送</button></li>
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
										<c:forEach items="${pageInfo.list}" var="info">
											<tr>
												<td>${info.reward_name}</td>
												<td>${info.start_time} 至 ${info.end_time}</td>
												<td>
													<fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
												</td>
												<td>
													<c:if test="${info.state == 0 }">
						                           		<a href="javascript:;" title="点击不生效" class="btn btn-success m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.reward_name}',-1)">生效中</a>
						                           	</c:if>
						                           	<c:if test="${info.state==-1}">
														<a href="javascript:;" title="点击生效" class="btn btn-warning m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.reward_name}',0)">已失效</a>
													</c:if>
												</td>
												<td style="padding:0px;margin:0px;text-align:center;">
												   	<a href="javascript:;" title="编辑" onclick="WIedit('${info.validate_id}','${info.validate_id_token}')" >
														编辑</a>&nbsp;|&nbsp;
						                       		<a href="javascript:;" title="删除" onclick="WIremove('${info.validate_id}','${info.validate_id_token}','${info.reward_name}')" >
														删除</a>
												</td>
											</tr>	
										</c:forEach> 
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
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			});
			
			function WIADD(){
				window.location="${pageContext.request.contextPath}/center/ump/reward/add?ts="+new Date().getTime();	
			}
			
			function WIedit(id,token){
				window.location="${pageContext.request.contextPath}/center/ump/reward/edit?validate_id="+id+"&validate_id_token="+token+"&ts="+new Date().getTime();	
			}

			function mUpdate(id,token,name,status){
				var title="";
				if(status=="-1"){
					title='确定要失效限时折扣活动<label style="color: red;">'+name+'</label> 吗？';
				}
				if(status=="1"){
					title='确定要生效限时折扣活动<label style="color: red;">'+name+'</label> 吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/reward/status?state="+status+"&validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			 
			function WIremove(id,token,name){
				MConfirm('确定要删除限时折扣活动<label style="color: red;">'+name+'</label> 吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/reward/remove?validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			</script>
						
