<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>客户管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="userList"><i class="icon-users"></i>会员管理</a></li>
								<li class="active"><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
								<li><a href="userCashList"><i class="icon-cash"></i>会员提现</a></li>
								<li><a href="userSet"><i class="icon-gear"></i>会员设置</a></li>
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
			                         <div class="widget white" style="width:321px;background:#fafafa;">
			                         	 <div class="widget-titlebar">
			                         	 	<h5 class="text-white text-center" style="margin-top:7px;">会员卡</h5>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="sortable-style">
			                                        <ul class="sortable list">
			                                             <li>
				                                             <div  style="<c:if test="${infoMap eq null }">background:#0e2e0e;</c:if><c:if test="${infoMap.card_bg_type==0 }">background:${infoMap.card_bg_color };</c:if><c:if test="${infoMap.card_bg_type==1 }">background:url(${infoMap.card_img });</c:if>color:white;border-radius:6px;padding:20px" id="card-info-div">
				                                             	<div class="card-info" style="width:100%;">
					                                             	<div class="card-header" style="">
					                                             		<img src="${imageDomain}/${shopInfo.shop_logo }" class="img-circle" width="30px" height="30px"/>
					                                             		<span class="text-bold text-white">
																		    ${shopInfo.shop_name }
																		</span>
																		<div class="card_qr_code" style="float:right;">
						                                             		<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/qc_code.png" class="img-circle" width="30px" height="30px"/>
						                                             	</div>
					                                             	</div>
					                                             	
				                                             	</div>
				                                             	<div class="card-name" style="padding:20px 0">
				                                             		<h2 class="text-bold text-white title" style="margin:0;line-height:1">测试卡片</h2>
				                                             	</div>
				                                             	<div class="card-limit">
				                                             		<span class="text-bold text-white time_prew">
				                                             		<c:choose>
					                                             		<c:when test="${infoMap eq null }">有效期:无期限</c:when>
					                                             		<c:otherwise>
					                                             			<c:if test="${infoMap.limit_type==1 }">有效期:无期限</c:if>
					                                             			<c:if test="${infoMap.limit_type==2 }">有效期:<fmt:formatDate value="${infoMap.start_time }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${infoMap.end_time }" pattern="yyyy-MM-dd"/></c:if>
					                                             		</c:otherwise>
				                                             		</c:choose>
				                                             		</span>
				                                             	</div>
															</div>
			                                             </li>
			                                             
			                                             <li style="background:white;">
				                                             <legend class="text-bold"><h6>享受权益</h6></legend>
				                                             <div class="row">
				                                             	<div class="col-md-3"  id="baoyou_prew" style="<c:if test="${infoMap eq null or infoMap.is_free_shippiing!=0 }">display:none;</c:if>">
				                                             		<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/icon_baoyou.png" class="img-circle" width="60px"/>
				                                             		<span class="text-bold text-muted"  style="margin-left:13px;line-height:1">包邮</span>
				                                             	</div>
				                                             	<div class="col-md-3" id="zhekou_prew" style="<c:if test="${infoMap eq null or infoMap.discount<0 }">display:none;</c:if>">
				                                             		<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/icon_zhekou.png" class="img-circle" width="60px"/>
				                                             		<span class="text-bold text-muted zhekou_prew_c"  style="margin-left:13px;line-height:1">${infoMap.discount }折</span>
				                                             	</div>
				                                             	<div class="col-md-4" id="jifen_prew" style="<c:if test="${infoMap eq null or infoMap.give_integral<0 }">display:none;</c:if>">
				                                             		<img src="${pageContext.request.contextPath}/resource/images/shopTemplate/icon_jifen.png" class="img-circle" width="60px"/>
				                                             		<br><span class="text-bold text-muted jifen_prew_c"  style="">送${infoMap.give_integral }积分</span>
				                                             	</div>
				                                             </div>
			                                             </li>
			                                             <li style="background:white;">
				                                             <legend class="text-bold"><h6>使用须知</h6></legend>
				                                             <div class="row">
				                                             	<div class="col-md-12 use_desc">
				                                             		<c:choose>
					                                             		<c:when test="${infoMap eq null }">暂无使用须知...</c:when>
					                                             		<c:otherwise>${infoMap.use_remark }</c:otherwise>
				                                             		</c:choose>
				                                             	</div>
				                                             </div>
			                                             </li>
			                                             <li style="background:white;">店铺主页</li>
			                                             <li></li>
			                                        </ul>
			                                   </div>
			                              </div>
			                         </div>
			                    </div>
			                    <div style="margin-left:350px;width:680px;">
			                         <div class="row">
										<div class="col-md-12">
											<!-- 表单验证开始 -->
											<div class="panel panel-flat">
												<div class="panel-body">
													<form class="form-horizontal" method="POST" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/user/userCardSave" enctype="multipart/form-data" >
														<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
														<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
														<fieldset class="content-group">
															<legend class="text-bold">会员卡基本信息</legend>
															<div class="form-group">
																<label class="control-label col-md-2">店铺名称:</label>
																<div class="control-label col-md-3">
																	<span class="text-bold text-muted">${shopInfo.shop_name }</span>
																</div>
															</div>		
															<div class="form-group">
																<label class="control-label col-md-2">店铺LOGO:</label>
																<div class="col-md-3 text-left">
																	<img src="${imageDomain}/${shopInfo.shop_logo }" class="img-circle" width="30px" height="30px"/>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2">卡片封面:</label>
																<div class="col-md-6 text-left">
																	<div class="radio">
																		<label>
																			<input type="radio" name="card_bg_type" value="0" class="styled" ${(infoMap.card_bg_type ne 1)?"checked":""}>
																			背景色
																		</label>
																		<input type="text" name="card_bg_color" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color)?'#0e2e0e':infoMap.card_bg_color}">
																		<script>
																		 //颜色选择器
																	    $(".colorpicker-show-input").spectrum({
																	    	showInput: true,
																	    	cancelText: "取消",
																	        chooseText: "确定",
																	        change:function(c){
																	        	$("#card-info-div").attr("style","background:"+c.toHexString()+";color:white;border-radius:6px;padding:20px");
																	        }
																	    });
																		</script>
																	</div>
																	<div class="radio">
																		<label>
																			<input type="radio" name="card_bg_type" value="1" class="styled" ${(infoMap.card_bg_type eq 1)?"checked":""}>
																			封面图片
																		</label>
																		<a href='javascript:;' class="selectUserCardPicture">选择会员卡图片</a>
																	</div>
																	<input type="hidden" name="card_img" id="card_img" value="${infoMap.card_img}">
																</div>
															</div>	
															<div class="form-group">
																<label class="control-label col-md-2">会员卡名称<span class="text-danger">*</span></label>
																<div class="col-md-5">
																	<input type="text" name="card_name" class="form-control validate[required,maxSize[12]]" value="${infoMap.card_name}" placeholder="最多支持12个字" data-errormessage-value-missing="会员卡名称不能为空" data-errormessage-range-overflow="最多支持12个字">
																	<span class="text-muted">(会员卡名称保存成功后不支持修改)</span>
																</div>
															</div>
				
															<div class="form-group">
																<label class="control-label col-md-2">享受权益<span class="text-danger">*</span></label>
																<div class="control-label col-md-8">
																	<label class="checkbox-inline"> 
																		<input type="checkbox" name="is_free_shippiing"  class="styled" value="0" <c:if test="${infoMap.is_free_shippiing==0 }">checked</c:if> >
																		包邮
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="discountCheck" class="styled"  value="0" <c:if test="${infoMap.discount>0 }">checked</c:if> >
																		会员折扣&nbsp;&nbsp;<input type="text" name="discount" class="validate[custom[integer]]" value="${(infoMap.discount eq -1)?'':infoMap.discount}" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;margin-top:-2px;line-height:1.5384616"/>折
																	</label>
																	
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="integralCheck" class="styled" value="0" <c:if test="${infoMap.give_integral>0 }">checked</c:if> >
																		送积分  &nbsp;&nbsp;&nbsp;&nbsp;开卡赠送：<input type="text" name="give_integral" class="validate[custom[integer]]" value="${(infoMap.give_integral eq -1)?'':infoMap.give_integral}" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;margin-top:-2px;line-height:1.5384616"/>积分 
																	</label> 
																	<div id="quanyiMsg_div">
																		
																	</div>
																</div>
																
															</div>
															<!-- 文本框 -->
															<div class="form-group">
																<label class="control-label col-lg-2">使用须知 <span class="text-danger">*</span></label>
																<div class="col-lg-9">
																	<textarea rows="3" cols="3" name="use_remark" id="use_remark" class="form-control validate[required,maxSize[100]]" placeholder="" data-errormessage-value-missing="使用须知不能为空" data-errormessage-range-underflow="使用须知不能超过100个字符">${infoMap.use_remark}</textarea>
																</div>
															</div>
															<!-- /文本框 -->
															<div class="form-group">
																<label class="control-label col-md-2">客服电话</label>
																<div class="col-md-5">
																	<input type="text" name="tel" class="form-control"  placeholder="" value="${infoMap.tel}" >
																</div>
															</div>
															<div class="form-group" style="padding-bottom:0px;margin-bottom:0px;">
														     	<label class="control-label col-md-2"> <font color="red"> * </font>激活设置：</label>
														     	<div class="col-md-6">
														     		<label class="radio-inline"> 
														     			<input type="radio" class="styled" name="is_disabled"   value="0" ${(infoMap.is_disabled ne 1)?"checked":""}>
																			无需激活
																	</label>
																	<label class="radio-inline">
																		<input type="radio" class="styled" name="is_disabled"   value="1" ${(infoMap.is_disabled eq 1)?"checked":""}>
																			需要激活
																	</label>
														     	</div>
													      	</div>
														</fieldset>
														
														<fieldset class="content-group">
															<legend class="text-bold">会员卡期限</legend>
															<div class="form-group" >
																<label class="control-label col-md-2">会员期限:</label>
																<div class="col-md-6 text-left">
																	<div class="radio">
																		<label>
																			<input type="radio" name="limit_type" class="styled"  value="1" ${(infoMap.limit_type ne 2)?"checked":""}>
																			无限期
																		</label>
																	</div>
																	<div class="radio">
																		<label>
																			<input type="radio" name="limit_type" class="styled"  value="2" ${(infoMap.limit_type eq 2)?"checked":""}>
																			有期限
																		</label>
																		<div class="input-group" style="padding-left:90px;margin-top:-24px;">
																			<input type="text" class="form-control pickadate-translated" style="height:33px;" name="start_time" id="start_time" value="${infoMap.start_time}" placeholder="开始时间">
																			<span class="input-group-addon" style="height:33px;padding:0">--</span> 
																			<input type="text" class="form-control pickadate-translated" style="height:33px;" name="end_time" id="end_time" value="${infoMap.end_time}" placeholder="结束时间">
																		</div>
																	</div>
																	<div id="dataMsg_div"></div>
																</div>
																
															</div>
															<div class="form-group" id="dateDiv" style="display: none;">
														     	<label class="col-sm-2 control-label text-right"> </label>
														     	<div class="col-sm-6">
														     		<font color="red" id="dateMsg" ></font>
															    </div>
													      	</div> 
														</fieldset>
														<fieldset class="content-group">
															<legend class="text-bold">领取设置</legend>
															<div class="form-group">
																<label class="control-label col-md-2">领取方式:</label>
																<div class="col-md-6 text-left"  style="padding-top:6px;">
																	<label class="radio-inline">
																		<input type="radio" name="type" class="styled" value="1" ${(infoMap.type ne 2)?"checked":""} 
																			onclick="changeType(1)" >
																		手工发卡
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="type" class="styled" value="2" ${(infoMap.type eq 2)?"checked":""}
																			onclick="changeType(2)" >
																		自动升级
																	</label>
																</div>
															</div>
															<div id="type_div" class="form-group <c:if test="${infoMap.type ne 2 }">hide</c:if>">
																<div class="form-group">
																	<label class="control-label col-lg-2">交易笔数满 </label>
																	<div class="col-lg-3">
																		<div class="input-group">
																			<input type="text" name="order_count"  class="form-control validate[required,custom[integer]]" placeholder="" value="${infoMap.order_count}"  data-errormessage-value-missing="交易笔数限定不能为空" >
																			<div class="input-group-addon">笔</div>
																		</div>
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-lg-2">或 消费金额满 </label>
																	<div class="col-lg-4">
																		<div class="input-group">
																			<input type="text" name="order_total"  class="form-control validate[required,custom[integer]]" placeholder="" value="${infoMap.order_total}"  data-errormessage-value-missing="消费金额限定不能为空">
																			<div class="input-group-addon">元</div>
																		</div>
																	</div>
																</div> 
																<div class="form-group">
																	<label class="control-label col-lg-2">或 累计积分满 </label>
																	<div class="col-lg-3">
																		<div class="input-group">
																			<input type="text" name="integral_count" class="form-control validate[required,custom[integer]]" placeholder="" value="${infoMap.integral_count}"  data-errormessage-value-missing="累计积分限定不能为空">
																			<div class="input-group-addon">积分</div>
																		</div>
																	</div>
																</div>
															</div>
														</fieldset>
														<div class="text-right">
															<button type="reset" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>
															<button type="button" id="save_btn" class="btn btn-primary">创建卡片<i class="icon-arrow-right14 position-right"></i></button>
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
			//会员卡图片素材打开
			function openUserCardPictureSource(){
				commonDialogModal("会员卡图片","${pageContext.request.contextPath}/center/user/pictureSource_usercard",900,500,'','1',
					function(result){ 
						if(result){
							var select = $(".col-md-3.selected" , window.frames["dialogModalFrame"].document) ;
							var img=$(select).find(".info").val();
							$("#card-info-div").attr("style","background-image:url("+img+");color:white;border-radius:6px;padding:20px");
							$("#card_img").val(img);
						} 
					}
				);
			}
			$(document).ready(function() {
				/*
				$("input[name=card_bg_type]").change(function(){
					if($(this).val()==1){//选择封面图片
						openUserCardPictureSource();
					}
				});*/
				$(".selectUserCardPicture").click(function(){
					openUserCardPictureSource();
				});
				//领取方式
				$("input[name='type']").click(function(e){
					if($(this).val()=='1'){
						$("#type_div").attr("class","hide");
					}else{
						$("#type_div").removeClass("hide");
					}
				});
				
				/*默认监听表单onbulr验证*/
				$('#infoForm').validationEngine({ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'formError-white',
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
						//判断权益必须选择一项
						if(!$("input[name='is_free_shippiing']").prop("checked")&&!$("input[name='discountCheck']").prop("checked")&&!$("input[name='integralCheck']").prop("checked")){
							$("#quanyiMsg_div").html("<font color='red'>享受权益最少选择一项!</font>");
							$("#save_btn").removeAttr("disabled"); 
			    			return false;
						}else{
							if($("input[name='discountCheck']").prop("checked")&&$("input[name='discount']").val()==''){
								$("#quanyiMsg_div").html("<font color='red'>享受权益选择会员折扣时必须输入折扣</font>");
								$("#save_btn").removeAttr("disabled"); 
				    			return false;
							}else{
								$("#quanyiMsg_div").html("");
							}
							if($("input[name='integralCheck']").prop("checked")&&$("input[name='give_integral']").val()==''){
								$("#quanyiMsg_div").html("<font color='red'>享受权益选择送积分时必须输入积分</font>");
								$("#save_btn").removeAttr("disabled"); 
				    			return false;
							}else{
								$("#quanyiMsg_div").html("");
							}
							
						}
						//判断时间控件 begin
						var useType=$('input:radio[name="limit_type"]:checked').val();
				    	if(useType=="2"){
				    		var startTime = $("#start_time").val();
				    		var endTime = $("#end_time").val();
				    		if(startTime == "" || endTime ==""){
				    			$("#dataMsg_div").html("<font color='red'>开始时间和结束时间不能为空!</font>"); 
				    			$("#save_btn").removeAttr("disabled"); 
				    			return false;
				    		}else{
				    			var start=new Date(startTime.replace("-", "/").replace("-", "/"));  	  
							    var end=new Date(endTime.replace("-", "/").replace("-", "/"));  
							    if(end<start){
							    	$("#dataMsg_div").html("<font color='red'>开始时间不能大于结束时间</font>"); 
					    			$("#save_btn").removeAttr("disabled"); 
					    			return false;
							    }else{
				    				$("#dataMsg_div").html(""); 
							    }
				    		}
				    	}else{
				    		$("#dataMsg_div").html(""); 
				    	}
				    	//判断时间控件 end
						FullScreenShow("数据提交中，请稍后！");
						$("#infoForm").submit();
					}
					
				});
				
				//右边动态效果控制 开始
				$("input[name=card_name]").blur(function(){
					$(".card-name .title").html($(this).val());
				});
				$("input[name=is_free_shippiing]").change(function(){
					if($("input[name='is_free_shippiing']").prop("checked")){
						$("#baoyou_prew").show();
					}else{
						$("#baoyou_prew").hide();
					}
				});
				$("input[name=discountCheck]").change(function(){
					if($("input[name='discountCheck']").prop("checked")){
						$("#zhekou_prew").show();
					}else{
						$("#zhekou_prew").hide();
					}
				});
				$("input[name=discount]").change(function(){
					$(".zhekou_prew_c").html($(this).val()+"折");
				});
				$("input[name=integralCheck]").change(function(){
					if($("input[name='integralCheck']").prop("checked")){
						$("#jifen_prew").show();
					}else{
						$("#jifen_prew").hide();
					}
				});
				$("input[name=give_integral]").change(function(){
					$(".jifen_prew_c").html("送"+$(this).val()+"积分");
				});
				$("#use_remark").change(function(){
					$(".use_desc").html($(this).val());
				});
				$("input[name=limit_type]").change(function(){
					if($(this).val()==1){
						$(".time_prew").html("有效期:无期限");
					}else{
						$(".time_prew").html("有效期:20xx:00:00-20xx:00:00");
					}
				});
				$("input[name=start_time]").change(function(){
					$(".time_prew").html("有效期:"+$(this).val()+"~20xx:00:00");
				});
				$("input[name=end_time]").change(function(){
					$(".time_prew").html("有效期:"+$("input[name=start_time]").val()+"~"+$(this).val());
				});
			}); 
			
			</script>
						
