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
				<c:if test="${mulu!=null }"><li class="active">${mulu.file_name }</li></c:if>
				
			</ul>
 			<ul class="breadcrumb" style="float:right;margin-right:30px;">
				<c:if test="${parent_id!=-1 }">
				<li><a href="${pageContext.request.contextPath}/center/file/picture/upload?parent_id=${parent_id}"><i class="icon-folder-upload3 position-left"></i> 图片上传</a></li>
				</c:if>
				<li><a href="javascript:;" onclick="createFloder()"><i class="icon-folder4 position-left"></i> 新建文件夹</a></li>
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
	         <div class="col-md-3" style="height:290px;min-width:220px;max-width:260px;margin-top:12px;">
				<div class="thumbnail" style="height:290px;">
					<div class="thumb" style="height:240px;"">
						<img src="${pageContext.request.contextPath}/resource/images/floder_yellow.png" alt=""
						 	onclick="onShowFloder(${info.id})" style="cursor:pointer" >
						 	<div class="caption-center">
							<span style="cursor:pointer" onclick="onShowFloder(${info.id})">
								${info.file_name }
							 </span>
						 </div>
					 </div>
					 <div class="panel-heading" style="height:50px;">
						<span class="text-muted">日期:<fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></span>
						 <div class="heading-elements"> 
								<div class="form-group">
									<label class="checkbox-inline checkbox-right">
										<c:if test="${info.is_read!=1}">
										<input type="checkbox" class="styled" name="ids"  value="${info.validate_id}|${info.validate_id_token}"/>
										</c:if>
									</label> 
								</div>
						  </div>
					   </div>
				 </div>
			</div>
			</c:if>
			<c:if test="${info.type eq 0}">
			<div class="col-md-3" style="min-width:220px;max-width:260px;height:290px;margin-top:12px;">
				<div class="thumbnail" style="height:290px;">
					<div class="thumb" style="height:240px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
						<img src="${imageDomain }${info.file_url}" >
						<div class="caption-overflow">
							<span>
								<a href="${imageDomain }${info.file_url}" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
								<a href="javascript:;"  id="file_${info.id }" data-clipboard-text="${imageDomain }${info.file_url}"  class="btn bg-blue-600 btn-rounded btn-icon" onclick="copyUrl('file_${info.id }')" ><i class="icon-link"></i>复制链接</a>
								<c:if test="${info.is_read!=1}">
								<a href="javascript:;" onclick="WIremove('${info.validate_id}','${info.validate_id_token }')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt"></i>删除</a>
								</c:if>
							 </span>
						 </div>
					 </div>
					 <div class="panel-heading" style="height:50px">
						日期:<fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></span>
						
						<div class="heading-elements">
							<div class="form-group">
								<label class="checkbox-inline checkbox-right">
									<c:if test="${info.is_read!=1}">
									<input type="checkbox" class="styled" name="ids"  value="${info.validate_id}|${info.validate_id_token}"/>
									</c:if>
								</label>
							</div>
						</div>
					 </div>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<br><br><br><br>
		<c:if test="${pageInfo.total>19 }">
		<form id="searchform" action="${pageContext.request.contextPath}/center/file/picture/list" method="post">
			<div id="pager" class="panel-body"></div>
			<input type="hidden" name="parent_id" value="${parent_id }"/>
		</form>
		</c:if>
	</div>
	
	<!-- /content area -->
</div>
<!-- /main content -->
</form>

<div id="images-modal-folder" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">新建文件夹</h2>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="folderForm" id="folderForm" action="${pageContext.request.contextPath}/center/file/picture/saveFloder" method="post"  >
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-sm-3 control-label text-right "> <span class="text-danger">*</span>文件夹名称：</label>
							<div class="col-sm-7">
								<input type="text" class="form-control validate[required]" name="file_name" id="file_name" title="请输入文件夹名称" data-errormessage-value-missing="请输入文件夹名称">
							</div>
						</div> 
					</fieldset>
					<div class="text-center">
						<input type="hidden" name="parent_id" id="parent_id" value="${parent_id}"/>
						<button type="submit" class="btn btn-primary" >创建 <i class="icon-checkmark3 position-right"></i></button>&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal">取消 <i class="icon-cross3 position-right"></i></button>
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
   
   /*默认监听表单onbulr验证*/
	$('#folderForm').validationEngine("attach",{ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'blackPopup formError-small',
		scroll: true,
		showOneMessage: true
	}); 
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

function createFloder(){
	$("#images-modal-folder").modal("show");
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