<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %> 
 
<form class="form-horizontal"  name="infoForm" id="infoForm" target="rightIframe"
	action="${pageContext.request.contextPath}/center/templateCate/save" method="post" >
<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>  				
<!-- Main content -->
<div class="content-wrapper"  style="padding:0px;margin:0px;">

	<!-- Content area -->
	<div class="content" >
		<!-- Bordered striped table -->
		<div class="row"> 
				<!-- 表单验证开始 -->
				<div class="panel panel-flat"> 
					<div class="panel-body"> 
					<fieldset class="content-group">
						<div class="form-group">
							<label class="control-label col-xs-3 text-bold text-right"><font color="red"> * </font>分类名称:</label>
							<div class="col-xs-6">
								<div class="input-group">
									<input type="text" class="form-control validate[required]" name="cate_name" id="cate_name" 
										data-errormessage-value-missing="标签名称不能为空" placeholder="请输入分类名称" value="${infoMap.cate_name}"> 
								</div>
							</div>
						</div>
						<div class="text-center">
							<button type="button" id="buttonsave" onclick="saveButton(this)" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>			
						</div>
					</fieldset>							
					</div>
				</div> 
			
		</div> 
		<!-- /bordered striped table -->
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
</form>
<%@include file="../common/footer.jsp" %>
<script>
/*默认监听表单onbulr验证*/
$('#infoForm').validationEngine({ 
	promptPosition: 'bottomRight', 
	addPromptClass: 'formError-white',
	scroll: true,
	showOneMessage: true
}); 

</script>