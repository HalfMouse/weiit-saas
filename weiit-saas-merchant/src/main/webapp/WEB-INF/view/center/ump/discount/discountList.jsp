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
								<li><a href="scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="spread"><i class="icon-sphere3"></i>我要推广</a></li>
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
								<span class="text-semibold"> 限时折扣列表 </span>
							</h4>
						</div>
						<div class="heading-elements"> 
							<ul class="breadcrumb-elements"> 
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="discount_name">折扣商品</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="discount_price">折扣价/折扣</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="max_limit">限购</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="description">活动标签</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="start_time">开始时间</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="end_time">结束时间</label></li>
									</ul>
								</li>
								<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick="Mget('${pageContext.request.contextPath}/center/ump/discount/create')" ><i class="icon-add position-left"></i>新建限时折扣</button></li>
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
												<th class="discount_name">折扣商品</th>
												<th class="discount_price">折扣价/折扣</th>
												<th class="max_limit">限购</th>
												<th class="description">活动标签</th>
												<th class="start_time">开始时间</th>
												<th class="end_time">结束时间</th>
												<th class="state">状态</th>
												<th style="padding:0px;margin:0px;text-align:center;">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="info">
											<tr>
												<td style="width:250px;padding-left:0px;padding-right:0px;">
													<table>
														<tr>
														<td><img src="${imageDomain }${info.product_img}?${i100}" width="60px" height="60px"></td>
														<td> ${info.product_name }</td>
														</tr>
													</table>
												</td>
												<td>
												￥${info.discount_price}<br>
												<span class="text-muted">${info.discount}折</span>
												</td>
												<td>
												<span class="text-muted">
													<c:if test="${info.max_limit eq null }">不限购</c:if>
													<c:if test="${info.max_limit!=null and info.max_limit>0 }">限购:${info.max_limit }</c:if>
												</span>
												</td>
												<td>
												${info.description}
												</td>
												<td>${info.start_time}</td> 
												<td>${info.end_time}</td>
												<td>
													<c:if test="${info.state == 1 }">
						                           		<a href="javascript:;" title="点击失效" class="btn bg-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.discount_name}',-1)">生效中</a>
						                           	</c:if>
						                           	<c:if test="${info.state==-1}">
														<a href="javascript:;" title="点击生效" class="btn bg-grey-300 m-r-5 m-b-5" style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.discount_name}',1)">已失效</a>
													</c:if>
												</td>
												<td style="padding:0px;margin:0px;text-align:center;">
						                       		<a href="javascript:;" onclick="Mget('${pageContext.request.contextPath}/center/ump/discount/edit?validate_id=${info.validate_id}&&validate_id_token=${info.validate_id_token}')"  title="编辑" class="btn bg-orange m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">编辑</a>
													&nbsp;&nbsp;
													<a href="javascript:;" onclick="WIremove('${info.validate_id}','${info.validate_id_token}','${info.discount_name}')" title="删除" class="btn bg-grey m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">删除</a>
												</td>
											</tr>	
										</c:forEach> 
									</table>
			
								</div>
								<br><br>
								<c:if test="${fn:length(pageInfo.list)>=10}">
								<div id="pager" class="panel-body">
								
								</div>
								</c:if>
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
			
			function mUpdate(id,token,name,state){
				var title="";
				if(state=="-1"){
					title='确定要失效限时折扣活动<label style="color: red;">'+name+'</label> 吗？';
				}
				if(state=="1"){
					title='确定要生效限时折扣活动<label style="color: red;">'+name+'</label> 吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/discount/state?state="+state+"&validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			 
			function WIremove(id,token,name){
				MConfirm('确定要删除限时折扣活动<label style="color: red;">'+name+'</label> 吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/discount/remove?validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			</script>
						
