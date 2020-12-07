<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Content area -->
				<div class="content">
				
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">

								<div class="panel-body">
									<div class="profile">
										
											
											<c:if test="${sessionScope.role_sign=='USER'}"><!-- 渠道商才可以创建店铺 -->
												<c:if test="${empty infoMap or infoMap.state==-1}">
												<form class="form-horizontal" action="${pageContext.request.contextPath}/center/shop/shopCreateSave" method="post" name="infoForm" id="infoForm" enctype="multipart/form-data">
													<fieldset class="content-group">
													<div class="form-group">
														<label class="control-label col-md-1"> <span class="text-danger">*</span>店铺名称</label>
														<div class="col-md-2">
															<input type="text" class="form-control  validate[required]" id="shop_name" value="${infoMap.shop_name}"  name="shop_name" 
																data-errormessage-value-missing="店铺名称不能为空" >
														</div>
													</div>
													<div class="form-group">
												     	<label class="control-label col-md-1">认证类型<span class="text-danger">*</span></label>
												     	<div class="col-md-5">
												     		<label class="radio-inline">
																<input type="radio" class="styled" name="auth_type"  checked value="2">
																	企业
															</label>
												     		<label class="radio-inline"> 
												     			<input type="radio" class="styled" name="auth_type" value="1">
																	个人
															</label>
												     	</div>
											      	</div> 
													
													<div id="company_div">
														<div class="form-group">
															<label class="control-label col-md-1">公司名称<span class="text-danger">*</span></label>
															<div class="col-md-2">
																<input type="text" class="form-control validate[required]"  value="${infoMap.auth_name}"  name="name_company" placeholder="如:深圳澳亚科技有限公司" data-errormessage-value-missing="公司名称不能为空" >
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1" >营业执照<span class="text-danger">*</span></label>
															<div class="col-md-2">
																<input type="text" class="form-control validate[required,custom[onlyLetterNumber]]"  value="${infoMap.auth_no }"  name="auth_no_company" data-errormessage-value-missing="营业执照不能为空">
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1">营业执照照片<span class="text-danger">*</span></label>
															<div class="col-md-6">
																<input type="file" name="file_business_img" class="bootstrap-uploader" id="file_business_img">
																<input type="hidden" name="business_img" id=business_img value="${infoMap.business_img }" class="hiddenClass"/>
																<br>
																<span style="color: gray">支持jpg、png等格式,文件大小不能超过5M.</span>
															</div>
														</div>
													</div>
													<div id="person_div" style="display:none">
														<div class="form-group">
															<label class="control-label col-md-1">姓名<span class="text-danger">*</span></label>
															<div class="col-md-2">
																<input type="text" class="form-control validate[required]" value="${infoMap.auth_name}"  name="name" data-errormessage-value-missing="姓名不能为空" >
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1" >身份证号码<span class="text-danger">*</span></label>
															<div class="col-md-2">
																<input type="text" class="form-control validate[required,custom[onlyLetterNumber]]" value="${infoMap.auth_no }"  name="auth_no" data-errormessage-value-missing="身份证号码不能为空" >
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1">身份证正面<span class="text-danger">*</span></label>
															<div class="col-md-6">
																<input type="file" name="file_idcard_front_img" class="bootstrap-uploader" id="file_idcard_front_img">
																<input type="hidden" name="idcard_front_img" id="idcard_front_img" value="${infoMap.idcard_front_img }" class="hiddenClass"/>
																<br>
																<span style="color: gray">支持jpg、png等格式,文件大小不能超过5M.</span>
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1">身份证反面<span class="text-danger">*</span></label>
															<div class="col-md-6">
																<input type="file" name="file_idcard_back_img" class="bootstrap-uploader" id="file_idcard_back_img">
																<input type="hidden" name="idcard_back_img" id="idcard_back_img" value="${infoMap.idcard_back_img }" class="hiddenClass"/>
																<br>
																<span style="color: gray">支持jpg、png等格式,文件大小不能超过5M.</span>
															</div>
														</div>
													</div>
													
													<div class="text-center">
														<input type="hidden" name="shop_id" id="shop_id" value="${queryParam.shop_id}"/>
														<input type="hidden" name="validate_id" value="${queryParam.validate_id }"/>
														<input type="hidden" name="validate_id_token" value="${queryParam.validate_id_token }"/>
														<a href="shopCertification"  class="btn btn-default" >重置<i class="icon-undo2 position-right"></i></a>
														&nbsp;&nbsp;&nbsp;&nbsp;
														<button type="button" id="save_btn"  class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
															
													</div>
													</fieldset>
													</form>
												</c:if>
											</c:if>
											<c:if test="${sessionScope.role_sign=='ADMIN'}"><!-- 平台端只能查看店铺认证与审核-->
												<c:if test="${!empty infoMap and infoMap.c_state!=-1 }">
												<form class="form-horizontal" action="${pageContext.request.contextPath}/center/shop/shopCreateSave" method="post" name="infoForm" id="infoForm" enctype="multipart/form-data">
													<fieldset class="content-group">
													<div class="form-group">
												     	<label class="control-label col-md-1">店铺认证<span class="text-danger">*</span></label>
												     	<div class="col-md-2" style="padding-top:8px;">
												     		<c:if test="${infoMap.c_state==0 }">
												     		<span class="text-warning text-bold"><i class="icon-shield-notice"></i>认证中</span>
												     		</c:if>
												     		<c:if test="${infoMap.c_state==1 }">
												     		<span class="text-success text-bold"><i class="icon-shield-check"></i>已认证</span>
												     		</c:if>
												     	</div>
											      	</div> 
													<c:if test="${infoMap.auth_type eq 2}">
														<div class="form-group">
													     	<label class="control-label col-md-1">认证类型<span class="text-danger">*</span></label>
													     	<div class="col-md-2"  style="padding-top:8px;">
													     		企业
													     	</div>
												      	</div> 
														<div class="form-group">
															<label class="control-label col-md-1">企业名称<span class="text-danger">*</span></label>
															<div class="col-md-2"  style="padding-top:8px;">${infoMap.auth_name} </div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1" >营业执照号<span class="text-danger">*</span></label>
															<div class="col-md-2"  style="padding-top:8px;">
																${infoMap.auth_no}
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1">营业执照照片<span class="text-danger">*</span></label>
															<div class="col-md-6">
																<img src="${imageDomain}/${infoMap.business_img}_300x300" width="300px" height="300px">
															</div>
														</div>
													</c:if>
													<c:if test="${infoMap.auth_type eq 1 }">
														<div class="form-group">
													     	<label class="control-label col-md-1">认证类型<span class="text-danger">*</span></label>
													     	<div class="col-md-2"  style="padding-top:8px;">
													     		个人
													     	</div>
												      	</div> 
														<div class="form-group">
															<label class="control-label col-md-1">姓名<span class="text-danger">*</span></label>
															<div class="col-md-2"  style="padding-top:8px;">${infoMap.auth_name} </div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1" >身份证编号<span class="text-danger">*</span></label>
															<div class="col-md-2"  style="padding-top:8px;">
																${infoMap.auth_no}
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1">身份证正面<span class="text-danger">*</span></label>
															<div class="col-md-6"> 
																<img src="${imageDomain}/${infoMap.idcard_front_img}_300x180" width="300px" height="180px">
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-1">身份证反面<span class="text-danger">*</span></label>
															<div class="col-md-6"> 
																<img src="${imageDomain}/${infoMap.idcard_back_img}_300x180" width="300px" height="180px">
															</div>
														</div>
													</c:if>
													<c:if test="${infoMap.c_state==0 }">
													<div class="text-left">
														&nbsp;&nbsp;&nbsp;&nbsp;
														<button type="button"  class="btn btn-primary" onclick="mUpdate('${queryParam.shop_id}','1')">审核实名<i class="icon-checkmark3 position-right"></i></button>
														<button type="button"  class="btn btn-default" onclick="mUpdate('${queryParam.shop_id}','-1')">驳回实名<i class="icon-undo2 position-right"></i></button>
															
													</div>
													</c:if>
													
													</fieldset>
													</form>
												</c:if>
												
											</c:if>
												
												
											
											
										
										
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
			<%@include file="../common/footer.jsp" %>
			<script> 
			$(document).ready(function() { 
				
				$("input[name=auth_type]").click(function(e){
					if($(this).val()=='2'){
						$("#person_div").hide();
						$("#company_div").show();
				 	}else{
				 		$("#company_div").hide();
						$("#person_div").show();
				 	}
				});
				
				initPicture("${imageDomain }","${infoMap.business_img}","#file_business_img",300,300);
				openSource("#file_business_img");
				
				initPicture("${imageDomain }","${infoMap.idcard_front_img}","#file_idcard_front_img",300,180);
				openSource("#file_idcard_front_img");
				
				initPicture("${imageDomain }","${infoMap.idcard_back_img}","#file_idcard_back_img",300,180);
				openSource("#file_idcard_back_img");
				
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
						var auth_type=$('input:radio[name="auth_type"]:checked').val();
						if(auth_type=="2"){
							var file1 = $("#file_business_img").val();
							if(file1 == ""&&$("#business_img").val()==""){
								MAlert("请上传营业执照照片");
								$("#save_btn").removeAttr("disabled"); 
								return false;
							}
						}else{
							var file2 = $("#file_idcard_front_img").val();
							var file3 = $("#file_idcard_back_img").val();
							if((file2 == ""&&$("#idcard_front_img").val()=="")||(file3 == ""&&$("#idcard_back_img").val()=="")){
								MAlert("请上传身份证正面与反面照片");
								$("#save_btn").removeAttr("disabled"); 
								return false;
							}
						}
						FullScreenShow("数据提交中，请稍后！");
						$("#infoForm").submit();
						
					}
					
				});
			});
			
			if("${sessionScope.role_sign}"=="ADMIN"){
				
				function mUpdate(shop_id,state){
					var message='';
					if(state==1){
						message='确定要审核实名吗 ？审核实名通过后，建不可更改信息';
					}
					if(state==-1){
						message='确定要驳回实名吗 ？驳回后建议电话告知需要修改的信息';
					}
					MConfirm(message,'','',function(result) {
						if(result){
							window.location="${pageContext.request.contextPath}/center/shop/shopCertificationUpdate?shop_id="+shop_id+"&state="+state;
						}
					});
				}
				
			}
			  </script>
