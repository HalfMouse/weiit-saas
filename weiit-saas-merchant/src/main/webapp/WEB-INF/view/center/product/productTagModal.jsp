<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 
<form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm" target="rightIframe"
	action="${pageContext.request.contextPath}/center/productTag/editProductTagSave" method="post" >
<input type="hidden" name="validate_id" id="validate_id" value="${queryParam.validate_id}"/>
<input type="hidden" name="validate_id_token" id="validate_id_token" value="${queryParam.validate_id_token}"/>  
<input type="hidden" name="ids" id="ids" value="${queryParam.ids}"/>  
<input type="hidden" name="saleOld" id="saleOld" value="${queryParam.saleOld}"/>  
<!-- Main content -->
<div class="content-wrapper col-xs-12" style="padding:0px;margin:0px;">
	<!-- Content area -->
	<div class="content"  style="padding:0px;margin:0px;">
		<!-- Bordered striped table -->
		<div class="panel panel-flat"> 
			<div class="panel-body" >
				<fieldset class="content-group">
					<div class="form-group">
						<label class="control-label col-xs-2 text-right">标签： </label>
						<div class="col-xs-8">
							<c:forEach items="${tagList}" var="info22" varStatus="ind22">
								<div class="col-xs-6 text-info-400">
									<label class="radio-inline"><input type="checkbox"  name="tag_id_str" id="tag_id_str${info22.validate_id}"
										value="${info22.validate_id}" title="${info22.tag_name}" class="styled" />&nbsp;&nbsp;&nbsp;${info22.tag_name}
									</label>
								</div>
							</c:forEach>
						</div>
					</div> 
					<div class="text-center">
						<button type="button" onclick="saveButton(this,'数据提交中，请稍后！')" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
					</div>
				</fieldset>
				
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
$(document).ready(function() {
	/*默认监听表单onbulr验证*/
	$('#infoForm').validationEngine({ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'formError-white',
		scroll: true,
		showOneMessage: true
	});
	
	<c:forEach items="${tagDetailList}" var="info"> 
		$("#tag_id_str${info.tag_id}").attr("checked",true);
		$("#tag_id_str${info.tag_id}").trigger('click'); 
	</c:forEach>
});
</script>