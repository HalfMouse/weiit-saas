<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<%@include file="../common/header.jsp"%>
<title>群发功能</title>
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
	<!-- begin #content -->
	<div id="content" class="content p-b-0 m-b-0">
		<!-- begin row -->
		<div class="row">
			<ul class="nav nav-tabs">
			    <li><a href="javascript:;" onclick="doSending(0)">新建群发消息</a></li>
				<li class="active"><a href="javascript:;" onclick="doSending(1)">已发送</a></li>
			</ul>
			<div class="tab-content p-b-0 m-b-0">
				<div class="tab-pane fade active in">
						<!-- begin panel -->
					<div class="panel panel-inverse" data-sortable-id="form-stuff-1">
						<form class="form-horizontal"  name="searchform" id="searchform" 
	action="${pageContext.request.contextPath}/center/weixin/batchSending/list?type=1" method="post" >		
						<div class="panel-body p-0">
							<div class="table-responsive">
								<table id="data-table"
									class="table table-striped table-bordered nowrap" width="100%">
									<thead>
										<tr>
											<th>消息类型</th>
											<th>消息内容</th>
											<th>群发对象</th>
											<th>发送状态</th>
											<th>发送时间</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${pageInfo.list}" var="info"
											varStatus="ind">
											<tr>
												<td>
												<c:if test="${info.action_type==1 }">
													文本消息
												</c:if> <c:if test="${info.action_type==2 }">
													图文消息
												</c:if> <c:if test="${info.action_type==3 }">
													图片消息
												</c:if>
												</td>
												<td valign="middle" style="vertical-align: middle;">
												<c:if test="${info.action_type==1 }">
													${info.send_content} 
												</c:if>
												<c:if test="${info.action_type==2 }">
													<img alt="" width="100px;" src="${info.cover_img}" /><br/>
													${info.title }
												</c:if>
												<c:if test="${info.action_type==3 }">
													<img alt="" width="100px;" src="${info.image_url}" />
												</c:if>
												</td>
												<td valign="middle" style="vertical-align: middle;">${info.group_tag }</td>
												<td valign="middle" style="vertical-align: middle;">
													<c:if test="${info.state==0 }">
														待定时发送
													</c:if>
													<c:if test="${info.state==1 }">
														已发送
													</c:if>
													(${info.successCount }/${info.allCount})
													<br/>
													<a href="javascript:;" title="立即发送" onclick="WISending(${info.record_id},${info.action_type})" class="btn bg-orange-400 m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">立即发送</a>
												</td>
												<td valign="middle" style="vertical-align: middle;">
													<fmt:formatDate value="${info.send_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td> 
												<td style="padding-top: 0px; padding-bottom: 0px; text-align:center;vertical-align: middle;">
													<a href="${pageContext.request.contextPath}/center/weixin/batchSending/batchSendingUsersLog?record_id=${info.record_id}" 
														title="群发用户记录" class="btn bg-blue m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">群发用户记录</a>
										  			<a href="javascript:;" title="删除" onclick="WIremove(${info.record_id})" class="btn bg-danger-300 m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">删除</a>
												</td>
											</tr>
										</c:forEach>

									</tbody>
								</table>

							</div>
							<div id="pager" class="panel-body"></div>
						</div>
						</form>
					</div>
				</div>	
			</div>
		</div>
		<!-- end row -->
	</div>
	<!-- end #content  -->
</div>
	<%@include file="../common/footer.jsp"%>

	<script language="javascript">
	$(document).ready(function() {
	    $("#pager").pager({
	        pagenumber: ${pageInfo.pageNum}, 
	        pagecount: ${pageInfo.pages},
	        pagesize: ${pageInfo.pageSize} ,
	        pagerecordSize: ${pageInfo.total},
	        buttonClickCallback: searchSubmit });
	});  
	function WIremove(id){
		MConfirm('确定要删除该条群发消息吗？','','',function(result) {
			if(result){
				window.location="${pageContext.request.contextPath}/center/weixin/batchSending/remove?record_id="+id;
			}
		});
	}
	function WISending(id,type){
		MConfirm('确定要立即发送该条定时群发消息吗？','','',function(result) {
			if(result){
				window.location="${pageContext.request.contextPath}/center/weixin/batchSending/immediatelySending?record_id="+id+"&action_type="+type;
			}
		});
	}
	
	function doSending(type){
		window.location="${pageContext.request.contextPath}/center/weixin/batchSending/list?type="+type;	
	}
	</script>
</body>
</html>
