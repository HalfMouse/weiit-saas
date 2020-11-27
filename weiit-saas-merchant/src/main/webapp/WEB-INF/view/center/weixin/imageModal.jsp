<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/weixin/weixinReply/imageModal" method="post" >						
<!-- Main content -->
<div class="col-md-13">

	<!-- Content area -->
	<div class="content">
		<div class="row"> 
		<c:forEach items="${pageInfo.list}" var="info"> 
			<div class="col-md-3" style="width:200px;height:200px;"> 
				<div class="thumbnail">
					<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
						<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${info.image_url}">
						<div class="caption-overflow">
							<span>
								<a href="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${info.image_url}" class="btn bg-orange btn-rounded btn-icon" data-popup="lightbox" target="_blank">
									<i class="icon-zoomin3"></i>预览
								</a>
								<a href="javascript:;" title="${info.image_url}" class="btn bg-blue btn-rounded btn-icon" onclick="selectReturn('${info.media_id}','http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${info.image_url}')" data-dismiss="modal">
									<i class="icon-link"></i>插入
								</a>
							 </span>
						 </div>
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
});

function selectReturn(media_id,images){
	parent.returnSelectImages(media_id,images);
}
 
</script>