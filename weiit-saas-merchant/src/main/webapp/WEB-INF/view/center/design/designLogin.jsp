<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/shopTemplate/user.css">
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>店铺装修</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/design/page/pageList"><i class="icon-html5"></i>微页面</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i class="icon-cube4"></i>底部菜单</a></li>
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
						
					<div class="panel-content">
			          <div class="main-content-area">
			               <div class="row">
			                    <div style="width:340px;float:left;">
			                         <div class="widget white" style="width:320px;background:#fafafa;">
			                         	 <div class="widget-titlebar">
			                         	 	<h5 class="text-white text-center" style="margin-top:7px;" id="nameH5">${(empty infoMap.name)?"会员登录":infoMap.name}</h5>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="sortable list">
			                                             <li>
				                                             <div class="user-center">
													            <div class="bgpic-box">
													            	<img id="topimg" src="${imageDomain }/${infoMap.login_img}">
													            </div> 
													        </div>
			                                             </li>
			                                             <li>
			                                             	<div class="row">
					                                        	<div class="form-group"> 
																	<div class="col-md-12">
																		<input type="text" style="border-left-width:0px;border-top-width:0px;border-right-width:0px;background-color:transparent;text-align:center" name="sss" placeholder="请输入手机号" class="form-control" value="">
																	</div>
																	<div class="col-md-12"  style="margin-top:20px;">
																		<input type="text" style="border-left-width:0px;border-top-width:0px;border-right-width:0px;background-color:transparent;text-align:center" name="sss" placeholder="请输入密码" class="form-control" value="">
																	</div>
														        </div>
														        <div class="form-group">  
																	<div class="col-md-4 text-left" style="padding-top:10px;">
																		注册新用户
																	</div>
																	<div class="col-md-4 text-left" style="padding-top:10px;">
																		 
																	</div>
																	<div class="col-md-4 text-right" style="padding-top:10px;">
																		<span class="text-danger">忘记密码</span>
																	</div> 
														        </div>
													        </div>
													        <div class="text-center" style="padding-top:30px;"> 
																<button type="button" id="buttonsave" style="" onclick="saveButton()" class="btn btn-danger col-md-12">登录</button>
															</div>
															<div class="text-center" style="padding-top:80px;"> 
																客户电话：<span class="text-danger" id="phoneSpan">${infoMap.tele_phone}</span>
															</div>
															<div class="text-center" style="padding-top:60px;">
															</div>
			                                             </li>
			                                             
			                                        </ul>
			                                   </div>
			                              </div>
			                              
			                         </div>
			                    </div>
			                    <div style="margin-left:350px;">
			                         <div class="row">
										<div class="col-md-12">
											<!-- 表单验证开始 -->
											<div class="panel panel-flat">
												<div class="panel-body">
													<form class="form-horizontal" method="POST"  name="infoForm" id="infoForm"
														action="${pageContext.request.contextPath}/center/store/designLoginSave" enctype="multipart/form-data" >
														<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
														<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
														<fieldset class="content-group">
															<legend class="text-bold">登录页信息</legend> 
															<div class="form-group">
																<label class="control-label col-md-2">页面名称：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control validate[required]" data-errormessage-value-missing="页面名称不能为空" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2">顶部图片：</label>
																<div class="col-md-6 text-left">
																	<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																	<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2">客服电话：</label>
																<div class="col-md-5">
																	<input type="text"  name="tele_phone" id="tele_phone" class="form-control" value="${infoMap.tele_phone}">
																</div>
															</div>
														</fieldset>
														 
														<div class="text-center">
															<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">保存<i class="icon-checkmark3 position-right"></i></button>
															<button type="button" class="btn btn-default" onclick="document.location.reload()">重置 <i class="icon-reload-alt position-right"></i></button>
														</div>
													</form>
												</div>
											</div>
											<!-- /form validation -->
				
											
										</div>
									 </div>

			                    </div>
			               </div>
			               
			          </div>
			     </div><!-- Panel Content -->
						

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script> 
			$(document).ready(function() {
				$('#infoForm').validationEngine({ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'formError-white',
					scroll: true,
					showOneMessage: true
				});
				
				openSource("#file1");
				if("${infoMap.login_img}"!=""){
					initPicture("${imageDomain }","${infoMap.login_img}","#file1",320,160);
				}
				$("#file1").change(function() {
					var $file = $(this); 
		        	var fileObj = $file[0]; 
		        	var windowURL = window.URL || window.webkitURL; 
		        	var dataURL; 
		        	var $img = $("#topimg"); 
		        	if(fileObj && fileObj.files && fileObj.files[0]){ 
		            	dataURL = windowURL.createObjectURL(fileObj.files[0]); 
		            	$img.attr('src',dataURL);
		        	}else{
		            	dataURL = $file.val(); 
		            	if(dataURL!=""){
			            	var imgObj = document.getElementById("topimg"); 
			            	imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)"; 
			            	imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
		            	}
		        	}
				});
				
				$("#tele_phone").blur(function() {
		        	$("#phoneSpan").html($(this).val());
				});
				
				$("#name").blur(function() {
		        	$("#nameH5").html($(this).val());
				});
				
			});
			
			</script>
						
