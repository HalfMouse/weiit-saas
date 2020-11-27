<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>
<style type="text/css">
.csshidden{
    width:320px;
    border:0px solid #ddd;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
}
</style>

<form class="form-horizontal form-validate-jquery" name="searchform"
	id="searchform" action="${pageContext.request.contextPath}/center/publics/log/list" method="post">
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;"> 
	<!-- Page header -->
	<div class="page-header"> 
		<div class="breadcrumb-line"> 
			<ul class="breadcrumb">
				<li><a href="#"><i
						class="icon-home2 position-left"></i> 日志管理</a></li>
				<li><a href="#">日志管理</a></li>
				<li class="active">日志列表</li>
			</ul> 
		</div>
	</div>

	<!-- Content area -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat"> 
			<div class="panel-body">
				<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-addon">日志名称</span>
						<input type="text" name="log_name" value="${queryParam.log_name }" class="form-control" placeholder="">
					</div>
				</div>
				<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-addon">日志级别</span>
						<select class="bootstrap-select" name="log_level" id="log_level">
							<option value="" <c:if test="${queryParam.log_level=='' }">selected="selected"</c:if>>--全部--</option>
							<option value="0" <c:if test="${queryParam.log_level=='0' }">selected="selected"</c:if>>一般</option>	
							<option value="1" <c:if test="${queryParam.log_level=='1' }">selected="selected"</c:if>>警告</option>
							<option value="2" <c:if test="${queryParam.log_level=='2' }">selected="selected"</c:if>>异常</option>
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="input-group">
						<span class="input-group-addon">记录时间</span> 
			                   	<input type="text" class="form-control pickadate-translated" name="startTime" id="startTime" value="${queryParam.startTime}" >
                           		<span class="input-group-addon">--</span>
                            	<input type="text" class="form-control pickadate-translated" name="endTime" id="endTime" value="${queryParam.endTime}" >				    	
					 
					</div>
				</div>
				&nbsp;&nbsp;
				<button class="btn bg-blue" type="submit">搜索</button>
			</div>

			<div class="table-responsive">
				<table id="data-table" class="table table-striped table-hover table-bordered  table-condensed nowrap dataTable">
					<thead>
						<tr>
							<th>ID</th>
							<th>所属业务</th>
							<th>日志名称</th>
							<th>日志级别</th>
							<th>详情</th> 
							<th>记录时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageInfo.list}" var="log">
							<tr>
								<td>${log.log_id}</td>
								<td>${log.service_module }</td>
								<td>${log.log_name}</td>
								<td>
									<c:if test="${log.log_level==0}">
										<font color="#5bc0de">一般</font>
									</c:if> 
									<c:if test="${log.log_level==1}">
										<font color="#f0ad4e">警告</font>
									</c:if> 
									<c:if test="${log.log_level==2}">
										<font color="#d9534f">异常</font>
									</c:if>
								</td>
								<td  width="32%" style="word-wrap:break-word;word-break:break-all;">
									<div class="csshidden" title="${log.content}">${log.content}</div>
								</td> 
								<td><fmt:formatDate value="${log.create_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>

			<div class="panel-body" id="pager"></div>
			
		</div>
		<!-- /bordered striped table -->
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
</form>

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