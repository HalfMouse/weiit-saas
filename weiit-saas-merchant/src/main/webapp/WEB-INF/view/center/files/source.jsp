<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/file/picture/source" method="post" >						
<!-- Main content -->
<div class="col-md-13">
	<!-- Page header -->
	<div class="page-header">
		<div class="breadcrumb-line">
			<ul class="breadcrumb">
				<c:if test="${mulu==null }">
					<li><a href="${pageContext.request.contextPath}/center/file/picture/source?parent_id=-1"><i class="icon-home2 position-left"></i> 图片空间</a></li>
				</c:if>
				<c:if test="${mulu!=null }">
					<li><a href="javascript:window.history.back();"><i class="icon-arrow-left52 position-left"></i> 返回上一层</a></li>
					<li class="active">${mulu.file_name }</li>
				</c:if>
			</ul>
		</div>
		
	</div>
	<!-- /page header -->
	
	<!-- Content area -->
	<div class="content">
		<div class="row"> 
		<c:forEach items="${pageInfo.list}" var="info">
			<c:if test="${info.type eq 1}">
	         <div class="col-md-3" style="width:200px;height:200px;">
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
			<div class="col-md-3" style="width:200px;height:200px;"> 
				<div class="thumbnail">
					<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
						<img src="${imageDomain }${info.file_url}">
						<div class="caption-overflow">
							<span>
								<a href="${imageDomain }${info.file_url}" class="btn bg-orange btn-rounded btn-icon" data-popup="lightbox">
									<i class="icon-zoomin3"></i>预览
								</a>
								<a href="javascript:;" title="${info.file_url}" class="btn bg-blue btn-rounded btn-icon" onclick="insert('${imageDomain }','${info.file_url}')" data-dismiss="modal">
									<i class="icon-link"></i>插入
								</a>
							 </span>
						 </div>
					 </div>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<c:if test="${pageInfo.total>19 }">
		<form id="searchform" action="${pageContext.request.contextPath}/center/file/picture/source" method="post">
			<div id="pager" class="panel-body"></div>
			<input type="hidden" name="parent_id" value="${parent_id }"/>
		</form>
		</c:if>
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

function onShowFloder(id){
	window.location="${pageContext.request.contextPath}/center/file/picture/source?parent_id="+id;	
}

 
</script>