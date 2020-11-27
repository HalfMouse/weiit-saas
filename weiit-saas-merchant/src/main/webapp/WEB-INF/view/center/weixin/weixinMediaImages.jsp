<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<meta name="referrer" content="never">

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default"
	style="width: 180px">
	<div class="category-content no-padding">
		<ul class="navigation navigation-alt navigation-accordion">
			<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
		</ul>
	</div>
</div>
<!--  /Secondary sidebar -->
 
<!-- Main content -->
<div class="content-wrapper">
	<!-- Content area -->
	<div class="content">
		<ul class="nav  nav-tabs"> 
			<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list" style="border-left:0px;border-top:0px;"><i class="fa fa-file-image-o position-left"></i>我的图文</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list"><i class="fa fa-photo position-left"></i>我的图片</a></li>
		</ul>
		<!-- Navbar navigation -->
		<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
			<div class="panel-heading">
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
					<span class="text-semibold">
						微信图片素材，指的是商家所绑定的公众号上面用到过的历史的图片管理。<br><br>
						如商家已经把公众号进行绑定了，可以点击<span class="text-warning">公众号同步</span>，同步时下载缓慢请等待。</span><br>
					
				</div> 
			</div>

			<div class="panel-body">
				<span class="text-success text-bold" id="info">${info }</span>
				<span class="text-danger text-bold" id="error">${error }</span>
				<br>
				
				<div class="row search-option-buttons">
						<div class="col-sm-6">
							<ul class="list-inline no-margin-bottom">
								<li><a  class="btn btn-success"  data-toggle="modal" data-target="#images-modal-folder"><i class="fa fa-photo position-left"></i>上传图片</a></li>
							</ul>
						</div>
						<div class="col-sm-6 text-right">
							<ul class="list-inline no-margin-bottom" style="margin-right:70px;">
								<li><a  class="btn bg-orange" onclick="Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaImages/wstoreCommonImages')"><i class="icon-download4 position-left"></i>下载素材</a></li>
								<li><a  class="btn btn-info" id="syncImage"><i class="icon-spinner9 position-left"></i>公众号同步</a></li>
							</ul>  
						</div>
					</div>
					<br> 
						<div class="row"> 
							<c:forEach items="${pageInfo.list}" var="image" varStatus="index">
								<div class="col-md-3" style="min-width:220px;max-width:300px;height:230px;margin-top:12px;"> 
									<div class="thumbnail" style="height:230px;">
										<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
											<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${image.image_url}" alt="">
											<div class="caption-overflow"> 
												<span>
													<a href="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${image.image_url}" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox" target="_blank"><i class="icon-zoomin3 position-left"></i>预览</a>
													<a href="javascript:;"  id="file_${image.image_id }" data-clipboard-text="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${image.image_url}"  class="btn bg-blue-600 btn-rounded btn-icon" onclick="copyUrl('file_${image.image_id }')" ><i class="icon-link position-left"></i>复制链接</a>
													<a href="javascript:;" onclick="WIremove('${image.media_id}')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt position-left"></i>删除</a>
												 </span>
											 </div>
										 </div>
										 <div class="panel-heading" style="height:50px">
											上传时间:<fmt:formatDate value="${image.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/>
										 </div>
									</div>
								</div>
						</c:forEach>
						</div>
						
						<br><br><br><br>
						<c:if test="${pageInfo.total>11 }">
						<form id="searchform" action="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list" method="post">
							<div id="pager" class="panel-body"></div>
						</form>
						</c:if>
				</div>
			</div>
		</div>
		<!-- /navbar navigation -->
</div>

<div id="images-modal-folder" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background:white;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">上传图片</h2>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/uploadImage" method="post"  enctype="multipart/form-data">
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-sm-3 control-label text-right ">选择图片<span class="text-danger">*</span></label>
							<div class="col-md-6">
								<input type="file" name="file" class="bootstrap-uploader" id="file">
								<br>
								<span style="color: gray">只支持本地上传,图库暂时不开放.</span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right "></label>
							<div class="col-md-6">
								<button type="button" class="btn btn-primary" id="buttonsave" onclick="uploadImage()">&nbsp;&nbsp;&nbsp;提交上传&nbsp;&nbsp;&nbsp;</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
			
		</div>
	</div>
</div>

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
		$('#infoForm').validationEngine("attach",{ 
			promptPosition: 'bottomRight', 
			addPromptClass: 'blackPopup formError-small',
			scroll: true,
			showOneMessage: true
		}); 
	 
	 $("#syncImage").click(function(){
		 $("#syncImage").attr("disabled", true);
    	 FullScreenShow("公众号同步操作时需要最长可能需要1分钟，请耐心等待.");
    	 var url="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/syncImage";
    	 window.location.href=url;
	 });
		
});

 
function WIremove(media_id){
	var url="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/remove?media_id="+media_id;
	Mremove("get",url);
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

function uploadImage(){
	$("#buttonsave").attr("disabled", true);
	
	if(!$("#infoForm").validationEngine("validate")){
		$("#buttonsave").removeAttr("disabled");
		return false;
	}else{
		if($("#file").val()==""){
			MAlert("请选择图片");
			$("#buttonsave").removeAttr("disabled"); 
			return false;
		}
		FullScreenShow("数据提交中，请稍后！");
		$("#infoForm").submit();
	}
	
	
}


</script>