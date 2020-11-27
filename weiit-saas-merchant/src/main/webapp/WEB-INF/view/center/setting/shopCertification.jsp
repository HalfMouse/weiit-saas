<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
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
							<!-- Tabs -->
							<ul class="nav  nav-tabs"> 
								<li><a href="shopInfo" ><i class="icon-home8 position-left"></i>店铺基本信息</a></li>
								<li class="active"><a href="shopCertification" style="border-top:0px;"><i class="icon-vcard position-left"></i>实名认证</a></li>
								<li><a href="shopAddress"><i class="icon-address-book position-left"></i>商家地址库</a></li>
							</ul> 
							<!-- /tabs -->
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								<div class="panel-body">
									<div class="profile">
										<form class="form-horizontal" action="${pageContext.request.contextPath}/center/setting/shopCertificationSave" method="post" name="infoForm" id="infoForm" enctype="multipart/form-data">
											<fieldset class="content-group">
											<c:if test="${empty infoMap or infoMap.state==-1}">
												<div class="form-group">
											     	<label class="control-label col-md-1">认证类型<span class="text-danger">*</span></label>
											     	<div class="col-md-5">
											     		<label class="radio-inline">
															<input type="radio" class="styled" name="auth_type"  <c:if test="${empty infoMap or infoMap.auth_type==2 }">checked='checked'</c:if>" value="2">
																企业
														</label>
											     		<label class="radio-inline"> 
											     			<input type="radio" class="styled" name="auth_type" <c:if test="${infoMap.auth_type==1 }">checked='checked'</c:if>value="1">
																个人
														</label>
											     	</div>
										      	</div> 
												
												<div id="company_div" style="display:${infoMap.auth_type==2?'block':'none' };">
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
												<div id="person_div" style="display:${infoMap.auth_type==1?'block':'none' };">
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
													<input type="hidden" name="validate_id" value="${infoMap.validate_id }"/>
													<input type="hidden" name="validate_id_token" value="${infoMap.validate_id_token }"/>
													<a href="shopCertification"  class="btn btn-default" >重置<i class="icon-undo2 position-right"></i></a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<button type="button" id="save_btn"  class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
														
												</div>
											</c:if>
											<c:if test="${!empty infoMap and infoMap.state!=-1 }">
												<div class="form-group">
											     	<label class="control-label col-md-1">店铺认证<span class="text-danger">*</span></label>
											     	<div class="col-md-2" style="padding-top:8px;">
											     		<c:if test="${infoMap.state==0 }">
											     		<span class="text-warning text-bold"><i class="icon-shield-notice"></i>认证中</span>
											     		</c:if>
											     		<c:if test="${infoMap.state==1 }">
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
											</c:if>
											
												
												
											</fieldset>
											
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
			
			  </script>
						
