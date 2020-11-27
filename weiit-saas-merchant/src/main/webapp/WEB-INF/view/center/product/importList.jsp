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
								<li><a href="${pageContext.request.contextPath}/center/productTag/list"><i class="icon-price-tags"></i> 商品标签</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productGroup/list"><i class="icon-paragraph-justify2"></i> 商品分组</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/productImport/list"><i class="icon-import"></i> 商品导入</a></li>
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
		<div class="page-header-content" >
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold"> 商品导入 </span>
				</h4>
			</div> 
			<div class="heading-elements">
				<ul class="breadcrumb-elements">		
					<li><a href="javascript:;"  data-toggle="modal" data-target="#import-modal">
						<i class="icon-import position-left"></i> 导入</a></li>
					 
				</ul>
			</div> 
		</div>
	</div>
	<!-- Content building -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
			
			<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/productImport/list" method="post" >	
			<div class="panel-body" style="padding:5px;margin:5px;">
				<div class="col-md-4">
					<div class="input-group" style="padding-top:5px;">
						<span class="input-group-addon">商品名称</span>
						<input type="text" class="form-control" id="product_name" name="product_name" value="${queryParam.product_name}">
					</div>
				</div>
				<div class="col-md-3" style="padding-top:5px;">
					<div class="input-group">
						<button class="btn bg-blue" type="submit">搜索</button>
					</div>
				</div>
				
			</div>
 	
			<div id="tableDiv" class="table-responsive">
				<table  id="data-table" class="table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" class="styled"  name="allCheck" onclick="allCheckClick(this)" value="" />
							</th>
							<th>商品</th>
							<th>价格</th>
		                    <th>库存</th>
		                    <th>导入时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${pageInfo.list}" var="info">
	                    <tr>
	                        <td><input type="checkbox" class="styled"   name="ids"  value="${info.id}"/></td>
	                        <td valign="middle" style="vertical-align: middle;width:300px;" title="${info.product_name }">
	                        	<img alt="" src="${imageDomain }/${info.original_img }" width="30px;" height="30px;">
								${info.product_name }
	                        </td>
	                        <td>${info.sale_price}</td>
	                        <td>${info.stock}</td>
	                        <td><fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                        <td>
	                        	<a href="javascript:;" onclick="onRelease(${info.id})" class="btn btn-success btn-xs m-r-5">一键发布</a>												
								<a href="javascript:;" onclick="WIremove(${info.id},'${info.product_name }')" class="btn btn-danger btn-xs m-r-5" >删除</a>	
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
			 	<button type="button" class="btn btn-default" onclick="BatchWIremove()">
			 		<i class="icon-trash"></i> 批量删除</button>
			</div>
		</form>
		</div> 
		<!-- /bordered striped table -->
	</div>
	<!-- /content building -->
</div>
<!-- /main content -->

<!-- Edit modal -->
<div id="import-modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">淘宝商品导入</h2>
			</div>
			<div class="modal-body">
				<form class="form-horizontal form-validate-jquery" name="updateForm" id="updateForm"  action="${pageContext.request.contextPath}/center/productImport/importSave"
					 method="post" enctype="multipart/form-data" >
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-sm-3 control-label text-right "> <span class="text-danger">*</span>Excel文件：</label>
							<div class="col-sm-7">
								<input type="file" class="form-control" name="mfile" id="mfile" 
									title="请选择上传文件" required="required">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-1 control-label"> </label>
	                        <div class="col-sm-11">
						                       请使用最新版的淘宝助手导出CSV文件。单次导入商品最大数量为40个。
								<br/>
								导入后的商品将出现在“外部商品素材”。
								<br/>
								导入商品后需要一段时间同步商品信息，之后才会出现，请耐心等待。
	                     	</div>
	                     </div> 
					</fieldset>
					<div class="text-right">
						<input type="hidden" name="roleId" value=""/>
						<button type="reset" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>
						<button type="button" class="btn btn-primary" onclick="addProdImport()" >提交 <i class="icon-arrow-right14 position-right"></i></button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- /edit modal -->

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

function onRelease(id){
	window.location="${pageContext.request.contextPath}/center/productImport/releaseTwo?product_id="+id+"&ts="+new Date().getTime();	
}
 
function WIremove(id,name){
	MConfirm('确认要删除商品  <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/productImport/remove?ids="+id;
		}
	});
} 


function BatchWIremove(){
	var idStr="";
	var idsCheck = $("#data-table input[name='ids']");
	idsCheck.each(function(i){
		if ($(this).prop("checked") ) {		
			if(idStr==""){
				idStr=$(this).val();
			}else{
				idStr=idStr+","+$(this).val();
			}
		}
    });
	if(idStr==""){
		MAlert('请至少选择一个商品进行删除！');
		return;
	}
	MConfirm('确认要批量删除选择的商品吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/productImport/remove?ids="+idStr ;
		}
	});
}

function addProdImport(){
	if(!$("#updateForm").validate().form()){
		return false;
	}
	var file=$("#mfile").val();
	if((file.substring(file.lastIndexOf(".")).toUpperCase())!=".CSV"){
		$("#mfile-error").remove();
		$("#mfile").after('<label id="mfile-error" class="validation-error-label" for="mfile">导入文件格式不正确，请使用最新版的淘宝助手导出CSV文件！！</label>');
		return false;
	}
	FullScreenShow("数据导入中，请稍后！");
	$("#updateForm").submit();
} 

</script>