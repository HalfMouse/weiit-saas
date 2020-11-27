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
								<li><a href="shopCertification"><i class="icon-vcard position-left"></i>实名认证</a></li>
								<li class="active"><a href="shopAddress"  style="border-top:0px;"><i class="icon-address-book position-left"></i>商家地址库</a></li>
							</ul> 
							<!-- /tabs -->
							<!-- 表单验证开始 -->
							<div class="panel panel-flat"  style="margin-top:-20px;border-top:0px;"> 
								<div class="panel-body">
								
								<form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/setting/shopAddressSave" method="post" >
									<input type="hidden" name="address_id" id="address_id" value="${infoMap.address_id}" />
									<fieldset class="content-group">
										
										<div class="form-group">
											<label class="control-label col-md-1">省/市/区<span
												class="text-danger">*</span> </label>
											<div class="col-md-1">
												<select  name="province" id="province"  data-placeholder="省"
													class="select" onchange="initRegion(this.value,'city')">
													<option value="">--请选择省--</option>
													<c:forEach items="${provinces }" var="region" >
													<option value="${region.id }" ${region.id==infoMap.province?"selected":"" }>${region.region_name }</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1">
												<select  name="city" id="city" data-placeholder="市"
													class="select"  onchange="initRegion(this.value,'district')">
													<option value="">--请选择城市--</option>
													<c:forEach items="${citys }" var="region" >
													<option value="${region.id }" ${region.id==infoMap.city?"selected":"" }>${region.region_name }</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-md-1">
												<select  name="district" id="district" data-placeholder="区/县" class="select">
													<option value="">--请选择区/县--</option>
													<c:forEach items="${districts }" var="region" >
													<option value="${region.id }" ${region.id==infoMap.district?"selected":"" }>${region.region_name }</option>
													</c:forEach>
												</select>
											</div>
										</div> 
										<div class="form-group">
											<label class="control-label col-md-1"> 街道地址<span class="text-danger">*</span></label>
											<div class="col-md-3">
												<input type="text" class="form-control validate[required]" name="address" value="${infoMap.address}"  placeholder="请输入街道地址" data-errormessage-value-missing="请输入街道地址" >
											</div>
										</div>
										
										<div class="form-group">
											<label class="control-label col-md-1">联系人名称<span class="text-danger">*</span> </label>
											<div class="col-md-2">
												<input type="text" class="form-control validate[required]" name="contact_name"   placeholder="请输入联系人名称" value="${infoMap.contact_name}" data-errormessage-value-missing="请输入联系人名称" >
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-1"> 联系号码<span class="text-danger">*</span> </label>
											<div class="col-md-2">
												<input type="text" class="form-control validate[required,custom[tel]]" name="phone" value="${infoMap.phone}" placeholder="请输入手机号码" data-errormessage-value-missing="请输入手机号码" >
											</div>
										</div> 
										<div class="form-group">
											<label class="control-label col-md-1"> 邮政编码</label>
											<div class="col-md-1">
												<input type="text" class="form-control" name="zip_code" value="${infoMap.zip_code}"  placeholder="518000" >
											</div>
										</div>
								      	<div class="form-group">
											<label class="control-label col-md-1"> 备注</label>
											<div class="col-md-3">
												<textarea name="remark" class="form-control"  rows="4" cols="60" >${infoMap.remark}</textarea>
											</div>
										</div>
									</fieldset> 
									<div class="text-center">
										<button type="button" id="save_btn" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
										&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)"  class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
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
			
			$(function(){
				
				$('#infoForm').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				}); 
				//表单提交
				$("#save_btn").click(function(){
					
					if($("#province").val()==""||$("#city").val()==""||$("#district").val()==""){
						MAlert("请选择省份/城市/区县");
						$("#save_btn").removeAttr("disabled"); 
						return false;
					}
					
					$("#save_btn").attr("disabled", true);
					if(!$('#infoForm').validationEngine("validate")){
						$("#save_btn").removeAttr("disabled");
						return false;
					}else{
						
						FullScreenShow("数据提交中，请稍后！");
						$("#infoForm").submit();
						
					}
					
				});
				
			});
			
			function initRegion(parent_id,id){
				if(parent_id!=0){
					$.ajax({
					    url:'${pageContext.request.contextPath}/center/publics/publics/selectRegionList',
					    type:'GET', 
					    data:{'parent_id':parent_id},
					    dataType:'json',
					    success:function(result){
					    	result=result.data;
					    	var option="";
					    	if(id=="city"){
					    		option="<option value=''>--请选择城市--</option>";
					    	}
					    	if(id=="district"){
					    		option="<option value=''>--请选择区/县--</option>";
					    	}
					    	for ( var i = 0; i < result.length; i++) {
					    		option=option+"<option value='"+result[i].id+"'>"+result[i].region_name+"</option>";
							} 
					    	$("#"+id).html(option);
					    	$("#"+id).select2("val","");//默认选中第一个
					    },
					    error:function(xhr,textStatus){
					        console.log('错误');
					    }
					});
				}
			}
			function checkRegion(){
				if($("#province").val()==""){
					return "省份不能为空";
				}
			}
			
			  </script>
			
