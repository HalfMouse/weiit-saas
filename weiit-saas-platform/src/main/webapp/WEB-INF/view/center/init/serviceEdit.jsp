<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 
			<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.config.js"></script>
   			<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.all.min.js"> </script>
   			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 收费服务项目 </span>
							</h4>
						</div>
					</div>  
				</div>
				<!-- /page header -->

				<!-- Content area -->
				<div class="content">
				
					<div class="row">
						<div class="col-md-12">
							<!-- Tabs -->
							<ul class="nav  nav-tabs"> 
								<li class="active"><a href="${pageContext.request.contextPath}/center/service/list" style="border-left:0px;border-top:0px;">收费服务项目</a></li>
								<li><a href="${pageContext.request.contextPath}/center/service/orderTimeConfig">订购时长配置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/service/versionList">版本收费配置</a></li>
							</ul> 
							<!-- /tabs -->
									
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								<div class="panel-body">
								<form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/service/save" method="POST" enctype="multipart/form-data">
									<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
									<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
									<fieldset class="content-group">
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>项目编号： </label>
											<div class="col-sm-3">
												<input type="text" class="form-control validate[required]" name="service_num" id="service_num" 
													data-errormessage-value-missing="项目编号不能为空" value="${infoMap.service_num}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>项目名称： </label>
											<div class="col-sm-3">
												<input type="text" class="form-control validate[required]" name="service_name" id="service_name" 
													data-errormessage-value-missing="项目名称不能为空" value="${infoMap.service_name}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2 text-right">项目Icon图<span class="text-danger">*</span></label>
											<div class="col-lg-10">
												<input type="file" name="file_service_icon" class="bootstrap-uploader" id="file_service_icon">
												<input type="hidden" name="service_icon" id="service_icon" class="hiddenClass" value="${infoMap.service_icon }"/>
												<span style="color: gray">建议尺寸：100 x 100 像素。</span>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2 text-right">项目主图<span class="text-danger">*</span></label>
											<div class="col-lg-10">
												<input type="file" name="file_service_logo" class="bootstrap-uploader" id="file_service_logo">
												<input type="hidden" name="service_logo" id="service_logo" class="hiddenClass" value="${infoMap.service_logo }"/>
												<span style="color: gray">建议尺寸：300 x 300 像素。</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label text-right"> <font
												color="red">*</font>原价
											</label>
											<div class="col-sm-3"> 
												<input type="text" class="form-control validate[required,custom[number]]" name="service_smarket_price" id="service_smarket_price"
													value="${infoMap.service_smarket_price}"
													data-errormessage-value-missing="原价不能为空" data-errormessage-custom-error="必须是金额类型" >
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label text-right"> <font
												color="red">*</font>当前价
											</label>
											<div class="col-sm-3"> 
												<input type="text" class="form-control validate[required,custom[number]]" name="service_price" id="service_price"
													value="${infoMap.service_price}"
													data-errormessage-value-missing="当前价不能为空" data-errormessage-custom-error="必须是金额类型" >
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> 备注：</label>
											<div class="col-sm-6">
												<textarea name="remark" class="form-control" id="remark" rows="4" cols="60">${infoMap.remark}</textarea>
											</div>
										</div>
								      	<div class="form-group">
											<label class="control-label col-sm-2 text-right"> 详情介绍：</label>
											<div class="col-sm-6">
												<script id="editor" type="text/plain" style="width:100%;height:300px;"></script> 
											</div>
										</div>
										<div class="form-group">
									     	<label class="col-sm-2 control-label text-right"> 状态：</label>
									     	<div class="col-sm-6">
									     		<label class="radio-inline"> 
									     			<input type="radio" class="styled" name="state" id="state1" checked="checked" 
															${infoMap.state ne -1?"checked":""} value="0">
														启用
												</label>
												<label class="radio-inline">
													<input type="radio" class="styled" name="state" id="state0" ${infoMap.state eq -1?"checked":""} value="-1">
														停用
												</label>
									     	</div>
								      	</div> 
								      	<div class="form-group">
											<label class="control-label col-sm-2 text-right">服务URL： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control" name="link_url" id="link_url" value="${infoMap.link_url}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right">服务类型： </label>
											<div class="col-sm-1">
												<select class="select" name="type">
													<option value="1">常规营销</option>
													<option value="2">场景营销</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right">排序编号： </label>
											<div class="col-sm-1">
												<input type="text" class="form-control validate[required,custom[integer]]" name="sort_num" id="sort_num" 
													data-errormessage-value-missing="排序编号不能为空，并且是整数" value="${infoMap.sort_num}">
											</div>
										</div>
									</fieldset> 
									<div class="text-center">
										<button type="button" onclick="saveButton(this,'数据提交中，请稍后！')" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
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
var ue = UE.getEditor('editor',{  
    toolbars: [  
               [
		        "fullscreen",
		        "source",
		        "bold",
		        "italic",
		        "underline",
		        "forecolor",
		        "backcolor",
		        "background",
		        "fontfamily",
		        "fontsize",
		        "indent",
		        "justifyleft",
		        "simpleupload",
		        "insertimage",
		        "emotion",
		        "insertvideo",
		        //"music",
		        "link",
		        "template",
		        "horizontal",
		        "inserttable"
		      ] 
           ]  
       });
$(document).ready(function() { 
	 ue.addListener("ready", function () {
	    	// editor准备好之后才可以使用
	    	ue.setContent('${infoMap.service_desc}');
	  }); 
	 
	initPicture("${imageDomain }","${infoMap.service_icon}","#file_service_icon",300,300);
	openSource("#file_service_icon");
		
	initPicture("${imageDomain }","${infoMap.service_logo}","#file_service_logo",300,300);
	openSource("#file_service_logo");
		
	/*默认监听表单onbulr验证*/
	$('#infoForm').validationEngine("attach",{ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'blackPopup formError-small',
		scroll: true,
		showOneMessage: true
	}); 
	
	$("#service_price").TouchSpin({
		min: 0,
		max: 99999999,
		step: 0.01,
		decimals: 2,
	    postfix: '元'
	});
	$("#service_smarket_price").TouchSpin({
		min: 0,
		max: 99999999,
		step: 0.01,
		decimals: 2,
	    postfix: '元'
	});
	
	<c:if test="${!empty infoMap &&  !empty infoMap.validate_id}"> 
		$("#service_num").attr("disabled","disabled");
	</c:if>
	
});

 
</script>
			
