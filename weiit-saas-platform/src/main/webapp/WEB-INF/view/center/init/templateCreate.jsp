<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<!-- Main content -->
			<div class="content-wrapper">
				
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 模板管理 </span>
							</h4>
						</div>
					</div>  
				</div>
				<!-- /page header -->
 
				<!-- Content area -->
				<div class="content">
				
					<!-- /tabs -->
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">

								<div class="panel-body">
									<form class="form-horizontal" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/template/templateCreateSave" method="post"  enctype="multipart/form-data">
										<fieldset class="content-group">
											<legend class="text-bold" style="padding-top:0px;"><h5>${title}</h5></legend>
										
											<!--弧形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2 text-right">模板名称<span class="text-danger">*</span></label>
												<div class="col-md-3">
													<input type="text" class="form-control input-rounded validate[required]" data-errormessage-value-missing="模板名称不能为空" 
														id="template_name" value="${template.template_name }"  name="template_name" placeholder="">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-2 text-right">模板效果图<span class="text-danger">*</span></label>
												<div class="col-lg-10">
													<input type="file" name="file1" class="bootstrap-uploader" id="file1">
													<input type="hidden" name="template_img" id="template_img" class="hiddenClass" value="${template.template_img }"/>
													<span style="color: gray">建议尺寸：200 x 200 像素。</span>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-md-2 text-right">模板分类<span class="text-danger">*</span></label>
												<div class="col-md-4"> 
													<select class="select" name="template_cate_id" id="template_cate_id" >
														<option value="" >--请选择模板分类--</option>
														<c:forEach items="${cateList }" var="cate">
															<option value="${cate.cate_id }" ${cate.cate_id eq template.template_cate_id?"selected":""}>${cate.cate_name }</option>
														</c:forEach>
													</select> 
												</div>
											</div>
											<div class="form-group">
										     	<label class="col-sm-2 control-label text-right"> 状态<span class="text-danger">*</span></label>
										     	<div class="col-sm-6">
										     		<label class="radio-inline"> 
										     			<input type="radio" class="styled" name="state" id="state1" checked="checked" 
																${infoMap.state ne -1?"checked":""} value="0">
															上架
													</label>
													<label class="radio-inline">
														<input type="radio" class="styled" name="state" id="state0" ${infoMap.state eq -1?"checked":""} value="-1">
															下架
													</label>
										     	</div>
									      	</div> 
											<div class="form-group">
												<label class="control-label col-md-2 text-right">模板数据模型</label>
												<div class="col-md-8">
													<textarea class="form-control " id="template_json" rows="8" cols="80" name="template_json">${template.template_json}</textarea>
												</div>
											</div> 
										</fieldset>
										<div class="text-center">
											<input type="hidden" name="validate_id"  value="${template.validate_id }"/>
											<input type="hidden" name="validate_id_token"  value="${template.validate_id_token }"/>
											<button type="button" id="buttonsave" onclick="saveButtonMy(this)" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
											&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)" id="qua1" class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
									 	</div>
									 	
									</form>
								</div>
							</div>
							<!-- /form validation -->
						</div>
					 </div>
				</div>
				<!-- /content area -->
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
			<script>
			$(function(){
				$('#infoForm').validationEngine({ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'formError-white',
					scroll: true,
					showOneMessage: true
				});
				
				openSource("#file1");
				<c:if test="${!empty template.template_img}">
				initPicture("${imageDomain }","${template.template_img}","#file1","300","200");
				</c:if>
			});
			function saveButtonMy(obj){
				var template_cate_id=$("#template_cate_id").val();
				if(template_cate_id==""){
					MAlert("请选择模板分类！");
					return ;
				}
				saveButton(obj,'数据提交中，请稍后！');
			}
			</script>
			
