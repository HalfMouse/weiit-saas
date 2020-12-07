<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="common/header.jsp" %>

			<!-- Main content -->
			<div class="content-wrapper">
				
				<!-- Page header -->
				<div class="page-header">
					<div class="breadcrumb-line">
						<ul class="breadcrumb">
							<li><a href="index.html"><i class="icon-home2 position-left"></i>系统管理</a></li>
							<li class="active">修改密码</li>
						</ul>

						
					</div>
					
				</div>
				<!-- /page header -->
				<!-- Edit modal -->
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">修改密码</h5>
								</div>
	
								<div class="modal-body">
									<form class="form-horizontal" action="${pageContext.request.contextPath}/center/manager/updatePassword" method="post">
											<fieldset class="content-group">
												<div class="form-group">
													<label class="control-label col-md-2">原密码 </label>
													<div class="col-md-9">
														<input type="password" class="form-control input-rounded" name="oldPassword" value="${oldPassword }">
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">新密码 </label>
													<div class="col-md-9">
														<input type="password" class="form-control input-rounded" name="password" value="${password }" >
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">确认密码 </label>
													<div class="col-md-9">
														<input type="password" class="form-control input-rounded" name="confirmPassword" value="${confirmPassword }" >
													</div>
												</div>
												
											</fieldset>
	
											<div class="text-right">
												<input type="hidden" name="validate_id" value="${sessionScope[sessionUserKey].validate_id }"/>
												<input type="hidden" name="validate_id_token" value="${sessionScope[sessionUserKey].validate_id_token }"/>
												<button type="reset" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>
												<button type="submit" class="btn btn-primary">提交 <i class="icon-arrow-right14 position-right"></i></button>
											</div>
										</form>
								</div>
								
							</div>
						</div>
				</div>
				<!-- /content area -->

<%@include file="common/footer.jsp" %>
<script type="text/javascript">
$(function(){
	if("${notifyMessage}"!=''){
	 new PNotify({title: '提示操作',text: '${notifyMessage}',addclass: 'bg-info'});
	}
	 }
);
</script>