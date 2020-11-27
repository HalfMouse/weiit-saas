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
								<li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>
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
								<span class="text-semibold"> 扫码收款 </span>
							</h4>
						</div>
					</div>
				</div>
				<!-- Content area -->
				<div class="content">
					
					 <form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
				 		action="${pageContext.request.contextPath}/center/ump/cashier/save" method="post" >
						<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
						<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>  
						<input type="hidden" name="cashier_img" id="cashier_img" value="${infoMap.cashier_img}"/>  
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat"> 
								<div class="panel-body"> 
									<div class="info">
											<fieldset class="content-group">
												<legend class="text-bold">
												<h5>${title}</h5>
												</legend> 
												<div class="form-group">
													<label class="control-label col-md-2 text-bold text-right">收款码名称:</label>
													<div class="col-lg-3">
														<div class="input-group">
															<input type="text" class="form-control input-rounded" name="cashier_name" id="cashier_name" required="required" value="${infoMap.cashier_name}"  title="选输入收款码名称"> 
														</div>
													</div>
												</div>
												 <div class="form-group">
													<label class="col-md-2 control-label text-bold text-right">
														<font color="red"> * </font>收款码类型
													</label>
													<div class="col-md-4">
														<label class="radio-inline">
															<input type="radio"  id="cashier_type0" name="cashier_type"  value="0" class="styled"
																checked="checked" onclick="changeMaxLimit(0)">
															自助收款码
														</label>
														<label class="radio-inline">
															<input type="radio"  id="cashier_type1" name="cashier_type" value="1" class="styled" onclick="changeMaxLimit(1)">
															指定金额收款码
														</label>
													</div>
												</div>  
												<div class="form-group hide"  id="maxLimit_div">
													<label class="control-label col-md-2 text-bold text-right">收款码金额:</label>
													<div class="col-md-3"> 
														<input type="text" class="form-control" name="cashier_price" id="cashier_price" value="0" number="true"/>
							                        </div>     
												</div> 
										      	<div class="form-group">
													<label class="col-md-2 control-label text-bold text-right">
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
									 
									<div class="text-right">
										<button type="button" id="buttonsave" onclick="saveButton()" class="btn btn-primary">创建扫码收款<i class="icon-arrow-right14 position-right"></i></button>
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
			$(document).ready(function() {  
				var cashier_type = '${infoMap.cashier_type}'; 
		       if(cashier_type =='1'){
		    	   $("input[name=cashier_type][value=1]").prop("checked",true);
		    	   $("input[name=cashier_type][value=1]").trigger('click');
		    	   $("#cashier_price").val("${infoMap.cashier_price}");
		       }else{
		    	   $("input[name=cashier_type][value=0]").prop("checked",true); 
		    	   $("input[name=cashier_type][value=0]").trigger('click');
		    	   $("#cashier_price").val("0");
		       }
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
				FullScreenShow("数据提交中，请稍后！");
				$("#infoForm").submit();
			} 
			
			function changeMaxLimit(type){
				if(type=='0'){
					$("#maxLimit_div").attr("class","form-group hide");
					$("#cashier_price").removeAttr("required"); 
					$("#cashier_price").val("0");
				}else if(type=='1'){
					$("#maxLimit_div").attr("class","form-group show");
					$("#cashier_price").attr("required","required");
				}
			}
			</script>
						
