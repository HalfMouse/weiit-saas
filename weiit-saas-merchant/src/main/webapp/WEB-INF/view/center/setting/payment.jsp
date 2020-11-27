<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-credit-card"></i>支付/交易</a></li>
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
									<div class="profile">
										
											<fieldset class="content-group">
												<legend class="text-bold"><h5>支付/交易管理</h5></legend>
												
											</fieldset>
											<div class="row">
												<div class="col-md-12">
						
													<!-- 小程序微信支付配置 -->
													<div class="panel-group panel-group-control panel-group-control-right">
														<div class="panel panel-white">
															<div class="panel-heading">
																<h6 class="panel-title">
																	<a href="javascript:;" style="padding:0px;margin: 0px;" onclick="updateState('${ma_weixin_pay.pay_id}','0')">
																		<input type="checkbox" name="ma_weixin_pay" id="ma_weixin_pay" value="0" class="ma_weixin_pay" <c:if test="${ma_weixin_pay.state==0 }">checked</c:if>>
																	</a>&nbsp;&nbsp;小程序-微信支付
																	<a class="" data-toggle="collapse" href="#ma_weixin_pay_div" aria-expanded="true">
																	</a>
																</h6>
															</div>
						
															<div id="ma_weixin_pay_div" class="panel-collapse collapse in">
																<div class="panel-body">
																	
																	<div class="alert alert-primary no-border">
																		<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
																		<span class="text-semibold">
																		启用小程序-微信支付，微信用户都可以在您的小程序上面下单，用户下单后款直接进入企业所配置的微信商户系统。<br><br>
																		商家必须是申请了</span>
																		<span class="text-warning">小程序微信支付</span>
																		<span class="text-semibold">认证后，配置才会生效。如商家还没开通微信支付，</span>
																		 <a href="">马上申请</a>
																	</div>
																	
																	<form class="form-horizontal" id="ma_weixin_pay_form" action="${pageContext.request.contextPath}/center/setting/paymentSave" method="post"  enctype="multipart/form-data">
																		<input type="hidden"  id="validate_id"  name="validate_id" value="${ma_weixin_pay.validate_id}">
																		<input type="hidden"  id="validate_id_token"  name="validate_id_token" value="${ma_weixin_pay.validate_id_token}">
																		<input type="hidden"  name="type" value="0">
																		<fieldset class="content-group">
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">商户号：<span class="text-danger">*</span></label>
																				<div class="col-md-3">
																					<input type="text" class="form-control validate[required]" value="${ma_weixin_pay.partner_id }"  name="partner_id" data-errormessage-value-missing="商户号不能为空" >
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">密钥：<span class="text-danger">*</span></label>
																				<div class="col-md-3">
																					<input type="text" class="form-control validate[required]" value="${ma_weixin_pay.partner_key }"  name="partner_key" data-errormessage-value-missing="秘钥不能为空" >
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">apiclient_cert私钥文件：</label>
																				<div class="col-md-4">
																					<input type="file" name="client_cert" class="file-styled ma_client_cert" placeholder="请上传私钥文件">
																					<span class="help-block">只支持: pfx格式的证书. 证书文件大小 不能超过10Mb</span>
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">apiclient_key公钥文件：</label>
																				<div class="col-md-4">
																					<input type="file" name="client_key" class="file-styled ma_client_key" placeholder="请上传公钥文件">
																					<span class="help-block">只支持: pfx格式的证书. 证书文件大小 不能超过10Mb</span>
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">CA证书文件：</label>
																				<div class="col-md-4">
																					<input type="file" name="ca_cert" class="file-styled ma_ca_cert" placeholder="请上传CA证书文件">
																					<span class="help-block">只支持: pfx格式的证书. 证书文件大小 不能超过10Mb</span>
																					<div class="alert alert-warning no-border">
																						<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
																						<span class="text-semibold">若使用在线退款和红包等高级功能需要上传私钥文件、公钥文件、CA证书文件</span> 
																					</div>
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right"></label>
																				<div class="col-md-4">
																					注意：微信支付目录已设置为 “www.wstore.me”
																				</div>
																			</div>
																			<div class="text-center">
																				<button class="btn bg-blue" type="button" id="save_btn_ma">保存</button>
																			</div>
																			
																		</fieldset>
																		
																	</form>
																																		
																</div>
															</div>
														</div>
														
													</div>
													<!-- 公众号微信支付配置 -->
													<div class="panel-group panel-group-control panel-group-control-right">
														<div class="panel panel-white">
															<div class="panel-heading">
																<h6 class="panel-title">
																	<a href="javascript:;" style="padding:0px;margin: 0px;" onclick="updateState('${mp_weixin_pay.pay_id}','1')">
																		<input type="checkbox" name="mp_weixin_pay" id="mp_weixin_pay" value="1" class="mp_weixin_pay"  <c:if test="${mp_weixin_pay.state==0 }">checked</c:if>>
																	</a>&nbsp;&nbsp;公众号-微信支付
																	<a class="" data-toggle="collapse" href="#mp_weixin_pay_div" aria-expanded="true">
																	</a>
																</h6>
															</div>
						
															<div id="mp_weixin_pay_div" class="panel-collapse collapse in">
																<div class="panel-body">
																	
																	<div class="alert alert-primary no-border">
																		<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
																		<span class="text-semibold">
																		启用公众号-微信支付，微信用户都可以在您的公众号上面下单，用户下单后款直接进入企业所配置的微信商户系统。<br><br>
																		商家必须是申请了</span>
																		<span class="text-warning">公众号微信支付</span>
																		<span class="text-semibold">认证后，配置才会生效。如商家还没开通微信支付，</span>
																		 <a href="">马上申请</a>
																	</div>
																	
																	<form class="form-horizontal" id="mp_weixin_pay_form" action="${pageContext.request.contextPath}/center/setting/paymentSave" method="post"  enctype="multipart/form-data">
																		<input type="hidden"  id="validate_id"  name="validate_id" value="${mp_weixin_pay.validate_id}">
																		<input type="hidden"  id="validate_id_token"  name="validate_id_token" value="${mp_weixin_pay.validate_id_token}">
																		<input type="hidden"  name="type" value="1">
																		<fieldset class="content-group">
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">商户号：<span class="text-danger">*</span></label>
																				<div class="col-md-3">
																					<input type="text" class="form-control validate[required]" value="${mp_weixin_pay.partner_id }"  name="partner_id" data-errormessage-value-missing="商户号不能为空" >
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">密钥：<span class="text-danger">*</span></label>
																				<div class="col-md-3">
																					<input type="text" class="form-control validate[required]" value="${mp_weixin_pay.partner_key }"  name="partner_key" data-errormessage-value-missing="秘钥不能为空" >
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">apiclient_cert私钥文件：</label>
																				<div class="col-md-4">
																					<input type="file" name="client_cert" class="file-styled mp_client_cert" placeholder="请上传私钥文件" >
																					<span class="help-block">只支持: pfx格式的证书. 证书文件大小 不能超过10Mb</span>
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">apiclient_key公钥文件：</label>
																				<div class="col-md-4">
																					<input type="file" name="client_key" class="file-styled mp_client_key" placeholder="请上传公钥文件">
																					<span class="help-block">只支持: pfx格式的证书. 证书文件大小 不能超过10Mb</span>
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right">CA证书文件：</label>
																				<div class="col-md-4">
																					<input type="file" name="ca_cert" class="file-styled mp_ca_cert" placeholder="请上传CA证书文件">
																					<span class="help-block">只支持: pfx格式的证书. 证书文件大小 不能超过10Mb</span>
																					<div class="alert alert-warning no-border">
																						<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
																						<span class="text-semibold">若使用在线退款和红包等高级功能需要上传私钥文件、公钥文件、CA证书文件</span> 
																					</div>
																				</div>
																			</div>
																			
																			<div class="form-group">
																				<label class="control-label col-md-2 text-right"></label>
																				<div class="col-md-4">
																					注意：微信支付目录已设置为 “www.wstore.me”
																				</div>
																			</div>
																			<div class="text-center">
																				<button class="btn bg-blue" type="button" id="save_btn_mp">保存</button>
																			</div>
																			
																		</fieldset>
																		
																	</form>
																																		
																</div>
															</div>
														</div>
														
													</div>
													
													<div class="panel-group panel-group-control panel-group-control-right">
														<div class="panel panel-white">
															<div class="panel-heading">
																<h6 class="panel-title">
																	<a href="javascript:;" style="padding:0px;margin: 0px;" onclick="updateState('${balance_pay.pay_id}','2')" >
																		<input type="checkbox" name="balance_pay" id="balance_pay" value="2" class="balance_pay" <c:if test="${balance_pay.state==0 }">checked</c:if>>
																	</a>&nbsp;&nbsp;余额支付
																	<a class="" data-toggle="collapse" href="#pay3" aria-expanded="true">
																	</a>
																</h6>
															</div>
						
															<div  class="panel-collapse collapse in">
																<div class="panel-body">
																	<div class="alert alert-primary no-border">
																		<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
																		<span class="text-semibold">
																		会员余额功能，手工充值余额功能都依赖本功能开启。<br><br>
																		</span>
																		<span class="text-warning">温馨提示：必须要开启该功能，用户才能使用余额充值与余额支付功能</span>
																	</div>
																</div>
															</div>
														</div>
														
													</div>
													<!-- /questions list -->
						
												</div>
											</div>
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
			//初始化关闭与开始控件
			var ma_weixin_pay = document.querySelector('.ma_weixin_pay');
		    new Switchery(ma_weixin_pay, { color: '#00BCD4'});
		    
		    var mp_weixin_pay = document.querySelector('.mp_weixin_pay');
		    new Switchery(mp_weixin_pay, { color: '#00BCD4'});
		    
		    var balance_pay = document.querySelector('.balance_pay');
		    new Switchery(balance_pay, { color: '#00BCD4'});
		    
		
		    $(".ma_client_cert").uniform({
		        wrapperClass: 'bg-sky',
		        fileButtonHtml: '<i class="icon-googleplus5"></i>',
		        fileDefaultHtml:'${ma_weixin_pay.client_cert}'
		    });
		    $(".ma_client_key").uniform({
		        wrapperClass: 'bg-sky',
		        fileButtonHtml: '<i class="icon-googleplus5"></i>',
		        fileDefaultHtml:'${ma_weixin_pay.client_key}'
		    });
		    $(".ma_ca_cert").uniform({
		        wrapperClass: 'bg-sky',
		        fileButtonHtml: '<i class="icon-googleplus5"></i>',
		        fileDefaultHtml:'${ma_weixin_pay.ca_cert}'
		    });
		    
		    $(".mp_client_cert").uniform({
		        wrapperClass: 'bg-sky',
		        fileButtonHtml: '<i class="icon-googleplus5"></i>',
		        fileDefaultHtml:'${mp_weixin_pay.client_cert}'
		    });
		    $(".mp_client_key").uniform({
		        wrapperClass: 'bg-sky',
		        fileButtonHtml: '<i class="icon-googleplus5"></i>',
		        fileDefaultHtml:'${mp_weixin_pay.client_key}'
		    });
		    $(".mp_ca_cert").uniform({
		        wrapperClass: 'bg-sky',
		        fileButtonHtml: '<i class="icon-googleplus5"></i>',
		        fileDefaultHtml:'${mp_weixin_pay.ca_cert}'
		    });
		    
			$(document).ready(function() {  
			    /*默认监听表单onbulr验证*/
				$('#ma_weixin_pay_form').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				}); 
				//表单提交
				$("#save_btn_ma").click(function(){
					$("#save_btn_ma").attr("disabled", true);
					if(!$('#ma_weixin_pay_form').validationEngine("validate")){
						$("#save_btn_ma").removeAttr("disabled");
						return false;
					}else{
						FullScreenShow("数据提交中，请稍后！");
						$("#ma_weixin_pay_form").submit();
					}
					
				});
			    
			    /*默认监听表单onbulr验证*/
				$('#mp_weixin_pay_form').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				}); 
				//表单提交
				$("#save_btn_mp").click(function(){
					$("#save_btn_mp").attr("disabled", true);
					if(!$('#mp_weixin_pay_form').validationEngine("validate")){
						$("#save_btn_mp").removeAttr("disabled");
						return false;
					}else{
						FullScreenShow("数据提交中，请稍后！");
						$("#mp_weixin_pay_form").submit();
					}
					
				});
			
			});
			
			function updateState(payId,type){
				
				var state=0;
				if(type==0){
					if($('input:checkbox[name="ma_weixin_pay"]').prop("checked")){
						state=0;
					}else{
						state=-1
					}
				}else if(type==1){
					if($('input:checkbox[name="mp_weixin_pay"]').prop("checked")){
						state=0;
					}else{
						state=-1
					}
				}else{
					if($('input:checkbox[name="balance_pay"]').prop("checked")){
						state=0;
					}else{
						state=-1
					}
				}
				$.ajax({
				    url:'${pageContext.request.contextPath}/center/setting/paymentUpdateState',
				    type:'POST', 
				    data:{'pay_id':payId,'state':state},
				    dataType:'json',
				    success:function(result){
				    	if(result.code==0){
				    		new PNotify({title: '提示操作',text: '操作成功',addclass: 'bg-info'});
				    	}else{
				    		new PNotify({title: '提示操作',text: '开启失败',addclass: 'bg-dangser'});
				    	}
				    },
				    error:function(xhr,textStatus){
				        console.log('错误');
				    }
				});
			}
			</script>