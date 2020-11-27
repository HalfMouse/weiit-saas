<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<style>
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
	action="${pageContext.request.contextPath}/center/file/picture/pictureSource_usercard" method="post" >						
<!-- Main content -->
<div class="col-md-13">
	<!-- Page header
	<div class="page-header">
		<div class="breadcrumb-line">
			<ul class="breadcrumb">
				<li><a href="index.html"><i class="icon-home2 position-left"></i> 文件管理</a></li>
				<li>图片空间</li>
				<li class="active">会员卡图片</li>
			</ul>
		</div>
		
	</div> -->
	<!-- /page header -->
	
	<!-- Content area -->
	<div class="content">
		<div class="row"> 
		<c:forEach items="${pageInfo.list}" var="info">
			<c:if test="${info.type eq 1}">
	         <div class="col-md-3" height="150">
				<div class="thumbnail">
					<div class="thumb">
						<img src="${pageContext.request.contextPath}/resource/images/floder_yellow.png" alt="" onclick="onShowFloder(${info.id})" style="width:180px;height:180px;cursor:pointer" >
						 <div style="position: absolute;margin-left: 70px;margin-top: -90px;color: white;font-weight:bold;">
							<span>
								${info.file_name }
							 </span>
						 </div>
					 </div>
				 </div>
			</div>
			</c:if>
			<c:if test="${info.type eq 0}">
				<div class="col-md-3" height="180">
					<div class="thumbnail">
						<div class="thumb">
							<img src="${imageDomain }${info.file_url}" alt="" style="width:180px;height:180px;">
						 </div>
						 <div class="panel-heading">
							<span class="text-muted" style="min-height:37px;max-height:37px;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-box-orient:vertical;-webkit-line-clamp:2;">${info.file_name }</span>
							<input type="hidden" class="info" value="${imageDomain }${info.file_url}"/>
						 </div>
					</div>
				</div>
			</c:if>
		</c:forEach>
		</div>
		<c:if test="${pageInfo.total>19 }">
		<div id="pager" class="panel-body"></div>
		</c:if>
	</div>
	
	<!-- /content area -->
</div>
<!-- /main content -->
</form>



<%@include file="../common/footer.jsp" %>
<script>
$(document).ready(function() {
	// 商品选择
	$('.col-md-3').click(function () {
		$('.col-md-3.selected').each(function(){
			$(this).removeClass('selected');
		});
		$(this).addClass('selected');
	  
	});

    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});

function onShowFloder(id){
	window.location="${pageContext.request.contextPath}/center/file/picture/pictureSource_usercard?parent_id="+id;	
}
 
</script>