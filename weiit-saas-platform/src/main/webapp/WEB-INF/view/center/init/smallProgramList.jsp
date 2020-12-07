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
					<span class="text-semibold"> 小程序发布 </span>
				</h4>
			</div>
		</div>
	</div>
	<!-- /page header -->

	<!-- Content area -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
			<div class="panel panel-flat">
				<div class="panel-heading">
					<h5 class="panel-title">小程序发布</h5>
					<a class="heading-elements-toggle"><i class="icon-menu"></i></a></div>

				<div class="panel-body">
					<form class="form-horizontal" action="#">
						<div class="form-group">
							<label class="control-label col-lg-2">&nbsp;&nbsp;&nbsp;&nbsp;模板ID: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${smallProgramInfo.template_id}</label>
						</div>

						<div class="form-group">
							<label class="control-label col-lg-2">&nbsp;&nbsp;&nbsp;&nbsp;版本号: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${smallProgramInfo.version_no}</label>
						</div>

						<div class="form-group">
							<label class="control-label col-lg-2">更新时间: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${smallProgramInfo.create_time}</label>
						</div>

						<div class="form-group">
							<label class="control-label col-lg-2">版本类型: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${smallProgramInfo.version_desc}</label>
						</div>

						<c:if test="${smallProgramInfo.is_new_version eq 0}">
							<div class="text-center">
								<a  onclick="newVersionPush()" class="btn btn-primary">新版本发布 <i class="icon-arrow-right14 position-right"></i></a>
							</div>
						</c:if>

					</form>
				</div>
			</div>
		</div>
		<!-- /bordered striped table -->

	</div>
	<!-- /content area -->
</div>
<!-- /main content -->

<%@include file="../common/footer.jsp"%>

<script>
	function newVersionPush() {
        FullScreenShow("小程序新版本发布中，请耐心等待.");
        window.location.href="${pageContext.request.contextPath}/center/smallprogram/newVersionPush";
    }

</script>


