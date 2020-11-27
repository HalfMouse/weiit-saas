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
								<li class="active"><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<li><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="${pageContext.request.contextPath}/center/ump/spread"><i class="icon-sphere3"></i>我要推广</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> 
								<span class="text-semibold"> 满减送 </span>
							</h4>
						</div>
					</div>
				</div>
				<!-- Content area -->
				<div class="content">
					
					 <form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
				 		action="${pageContext.request.contextPath}/center/ump/reward/save" method="post" >
						<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
						<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/> 
						<input type="hidden" name="idsCount" id="idsCount" value="${(!empty itemList )?'fn:length(itemList)':'0'}"/>
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">

								<div class="panel-body">
									
									<div class="info">
											<fieldset class="content-group">
												<legend class="text-bold">
												<h5>满减送活动信息</h5>
												</legend>
												
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">活动名称:</label>
													<div class="col-lg-3">
														<div class="input-group">
															<input type="text" class="form-control input-rounded" name="reward_name" id="reward_name" required="required" value="${infoMap.reward_name}"  title="选输入活动名称"> 
														</div>
													</div>
												</div>
												<div class="form-group" id="fixed_div">
													<label class="col-md-1 control-label text-bold">生效时间</label>	
													<div class="col-md-5">
									                    <div class="col-sm-12 input-group">
													        <div class="input-group"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
													           <input type="text" class="form-control pickadate-translated" name="start_time" id="start_time" value="${infoMap.start_time}"  onchange="judgeDate(1)">
										                       <span class="input-group-addon">--</span>
										                       <input type="text" class="form-control pickadate-translated" name="end_time" id="end_time" value="${infoMap.end_time}" onchange="judgeDate(2)">	
													        </div>
													     </div>
													 </div> 						
												</div>
												<div class="form-group" id="dateDiv" style="display: none;">
											     	<label class="col-md-1 control-label text-right"> </label>
											     	<div class="col-md-5">
											     		<font color="red" id="dateMsg" ></font>
												    </div>
										      	</div>
										      	<div class="form-group">
													<label class="col-md-1 control-label">
														<font color="red"> * </font>状态
													</label>
													<div class="col-md-4">
														<label class="radio-inline">
															<input type="radio"  id="state1" name="state" ${infoMap.state ne -1?"checked":""}   value="0" class="styled" >
															生效
														</label>
														<label class="radio-inline">
															<input type="radio"  id="state2" name="state" value="-1" ${infoMap.state eq -1?"checked":""}  class="styled" >
															不生效
														</label>
													</div>
												</div>
											</fieldset>
									</div>
									
									<div class="rule">
										<legend class="text-bold">
										<h5>优惠设置</h5>
										</legend> 
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
													<c:forEach items="${itemList}" var="info" varStatus="ind">
														<tr>
															<td>${ind.count}</td>
															<td>
																满
																<input type="text" name="meet_price${ind.count-1}" value="${info.meet_price}" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>
																<select name="meet_type${ind.count-1}" style="width:50px;border:1px solid #ddd;height:26px;line-height:1.5384616">
																	<option value="0" ${(info.meet_type ne 1)?"selected":""} >元</option>
																	<option value="1" ${(info.meet_type eq 1)?"selected":""}>件</option>
																</select>
															</td>
															<td>
																<div class="control-label col-md-11">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="cash_type${ind.count-1}" ${(!empty info.cash_price and info.cash_price ne '0.00')?"checked":""} class="styled" value="1">
																		减现金
																		<input type="text" name="cash_price${ind.count-1}" value="${info.cash_price}" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>元
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" name="discount_type${ind.count-1}" ${(!empty info.discount_price and info.discount_price ne '0.00')?"checked":""} value="1">
																		打折&nbsp;&nbsp;
																		<input type="text" name="discount_price${ind.count-1}" value="${info.discount_price}" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>折
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" name="shipping_free${ind.count-1}" ${(!empty info.shipping_free and info.shipping_free ne 0)?"checked":""} value="1">
																		免邮
																	</label>
																	<br>
																	<label class="checkbox-inline">
																		<input type="checkbox" class="styled" name="coupon_type${ind.count-1}" ${(!empty info.coupon_id and info.coupon_id ne 0)?"checked":""}>
																		送优惠券</label>
																		<select name="coupon_id${ind.count-1}" style="width:200px;border:1px solid #ddd;height:26px;line-height:1.5384616">
																			<option value="0" >未选择</option>
																			<option value="1" ${(info.coupon_id eq 1)?"selected":""}>优惠券1</option>
																			<option value="2" ${(info.coupon_id eq 2)?"selected":""}>优惠券2</option>
																		</select>
																	
																</div>
															</td>
															<td>
																<c:if test="${ind.count ne 1}">
																<a href="javascript:;" onclick="delRowTupian(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a>
																</c:if>
															</td>
														</tr>
													</c:forEach> 
												</table>
												<br/>
												<a href="javascript:;" onclick="addRow()">新增一级优惠</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="text-muted">最多可设置五个层级 (每级优惠不累加)</span>
											</div>
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
										<button type="button" id="buttonsave" onclick="saveButton()" class="btn btn-primary">创建满减送活动<i class="icon-arrow-right14 position-right"></i></button>
										<button type="button" class="btn btn-default" onclick="javascript:history.back(-1)">返回 <i class="icon-reload-alt position-right"></i></button>				
									</div>
								</div>
							</div>
							<!-- /form validation -->
						</div>
					 </div>
				 	</form>	

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script> 
			var rowNum=0;
			$(document).ready(function() { 
				<c:if test="${!empty itemList}">
					rowNum=${fn:length(itemList)};
				</c:if>
				<c:if test="${empty itemList}">
					addRow();
				</c:if>
			});
			
			function addRow(){
				var trStr="<tr>"
					+'<td>'+(rowNum+1)+'</td>'
					+'<td>'
					+'	满'
					+'	<input type="text" name="meet_price'+rowNum+'" id="meet_price'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>'
					+'	<select name="meet_type'+rowNum+'" id="meet_type'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;line-height:1.5384616">'
					+'		<option value="0">元</option>'
					+'		<option value="1">件</option>'
					+'	</select>'
					+'</td>'
					+'<td>'
					+'	<div class="control-label col-md-11">'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="cash_type'+rowNum+'" id="cash_type'+rowNum+'" class="styled" value="1">'
					+'			减现金'
					+'			<input type="text" name="cash_price'+rowNum+'" id="cash_price'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>元'
					+'		</label>'
					+'		<br>'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="discount_type'+rowNum+'" id="discount_type'+rowNum+'" class="styled" value="1">'
					+'			打折&nbsp;&nbsp;'
					+'		<input type="text" name="discount_price'+rowNum+'" id="discount_price'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>折'
					+'		</label>'
					+'		<br>'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="shipping_free'+rowNum+'" id="shipping_free'+rowNum+'" class="styled" value="1">'
					+'			免邮'
					+'		</label>'
					+'		<br>'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="coupon_type'+rowNum+'" id="coupon_type'+rowNum+'" class="styled" value="1">'
					+'			送优惠券'
					+'			<select name="coupon_id'+rowNum+'" id="coupon_id'+rowNum+'" style="width:200px;border:1px solid #ddd;height:26px;line-height:1.5384616">'
					+'				<option value="0">未选择</option>'
					+'				<option value="1">优惠券1</option>'
					+'				<option value="2">优惠券2</option>'
					+'			</select>'
					+'		</label>'
					+'	</div>'
					+'</td>'
					+'<td>';
				if(rowNum!=0){
					trStr=trStr+'<a href="javascript:;" onclick="delRowTupian(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a>'
				}
					+'</td>'
				+'</tr>';
				$("#data-table").append(trStr); 
				rowNum++;
			}
			
			function delRowTupian(nowTr){
				$(nowTr).parent().parent().remove();
			} 
			
			 
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
				
				var startTime = $("#start_time").val();
				var endTime = $("#end_time").val();
				if(startTime == "" || endTime ==""){
					$("#dateDiv").attr("style","display:block;"); 
					$("#dateMsg").html("生效时间不能为空"); 
					$("#buttonsave").removeAttr("disabled"); 
					if(!$("#infoForm").validate().form()){
						return false;
					}
					return false;
				}else{
					$("#dateDiv").attr("style","display:none;"); 
					$("#dateMsg").html(""); 
				}
				if(!$("#infoForm").validate().form()){
					$("#buttonsave").removeAttr("disabled");
					return false;
				} 
				$("#idsCount").val(rowNum);
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
						
