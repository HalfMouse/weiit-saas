<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>

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
								<li  class="active"><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i class="icon-cube4"></i>底部菜单</a></li>
								<li ><a href="${pageContext.request.contextPath}/center/design/page/navEdit"><i
										class="icon-cube3"></i>底部导航</a></li>
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
										<form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
								 			action="${pageContext.request.contextPath}/center/design/page/globalStyleSave" method="post" >
											<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
											<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
											<fieldset class="content-group">
												<legend class="text-bold"><h5>全店风格</h5></legend>
												 
												<div class="col-md-12">
													<div class="form-group">
														<input type="hidden" name="global_bg1" id="global_bg1" value="">
														<input type="hidden" name="global_bg2" id="global_bg2" value="">
														<label class="control-label col-md-2 text-right">显示方式：</label>
														<div class="col-md-6">
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type" checked class="styled" value="1" onchange="globalClick(1,'#FF4444','#FF8855')" >
																<span style="width: 16px; height: 16px; display: inline-block; background: #FF4444;"></span><span style="width: 16px; height: 16px; display: inline-block; background: #FF8855;"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="2" onchange="globalClick(2,'#FF5E15','#FF9300')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(255, 94, 21);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(255, 147, 0);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="3" onchange="globalClick(3,'#FF547B','#FFE6E8')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(255, 84, 123);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(255, 230, 232);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="4" onchange="globalClick(4,'#FF4444','#555555')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(255, 68, 68);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(85, 85, 85);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="5" onchange="globalClick(5,'#FCC600','#1D262E')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(252, 198, 0);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(29, 38, 46);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<%--<input type="radio" name="global_type"  class="styled" value="6" onchange="globalClick(6,'#65C4AA','#DDF2EC')">--%>
																<input type="radio" name="global_type"  class="styled" value="6" onchange="globalClick(6,'#65C4AA','#AFEEEE')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(101, 196, 170);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(221, 242, 236);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="7" onchange="globalClick(7,'#09BB07','#383838')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(9, 187, 7);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(56, 56, 56);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="8" onchange="globalClick(8,'#63C772','#FFF4E3')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(99, 190, 114);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(225, 244, 227);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<%--<input type="radio" name="global_type"  class="styled" value="9" onchange="globalClick(9,'#4A90E2','#E6E6FA')">--%>
																<input type="radio" name="global_type"  class="styled" value="9" onchange="globalClick(9,'#4A90E2','#6495ED')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(74, 144, 226);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(219, 233, 249);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<input type="radio" name="global_type"  class="styled" value="10" onchange="globalClick(10,'#C3A769','#F3C0A6')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(195, 167, 105);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(243, 238, 225);"></span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);"></span>
															</label>
															<label class="radio-inline" style="margin-left:5px;">
																<%--<input type="radio" name="global_type"  class="styled" value="11" onchange="globalClick(11,'#333333','#D3D3D3')">--%>
																<input type="radio" name="global_type"  class="styled" value="11" onchange="globalClick(11,'#333333','#F5DEB3')">
																<span style="width: 16px; height: 16px; display: inline-block; background: rgb(51, 51, 51);"></span><span style="width: 16px; height: 16px; display: inline-block; background: rgb(211, 211, 255); "> </span><span style="width: 14px; height: 14px; display: inline-block; background: rgb(255, 255, 255); border: 1px solid rgb(234, 234, 234);">
															</span>
															</label>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-sm-2 text-right"> 当前风格示例： </label>
														<div class="col-md-6">
															<img id="globalImg" src="${pageContext.request.contextPath}/resource/images/custom/global1.png" width="769" height="438">
														</div>
													</div>
													<div class="text-center">
														<button type="button" onclick="saveButton(this,'数据提交中，请稍后！')" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
													</div>
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
			
			<%@include file="../../common/footer.jsp"%>
			
			<script>
			$(document).ready(function() { 
				if("${infoMap.global_type}"!=""){
					$("input[name=global_type][value=${infoMap.global_type}]").prop("checked",true);
					$("input[name=global_type][value=${infoMap.global_type}]").trigger('click'); 
					globalClick('${infoMap.global_type}','${infoMap.global_bg1}','${infoMap.global_bg2}');
				}
			}); 
			
			function globalClick(type,bg1,bg2){
				$("#global_bg1").val(bg1);
				$("#global_bg2").val(bg2);
				$("#globalImg").attr("src","${pageContext.request.contextPath}/resource/images/custom/global"+type+".png?1");
			}
			
			</script>
						
