<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>客户管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="userList"><i class="icon-users"></i>会员管理</a></li>
								<li><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
								<li><a href="userCashList"><i class="icon-cash"></i>会员提现</a></li>
								<li><a href="userSet"><i class="icon-gear"></i>会员设置</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 会员地址库 </span>
							</h4>
						</div>
						<div class="heading-elements" >
							<ul class="breadcrumb-elements">
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn1">会员名</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn2">收件人</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn3"> 手机</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn4"> 省-市-区县</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn5"> 地址</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn6"> 邮政编码</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="addresscolumn7"> 创建时间</label></li>
									</ul>
								</li>
								
							</ul>
						</div>
					</div>  
				</div>
				<!-- /page header -->
				
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
							
							<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/user/addressList" method="post">
								<input type="hidden" name="user_id" id="user_id" value="${queryParam.user_id}"/>
								<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">会员名称</span>
											<input type="text" class="form-control" placeholder="" name="user_name" value="${queryParam.user_name }">
										</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>&nbsp;&nbsp;
							<br>
							<br>
							<div class="table-responsive">
								<table id="data-table" class="table">
									<thead>
										<tr >
											<th class="addresscolumn1">会员名</th>
											<th class="addresscolumn2">收件人</th>
											<th class="addresscolumn3">手机</th>
											<th class="addresscolumn4">省-市-区县</th>
											<th class="addresscolumn5">地址</th>
											<th class="addresscolumn6">邮政编码</th>
											<th class="addresscolumn7">创建时间</th>
											<th class="addresscolumn8">是否默认地址</th>
										</tr>
									</thead>
									<tbody>
										
						           <c:forEach items="${pageInfo.list}" var="user">
										<tr> 
										    <td><img src="${user.user_img}" width="40" height="40"/>&nbsp;&nbsp;${user.user_name}</td>
										    <td>${user.consignee}</td>
										    <td>${user.phone}</td>
										    <td>${user.province}-${user.city }-${user.district }</td>
										    <td>${user.address_detail}</td>
										    <td>${user.zip_code}</td>
										    <td><fmt:formatDate value="${user.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										    <td>
										    	<c:if test="${user.is_default==0}"><span class="label label-info">默认地址</span></c:if>
										    </td>		
										</tr>
									</c:forEach>
									</tbody>
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

function history(){
	window.location="${pageContext.request.contextPath}/center/user/userList";	
} 
</script>