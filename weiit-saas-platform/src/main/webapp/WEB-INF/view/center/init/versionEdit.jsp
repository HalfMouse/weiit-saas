<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.config.js"></script>
   		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.all.min.js"> </script>
        <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
			
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
								<li><a href="${pageContext.request.contextPath}/center/service/list" style="border-left:0px;border-top:0px;">收费服务项目</a></li>
								<li><a href="${pageContext.request.contextPath}/center/service/orderTimeConfig">订购时长配置</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/service/versionList">版本收费配置</a></li>
							</ul> 
							<!-- /tabs -->
									
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								<div class="panel-body">
								<form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/service/versionSave" method="POST" enctype="multipart/form-data">
									<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
									<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
									<fieldset class="content-group">
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>版本编号： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-rounded validate[required,funcCall[checkNum]]" name="version_num" id="version_num" 
													data-errormessage-value-missing="版本编号不能为空" value="${infoMap.version_num}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2 text-right"> <span class="text-danger">*</span>版本名称： </label>
											<div class="col-sm-4">
												<input type="text" class="form-control input-rounded validate[required]" name="version_name" id="version_name" 
													data-errormessage-value-missing="版本名称不能为空" value="${infoMap.version_name}">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-2 text-right">版本宣传图<span class="text-danger">*</span></label>
											<div class="col-lg-10">
												<input type="file" name="file_version_logo" class="bootstrap-uploader" id="file_version_logo">
												<input type="hidden" name="version_logo" id="version_logo" class="hiddenClass" value="${infoMap.version_logo }"/>
												<span style="color: gray">建议尺寸：500 x 750 像素。</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label text-right"> <font
												color="red">*</font>原价
											</label>
											<div class="col-sm-3"> 
												<input type="text" class="form-control validate[required,custom[number]]" name="smarket_price" id="smarket_price"
													value="${infoMap.smarket_price}"
													data-errormessage-value-missing="原价不能为空" data-errormessage-custom-error="必须是金额类型" >
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label text-right"> <font
												color="red">*</font>官方价格
											</label>
											<div class="col-sm-3"> 
												<input type="text" class="form-control validate[required,custom[number]]" name="sale_price" id="sale_price"
													value="${infoMap.sale_price}"
													data-errormessage-value-missing="官方价格不能为空" data-errormessage-custom-error="必须是金额类型" >
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label text-right"> <font
												color="red">*</font>渠道价格
											</label>
											<div class="col-sm-3"> 
												<input type="text" class="form-control validate[required,custom[number]]" name="supply_price" id="supply_price"
													value="${infoMap.supply_price}"
													data-errormessage-value-missing="渠道价格不能为空" data-errormessage-custom-error="必须是金额类型" >
											</div>
										</div>
								      	<div class="form-group">
											<label class="control-label col-sm-2 text-right"> 备注：</label>
											<div class="col-sm-6">
												<script id="editor" type="text/plain" style="width:100%;height:300px;"></script> 
											</div>
										</div>
										<div class="form-group">
									     	<label class="col-sm-2 control-label text-right"> 状态：</label>
									     	<div class="col-sm-6">
									     		<label class="radio-inline"> 
									     			<input type="radio" class="styled" name="state" checked="checked" 
															${infoMap.state ne -1?"checked":""} value="0">
														启用
												</label>
												<label class="radio-inline">
													<input type="radio" class="styled" name="state"  ${infoMap.state eq -1?"checked":""} value="-1">
														停用
												</label>
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
							"justifycenter",
					        "justifyright",
					        "justifyjustify",
							//"music",
							"link",
							"horizontal",
							"inserttable"
			                 ]  
			           ]  
			       });
			$(document).ready(function() { 
				
				 ue.addListener("ready", function () {
				    	// editor准备好之后才可以使用
				    	ue.setContent('${infoMap.version_desc}');
				 }); 
				   
				   
				initPicture("${imageDomain }","${infoMap.version_logo}","#file_version_logo",500,750);
				openSource("#file_version_logo");
					
				/*默认监听表单onbulr验证*/
				$('#infoForm').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				}); 
				
				$("#sale_price").TouchSpin({
					min: 0,
					max: 99999999,
					step: 0.01,
					decimals: 2,
				    postfix: '元'
				});
				$("#smarket_price").TouchSpin({
					min: 0,
					max: 99999999,
					step: 0.01,
					decimals: 2,
				    postfix: '元'
				});
				$("#supply_price").TouchSpin({
					min: 0,
					max: 99999999,
					step: 0.01,
					decimals: 2,
				    postfix: '元'
				});
				
				<c:if test="${!empty infoMap &&  !empty infoMap.validate_id}"> 
					$("#version_num").attr("disabled","disabled");
				</c:if>
				
			});
			
			function checkNum(){
				var version_num=$("#version_num").val();
				if(version_num!=""){
					var flag="";
					$.ajax({
					    url:'${pageContext.request.contextPath}/center/service/selectVersionNumCheck',
					    type:'GET', 
					    async: false,
					    data:{'version_num':version_num},
					    dataType:'json',
					    success:function(result){
					    	if(result.code=='0'){
					    	}else{
					    		flag=result.message ; 
					    	}
					    },
					    error:function(xhr,textStatus){
					        console.log('错误');
					    }
					});
					if(flag!=""){
						return flag;
					}
				}
			}  
			
			
			 
			</script>
			
