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
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold"> 会员积分记录 </span>
				</h4>
			</div>
			<div class="heading-elements" >
				<ul class="breadcrumb-elements"> 
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
						<ul class="dropdown-menu dropdown-menu-right">
							<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_account">会员名</label></li>
							<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="integral">变动积分</label></li>
							<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="last_integral">变动后余额</label></li>
							<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="create_time">时间</label></li>
							<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="remark">明细</label></li>
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
				<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/user/integralList" method="post">
					<input type="hidden" name="user_id" id="user_id" value="${queryParam.user_id}"/>
					<div class="col-md-3">
							<div class="input-group">
								<span class="input-group-addon">会员名称</span>
								<input type="text" class="form-control" placeholder="" name="user_account" value="${queryParam.user_account }">
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
								<th class="user_account">会员名</th>	
								<th class="integral">变动积分</th>
								<th class="last_integral">变动后积分</th>
								<th class="create_time">时间</th>
								<th class="remark">明细</th>	
							</tr>
						</thead>
						<tbody>
							
			         	<c:forEach items="${pageInfo.list}" var="user">
							<tr>
							   <td><img src="${user.user_img}" width="40" height="40"/>&nbsp;&nbsp;${user.user_account }</td>
							   <td>
							   <c:if test="${user.state==0 }"><span class='text-success text-bold'>+${user.integral }</span></c:if>
							   <c:if test="${user.state==-1 }"><span class='text-danger text-bold'>${user.integral }</span></c:if>
							   </td>
							   <td><span class='text-success text-bold'>${user.last_integral }</span></td>
	                           <td><fmt:formatDate value="${user.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							   <td>${user.remark }</td>
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
</script>