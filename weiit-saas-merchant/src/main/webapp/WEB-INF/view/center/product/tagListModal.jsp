<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content">
							<a href="${pageContext.request.contextPath}/center/product/releaseOne?saleOld=1" class="btn bg-orange btn-rounded btn-block btn-xs">发布商品</a>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/product/onSaleList"><i class="icon-price-tag3"></i>出售中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/soldOutList"><i class="icon-flag3"></i>库存紧张商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/forSaleList"><i class="icon-make-group"></i>仓库中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productCate/list"><i class="icon-chess"></i> 商品分类</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/productTag/list"><i class="icon-chess"></i> 商品分组</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productImport/list"><i class="icon-import"></i> 商品导入</a></li>
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
								<span class="text-semibold">商品分组列表 </span>
							</h4>
						</div>
						<div class="heading-elements"> 
							<ul class="breadcrumb-elements"> 
								<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick="WIADD()" ><i class="icon-add position-left"></i>新建分组</button></li>
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
												<th>分组名称</th>
												<th>创建时间</th>
												<th>状态</th>
												<th width="150">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="info">
											<tr>
												<td>${info.tag_name}</td>
												<td><fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
												<td>
													<c:if test="${info.state == 0 }">
						                           		<a href="javascript:;" title="点击隐藏" class="btn btn-success m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.tag_name}',-1)">显示</a>
						                           	</c:if>
						                           	<c:if test="${info.state==-1}">
														<a href="javascript:;" title="点击显示" class="btn btn-warning m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.tag_name}',0)">隐藏</a>
													</c:if>
												</td>
												<td style="padding:0px;margin:0px;text-align:center;">
												   	<a href="javascript:;" title="编辑" onclick="WIedit('${info.validate_id}','${info.validate_id_token}')" >
														编辑</a>&nbsp;|&nbsp;
						                       		<a href="javascript:;" title="删除" onclick="WIremove('${info.validate_id}','${info.validate_id_token}','${info.tag_name}')" >
														删除</a>
												</td>
											</tr>	
										</c:forEach> 
									</table>
								</div>
								<div id="pager" class="panel-body"></div>
							</form>
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
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
				var url="${pageContext.request.contextPath}/center/productTag/add?ts="+new Date().getTime();	
				commonDialogModal("商品分组新增",url,500,300,'','');
			}
			
			function WIedit(id,token){
				var url="${pageContext.request.contextPath}/center/productTag/edit?validate_id="+id+"&validate_id_token="+token+"&ts="+new Date().getTime();	
				commonDialogModal("商品分组编辑",url,500,300,'','');
			}

			function mUpdate(id,token,name,state){
				var title="";
				if(state=="-1"){
					title='确定要隐藏商品分组<label style="color: red;">'+name+'</label> 吗？';
				}
				if(state=="0"){
					title='确定要显示商品分组<label style="color: red;">'+name+'</label> 吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/productTag/save?state="+state+"&validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			 
			function WIremove(id,token,name){
				MConfirm('确定要删除商品分组<label style="color: red;">'+name+'</label> 吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/productTag/remove?validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			</script>
						
