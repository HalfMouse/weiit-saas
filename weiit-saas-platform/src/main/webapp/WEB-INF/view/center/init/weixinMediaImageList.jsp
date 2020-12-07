<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<style>
.yang-class {
	max-width: 1488px;
	min-width: 940px;
	height: 40px;
	overflow: hidden;
	position: relative
}

.yang-class ul {
	float: left;
	padding-left: 40px;
	max-width: 1480px;
	min-width: 960px;
	padding-right: 160px;
	margin-bottom: 10px
}

.yang-class ul li {
	float: left;
	height: 30px;
	margin-left: 26px;
	position: relative;
	z-index: 1
}

.yang-class ul li.on a {
	color: #10c55b
}

.yang-class ul li span {
	width: 100%;
	height: 40px;
	display: block;
	position: absolute;
	z-index: 10;
	top: 0;
	left: 0;
	cursor: pointer
}

.yang-check i {
	background: url(http://pic.qiantucdn.com/yang/img/icon25.png) 1px -110px
}

.yang-class ul li a {
	font-size: 14px;
	line-height: 38px
}

.yang-class ul li i {
	width: 16px;
	height: 16px;
	display: block;
	float: left;
	border: 1px solid #d3d3d3;
	margin-top: 11px;
	margin-right: 5px
}

.yang-class ul li:hover a {
	color: #10c55b
}

.yang-class ul li:hover i {
	border: 1px solid #10c55b
}

.yang-class strong {
	font-weight: 700;
	display: block;
	height: 25px;
	font-size: 14px;
	position: absolute;
	left: 10px;
	top: 9px
}

ol,ul {
	list-style: none
}
a {
	color: #666;
	text-decoration: none;
	cursor: pointer
}

</style>
<!-- Main content -->
<div class="content-wrapper">

<!-- Content building -->
<div class="content">
  <!-- Content area -->
	<div class="content">
		<ul class="nav  nav-tabs"> 
			<li><a href="${pageContext.request.contextPath}/center/weixinMedia/weixinMediaImageCateList" style="border-left:0px;border-top:0px;">微信公共图片分类</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixinMedia/weixinMediaImageList">微信公共图片</a></li>
		</ul>
		<!-- Navbar navigation -->
		<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
			<div class="panel-heading">
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
					<span class="text-semibold">
						微信公共图片，指的是官方团队可以上传优质的图片，供商户使用。</span><br>
					
				</div> 
			</div>

	        <div class="panel-body">
	           <div class="row search-option-buttons">
					<div class="col-sm-12">
						<ul class="list-inline no-margin-bottom">
							<li><a  class="btn btn-success"  data-toggle="modal" data-target="#images-modal-folder" onclick="imageCate('')" ><i class="fa fa-photo position-left"></i>上传图片</a></li>
						</ul>
					</div>
				</div>
				<br> 
			    <div class="yang-class">
			     <strong>分类：</strong>
			     <ul id="industry_key" data-id="1">
					 <li class="fl ${(empty formMap.media_cate_id)?'on':''}"><a href="${pageContext.request.contextPath}/center/weixinMedia/weixinMediaImageList">全部</a></li>
					 <c:forEach items="${sortList}" var="info">
						 <li class="fl ${(info.id eq formMap.media_cate_id)?'on':''}"><a href="${pageContext.request.contextPath}/center/weixinMedia/weixinMediaImageList?media_cate_id=${info.id}">${info.cate_name}</a></li>
					 </c:forEach>
			     </ul>
			    </div>


				<div class="row">
					<c:forEach items="${pageInfo.list}" var="info">
					<div class="col-md-3" style="width:350px;height:235px;"> 
						<div class="thumbnail" style="height:235px;">
							<div class="thumb" style="height:182px;">
								<img src="${imageDomain }${info.image_url }" alt="" style="width:320px;height:180px;">
								<div class="caption-overflow"> 
								<span>
									<a href="${imageDomain }${info.image_url }" class="btn bg-orange  btn-icon" data-popup="lightbox" target="_blank"><i class="icon-zoomin3 position-left"></i>预览</a>
									<a href="javascript:;" onclick="WIremove('${info.image_id}')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt"></i>删除</a>
								 </span>
								</div> 
							</div>
							 <div class="panel-heading" style="height:50px">
								上传时间:${info.create_time }
							</div>
						</div>
					</div>	
					</c:forEach>
				</div>
				<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/weixinMedia/weixinMediaImageList?media_cate_id=${formMap.media_cate_id}" method="post">
				<div id="pager" class="panel-body"></div>
				</form>
	        </div>
    	</div>

	</div>
</div>
<!-- /content building -->

</div>
<!-- /main content -->

<div id="images-modal-folder" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background:white;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">上传图片</h2>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/weixinMedia/insertImage" method="post"  enctype="multipart/form-data">
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-sm-3 control-label text-right "> 图片分类<font color="red">*</font></label>
							<div class="col-sm-4">
								<select name="cate_id" id="cate_id" class="select" >
									<c:forEach items="${sortList}" var="info">
										<option value="${info.id}">${info.cate_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right"> 排序<font
									color="red">*</font>
							</label>
							<div class="col-sm-4">
								<input type="text" name="sort_num" id="sort_num" value="" class="form-contro" >
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right ">选择图片<span class="text-danger">*</span></label>
							<div class="col-md-6">
								<input type="file" name="file" class="bootstrap-uploader validate[required]" id="file">
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


<%@include file="../common/footer.jsp"%>
<script>

    $(document).ready(function() {
        $("#pager").pager({
            pagenumber: ${pageInfo.pageNum},
            pagecount: ${pageInfo.pages},
            pagesize: ${pageInfo.pageSize} ,
            pagerecordSize: ${pageInfo.total},
            buttonClickCallback: searchSubmit });

        $('#infoForm').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
    });

    //表单提交
    $("#buttonsave").click(function(){
        $("#infoForm").submit();
    });


    function uploadImage(){
        window.location="${pageContext.request.contextPath}/center/weixinMedia/insertImage";
    }

    function WIremove(image_id){
        window.location="${pageContext.request.contextPath}/center/weixinMedia/imageDelete?image_id="+image_id;
    }


</script>