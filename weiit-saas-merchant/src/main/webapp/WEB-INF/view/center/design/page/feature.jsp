<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/shopTemplate/user.css">

 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.all.min.js"></script>
 <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
 <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>					

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
								<li class="active"><a href="${pageContext.request.contextPath}/center/design/page/feature"><i class="icon-html5"></i>微页面</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<form class="form-horizontal form-validate-jquery" method="POST"  name="infoForm" id="infoForm"
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
			                                   		<ul class="sortable list" id="labelH5">
			                                   		</ul>
			                                   </div>
			                              </div>
			                              <div class="custom_content" > 
			                              	<h5 class="text-default  text-center" style="margin-top:7px;">自定义添加</h5>
			                              	<div class="row" style="padding:0px;margin:0px;">
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(1)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">店招</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(2)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">图片广告</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(3)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">图标导航</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(4)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">搜索框</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(5)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">商品列表</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(6)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">商品分组</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(7)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">文本导航</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(8)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">标题</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(9)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">富文本</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(10)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">语音</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(11)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">视频</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(12)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">公告</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(13)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">客服电话</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(14)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">辅助线</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(15)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">辅助空白</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(16)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">秒杀</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(17)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">优惠券</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(18)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">拼团</span>
			                              			</div>
			                              		</div>
			                              	</div>
			                              </div>
			                         </div>
			                    </div>
			                    <div style="margin-left:350px;width:680px;">
			                         <div class="row">
										<div class="col-md-12" id="divH5">
											<!-- 表单验证开始 -->
											<div class="panel panel-flat" style="padding-bottom:0px;margin-bottom:0px;">
												<div class="panel-body" style="padding:0px;margin: 0px;">
													<fieldset class="content-group">
														<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>页面基础设置</h4></legend>
														<div class="form-group">
															<label class="control-label col-md-2 text-right">页面标题：</label>
															<div class="col-md-5">
																<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-2 text-right">页面描述：</label>
															<div class="col-md-5">
																<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-2 text-right">卡片封面:</label>
															<div class="col-md-6 "> 
																背景色<input type="text" name="card_bg_color" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color)?'#f75d1c':''}">
															</div>
														</div>	
													</fieldset>
												</div>
											</div>
											<!-- /form validation -->
				
											<!-- 表单验证开始 -->
											<div id="custonDiv1" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>店招设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">选择风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="align"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >经典风格
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >高雅风格
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">卡片封面:</label>
																<div class="col-md-6 "> 
																	背景色<input type="text" name="card_bg_color22" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																</div>
															</div>	
															<div class="form-group">
																<label class="control-label col-md-2 text-right">店招图片：</label>
																<div class="col-md-6 text-left">
																	<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																	<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv2" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>图片模板设置</h4></legend>
															<div class="form-group"> 
																<label class="control-label col-md-2 text-right">显示方式：</label>
																<div class="col-md-10">
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic01.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic02.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic03.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic04.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic05.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic06.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic07.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic08.png" height="40" width="50">	
																	</label>
																	<label class="radio-inline" style="margin-left:5px;">
																		<input type="radio" name="set_style"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		<img src="https://mch.wxrrd.com/image/placehold/pic09.png" height="40" width="50">	
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:20px;">
																<div class="col-md-4">
																	<button type="button" class="btn btn-primary" onclick="">添加图标<i class="icon-checkmark3 position-right"></i></button>
																</div>
															</div> 
															<div class="form-group" style="padding:0px;margin: 0px;padding-left:12px;padding-right:12px;">
																<div class="col-md-12 alert-danger">
																	<table  class="col-md-12">
																		<tr>
																			<td rowspan="2">
																				<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																				<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																			</td>
																			<td>
																				<div class="form-group" style="padding-top:10px;margin-bottom:10px;">
																					<label class="control-label col-md-3 text-right">图片标题：</label>
																					<div class="col-md-7">
																						<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																					</div>
																				</div>
																				<div class="form-group" style="padding-bottom: 15px;">
																					<label class="control-label col-md-3 text-right">图片链接：</label>
																					<div class="col-md-7">
																						<select class="select" data-width="100%" name="state" id="state">
																							<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--请选择--</option>
																							<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>微页面</option>
																							<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>商品分组页</option>
																							<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>商品页</option>
																							<option value="3" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>直接购买</option>
																							<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>店铺主页</option>
																							<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>个人中心</option>
																							<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>列表页</option>
																						</select>
																					</div>
																				</div>
																			</td>
																			<td rowspan="2">删除</td>
																		</tr>
																	</table>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv3" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>图标导航</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">选择风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="align11"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >导航
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align11"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >分组
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示图标：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="align22"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >图标居上
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align22"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >图标居左
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align22"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >不显示图标
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">图标大小：</label>
																<div class="col-md-4">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>像素
															</div>
															<div class="form-group" style="padding-left:20px;">
																<div class="col-md-4">
																	<button type="button" class="btn btn-primary" onclick="">添加图标<i class="icon-checkmark3 position-right"></i></button>
																</div>
															</div> 
															<div class="form-group" style="padding:0px;margin: 0px;padding-left:12px;padding-right:12px;">
																<div class="col-md-12 alert-danger">
																	<table  class="col-md-12">
																		<tr>
																			<td rowspan="2">
																				<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																				<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																			</td>
																			<td>
																				<div class="form-group" style="padding-top:10px;margin-bottom:10px;">
																					<label class="control-label col-md-3 text-right">图片标题：</label>
																					<div class="col-md-9">
																						<label class="radio-inline" style="padding:0px;margin:0px;">
																							<input type="text" style="width:150px;"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																						</label>
																						<label class="radio-inline" style="padding:0px;margin:0px;">
																							<input type="text" name="card_bg_color33" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																						</label>
																					</div>
																				</div>
																				<div class="form-group" style="margin-bottom:10px;">
																					<label class="control-label col-md-3 text-right">图片链接：</label>
																					<div class="col-md-7">
																						<select class="select" data-width="100%" name="state" id="state">
																							<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--请选择--</option>
																							<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>微页面</option>
																							<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>商品分组页</option>
																							<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>商品页</option>
																							<option value="3" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>直接购买</option>
																							<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>店铺主页</option>
																							<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>个人中心</option>
																							<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>列表页</option>
																						</select>
																					</div>
																				</div>
																				<div class="form-group" style="padding-bottom: 15px;">
																					<label class="control-label col-md-3 text-right">背景颜色：</label>
																					<div class="col-md-6 "> 
																						<input type="text" name="card_bg_color22" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																					</div>
																				</div>
																			</td>
																			<td rowspan="2">删除</td>
																		</tr>
																	</table>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv4" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>搜索设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">选择风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="align44"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >普通搜索
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="align44"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >顶部搜索
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">卡片封面:</label>
																<div class="col-md-6 "> 
																	外底色<input type="text" name="card_bg_colorss" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">卡片封面:</label>
																<div class="col-md-6 "> 
																	内底色<input type="text" name="card_bg_colorss11" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->		
														
											<!-- 表单验证开始 -->
											<div id="custonDiv5" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>商品设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">添加方式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shptjfs"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >自动获取
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:30px;">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">显示个数：</label>
																	<div class="col-md-2">
																		<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																	</div>最多显示10个
																</div>
															 	<div class="form-group">
																	<label class="control-label col-md-2 text-right"> </label>
																	<div class="col-md-8">
																		<input type="checkbox" name="shptckqb"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		显示查看全部按钮  
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">排序规则：</label>
																	<div class="col-md-6">
																		<label class="radio-inline">
																			<input type="radio" name="shptpxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >销量(最高销量最高的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="shptpxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最热(浏览次数最多的排在前面)
																		</label>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">添加方式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shptjfs"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >手动获取
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:30px;">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">选择商品：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >大图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >小图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >列表
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示设置：</label>
																<div class="col-md-6">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >标题
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >购买按钮
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >价格
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >销量
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">按钮样式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >样式1
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >样式2
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >样式3
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >样式4
																	</label>
																</div>
															</div>
															
															<div class="form-group">
																<label class="control-label col-md-2 text-right">图标大小：</label>
																<div class="col-md-4">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>像素
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->		
											
											<!-- 表单验证开始 -->
											<div id="custonDiv6" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>商品分组</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">分组模版：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="fzmb"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >左侧菜单
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzmb"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >顶部菜单
																	</label>
																</div>
															</div>
															<div class="form-group" >
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">选择分组：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示数量：</label>
																<div class="col-md-3">
																	<select class="select" data-width="100%" name="state" id="state">
																		<option value="5" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>5</option>
																		<option value="10" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>10</option>
																		<option value="15" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>15</option>
																		<option value="20" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>20</option>
																		<option value="30" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>30</option>
																		<option value="50" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>50</option>
																		<option value="100" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>100</option>
																	</select>
																</div>
															</div> 
															<div class="form-group">
																<label class="control-label col-md-2 text-right">排序：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="fzpx"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >按销量
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzpx"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >按新增
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="fzxsfg"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >大图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >小图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >列表
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示设置：</label>
																<div class="col-md-6">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="fzxssz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >标题
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="fzxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >购买按钮
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="fzxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >价格
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="fzxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >销量
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">按钮样式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="fzanys"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >样式1
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >样式2
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >样式3
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >样式4
																	</label>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->	
											
											<!-- 表单验证开始 -->
											<div id="custonDiv7" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>文本导航</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">导航名称：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">右侧文字：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">选择链接：</label>
																<div class="col-md-3">
																	<select class="select" data-width="100%" name="state" id="state">
																		<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--请选择--</option>
																		<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>微页面</option>
																		<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>商品分组页</option>
																		<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>商品页</option>
																		<option value="3" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>直接购买</option>
																		<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>店铺主页</option>
																		<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>个人中心</option>
																		<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>列表页</option>
																	</select>
																</div>
															</div> 
															<div class="form-group" >
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">左侧图标：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv8" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>标题设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">标题名：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">日期：</label>
																<div class="col-md-5">
																	<input type="text" class="form-control pickadate-translated" name="startTime" id="startTime" value="">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">作者：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">链接标题：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">链接地址：</label>
																<div class="col-md-3">
																	<select class="select" data-width="100%" name="state" id="state">
																		<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--请选择--</option>
																		<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>微页面</option>
																		<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>商品分组页</option>
																		<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>商品页</option>
																		<option value="3" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>直接购买</option>
																		<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>店铺主页</option>
																		<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>个人中心</option>
																		<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>列表页</option>
																	</select>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv9" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>富文本内容</h4></legend>
															<div class="form-group" style="padding-left:5px;padding-right:5px;"> 
																<div class="col-md-12">
																	<script id="editor"  type="text/plain" style="width:100%;height:300px;"></script>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv10" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>语音设置</h4></legend>
															<div class="form-group">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">选择音频：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">选择风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="ypfg"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >模仿微信对话样式
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="ypfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >简易音乐播放器
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">标题：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">循环：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="ypxh"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >开启循环播放
																	</label>
																</div>
															</div>
															<div class="form-group">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">头像：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">气泡：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="ypqp"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >居左
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="ypqp"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >居右
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">播放：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="yybf"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >暂停后再恢复播放时，从头开始
																	</label><br/>
																	<label class="radio-inline" style="margin-left:0px;">
																		<input type="radio" name="yybf"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >暂停后再恢复播放时，从暂停位置开始
																	</label>
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv11" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>视频设置</h4></legend>
															<div class="form-group" style="padding-left:20px;">
																<label class="control-label col-md-10">
																填写视频网站获取的通用代码
																 </label> 
															</div>
															<div class="form-group">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">视频地址：</label>
																	<div class="col-md-8 text-left">
																		<textarea rows="4" cols="" name="aaaaadddf" class="form-control"><iframe frameborder="0" width="100%" height="200" src="https://v.qq.com/iframe/player.html?vid=n0341nmmg98&tiny=0&auto=0" style="z-index: 1; "></iframe>
																		</textarea>
																	</div>
																</div>
															</div>
															<div class="form-group" style="padding-left:20px;">
																<label class="control-label col-md-10 text-danger">
																温馨提示：手机中不支持flash，请不要填写.swf结尾的代码<br/><br/>
																特别注意：请务必填写以 "https://" 开头的视频地址,否则视频不显示!
																 </label> 
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->	
											
											<!-- 表单验证开始 -->
											<div id="custonDiv12" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>公告设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">公告内容：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">公告链接：</label>
																<div class="col-md-3">
																	<select class="select" data-width="100%" name="state" id="state">
																		<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--请选择--</option>
																		<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>微页面</option>
																		<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>商品分组页</option>
																		<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>商品页</option>
																		<option value="3" <c:if test="${queryParam.state=='3' }">selected="selected"</c:if>>直接购买</option>
																		<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>店铺主页</option>
																		<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>个人中心</option>
																		<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>列表页</option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">背景色:</label>
																<div class="col-md-6 "> 
																	<input type="text" name="card_bg_colorss11" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->	
											
											<!-- 表单验证开始 -->
											<div id="custonDiv13" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>客服电话</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">文本：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">电话：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv14" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>空白高度设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">空白高度：</label>
																<div class="col-md-5">
																	<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																</div>像素
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv15" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>辅助线设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">样式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="fzxys"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >实线
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzxys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >虚线
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="fzxys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >点线
																	</label>
																</div>      
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">颜色:</label>
																<div class="col-md-6 "> 
																	<input type="text" name="card_bg_colorss11" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.card_bg_color22)?'#f75d1c':''}">
																</div>
															</div>
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv16" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>秒杀商品设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">添加方式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="mstjfs"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >自动获取
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:30px;">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">显示个数：</label>
																	<div class="col-md-2">
																		<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																	</div>最多显示30个
																</div>
															 	<div class="form-group">
																	<label class="control-label col-md-2 text-right"> </label>
																	<div class="col-md-8">
																		<input type="checkbox" name="shptckqb"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		显示查看全部按钮  
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">排序规则：</label>
																	<div class="col-md-6">
																		<label class="radio-inline">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >销量(最高销量最高的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最热(浏览次数最多的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最新(最新开始的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最快结束(离活动结束时间最近的排在前面)
																		</label>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">添加方式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shptjfs"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >手动获取
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:30px;">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">选择活动：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >大图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >小图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >列表
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示设置：</label>
																<div class="col-md-6">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >标题
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >购买按钮
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >价格
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >销量
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">按钮样式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >样式1
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >样式2
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >样式3
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >样式4
																	</label>
																</div>
															</div>
															
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->		
											
											<!-- 表单验证开始 -->
											<div id="custonDiv17" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>优惠券设置</h4></legend>
															<div class="form-group">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">优惠券：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
																<div class="form-group" style="padding-left:20px;">
																	<div class="col-md-4">
																		<button type="button" class="btn btn-primary" onclick="">添加优惠券<i class="icon-checkmark3 position-right"></i></button>
																	</div>
																</div> 
															</div> 
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->
											
											<!-- 表单验证开始 -->
											<div id="custonDiv18" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
												<div class="panel-body"  style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>拼团设置</h4></legend>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">添加方式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="mstjfs"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >自动获取
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:30px;">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">显示个数：</label>
																	<div class="col-md-2">
																		<input type="text"  name="name" id="name" class="form-control" required="required" value="${infoMap.name}">
																	</div>最多显示30个
																</div>
															 	<div class="form-group">
																	<label class="control-label col-md-2 text-right"> </label>
																	<div class="col-md-8">
																		<input type="checkbox" name="shptckqb"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >
																		显示查看全部按钮  
																	</div>
																</div>
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">排序规则：</label>
																	<div class="col-md-6">
																		<label class="radio-inline">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >销量(最高销量最高的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最热(浏览次数最多的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最新(最新开始的排在前面)
																		</label><br/>
																		<label class="radio-inline" style="margin-left:0px;">
																			<input type="radio" name="mspxgz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >最快结束(离活动结束时间最近的排在前面)
																		</label>
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">添加方式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shptjfs"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >手动获取
																	</label>
																</div>
															</div>
															<div class="form-group" style="padding-left:30px;">
																<div class="form-group">
																	<label class="control-label col-md-2 text-right">选择活动：</label>
																	<div class="col-md-6 text-left">
																		<input type="file" name="file1"  class="bootstrap-uploader" id="file1" src="${imageDomain }/${infoMap.login_img}">
																		<input type="hidden" name="login_img" id="login_img" value="${infoMap.login_img}">
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示风格：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >大图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >小图
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopxsfg"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >列表
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">显示设置：</label>
																<div class="col-md-9">
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >标题
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >购买按钮
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >价格
																	</label>
																	<label class="checkbox-inline">
																		<input type="checkbox" name="shopxssz"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >成团人数
																	</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-md-2 text-right">按钮样式：</label>
																<div class="col-md-6">
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(empty infoMap.align or infoMap.align eq 0)?"checked":""} class="styled" value="0" >样式1
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="1" >样式2
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="2" >样式3
																	</label>
																	<label class="radio-inline">
																		<input type="radio" name="shopanys"  ${(infoMap.align eq 1)?"checked":""} class="styled" value="3" >样式4
																	</label>
																</div>
															</div>
															
														</fieldset>
												</div>
											</div>
											<!-- /form validation -->	
											
											
										</div>
									 </div>

			                    </div>
			               </div>
			               
			          </div>
			     </div><!-- Panel Content -->
					<div class="form-group " style="width:100%; margin:0 auto; overflow:hidden; position: fixed; bottom:0;">
						<ul class="nav nav-pills col-sm-12  alert-danger" style="margin:0px;padding:0px;">
							<li class="col-sm-12" style="padding-top:10px;padding-bottom:10px;margin-left:30%">
								<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">保存<i class="icon-checkmark3 position-right"></i></button>
								<button type="button" class="btn btn-default" onclick="document.location.reload()">重置 <i class="icon-reload-alt position-right"></i></button>				
							</li>
						</ul>
					</div> 	 
				</div>
				<!-- /content area -->
				
				</form>
			
				
			</div>
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script>
			$(".colorpicker-show-input").spectrum({
		    	showInput: true,
		    	cancelText: "取消",
		        chooseText: "确定",
		        change: function(c) { 
		        }
		    });
			var ue = UE.getEditor('editor');
			$(document).ready(function() {
				ue.addListener("ready", function () {
					ue.setHeight(300);
			    	// editor准备好之后才可以使用
			    	ue.setContent('');
				});
				
			});
			
			var customNum=0;
			function customClick(num){
				$("div[id^='custonDiv']").removeClass("show");
				$("div[id='custonDiv"+num+"']").addClass("show");
			}
			
			function labelClick(num){
				customNum++;
				var labelH5="";
				if(num==1){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
            		 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/dianzhao.png" >'
 	                		+'</li>';
				}else if(num==2){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
    		 					+'<img src="${pageContext.request.contextPath}/resource/images/custom/banner.png" >'
             				+'</li>';
				}else if(num==3){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/tubiao.png" >'
			         		+'</li>';
				}else if(num==4){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/sousuo.png" >'
			         		+'</li>';
				}else if(num==5){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/shangpin.png" >'
			         		+'</li>';
				}else if(num==6){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/shangpinfenzu.png" >'
			         		+'</li>';
				}else if(num==7){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/biaotidaohang.png" >'
			         		+'</li>';
				}else if(num==8){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/biaoti.png" >'
			         		+'</li>';
				}else if(num==9){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/fuwenben.png" >'
			         		+'</li>';
				}else if(num==10){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/yuyin.png" >'
			         		+'</li>';
				}else if(num==11){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/shipin.png" >'
			         		+'</li>';
				}else if(num==12){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/gonggao.png" >'
			         		+'</li>';
				}else if(num==13){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/kefu.png" >'
			         		+'</li>';
				}else if(num==14){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/kongbai.png" >'
			         		+'</li>';
				}else if(num==15){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/fengexian.png" >'
			         		+'</li>';
				}else if(num==16){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/miaosha.png" >'
			         		+'</li>';
				}else if(num==17){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/youhuiquan.png" >'
			         		+'</li>';
				}else if(num==18){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					 			+'<img src="${pageContext.request.contextPath}/resource/images/custom/pingtuan.png" >'
			         		+'</li>';
				}
				$("#labelH5").append(labelH5);
				
				var divH5 = $('<div id="custonDiv'+num+"_"+customNum+'" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">');
					divH5.append($("#custonDiv"+num).html());
				$("#divH5").append(divH5);
				  
				$("div[id^='custonDiv']").removeClass("show");
				$("div[id='custonDiv"+num+"_"+customNum+"']").addClass("show");
			}
			
	 
			</script>
						
