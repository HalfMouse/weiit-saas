<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=Ot8m2eR2tQI4lg1lUxtjGnwuFwFIn2US"></script>
<style>
.anchorBL{display:none;}
</style>
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
								<li class="active"><a href="shopInfo" style="border-left:0px;border-top:0px;"><i class="icon-home8 position-left"></i>店铺基本信息</a></li>
								<li><a href="shopCertification"><i class="icon-vcard position-left"></i>实名认证</a></li>
								<li><a href="shopAddress"><i class="icon-address-book position-left"></i>商家地址库</a></li>
							</ul> 
							<!-- /tabs -->
							
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								
								<div class="panel-body">
									<div class="profile">
										<form class="form-horizontal" id="infoForm" action="${pageContext.request.contextPath}/center/setting/shopInfoSave" method="post"  enctype="multipart/form-data">
											<input type="hidden"  id="validate_id"  name="validate_id" value="${shopInfo.validate_id}">
											<input type="hidden"  id="validate_id_token"  name="validate_id_token" value="${shopInfo.validate_id_token}">
											<fieldset class="content-group">
												<div class="form-group">
													<label class="col-md-1">
														<img src="${imageDomain }${shopInfo.shop_logo }" class="img-circle" width="128" height="128"/>
													</label>
													<div class="col-md-3" style="margin-left: 5rem; ">
														<span class="text-bold text-muted">
														    <br>店铺认证:
														    <c:if test="${shopInfo.is_auth eq -1}"><span class="text-default text-bold"><i class="icon-shield-check"></i>未认证</span></c:if>
															<c:if test="${shopInfo.is_auth eq 0}"><span class="text-warning text-bold"><i class="icon-shield-check"></i>认证中</span></c:if>
													    	<c:if test="${shopInfo.is_auth eq 1}"><span class="text-success text-bold"><i class="icon-shield-check"></i>已认证</span></c:if>
															<br><br>主营类目:数码家电<br><br>
															注册时间:<fmt:formatDate value="${shopInfo.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/><br>
														</span>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-1">商城名称<span class="text-danger">*</span></label>
													<div class="col-md-2">
														<input type="text" class="form-control validate[required]" value="${shopInfo.shop_name }"  name="shop_name" data-errormessage-value-missing="商城名称不能为空" >
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-1">店铺域名<span class="text-danger">*</span></label>
													<div class="control-label col-md-6">
														<!-- 
														<div class="input-group">
															<input type="text" name="shop_domain_prex" id="shop_domain_prex" class="form-control validate[required,custom[onlyLetterNumber],ajax[ajaxCheckShopDomain]]" value="${shopInfo.shop_domain_prex }" placeholder="如:aopinhui" data-errormessage-value-missing="店铺域名不能为空" >
															<div class="input-group-addon">.wstore.me</div>
														</div>
														 -->
														 <c:if test="${sessionScope.publicInfo!=null }">
															 <div class="input-group">
																<a href="http://${sessionScope.publicInfo.authorizer_app_id }.wx.ustore.wang" target="_blank">${sessionScope.publicInfo.authorizer_app_id }.wx.ustore.wang</a>
															 </div>
														 </c:if>
														 <c:if test="${sessionScope.publicInfo eq null }">
															<div class="input-group">
																<a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo">先去授权</a>
															</div> 
														 </c:if>
													</div>
												</div> 
												<div class="form-group">
													<label class="control-label col-md-1">商城LOGO<span class="text-danger">*</span></label>
													<div class="col-lg-10">
														<input type="file" name="file_logo" class="bootstrap-uploader" id="file_logo">
														<input type="hidden" name="shop_logo" id="shop_logo" value="${shopInfo.shop_logo }" class="hiddenClass"/>
														<br>
														<span style="color: gray">建议尺寸：120 * 120 像素。</span>
													</div>
												</div>
												
												<div class="form-group">
													<label class="control-label col-md-1">客服电话<span class="text-danger">*</span></label>
													<div class="col-md-2">
														<input type="text" class="form-control validate[required,custom[tel]]" value="${shopInfo.shop_tel}"  name="shop_tel"  data-errormessage-value-missing="客服电话不能为空">
													</div>
												</div> 
												
												<div class="form-group">
													<label class="control-label col-md-1">店铺简介</label>
													<div class="col-md-4">
														<textarea rows="4" cols="3" name="shop_summary" class="form-control" placeholder="">${shopInfo.shop_summary}</textarea>
													</div>
												</div>
												
												
												 <!-- /弧形输入框 -->
												<div class="form-group">
													<label class="control-label col-md-1">省/市/区 </label>
													<div class="col-md-1">
														<select  name="province_id" id="province_id"  data-placeholder="省"
															class="select" onchange="initRegion(this.value,'city_id')">
															<option value="0">--请选择省--</option>
															<c:forEach items="${provinces }" var="region" >
															<option value="${region.id }" ${region.id==shopInfo.province_id?"selected":"" } value-name="${region.region_name }">${region.region_name }</option>
															</c:forEach>
														</select>
													</div>
													<div class="col-md-1">
														<select  name="city_id" id="city_id" data-placeholder="市"
															class="select" onchange="initRegion(this.value,'district_id')">
															<option value="0">--请选择城市--</option>
															<c:forEach items="${citys }" var="region" >
															<option value="${region.id }" ${region.id==shopInfo.city_id?"selected":"" } value-name="${region.region_name }">${region.region_name }</option>
															</c:forEach>
														</select>
													</div>
													<div class="col-md-1">
														<select  name="district_id" id="district_id" onchange="initRegion('','')"  data-placeholder="区/县" class="select" >
															<option value="0">--请选择区/县--</option>
															<c:forEach items="${districts }" var="region" >
															<option value="${region.id }" ${region.id==shopInfo.district_id?"selected":"" } value-name="${region.region_name }">${region.region_name }</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													
													<label class="control-label col-md-1">详细地址</label>
													<div class="col-md-4">
														<div class="panel panel-flat">
															<div class="panel-body" id="allmap" style="height:300px;">
															</div>
														</div>
														
														<script type="text/javascript">
														
														    // 百度地图API功能
														    var map = new BMap.Map("allmap",{enableMapClick:false});
														  	
														    map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);
														    map.enableScrollWheelZoom(true);
														    
															var local = new BMap.LocalSearch(map, {
																renderOptions:{map: map}
															});
															
															if($("#province_id").find('option:selected').attr('value-name')){
																local.search($("#province_id").find('option:selected').attr('value-name'));
															}
															if($("#city_id").find('option:selected').attr('value-name')){
																local.search($("#city_id").find('option:selected').attr('value-name'));
															}
															if($("#district_id").find('option:selected').attr('value-name')){
																local.search($("#district_id").find('option:selected').attr('value-name'));
															}
															if('${shopInfo.address_detail}'!=''){
																local.search("${shopInfo.address_detail}");
															}
															
														    var geoc = new BMap.Geocoder();   //地址解析对象  
														   
														    map.addEventListener("click", showInfo);  
														    //点击地图时间处理  
														    function showInfo(e) {  
														        geoc.getLocation(e.point, function (rs) {  
														            var addComp = rs.addressComponents;  
														            var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;  
														            $("#shop_x").val(e.point.lng);
															        $("#shop_y").val(e.point.lat);
															        $("#address_detail").val(address); 
														        });  
														    }  
														</script>
														<input type="text" class="form-control" value="${shopInfo.address_detail}"  id="address_detail" name="address_detail" ><br>
														
													</div>
												</div>
														
												<div class="text-center">
													<input type="hidden" class="form-control"  value="${shopInfo.shop_x}"  id="shop_x" name="shop_x">
													<input type="hidden" class="form-control" value="${shopInfo.shop_y}" id="shop_y"  name="shop_y">
													<a href="shopInfo" id="qua1" class="btn btn-default" >重置<i class="icon-undo2 position-right"></i></a>
													&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" id="save_btn" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
														
												</div>
												
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
				
				initPicture("${imageDomain }","${shopInfo.shop_logo}","#file_logo");
				openSource("#file_logo");
				 
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
// 						$.ajax({
// 						    url:'${pageContext.request.contextPath}/center/setting/checkShopDomain',
// 						    type:'POST', 
// 						    data:{'shop_domain_prex':$("#shop_domain_prex").val()},
// 						    dataType:'json',
// 						    success:function(result){
// 						    	if(result[1]){
// 						    		FullScreenShow("数据提交中，请稍后！");
// 									$("#infoForm").submit();
// 						    	}else{
// 						    		$("#save_btn").removeAttr("disabled");
// 									return false;
// 						    	}
						    	
// 						    },
// 						    error:function(xhr,textStatus){
// 						        console.log('错误');
// 						        $("#save_btn").removeAttr("disabled");
// 								return false;
// 						    }
// 						});
						FullScreenShow("正在修改店铺数据，请稍后！");
						$("#infoForm").submit();
					}
					
				});
			});
			
			
			function initRegion(parent_id,id){
				
				//加载地图
				//if($("#address_detail").val().length<1){
					if($("#province_id").find('option:selected').attr('value-name')){
						local.search($("#province_id").find('option:selected').attr('value-name'));
					}
					if($("#city_id").find('option:selected').attr('value-name')){
						local.search($("#city_id").find('option:selected').attr('value-name'));
					}
					if($("#district_id").find('option:selected').attr('value-name')){
						local.search($("#district_id").find('option:selected').attr('value-name'));
					}
					
				//}else{
				//	local.search($("#address_detail").val());
				//}
				if(parent_id!=''){
					if(parent_id!=0){
						$.ajax({
						    url:'${pageContext.request.contextPath}/center/publics/publics/selectRegionList',
						    type:'GET', 
						    data:{'parent_id':parent_id},
						    dataType:'json',
						    success:function(result){
						    	result=result.data;
						    	var option="";
						    	if(id=="city_id"){
						    		option="<option value='0'>--请选择城市--</option>";
						    	}
						    	if(id=="district_id"){
						    		option="<option value='0'>--请选择区/县--</option>";
						    	}
						    	for ( var i = 0; i < result.length; i++) {
						    		option=option+"<option value='"+result[i].id+"' value-name='"+result[i].region_name+"'>"+result[i].region_name+"</option>";
								} 
						    	$("#"+id).html(option);
						    	$("#"+id).select2("val","0");//默认选中第一个
						    	if(id=='city_id'){//如果选择的是省份，区县也置空
						    		$("#district_id").select2("val","0");//默认选中第一个
						    	}
						    },
						    error:function(xhr,textStatus){
						        console.log('错误');
						    }
						});
					}
				}
				
			}
			
			
			  </script>
						
