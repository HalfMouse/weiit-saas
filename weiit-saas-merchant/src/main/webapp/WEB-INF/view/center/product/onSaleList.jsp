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
								<li class="active"><a href="${pageContext.request.contextPath}/center/product/onSaleList"><i class="icon-price-tag3"></i>出售中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/soldOutList"><i class="icon-flag3"></i>库存紧张商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/forSaleList"><i class="icon-make-group"></i>仓库中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productTag/list"><i class="icon-price-tags"></i> 商品标签</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productGroup/list"><i class="icon-paragraph-justify2"></i> 商品分组</a></li>
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
				<div class="page-header"> 
					<div class="page-header-content" >
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 出售中的商品 </span>
							</h4>
						</div>
						<div class="heading-elements" >
							<ul class="breadcrumb-elements">
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-file-excel position-left"></i> 导出 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li><a href="javascript:exportExcel('xlsx')"><i class="icon-file-excel"></i> Excel导出</a></li>
										<li><a href="javascript:exportExcel('csv')"><i class="icon-file-excel"></i> CSV导出</a></li>
									</ul>
								</li>
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn1">商品</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn2">商品分类</label></li> 
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn4">市场价</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn5">销售价</label></li> 
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn7">库存</label></li>		
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn8">销量</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="onSalecolumn9">操作</label></li>
									</ul>
								</li>
							
							</ul>
						</div>
					</div>
					
					 
			
				</div>
				<!-- /page header -->
				
				<!-- Content building -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
						<form class="form-horizontal"  name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/product/onSaleList" method="post" >
						<div class="panel-body" style="padding:5px;margin:5px;">
							<div class="col-md-4">
								<div class="input-group" style="padding-top:5px;">
									<span class="input-group-addon">商品名称</span>
									<input type="text" class="form-control" id="product_name" name="product_name" value="${queryParam.product_name}">
								</div>
							</div>
							<div class="col-md-3">
								<div class="input-group" style="padding-top:5px;">
									<span class="input-group-addon">分类</span>
									<input type="text" class="form-control" id="cate_name" name="cate_name" value="${queryParam.cate_name}">
								</div>
							</div>
							<div class="col-md-3">
								<div class="input-group" style="padding-top:5px;">
									<span class="input-group-addon">分组</span>
									 <select class="bootstrap-select" data-width="100%" name="group_id" id="group_id">
										<option value="" <c:if test="${queryParam.group_id=='' }">selected="selected"</c:if>>--全部--</option>
										<c:forEach items="${groupList}" var="info">
											<option value="${info.group_id}" <c:if test="${queryParam.group_id==info.group_id}">selected="selected"</c:if>>${info.group_name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="col-md-2" style="padding-top:5px;">
								<div class="input-group">
									<button class="btn bg-blue" type="submit">搜索</button>
								</div>
							</div>
							<input type="hidden" name="is_on_sale" value="${queryParam.is_on_sale}"/>
						</div>
			 	
						<div id="tableDiv" class="table-responsive">
							<table  id="data-table" class="table">
								<thead>
									<tr>
										<th>
											<input type="checkbox" class="styled" name="allCheck" onclick="allCheckClick(this)" value="" />
										</th>
										<th class="onSalecolumn1">商品</th>
										<th class="onSalecolumn2">商品分类</th> 
										<th class="onSalecolumn4">市场价</th>
										<th class="onSalecolumn5">销售价</th> 
			                           	<th class="onSalecolumn7">库存</th>				                                   
			                          	<th class="onSalecolumn8">销量</th> 
										<th class="onSalecolumn9" width="200">操作</th>
									</tr> 
								</thead>
								<tbody>
								<c:forEach items="${pageInfo.list}" var="info">
				                    <tr>
				                        <td><input type="checkbox" class="styled" name="ids"  value="${info.product_id }|${info.validate_id_token}" /></td>
				                        <td  style="max-width: 10%;">
											<table>
											<tr>
												<td><img src="${imageDomain }${info.product_img}?${i100}" width="60px" height="60px"></td>
												<td>&nbsp;&nbsp;
													<a class="list_title" href="javascript:;" title="点击查看商品详情" onclick="detail('${info.product_id}','${info.validate_id_token }')" >${info.product_name }</a>
													&nbsp;&nbsp;
													<span class="btn-warning">
														<c:forEach items="${tagList}" var="taginfo">
															<c:if test="${taginfo.product_id==info.product_id}">
															${taginfo.tag_name}&nbsp; 
															</c:if>
														</c:forEach>
													</span>
												</td>
											</tr>
											</table>
										</td>
				                        <td>${info.firstCateName}
				                        <c:if test="${!empty info.secondCateName}">>><br/>${info.secondCateName}</c:if>
				                        <c:if test="${!empty info.thirdCateName}">>><br/>${info.thirdCateName}</c:if>
				                        </td> 
				                        <td>${info.smarket_price}</td>
				                        <td>${info.sale_price}</td>
				                        <td>${info.stock}</td>
				                        <td>${info.sale_count}</td> 
				                        
				                        <td style="padding:0px;margin:0px;text-align:center;">  
											<a href="javascript:;" title="编辑" onclick="WIedit('${info.product_id}','${info.validate_id_token }')"class="btn bg-orange-400 m-r-5 m-b-5" style="height: 22px;padding-top: 0px;" >编辑</a>
											<a href="javascript:;" title="下架" onclick="WIStatus('${info.validate_id}','${info.product_name}','-1','${info.validate_id_token }')" class="btn bg-danger-300 m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">下架</a>
											<a href="javascript:;" title="改分组" onclick="WIeditTag('${info.product_id}','${info.validate_id_token }')" class="btn bg-blue m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">打标签</a>
										</td>
				                    </tr>
				                </c:forEach> 
				                   
								</tbody>
							</table>
						</div>
			
						<div id="pager" class="panel-body">
							<label class="btn btn-default"  > 
								<input type="checkbox" name="selectAll" class="styled" onclick="allCheckClick(this)" value="1" />&nbsp;全选/不选
							</label>
							<button type="button" class="btn btn-default" onclick="BatchOnSale(-1)">
			                 		<i class="icon-square-down" ></i> 批量下架</button>
			                <button type="button" class="btn btn-default" onclick="BatchWIeditTag()">
					         	<i class=" icon-pencil7"></i> 批量打标签</button>&nbsp;&nbsp;&nbsp;
						</div>
						</form>
					</div> 
					<!-- /bordered striped table -->
				</div>
				<!-- /content building -->
			</div>
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp" %>
			<script>
			$(document).ready(function() {
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			}); 
			
			function detail(validate_id,validate_id_token){
				commonDialogModal("商品详情","${pageContext.request.contextPath}/center/product/productDetail?validate_id="+validate_id+"&validate_id_token="+validate_id_token+"&ts="+new Date().getTime(),900,500,'','');
			}
			
			function WIedit(id,validate_id_token){
				window.location="${pageContext.request.contextPath}/center/product/releaseTwo?saleOld=1&validate_id="+id+"&validate_id_token="+validate_id_token+"&ts="+new Date().getTime();	
			}
			
			function WIStatus(id,name,status,validate_id_token){ 
				var url="${pageContext.request.contextPath}/center/product/status?saleOld=1&is_on_sale="+status+"&validate_id="+id+"&validate_id_token="+validate_id_token;
				Mremove("get",url,'确定要下架商品 <label style="color: red;">'+name+'</label> 吗？');
			}
			
			function BatchOnSale(onSale){
				var url="${pageContext.request.contextPath}/center/product/status?mfalg=1&saleOld=1&is_on_sale="+onSale;
				MremoveBath("input[name='ids']",url,'确定要批量下架选择的商品吗？');
			}
			
			//excel导出
			function exportExcel(fileType){
				var exportClassName="com.weiit.web.admin.product.service.ProductService";
				var	exportMethodName="selectList";
				var	exportExcelName="商品上下架列表";
				var	exportTitles="商品,商品一级分类,商品二级分类,商品三级分类,价格,库存,销量,发布时间";
				var	exportFields="product_name,firstCateName,secondCateName,thirdCateName,sale_price,stock,sale_count,update_time";	
				commonExportList("searchform",exportClassName,exportMethodName,exportExcelName,exportTitles,exportFields,fileType);
			}
			
			function WIeditTag(id,validate_id_token){
				commonDialogModal("商品打标签","${pageContext.request.contextPath}/center/productTag/editProductTag?validate_id="+id+"&validate_id_token="+validate_id_token,800,500);	
			}
			function BatchWIeditTag(){
				var ids="";
				$("input[name='ids']").each(function(){
					 if($(this).prop("checked")){
						 var valueStr=$(this).val().split("|");
						 if(ids==""){
							 ids=valueStr[0];
						 }else{
							 ids=ids+"|" +valueStr[0];
						 }
					 }
				});
				if(ids==""){
					MAlert("请至少选择一个商品进行打标签！");
					return;
				}
				commonDialogModal("商品批量打标签","${pageContext.request.contextPath}/center/productTag/editProductTag?mfalg=1&ids="+ids ,800,500);	
			}
			
			</script>
						
