<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<!-- Main content -->
<div class="col-md-13">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4><i class="icon-arrow-left52 position-left"></i>
				<span class="text-semibold">
					<c:if test="${parent_id == -1 }">
						图片上传
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
				<li class="active">图片上传</li>
			</ul>
 			<ul class="breadcrumb" style="float:right;margin-right:30px;">
				<li><a href="${pageContext.request.contextPath}/center/file/picture/list?parent_id=${parent_id}"><i class="icon-folder-upload3 position-left"></i> 查看最新上传</a></li>
			</ul> 
		</div>
		
	</div>
	<!-- /page header -->

	<!-- Content area -->
	<div class="content">
		<!-- Multiple file upload -->
		<form action="${pageContext.request.contextPath}/center/file/picture/uploadExec?parent_id=${parent_id}" class="dropzone" id="dropzone_file_limits"></form>
		<!-- /multiple file upload -->
	</div>

	<!-- /content area -->
</div>
<!-- /main content -->



<%@include file="../common/footer.jsp" %>
<script>
$(function() {
    Dropzone.autoDiscover = false;
    // 多图片上传
    $("#dropzone_file_limits").dropzone({
        paramName: "files", // The name that will be used to transfer the file
        dictDefaultMessage: '把图片拖拽到这里 <span>或 点击</span>',
        method:"post",
        maxFileSize: 13, // 文件限制大小MB
        maxFiles: 30,//最多允许上传文件数
        maxThumbnailFilesize: 1,
        addRemoveLinks: true,
        success:function(a){
        	console.log(a);
        }
    });
});
</script>
