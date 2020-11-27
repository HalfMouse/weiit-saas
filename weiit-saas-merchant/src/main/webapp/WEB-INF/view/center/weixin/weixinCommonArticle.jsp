<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<meta name="referrer" content="never">
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
			<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list" style="border-left:0px;border-top:0px;"><i class="fa fa-photo position-left"></i>我的公众号图片库</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/wstoreCommonImages"><i class="icon-images3 position-left"></i>蜗店图片库</a></li>
		</ul>
		<!-- Navbar navigation -->
		<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
			<div class="panel-heading">
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
					<span class="text-semibold">
						官方素材，指的是蜗店设计的一些优美的图片，可以让商家选择下载使用。<br><br>
						选择下载后，我们会将下载后的图片同步到您的公众号中去</span><br>
					
				</div> 
			</div>
			
			<div class="panel-body">
				<span class="text-success text-bold" id="info"></span>
				<span class="text-danger text-bold" id="error"></span>
				<br>
			    <div class="yang-class">
			     <strong>分类：</strong>
			     <ul id="industry_key" data-id="1">
			      <li class="fl <c:if test="${empty param.media_cate_id or param.media_cate_id=='' }">on</c:if>"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/wstoreCommonImages">全部</a></li>
			      <c:forEach items="${imageCateList }" var="cate">
			      	<li class="fl <c:if test="${cate.id==param.media_cate_id }">on</c:if>"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/wstoreCommonImages?media_cate_id=${cate.id}">${cate.cate_name }</a></li>
			      </c:forEach>
			     </ul>
			    </div>
			    
			    
			    <br> 
					 <div class="row"> 
							<c:forEach items="${pageInfo.list}" var="image" varStatus="index">
								<div class="col-md-3" style="width:350px;height:235px;"> 
									<div class="thumbnail" style="height:235px;">
										<div class="thumb" style="height:182px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
											<img src="${imageDomain }${image.image_url}" alt="">
											<div class="caption-overflow"> 
												<span>
													<a href="${imageDomain }${image.image_url}" class="btn bg-orange  btn-icon" data-popup="lightbox" target="_blank"><i class="icon-zoomin3 position-left"></i>预览</a>
													<a href="javascript:;"   class="btn bg-green  btn-icon"  onclick="downloadImage('${image.image_id }')"><i class="icon-download position-left"></i>免费下载</a>
												 </span>
											 </div> 
										 </div>
										 <div class="panel-heading" style="height:50px">
											上传时间:<fmt:formatDate value="${image.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/>
										 </div>
									</div>
								</div>
								<c:if test="${index.count%4==0 and index.count!=0}">
								</div><br><div class="row">
								</c:if>
						</c:forEach>
						</div>
						
						<br><br><br><br>
						<c:if test="${pageInfo.list.size()>11 }">
						<form id="searchform" action="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list" method="post">
							<div id="pager" class="panel-body"></div>
						</form>
						</c:if>
			</div> 
		</div>
		<!-- /navbar navigation -->
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
   
   
});

function downloadImage(imageId){
	FullScreenShow("正在下载图片，请耐心等待."); 
 	 
	 $.ajax({
	     url: '${pageContext.request.contextPath}/center/weixin/weixinMediaImages/download',
	     type: 'POST',
	     data:{image_id:imageId},
	     success:function(res){
	    	console.log(res);
	    	var res=eval("("+res+")");
	    	if(res.code=="0"){
	    		$("#info").html(res.message);
	    	}else{
	    		$("#error").html(res.message);
	    	}
	    	
	     } 
	 })
	 .done(function(res) {
	     // success and do something
	      FullScreenHide();
	 })
	 .fail(function(res) {
	     // fail and do something
	 });
}

</script>