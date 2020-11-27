<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
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
				<form class="form-horizontal" method="POST"  name="infoForm" id="infoForm"
					action="${pageContext.request.contextPath}/center/design/page/userCenterSave" enctype="multipart/form-data" >												
					<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
					<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
				<!-- Content area -->
				<div class="content">
						
					<div class="panel-content">
			          <div class="main-content-area">
			               <div class="row">
			                    <div style="width:340px;float:left;">
			                         <div class="widget white" style="width:320px;background:#fafafa;">
			                         	 <div class="widget-titlebar">
			                         	 	<h5 class="text-white text-center" style="margin-top:7px;" id="nameH5" >${(empty infoMap.name)?"会员中心":infoMap.name}</h5>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="sortable list">
			                                             <li>
				                                             <div class="user-center">
													            <div class="bgpic-box">
													            	<img id="topimg"  src="${imageDomain }/${infoMap.bg_img}">
													            </div>
													            <div class="user-infor">
														            <div class="user-photo">
														            	<img  src="${imageDomain }/${infoMap.bg_img}" >
														            </div> 
													            </div>
													            <div class="user-infor">
													            	<div class="user-name"> 
															          <span>半个鼠标</span>
															        </div> 
															        <div class="user-other" id="levelH5"> 
															          <span>会员等级【普通会员】</span>
															        </div>
															    </div>
													            <div class="assets-text">
													            	<span id="balanceH5">余额：<em>¥</em><font size="3px" style="font-weight:normal">999.99</font></span>
													            	<span id="integralH5">积分：<font size="3px" style="font-weight:normal">9999</font></span>
													            </div>
													            <div class="admin-text">
													            	<a href="#">账户信息</a>
													            </div>
													        </div>
			                                             </li>
			                                             <li style="background:white;">
				                                             <legend class="text-bold">
				                                             	  <a href="#" class="text-default">
														            <span class="icon-span">
														            	<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon01.png" height="17" width="16">
														            </span>&nbsp;
														            <span class="text-span">我的订单<font color="#BABABA" style="margin-left: 100px;">查看全部订单</font></span>
														            <span style="float:right;"><i class="icon-arrow-right13"></i></span>
														          </a>
				                                             </legend>
				                                             <div class="row">
				                                             	<ul class="user-order" style="padding:0;">
														            <li style="padding:0;background:white;">
														                <a href="#">
														                    <span class="icon-span">
														                    	<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uo_icon01.png" height="28" width="28">
														                    	<em class="num-e">5</em>
														                    </span>
														                    <span class="text-span">待付款</span>
														                </a>
														            </li>
														            <li style="padding:0;background:white;">
														                <a href="#">
														                    <span class="icon-span">
														                    	<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uo_icon02.png" height="28" width="28">
														                    	<em class="num-e">5</em>
														                    </span>
														                    <span class="text-span">待发货</span>
														                </a>
														            </li>
														            <li style="padding:0;background:white;">
														                <a href="#">
														                    <span class="icon-span">
														                    	<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uo_icon03.png" height="28" width="28">
														                    	<em class="num-e">5</em>
														                    </span>
														                    <span class="text-span">待收货</span>
														                </a>
														            </li>
														            <li style="padding:0;background:white;">
														                <a href="#">
														                    <span class="icon-span">
														                        <img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uo_icon04.png" height="28" width="28">
														                        <em class="num-e">5</em>
														                    </span>
														                    <span class="text-span">待评价</span>
														                </a>
														            </li>
														            <li style="padding:0;background:white;">
														                <a href="#">
														                    <span class="icon-span">
														                        <img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uo_icon05.png" height="28" width="28">
														                        <em class="num-e">5</em>
														                    </span>
														                    <span class="text-span">退换货</span>
														                </a>
														            </li>            
														        </ul>
				                                             </div>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon06.png" height="16" width="16"></span>&nbsp;<span class="text-span">收货地址管理</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon10.png" height="17" width="16"></span>&nbsp;<span class="text-span">我的足迹</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon04.png" height="14" width="15"></span>&nbsp;<span class="text-span">我的钱包<font color="#BABABA" style="margin-left: 120px;">¥99.00</font></span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon11.png" height="17" width="17"></span>&nbsp;<span class="text-span">我的积分</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon03.png" height="16" width="16"></span>&nbsp;<span class="text-span">我的优惠券  </span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon02.png" height="16" width="16"></span>&nbsp;<span class="text-span">分享二维码</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon09.png" height="17" width="16"></span>&nbsp;<span class="text-span">我的分销商</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon07.png" height="16" width="16"></span>&nbsp;<span class="text-span">帮助中心</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon05.png" height="16" width="16"></span><span class="text-span">在线客服（9:00-21:00）</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li style="background:white;">
			                                            	  <a href="#" class="text-default">
													            <span class="icon-span"><img src="${pageContext.request.contextPath}/resource/images/shopTemplate/uc_icon08.png" height="16" width="16"></span><span class="text-span">关于我们</span>
													            <span style="float:right"><i class="icon-arrow-right13"></i></span>
													          </a>
			                                             </li>
			                                             <li>
			                                            	<br>
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
														<fieldset class="content-group">
															<legend class="text-bold">会员主页</legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">页面名称：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control validate[required]" data-errormessage-value-missing="页面名称不能为空" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group" style="margin-bottom:10px;">
																<label class="control-label col-md-2 text-right">背景图：</label>
																<div class="col-md-6">
																	<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.bg_img}">
																	<br/>建议尺寸：640 x 320 像素
																	<input type="hidden" name="bg_img" id="bg_img" value="${infoMap.bg_img}">
																</div>
															</div>
															<div class="form-group" style="margin-bottom:0px;">
																<label class="control-label col-md-2 text-right">头像位置：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="align"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		左
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >
																		中
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align"  ${(infoMap.align eq 2)?"checked":""} class="styled" value="2" >
																		右
																	</label>
																</div>
															</div>
															<div class="form-group" style="margin-bottom:0px;">
																<label class="control-label col-md-2 text-right">等级：</label>
																<div class="col-md-6">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="order_state" onclick="levelClick()" ${(infoMap.order_state eq 1)?"checked":""} class="styled" value="1" >
																		显示等级
																	</label>
																</div>
															</div>
															<div class="form-group" style="margin-bottom:0px;">
																<label class="control-label col-md-2 text-right">余额：</label>
																<div class="col-md-6">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="balance_state" onclick="balanceClick()" ${(infoMap.balance_state eq 1)?"checked":""} class="styled" value="1" >
																		显示余额
																	</label>
																</div>
															</div>
															<div class="form-group" style="margin-bottom:0px;">
																<label class="control-label col-md-2 text-right">积分：</label>
																<div class="col-md-6">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="integral_state" onclick="integralClick()" ${(infoMap.integral_state eq 1)?"checked":""} class="styled" value="1" >
																		显示积分
																	</label>
																</div>
															</div>
														</fieldset>
														<div class="text-center">
															<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">保存<i class="icon-checkmark3 position-right"></i></button>
															<button type="button" class="btn btn-default" onclick="document.location.reload()">重置 <i class="icon-reload-alt position-right"></i></button>
														</div>
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
				
				</form>
			</div>
			
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
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

				levelClick();
				balanceClick();
				integralClick();
				
				openSource("#file1");
				if("${infoMap.bg_img}"!=""){
					initPicture("${imageDomain }","${infoMap.bg_img}","#file1",320,160);
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
				
				$("#name").blur(function() {
		        	$("#nameH5").html($(this).val());
				});
			});
			
			function levelClick(){
				var useType=$('input[name="order_state"]:checked').val();
		    	if(useType=="1"){
		    		$("#levelH5").show();
		    	}else{
		    		$("#levelH5").hide();
		    	}
			}
			function balanceClick(){
				var useType=$('input[name="balance_state"]:checked').val();
		    	if(useType=="1"){
		    		$("#balanceH5").show();
		    	}else{
		    		$("#balanceH5").hide();
		    	}
			}
			function integralClick(){
				var useType=$('input[name="integral_state"]:checked').val();
		    	if(useType=="1"){
		    		$("#integralH5").show();
		    	}else{
		    		$("#integralH5").hide();
		    	}
			}
			
			</script>
						
