<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<style type="text/css">   
.table {   
   table-layout: fixed;   
   width: 98% border:0px;   
   margin: 0px;   
}   
  
.table tr td {   
    text-overflow: ellipsis; /* for IE */  
    -moz-text-overflow: ellipsis; /* for Firefox,mozilla */  
    overflow: hidden;   
    white-space: nowrap;   
    border: 1px solid;   
    text-align: left   
}   
</style>
<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/publics/publics/productList" method="post" >						
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
 
	<!-- Content area -->
	<div class="content"  style="padding:0px;margin:0px;">
		<!-- Bordered striped table -->
		<div class="panel panel-flat"> 
			<div class="panel-body" >
				<div class="col-xs-5">
					<div class="input-group">
						<span class="input-group-addon bg-info-300">商品名称</span>
						<input type="text" class="form-control" id="product_name" name="product_name" value="${queryParam.product_name}">
					</div>
				</div>
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>
			</div>
				
			<div class="table-responsive">
				<table  id="data-table"  class="table table-bordered table-striped">
					<thead>
						<tr >
							<th width="70">序号</th>
							<th>商品名称</th>
							<th width="70">操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${pageInfo.list}" var="info" varStatus="ind">
	                    <tr>
	                        <td>${ind.count}</td>
	                        <td valign="middle" style="vertical-align: middle;" title="${info.product_name}">
	                        	<img alt="" width="30px;" src="${imageDomain }/${info.product_img}">
	                        	${info.product_name}
	                        </td>
	                        <td>
								<a href="javascript:;" title="选择" onclick="selectReturn('${info.product_id}','${info.product_name}','${info.product_img}','${info.smarket_price}')" >选择</a>
							</td>
	                    </tr>
	                </c:forEach>
					</tbody>
				</table>
			</div>

			<div id="pager" class="panel-body"></div>
			
		</div> 
		<!-- /bordered striped table -->
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
</form>			
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

function selectReturn(id,name,images,price){ 
	parent.returnProductList(id,name,images,price);
}

</script>