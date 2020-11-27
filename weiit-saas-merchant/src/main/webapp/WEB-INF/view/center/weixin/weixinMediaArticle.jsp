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
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list" style="border-left:0px;border-top:0px;"><i class="fa fa-file-image-o position-left"></i>我的图文</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list"><i class="fa fa-photo position-left"></i>我的图片</a></li>
		</ul>
		<!-- Navbar navigation -->
		<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
			<div class="panel-heading">
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
					<span class="text-semibold">
						公众号图文，管理的是所绑定的公众号的所有的图文<br><br>
						商家可以点击“发送”可以将图文推送到其所关注该公众号的微信用户去，
						</span>
						<span class="text-warning">微信规定：服务号一个月可以推送4次。</span><br>
					
				</div> 
			</div>

			<div class="panel-body">
				<span class="text-success text-bold" id="info"></span>
				<span class="text-danger text-bold" id="error"></span>
				<br>
				
				<div class="row search-option-buttons">
						<div class="col-sm-12 text-right">
							<ul class="list-inline no-margin-bottom" style="margin-right:70px;">
								<li><a  class="btn btn-success" onclick="Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/add')"><i class="icon-plus2 position-left"></i>新建图文</a></li>
								<li><a  class="btn bg-blue-600" onclick="Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/sendMulti')"><i class="icon-paperplane position-left"></i>发送多图文</a></li>
								<!-- <li><a  class="btn btn-info"><i class="icon-spinner9 position-left"></i>公众号同步</a></li> --> 
							</ul>
						</div>
					</div>
					<br> 
						<div class="row"> 
						<c:forEach items="${pageInfo.list}" var="ar" varStatus="index">
								<div class="col-md-3" style="min-width:220px;max-width:300px;height:250px;margin-top:12px;"> 
									<div class="thumbnail" style="height:250px;">
										<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
											<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${ar.cover_img}" alt="">
											<div class="caption-overflow"> 
												<span>
													<a href="javascript:;" class="btn bg-info btn-rounded btn-icon" onclick="Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/edit?validate_id=${ar.validate_id }&validate_id_token=${ar.validate_id_token }&media_id=${ar.media_id }')" ><i class="icon-pencil5 position-left"></i>编辑</a>
													<a href="javascript:;"  onclick="Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/selectUser?ids=${ar.id }')" class="btn bg-blue-600 btn-rounded btn-icon" ><i class="icon-paperplane position-left"></i>发送图文</a>
													<a href="javascript:;" onclick="WIremove('${ar.media_id}','${ar.validate_id }','${ar.validate_id_token }')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt position-left"></i>删除</a>
												 </span>
											 </div>
										 </div>
										 <div class="panel-heading" style="height:60px;word-wrap:break-word;word-break:break-all;">
											${ar.title}
											
										 </div> 
									</div>
								</div>
						</c:forEach>
						</div>
						
						<br><br><br><br>
						<c:if test="${pageInfo.total>11 }">
						<form id="searchform" action="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list" method="post">
							<div id="pager" class="panel-body"></div>
						</form>
						</c:if>
				</div>
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

 
function WIremove(media_id,validate_id,validate_id_token){
	var url="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/remove?media_id="+media_id+"&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
	 
	MConfirm('确定要删除该图文吗','','',function(result) {
		if(result){
			$("#removeForm").attr("action",url);
			$("#removeForm").submit();
			FullScreenShow("图文正在删除中，请耐心等待.");
		}
	});
}



</script>