<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.config.js"></script>
   		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.all.min.js"> </script>
        <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
      			

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-credit-card"></i>支付/交易</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/expressList"><i class="icon-truck"></i>物流配送</a></li>
								<li><a href="${pageContext.request.contextPath}/center/account/password"><i class="icon-key"></i> 修改密码</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Content area -->
				<div class="content"> 
				
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat"> 
								<div class="panel-body">
								<form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/setting/protocolSave" method="post" >
									<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
									<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
									<fieldset class="content-group">
										<legend class="text-bold" style="padding-top:0px;"><h5>${title}</h5></legend>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>协议名称： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-rounded validate[required]" name="protocol_title"  value="${infoMap.protocol_title}"  data-errormessage-value-missing="协议名称不能为空" >
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2 text-right">协议内容</label>
											<div class="col-md-8">
												<script id="editor" type="text/plain" style="width:100%;height:300px;"></script> 
											</div>
										</div> 
									</fieldset> 
									<div class="text-center">
										<button type="button" id="save_btn" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
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
							//"music",
							"link",
							"horizontal",
							"inserttable"
			                 ]  
			           ]  
			       });
			
			$(document).ready(function() {
			  //UE.getEditor('editor').setContent("ddd"); 
			   ue.addListener("ready", function () {
			    	// editor准备好之后才可以使用
			    	ue.setContent('${infoMap.protocol_content}');
			  }); 
			   
			   /*默认监听表单onbulr验证*/
				$('#infoForm').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				}); 
				//表单提交
				$("#save_btn").click(function(){
					$("#save_btn").attr("disabled", true);
					if(!$('#infoForm').validationEngine("validate")){
						$("#save_btn").removeAttr("disabled");
						return false;
					}else{
						FullScreenShow("数据提交中，请稍后！");
						$("#infoForm").submit();
						
					}
					
				});
			});
			 </script>
			
