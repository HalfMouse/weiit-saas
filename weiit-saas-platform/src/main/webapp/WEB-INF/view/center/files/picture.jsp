<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<form class="form-horizontal"  name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/file/picture/list" method="post" > 
<!-- Main content -->
<div class="col-md-13">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4><i class="icon-arrow-left52 position-left"></i>
				<span class="text-semibold">
					<c:if test="${parent_id == -1 }">
						图片空间首页
					</c:if>
					<c:if test="${parent_id != -1 }">
						<a href="javascript:window.history.back();">返回上级目录</a>
					</c:if>
				</span></h4>
			</div>
		</div>
		<div class="breadcrumb-line">
			<ul class="breadcrumb">
				<li><a href="${pageContext.request.contextPath}/center/file/picture/list?parent_id=-1"><i class="icon-home2 position-left"></i> 图片空间</a></li>
				<li class="active">图片空间</li>
			</ul>
 			<ul class="breadcrumb" style="float:right;margin-right:30px;">
				<li><a href="${pageContext.request.contextPath}/center/file/picture/upload?parent_id=${parent_id}"><i class="icon-folder-upload3 position-left"></i> 图片上传</a></li>
				<li><a href="javascript:;" onclick="BatchWIremove()" data-toggle="modal" data-target="#remove_batch_modal"><i class="icon-trash"></i> 批量删除</a></li>
			</ul> 
		</div>
		
	</div>
	<!-- /page header -->
	
	<!-- Content area -->
	<div class="content">
		<div class="row"> 
		<c:forEach items="${pageInfo.list}" var="info">
			<c:if test="${info.type eq 1}">
	         <div class="col-md-3" style="width:252px;">
				<div class="thumbnail">
					<div class="thumb">
						<img src="${pageContext.request.contextPath}/resource/images/floder_yellow.png" alt=""
						 	onclick="onShowFloder(${info.id})" style="width:300px;height:250px;cursor:pointer" >
						 	<div class="caption-center">
							<span>
								${info.file_name }
							 </span>
						 </div>
					 </div>
					 <div class="panel-heading">
						<span class="text-muted">日期:<fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></span>
						 <div class="heading-elements"> 
								<div class="form-group">
									
								</div>
						  </div>
					   </div>
				 </div>
			</div>
			</c:if>
			<c:if test="${info.type eq 0}">
			<div class="col-md-3"  style="width:252px;">
				<div class="thumbnail">
					<div class="thumb">
						<img src="${imageDomain }${info.file_url}" alt="" 
							style="width:300px;height:250px;">
						<div class="caption-overflow">
							<span>
								<a href="${imageDomain }${info.file_url}" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
								<a href="javascript:;"  id="file_${info.id }" data-clipboard-text="${imageDomain }${info.file_url}"  class="btn bg-blue-600 btn-rounded btn-icon" onclick="copyUrl('file_${info.id }')" ><i class="icon-link"></i>复制链接</a>
								<a href="javascript:;" onclick="WIremove('${info.validate_id}','${info.validate_id_token }')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt"></i>删除</a>
							 </span>
						 </div>
					 </div>
					 <div class="panel-heading">
						日期:<fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></span>
						
						<div class="heading-elements">
							<div class="form-group">
								<label class="checkbox-inline checkbox-right">
									<input type="checkbox" class="styled" name="ids"  value="${info.validate_id}|${info.validate_id_token}"/>
								</label>
							</div>
						</div>
					 </div>
				</div>
			</div>
			</c:if>
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
});

function onShowFloder(id){
	window.location="${pageContext.request.contextPath}/center/file/picture/list?parent_id="+id;	
}
 
function WIremove(validate_id,validate_id_token){
	var url="${pageContext.request.contextPath}/center/file/picture/remove?parent_id=${parent_id}&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
	Mremove("get",url);
}

function BatchWIremove(){
	MremoveBath("input[name='ids']","${pageContext.request.contextPath}/center/file/picture/removeBatch?parent_id=${parent_id}");
}


function copyUrl(id){
	var clipboard = new Clipboard('#'+id);
    clipboard.on('success', function(e) {
    	$("#"+id).attr("disabled","disabled");
    	$("#"+id).html("<i class='icon-link'></i>已复制");
    });
    clipboard.on('error', function(e) {
     	$("#"+id).attr("class","btn bg-danger btn-rounded btn-icon");
    	$("#"+id).html("<i class='icon-link'></i>复制失败");
    });
}
</script>