<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<style>
body{
background:white;
}
.col-md-3:before {
  content: "\2714";
  display: block;
  position: absolute;
  width: 25px;
  height: 25px;
  line-height: 25px;
  background:  #00c09e;
  color: #fff;
  text-align: center;
  font-size: 10px;
  z-index: 10;
  opacity: 0;
  transition:         0.3s linear;
  -o-transition:      0.3s linear;
  -ms-transition:     0.3s linear;
  -moz-transition:    0.3s linear;
  -webkit-transition: 0.3s linear;
  -o-user-select:      none;
  -moz-user-select:    none;
  -webkit-user-select: none;
  cursor: pointer;
}
.col-md-3.selected:before {
  opacity: 1;
}
.col-md-3.selected .thumbnail {
  box-shadow: 0 0 0 4px #00c09e;
  animation:        selected 0.3s cubic-bezier(0.250, 0.100, 0.250, 1.000);
  -o-animation:     selected 0.3s cubic-bezier(0.250, 0.100, 0.250, 1.000);
  -ms-animation:    selected 0.3s cubic-bezier(0.250, 0.100, 0.250, 1.000);
  -moz-animation:   selected 0.3s cubic-bezier(0.250, 0.100, 0.250, 1.000);
  -webkit-animation: selected 0.3s cubic-bezier(0.250, 0.100, 0.250, 1.000);
}
</style>
<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/publics/publics/productGridList" method="post" >						
<!-- Main content -->
<div class="col-md-13">
	<!-- Page header -->
	<div class="page-header">
		<div class="panel-body" >
				<div class="col-xs-5">
					<div class="input-group">
						<span class="input-group-addon">商品名称</span>
						<input type="text" class="form-control" id="product_name" name="product_name" value="${queryParam.product_name}">
					</div>
				</div>
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>
			</div>
		
	</div>
	<!-- /page header -->
	
	<!-- Content area -->
	<div class="content">
		
		<div class="row"> 
			<c:forEach items="${pageInfo.list}" var="info">
				<div class="col-md-3" height="180">
					<div class="thumbnail">
						<div class="thumb">
							<img src="${imageDomain }${info.product_img}" alt="" style="width:180px;height:180px;">
						 </div>
						 <div class="panel-heading">
							<span class="text-muted" style="min-height:37px;max-height:37px;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-box-orient:vertical;-webkit-line-clamp:2;">${info.product_name }</span>
							<input type="hidden" class="info" value="${info.product_id }"  product_name="${info.product_name }" product_img="${imageDomain }${info.product_img }"/>
						 </div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div id="pager" class="panel-body"></div>
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
    
    //判断是否选中回显复选框勾选。判断是否存在缓存商品ids，如果存在表示要回显
    if(window.parent.$("#cacheOpenProductId").val()!=''){
    	//判断是哪个页面的那个控件打开的弹出框
    	var product_div_id=window.parent.$("#cacheOpenProductId").val();
    	//获取打开控件中已有的商品
    	var productIds=window.parent.$("#"+product_div_id).parent().find("#"+product_div_id+"Values").val().split(",");
    	//存在缓存则选中复选框
    	$('.col-md-3').each(function(i,e){
    		for(var j=0;j<productIds.length;j++){
        		if($(this).find(".info").val()==productIds[j]){
        			$(this).addClass('selected');
        		}
        	}
	    });
    	
    	
    }
    
 	// 商品选择
	$('.col-md-3').click(function () {
	  $(this).toggleClass('selected');
	  if ($('.col-md-3.selected').length == 0)
	    $('.select').removeClass('selected');
	  else
	    $('.select').addClass('selected');
	});

});


</script>