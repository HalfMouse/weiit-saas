<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>


<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold"> 服务协议列表 </span>
				</h4>
			</div>
			<div class="heading-elements">
				<ul class="breadcrumb-elements">
					<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick="WIADD()" ><i class="icon-add position-left"></i>新建服务协议</button></li>
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
				<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
					<div class="table-responsive">
						<table id="data-table"
							   class="table">
							<thead>
							<tr>
								<th>协议标题</th>
								<th>协议内容</th>
								<th>创建时间</th>
								<th width="150">操作</th>
							</tr>
							</thead>
							<c:forEach items="${pageInfo.list}" var="info">
								<tr>
									<td>${info.protocol_title}</td>
									<td>${info.protocol_content}...</td>
									<td><fmt:formatDate value="${info.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
									<td>
										<a href="javascript:;" title="编辑" onclick="WIedit('${info.id}','${info.validate_id_token}')" >编辑</a>
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

    function WIADD(){
        window.location="${pageContext.request.contextPath}/center/agreement/add";
    }

    function WIedit(id){
        window.location="${pageContext.request.contextPath}/center/agreement/edit?id="+id;
    }


</script>

