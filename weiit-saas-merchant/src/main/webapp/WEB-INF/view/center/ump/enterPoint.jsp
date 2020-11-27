<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
	<!-- Secondary sidebar -->
	<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
		<div class="sidebar-content">
			<!-- Sub navigation -->
			<div class="sidebar-category">
				<div class="category-title">
					<span>营销服务</span>
				</div>
				<div class="category-content no-padding">
					<ul class="navigation navigation-alt navigation-accordion">
						<li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
						<li class="active"><a  href=""><i class="icon-sphere3"></i>入口设置</a></li>
					</ul>
				</div>
			</div>
			<!-- /sub navigation -->

		</div>
	</div>
</div>
<!--  /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">入口设置 </span>
				</h4>
			</div>
		</div>
	</div>
	<!-- Content area -->
	<div class="content">

		<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
			<li  class="active"><a href="${pageContext.request.contextPath}/center/ump/integral/config"><i class="icon-vcard position-left"></i>显示配置</a></li>
		</ul>
		<div class="row">
			<div class="col-md-12">
				<!-- 表单验证开始 -->
				<div class="panel panel-flat">

					<div class="panel-body">


						<div class="profile">
							<form class="form-horizontal" id="infoFrom" name="infoFrom" action="${pageContext.request.contextPath}/center/ump/enterSave" method="post" >
								<fieldset class="content-group">
									<legend class="text-bold"><h4>个人中心入口设置</h4></legend>
									<div class="alert alert-primary no-border">
										<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
										<span class="text-semibold"> 设置显示后，个人中心页将添加相应快捷入口</span><br>
									</div>
									<div class="form-group">
										<label class="control-label col-md-2 text-bold">我的拼团:</label>
										<div class="col-md-2 text-bold"><input type="hidden" value="${queryParam.GROUPON_ID}" name="GROUPON_ID">
											<label class="radio-inline"> <input type="radio" class="styled" name="GROUPON" ${(queryParam.GROUPON ne 0)?"checked":""} value="-1"> 关闭</label>
											<label class="radio-inline"> <input type="radio" class="styled" name="GROUPON" ${(queryParam.GROUPON eq 0)?"checked":""} value="0"> 显示</label>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-2 text-bold">我的砍价:</label>
										<div class="col-md-2 text-bold"><input type="hidden" value="${queryParam.BARGAIN_ID}" name="BARGAIN_ID">
											<label class="radio-inline"> <input type="radio" class="styled" name="BARGAIN" ${(queryParam.BARGAIN ne 0)?"checked":""} value="-1"> 关闭</label>
											<label class="radio-inline"> <input type="radio" class="styled" name="BARGAIN" ${(queryParam.BARGAIN eq 0)?"checked":""} value="0"> 显示</label>
										</div>
									</div>
								</fieldset>
								<div class="text-center">
									<button type="button" onclick="window.location.reload()" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button> &nbsp;&nbsp;&nbsp;&nbsp;
									<button type="submit" class="btn btn-primary">更新<i class="icon-arrow-right14 position-right"></i></button>
								</div>
							</form>
						</div>

					</div>
				</div>
				<!-- /form validation -->
			</div>
		</div>


	</div>
	<!-- /content area -->

</div>

<!-- /main content -->

<%@include file="../common/footer.jsp"%>

<script>
    $(document).ready(function() {
        $('#infoFrom').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
    });
</script>