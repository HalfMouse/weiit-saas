<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>群发消息用户管理</title>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<%@include file="../common/header.jsp"%>
</head>
<body>
<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
	<div class="sidebar-content">
		<!-- Sub navigation -->
		<div class="sidebar-category">
			<div class="category-content no-padding">
				<ul class="navigation navigation-alt navigation-accordion">
					<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
					<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
					<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
					<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
				</ul>
			</div>
		</div>
		<!-- /sub navigation -->
	</div>
</div>	
<!--  /Secondary sidebar -->	
<!-- Main content -->
<div class="col-md-13">
	<!-- Page header -->
	<div class="page-header"> 
		<div class="page-header-content" >
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold">消息群发</span>
				</h4>
			</div> 
		</div> 
	</div>
	<!-- /page header --> 
	<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/weixin/batchSending/batchSendingUsersLog" method="post" >
	<input type="hidden" name="record_id" value="${queryParam.record_id}">		
	<!-- /page header -->
	<!-- begin #content -->
	<div id="content" class="content  p-b-0 m-b-0" style="padding-top:0px;">
		<div class="row">			
			<div class="tab-content p-b-0 m-b-0">
				<div class="tab-pane fade active in" id="default-tab-1">
					<!-- begin panel -->
					<div class="panel panel-inverse" data-sortable-id="form-stuff-1">

						<div class="panel-body p-0">
							<div class="col-md-3">
								<div class="input-group">
									<span class="input-group-addon">会员名</span>
									<input type="text" class="form-control" placeholder="" name="user_name" value="${queryParam.user_name}">
								</div>
							</div>
							&nbsp;&nbsp;
							<button class="btn bg-blue" type="submit">搜索</button>&nbsp;&nbsp;
							<a href="${pageContext.request.contextPath}/center/weixin/batchSending/list?type=1" 
								title="返回列表" class="btn btn-default m-r-5 m-b-5" >返回</a>
							
							<br><br>
						
							<div class="table-responsive">
								<table id="data-table"
									class="table table-striped table-bordered nowrap"
									width="100%">
									<thead>
										<tr>
											<th>头像</th>
											<th>会员名</th> 
											<th>发送时间</th>
											<th width="30%">状态</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${pageInfo.list}" var="info"
											varStatus="ind">
											<tr>
												<td><img src="${info.user_img }" width="40" height="40" /></td>
												<td>${info.user_name }</td>
												<td>
													<c:if test="${info.state==0 or info.state==-1}">
														<fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss" />
													</c:if>
												</td>
												<td>
													<c:if test="${info.state==-1 }">失败(${info.reason })</c:if>
													<c:if test="${info.state==0 }">成功</c:if>
													<c:if test="${info.state==1 }">待发送</c:if>
												</td>

											</tr>

										</c:forEach>

									</tbody>
								</table>
							</div>
							<div id="pager" class="panel-body"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>
</form>
</div>
		<!-- end #content -->
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
		</script>
</body>
</html>
