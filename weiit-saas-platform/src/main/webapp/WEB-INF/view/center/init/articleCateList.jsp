<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp" %>

<!-- Main content -->
<div class="content-wrapper">

	<!-- Content area -->
	<div class="content">
		<ul class="nav  nav-tabs">
			<li class="active"><a href="${pageContext.request.contextPath}/center/articleCate/list" style="border-left:0px;border-top:0px;">微信公共图文分类</a></li>
			<li><a href="${pageContext.request.contextPath}/center/article/list">微信公共图文</a></li>
		</ul>
		<!-- Navbar navigation -->
		<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
			<div class="panel-heading">
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
					<span class="text-semibold">
						微信公共图文分类，是用于管理商户端微信官方图文的分类。</span><br>
				</div>
			</div>
			<div class="panel-body">
				<div style="float:left;">
					<a href="${pageContext.request.contextPath}/center/articleCate/add" class="btn bg-blue">新增图文分类</a>
				</div>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/articleCate/list" method="post">
					<div class="table-responsive">
						<table id="data-table"
							   class="table">
							<thead>
							<tr>
								<th>编号</th>
								<th>图文分类名称</th>
								<th>创建时间</th>
								<th>序号</th>
								<th width="150">操作</th>
							</tr>
							</thead>
							<c:forEach items="${pageInfo.list}" var="info">
							<tr>
								<td>${info.id}</td>
								<td>${info.cate_name}</td>
								<td>${info.create_time}</td>
								<td>${info.sort_num}</td>
								<td>
									<a href="javascript:;" title="编辑" onclick="WIedit('${info.id}')" >编辑</a>
									<a href="javascript:;" title="置顶" onclick="WIeditSort('${info.id}')" >置顶</a>
								</td>
							</tr>
							</c:forEach>
						</table>
					</div>
					<div id="pager" class="panel-body"></div>
				</form>
			</div>
		</div>
		<!-- /bordered striped table -->
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->

<%@include file="../common/footer.jsp"%>
<script>
    $(document).ready(function() {
        $("#pager").pager({
            pagenumber: ${pageInfo.pageNum},
            pagecount: ${pageInfo.pages},
            pagesize: ${pageInfo.pageSize} ,
            pagerecordSize: ${pageInfo.total},
            buttonClickCallback: searchSubmit });
    });

    function WIedit(id){
        window.location="${pageContext.request.contextPath}/center/articleCate/edit?cate_id="+id;
    }

    function WIeditSort(id){
        window.location="${pageContext.request.contextPath}/center/articleCate/sort?cate_id="+id;
    }



</script>

