<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>营销服务</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<li><a href="scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="spread"><i class="icon-sphere3"></i>我要推广</a></li>
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
									
									<div class="info">
										<form class="form-horizontal form-validate-jquery" action="" method="post"  enctype="multipart/form-data">
											<fieldset class="content-group">
												<legend class="text-bold">
												<h5>活动信息</h5>
												</legend>
												
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">活动名称:</label>
													<div class="col-lg-3">
														<div class="input-group">
															<input type="text" class="form-control input-rounded" name="coupon_name" id="coupon_name" required="required"  title="选输入活动名称"> 
														</div>
													</div>
												</div>
												<div class="form-group" id="fixed_div">
													<label class="col-md-1 control-label">生效时间</label>	
													<div class="col-md-5">
									                    <div class="col-sm-12 input-group">
													        <div class="input-group"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
													           <input type="text" class="form-control pickadate-translated" name="start_time" id="start_time" value=""  onchange="judgeDate(1)">
										                       <span class="input-group-addon">--</span>
										                       <input type="text" class="form-control pickadate-translated" name="end_time" id="end_time" value="" onchange="judgeDate(2)">	
													        </div>
													     </div> 	
													 </div> 						
												</div>
											</fieldset>
										</form>
									</div>
									
									<div class="rule">
										<legend class="text-bold">
										<h5>优惠设置</h5>
										</legend>
										
										<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
											<div class="table-responsive">
												<table id="data-table" class="table table-bordered ">
													<thead>
														<tr class="bg-grey-300">
															<th class="user_column_user_account">层级</th> 
															<th class="user_column_user_name">优惠门槛</th>
															<th class="user_column_user_phone">优惠方式(可多选)</th>
															<th width="80">操作</th>
														</tr>
													</thead>
														<tr>
															<td>1</td>
															<td>
																<div class="col-lg-3">
																	<div class="input-group">
																		<span class="input-group-addon">满</span>
										                           		<input type="text" class="form-control" name="condition_price" id="condition_price" number="true"/>
										                            	<span class="input-group-addon">件</span>
																	</div>
																</div>
															</td>
															<!-- 
															<td>
																满
																<input type="text" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>
																<select style="width:50px;border:1px solid #ddd;height:26px;line-height:1.5384616">
																	<option value="">元</option>
																	<option value="0">件</option>
																</select>
															</td>
															 -->
															<td>
																<div class="control-label col-md-8">
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" checked="checked">
																		减现金
																		<input type="text" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>元
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" checked="checked">
																		打折&nbsp;&nbsp;
																		<input type="text" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>折
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" checked="checked">
																		免邮
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" checked="checked">
																		送优惠券
																		<select style="width:50px;border:1px solid #ddd;height:26px;line-height:1.5384616">
																			<option value="">元</option>
																			<option value="0">件</option>
																		</select>
																	</label>
																</div>
															</td>
															<td>
															</td>
														</tr>
														<tr>
															<td colspan="4"><a href="">新增一级优惠</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="text-muted">最多可设置五个层级 (每级优惠不累加)</span></td>
														</tr>
														
												</table>
						
											</div>
										</form>
									</div>
									<br>
									<div class="product">
										<form class="form-horizontal form-validate-jquery" action="" method="post"  enctype="multipart/form-data">
											<fieldset class="content-group">
												<legend class="text-bold">
												<h5>选择活动商品</h5>
												</legend>
												
												<div class="form-group">
													<label class="col-md-1 control-label">
														<font color="red"> * </font>活动商品
													</label>
													<div class="col-md-4">
														<label class="radio-inline">
															<input type="radio"  id="maxLimitType1" name="maxLimitType"  value="1" class="styled"
																checked="checked" onclick="changeMaxLimit(1)">
															全店商品参加
														</label>
														<label class="radio-inline">
															<input type="radio"  id="maxLimitType2" name="maxLimitType" value="2" class="styled" onclick="changeMaxLimit(2)">
															部分商品参加
														</label>
													</div>
												</div>
											</fieldset>
										</form>
									</div>
									
									<div class="text-right">
											<button type="reset" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>
											<button type="submit" class="btn btn-primary">创建满减送活动<i class="icon-arrow-right14 position-right"></i></button>
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
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script>
 
			$(document).ready(function() {
				<c:if test="${!empty infoMap &&  !empty infoMap.validate_id}">
					$("#validate_id").val("${infoMap.validate_id}");
					$("#validate_id_token").val("${infoMap.validate_id_token}");
					$("#coupon_name").val("${infoMap.coupon_name}");
			    	$("#coupon_price").val("${infoMap.coupon_price}");
			
			 
			      	$("input[name=type][value=${infoMap.type}]").prop("checked",true);
			       	$("input[name=type][value=${infoMap.type}]").trigger('click');
			    
			       	$("input[name=is_condition][value=${infoMap.is_condition}]").prop("checked",true);
			       	$("input[name=is_condition][value=${infoMap.is_condition}]").trigger('click');
			       	
			       	$("input[name=use_type][value=${infoMap.use_type}]").prop("checked",true);
			       	$("input[name=use_type][value=${infoMap.use_type}]").trigger('click');
			       	
			       	$("input[name=state][value=${infoMap.state}]").prop("checked",true);
			       	$("input[name=state][value=${infoMap.state}]").trigger('click');
			        
			        var isCondition = '${infoMap.is_condition}';
			        var useType = '${infoMap.use_type}';
			        var maxLimit = '${infoMap.max_limit}';
			        
			       if(isCondition == '1'){				    	   
			    	   $("#condition_price").val("${infoMap.condition_price}");	
			       }
			       
			       if(useType=='1'){
			    	   $("#from_day").val("${infoMap.from_day}");	 
			    	   $("#to_day").val("${infoMap.to_day}");	 
			       }else if(useType=='2'){
			    	   $("#start_time").val("${infoMap.start_time}");	 
			    	   $("#end_time").val("${infoMap.end_time}");	 
			       }
				 
			       if(maxLimit == null || maxLimit ==''){
			    	   $("input[name=maxLimitType][value=1]").prop("checked",true);
			    	   $("input[name=maxLimitType][value=1]").trigger('click');
			       }else{
			    	   $("input[name=maxLimitType][value=2]").prop("checked",true); 
			    	   $("input[name=maxLimitType][value=2]").trigger('click');
			    	   $("#max_limit").val("${infoMap.max_limit}");
			       }
				</c:if>
			});
			 
			function judgeDate(type){
				var startTime = $("#start_time").val();
				var endTime = $("#end_time").val();
				if(startTime == "" || endTime ==""){
					return false;
				}
				$("#dateDiv").attr("style","display:none;"); 
				$("#dateMsg").html(""); 
				
			    var start=new Date(startTime.replace("-", "/").replace("-", "/"));  	  
			    var end=new Date(endTime.replace("-", "/").replace("-", "/"));  
			    if(end<start){
			    	MAlert("开始时间应不小于结束时间");
			    	if(type==1){
			    		$("#start_time").val("");
			    	}else{
			    		$("#end_time").val("");
			    	}
			       return false;
			    }else{
			       return true;
			    }
			}
			
			function saveButton(){
				$("#buttonsave").attr("disabled", true);
				var useType=$('input:radio[name="use_type"]:checked').val();
				if(useType=="2"){
					var startTime = $("#start_time").val();
					var endTime = $("#end_time").val();
					if(startTime == "" || endTime ==""){
						$("#dateDiv").attr("style","display:block;"); 
						$("#dateMsg").html("开始时间和结束时间不能为空"); 
						$("#buttonsave").removeAttr("disabled"); 
						if(!$("#infoForm").validate().form()){
							return false;
						}
						return false;
					}else{
						$("#dateDiv").attr("style","display:none;"); 
						$("#dateMsg").html(""); 
					}
				}else{
					$("#dateDiv").attr("style","display:none;"); 
					$("#dateMsg").html(""); 
				}
				
				if(!$("#infoForm").validate().form()){
					$("#buttonsave").removeAttr("disabled");
					return false;
				}
				FullScreenShow("数据提交中，请稍后！");
				$("#infoForm").submit();
			}
			
			function changeCouponPrice(type){
				if(type=='1'){
					$("#typespan11").html("减");
					$("#typespan22").html("元");
				}else if(type=='2'){
					$("#typespan11").html("打");
					$("#typespan22").html("折");
				}
			}
			
			function changeIsCondition(type){
				if(type=='-1'){
					$("#conditionPrice_div").attr("class","form-group hide");
					$("#condition_price").removeAttr("required");
				}
				else if(type=='1'){
					$("#conditionPrice_div").attr("class","form-group show");
					$("#condition_price").attr("required","required");
				}
			}
			 
			function changeUseType(type){
			 	if(type=='1'){
			 		$("#dateDiv").attr("style","display:none;"); 
					$("#dateMsg").html(""); 
					
			 		$("#range_div").attr("class","form-group show");
			 		$("#fixed_div").attr("class","form-group hide");
			 		$("#start_time").removeAttr("required");
			 		$("#end_time").removeAttr("required");
			 		$("#from_day").attr("required","required");
			 		$("#to_day").attr("required","required");
			 	}
			 	else if(type=='2'){
			 		$("#range_div").attr("class","form-group hide");
			 		$("#fixed_div").attr("class","form-group show");
			 		$("#from_day").removeAttr("required");
			 		$("#to_day").removeAttr("required");
			 		$("#start_time").attr("required","required");
			 		$("#end_time").attr("required","required");
			 	}
			}
			
			function changeMaxLimit(type){
				if(type=='1'){
					$("#maxLimit_div").attr("class","form-group hide");
					$("#max_limit").removeAttr("required");
				}else if(type=='2'){
					$("#maxLimit_div").attr("class","form-group show");
					$("#max_limit").attr("required","required");
				}
			}
			
			</script>
						
