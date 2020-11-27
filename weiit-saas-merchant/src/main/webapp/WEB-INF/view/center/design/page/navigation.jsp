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
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold">店铺导航</span>
							</h4>
						</div> 
					</div>  
				</div>
				<!-- /page header -->
			 
				<!-- Content area -->
				<div class="content" style="padding-top:0px;margin-top:0px;"> 
					<div class="panel-content">
			          <div class="main-content-area">
			               <div class="row">
			                    <div style="width:340px;float:left;">
			                         <div class="widget white" style="width:320px;background:#fafafa;padding-top:0px;margin-top:0px;">
			                        	  <div class="widget-titlebar">
			                         	 	<h5 class="text-white text-center" style="margin-top:7px;" id="nameH5" >方案列表</h5>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="">
			                                   		<ul class="sortable list" id="labelH5">
			                                   		</ul>
			                                   </div>
			                              </div>
			                              <div class="custom_content" > 
			                              	<button type="button" data-toggle="modal" data-target="#addnav_modal" class="btn btn-primary" >
			                              			添加导航<i class="icon-checkmark3 position-right"></i></button>
			                              </div>
			                         </div>
			                    </div>
			                    <div style="margin-left:350px;">
			                         <div class="row">
										<div class="col-md-12" data-role="listview" id="divH5">
											 

<!-- 表单验证开始 -->
<div id="custonDiv1" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<form class="form-horizontal form-validate-jquery" method="POST"  name="infoForm" id="infoForm"
		action="${pageContext.request.contextPath}/center/design/page/navigationSave" enctype="multipart/form-data" >												
		<input type="hidden" name="validate_id" id="validate_id" value=""/>
		<input type="hidden" name="validate_id_token" id="validate_id_token" value=""/>
		<input type="hidden"  name="nav_type" id="nav_type" class="form-control" value="1">
		<div class="panel-body" style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>页面基础设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">方案名称：</label>
					<div class="col-md-6">
						<input type="text"  name="nav_name" id="nav_name" class="form-control" required="required" value="新加方案">
					</div>
				</div>
				<div class="form-group"> 
					<div class="col-md-12" style="padding-left:40px;">
						<input type="hidden"  name="nav_page" id="nav_page" value="" >
						将导航应用在以下页面：<br/>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="1" >店铺主页
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="2" >用户中心
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="3" >商品分组
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="4" >微页面
						</label><br/>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="5" >推客中心
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="6" >列表页&nbsp;&nbsp;&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(1)" class="styled" value="7" >合伙人
						</label>
					</div>
				</div>
			</fieldset>
		</div>
	
		<div class="panel-body"  style="padding:0px;margin: 0px;">
			<input type="hidden"  name="time_one_count" id="time_one_count" value="3">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>菜单管理</h4></legend>
				<div class="row">
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:30px;">
							<input type="hidden"  name="time_one_count1" id="time_one_count1" value="3">
							<input type="text"  name="time_one_name1" id="time_one_name1" style="width:150px;" class="form-control" required="required" value="">
						</div>
						<div class="col-md-4">
							<select class="bootstrap-select" onchange="changeType(this.value,1)" data-width="100%" style="width:150px;" name="time_one_target1" id="time_one_target1">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
							<input type="hidden" class="form-control" name="time_one_targetId1" id="time_one_targetId1" value="0">
							<input type="text" class="form-control" title="双击修改" style="display:none" ondblclick="changeType(0,1)"  name="time_one_targetUrl1" id="time_one_targetUrl1" value="">
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
							<a href="javascript:;" title="新增二级菜单"  class="m-r-5" onclick="toEdit(${third.cate_id},'${third.validate_id_token }')">
	           	 				<i class="icon-add"></i></a>&nbsp;
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="onclickDelete(this);">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:70px;">
							<input type="text"  name="time_one_name1_1" id="time_one_name1_1" style="width:150px;" class="form-control"  value="">
						</div>
						<div class="col-md-4">
							<select class="bootstrap-select" onchange="changeType(this.value,'1_1')" data-width="100%" style="width:150px;" name="time_one_target1_1" id="time_one_target1_1">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
							<input type="hidden" class="form-control" name="time_one_targetId1_1" id="time_one_targetId1_1" value="0">
							<input type="text" class="form-control" title="双击修改" style="display:none" ondblclick="changeType(0,'1_1')"  name="time_one_targetUrl1_1" id="time_one_targetUrl1_1" value="">
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="onclickDelete(this);">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:70px;">
							<input type="text"  name="time_one_name1_2" id="time_one_name1_2" style="width:150px;" class="form-control" value="">
						</div>
						<div class="col-md-4">
							<select class="bootstrap-select" onchange="changeType(this.value,'1_2')" data-width="100%" style="width:150px;" name="time_one_target1_2" id="time_one_target1_2">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
							<input type="hidden" class="form-control" name="time_one_targetId1_2" id="time_one_targetId1_2" value="0">
							<input type="text" class="form-control" title="双击修改" style="display:none" ondblclick="changeType(0,'1_2')"  name="time_one_targetUrl1_2" id="time_one_targetUrl1_2" value="">
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="onclickDelete(this);">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:30px;">
							<input type="hidden"  name="time_one_count2" id="time_one_count2" value="1">
							<input type="text"  name="time_one_name2" id="time_one_name2" style="width:150px;" class="form-control" required="required" value="">
						</div>
						<div class="col-md-4">
							<input type="hidden"  name="time_one_targetId2" id="time_one_targetId2" value="0">
							<input type="hidden"  name="time_one_targetUrl2" id="time_one_targetUrl2" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target2" id="time_one_target2">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
							<a href="javascript:;" title="新增二级菜单"  class="m-r-5" onclick="toEdit(${third.cate_id},'${third.validate_id_token }')">
	           	 				<i class="icon-add"></i></a>&nbsp;
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:70px;">
							<input type="text"  name="time_one_name2_1" id="time_one_name2_1" style="width:150px;" class="form-control" required="required" value="">
						</div>
						<div class="col-md-4">
							<input type="hidden"  name="time_one_targetId2_1" id="time_one_targetId2_1" value="0">
							<input type="hidden"  name="time_one_targetUrl2_1" id="time_one_targetUrl2_1" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target2_1" id="time_one_target2_1">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:30px;">
							<input type="hidden"  name="time_one_count3" id="time_one_count3" value="1">
							<input type="text"  name="time_one_name3" id="time_one_name3" style="width:150px;" class="form-control" required="required" value="">
						</div>
						<div class="col-md-4">
							<input type="hidden"  name="time_one_targetId3" id="time_one_targetId3" value="0">
							<input type="hidden"  name="time_one_targetUrl3" id="time_one_targetUrl3" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target3" id="time_one_target3">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
							<a href="javascript:;" title="新增二级菜单"  class="m-r-5" onclick="toEdit(${third.cate_id},'${third.validate_id_token }')">
	           	 				<i class="icon-add"></i></a>&nbsp;
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
					<div class="form-group ">
						<div class="col-md-5" style="padding-left:70px;">
							<input type="text"  name="time_one_name3_1" id="time_one_name3_1" style="width:150px;" class="form-control" required="required" value="">
						</div>
						<div class="col-md-4">
							<input type="hidden"  name="time_one_targetId3_1" id="time_one_targetId3_1" value="0">
							<input type="hidden"  name="time_one_targetUrl3_1" id="time_one_targetUrl3_1" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target3_1" id="time_one_target3_1">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-3 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div>
				</div>
				<hr/>
				<div class="form-group text-center">
					<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">提交修改<i class="icon-checkmark3 position-right"></i></button>
				</div> 	 
			</fieldset>
		</div>
	</form>
</div>
<!-- /form validation --> 

<!-- 表单验证开始 -->
<div id="custonDiv2" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<form class="form-horizontal form-validate-jquery" method="POST"  name="infoForm" id="infoForm"
		action="${pageContext.request.contextPath}/center/design/page/navigationSave" enctype="multipart/form-data" >												
		<input type="hidden" name="validate_id" id="validate_id" value=""/>
		<input type="hidden" name="validate_id_token" id="validate_id_token" value=""/>
		<input type="hidden"  name="nav_type" id="nav_type" class="form-control" value="2">
		<div class="panel-body" style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>页面基础设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">方案名称：</label>
					<div class="col-md-6">
						<input type="text"  name="nav_name" id="nav_name" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group"> 
					<div class="col-md-12" style="padding-left:40px;">
						<input type="hidden"  name="nav_page" id="nav_page" value="" >
						将导航应用在以下页面：<br/>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="1" >店铺主页
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="2" >用户中心
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="3" >商品分组
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="4" >微页面
						</label><br/>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="5" >推客中心
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="6" >列表页&nbsp;&nbsp;&nbsp;
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pagecheckbox" onchange="pageChange(2)" class="styled" value="7" >合伙人
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">底色：</label>
					<div class="col-md-6 "> 
						<input type="text" name="nav_bgcolor" id="nav_bgcolor" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
					</div>
				</div>	
			</fieldset>
		</div>
	
		<div class="panel-body"  style="padding:0px;margin: 0px;">
			<input type="hidden"  name="time_two_count" id="time_two_count" value="3">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>菜单管理</h4></legend>
				<div class="row">
					<div class="form-group ">
						<div class="col-md-4" style="padding-left:30px;"> 
							<input type="file" name="fileitem1"  class="bootstrap-uploader" id="fileitem1" src="">
							<input type="hidden" name="imgfileitem1" id="imgfileitem1" value="">
						</div>	
						<div class="col-md-4" style="padding-left:30px;"> 
							<input type="file" name="fileitem1_1"  class="bootstrap-uploader" id="fileitem1_1" src="">
							<input type="hidden" name="imgfileitem1_1" id="imgfileitem1_1" value="">
						</div>
						<div class="col-md-3" style="padding-left:30px;">
							<input type="hidden"  name="time_one_targetId1" id="time_one_targetId1" value="0">
							<input type="hidden"  name="time_one_targetUrl1" id="time_one_targetUrl1" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target1" id="time_one_target1">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-1 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div> 
				</div>
				<hr>
				<div class="row">
					<div class="form-group ">
						<div class="col-md-4" style="padding-left:30px;"> 
							<input type="file" name="fileitem2"  class="bootstrap-uploader" id="fileitem2" src="">
							<input type="hidden" name="imgfileitem2" id="imgfileitem2" value="">
						</div>	
						<div class="col-md-4" style="padding-left:30px;"> 
							<input type="file" name="fileitem2_1"  class="bootstrap-uploader" id="fileitem2_1" src="">
							<input type="hidden" name="imgfileitem2_1" id="imgfileitem2_1" value="">
						</div>
						<div class="col-md-3" style="padding-left:30px;">
							<input type="hidden"  name="time_one_targetId2" id="time_one_targetId2" value="0">
							<input type="hidden"  name="time_one_targetUrl2" id="time_one_targetUrl2" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target2" id="time_one_target2">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-1 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div> 
				</div>
				<hr>
				<div class="row">
					<div class="form-group ">
						<div class="col-md-4" style="padding-left:30px;"> 
							<input type="file" name="fileitem3"  class="bootstrap-uploader" id="fileitem3" src="">
							<input type="hidden" name="imgfileitem3" id="imgfileitem3" value="">
						</div>	
						<div class="col-md-4" style="padding-left:30px;"> 
							<input type="file" name="fileitem3_1"  class="bootstrap-uploader" id="fileitem3_1" src="">
							<input type="hidden" name="imgfileitem3_1" id="imgfileitem3_1" value="">
						</div>
						<div class="col-md-3" style="padding-left:30px;">
							<input type="hidden"  name="time_one_targetId3" id="time_one_targetId3" value="0">
							<input type="hidden"  name="time_one_targetUrl3" id="time_one_targetUrl3" value="">
							<select class="bootstrap-select" data-width="100%" style="width:150px;" name="time_one_target3" id="time_one_target3">
								<option value="0">--请选择链接--</option>
								<c:forEach items="${linkList}" var="info"> 
									<option value="${info.url_type}" >${info.url_content}</option>
					    		</c:forEach> 
							</select>
						</div>
						<div class="col-md-1 text-right" style="padding-right:30px;">
	           	 			<a href="javascript:;" title="删除菜单" class="m-r-5" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');">
	           	 				<i class="icon-trash"></i></a>
						</div>
					</div> 
				</div>
				<hr/>
				<div class="form-group text-center">
					<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">提交修改<i class="icon-checkmark3 position-right"></i></button>
				</div> 	 
			</fieldset>
		</div>
	</form>
</div>
<!-- /form validation --> 

											
										</div>
									 </div>

			                    	</div>
			               		</div>
			               </div>
			               
			          </div>
			     	</div><!-- Panel Content -->
					 
			</div>
			<!-- /main content -->
			
<!-- Edit modal -->
<div id="addnav_modal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="text-align:left;width:800px;"> 
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">选择导航模板</h2>
			</div>
			<div class="modal-body" style="padding-top:0px;margin-top:0px;">
				<form class="form-horizontal " name="okForm" id="okForm" action="" method="post" >
					<fieldset class="content-group"> 
						<div class="form-group">
							<div class="col-md-6">
								<label class="radio-inline" style="margin-left:5px;">
									<input type="radio" name="navType" checked class="styled" value="1" >微信公众号自定义菜单样式<br/>
									<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb1.png">	
								</label><br/><br/>
								<label class="radio-inline" style="margin-left:5px;">
									<input type="radio" name="navType"  class="styled" value="2" >APP导航模版（图标及底色都可配置）<br/>
									<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb2.png" >	
								</label><br/><br/>
								<label class="radio-inline" style="margin-left:5px;">
									<input type="radio" name="navType" class="styled" value="3" >带购物车导航模版<br/>
									<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb3.png">	
								</label>
							</div>
						<%--	<div class="col-md-6">
								<label class="radio-inline" style="margin-left:5px;">
									<input type="radio" name="navType" class="styled" value="4" >Path展开形式导航<br/>
									<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb4.png">	
								</label>
								<label class="radio-inline" style="margin-left:5px;">
									<input type="radio" name="navType"  class="styled" value="5" >两侧展开形式导航<br/>
									<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb5.png" >	
								</label>
							</div>--%>
						</div> 
						 
					</fieldset>
					<div class="text-right">
						<button type="button" class="btn btn-primary" onclick="onNavOk()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>
<!-- /edit modal -->


					<!-- select product modal -->
					<div id="select_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择商品</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">商品标题</span>
												<input type="text" class="form-control"  name="product_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="product_search">搜索</button>
										<table id="data-table" class="table product_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">商品</th>
													<th class="col-lg-2">价格</th>
													<th class="col-lg-2">库存</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					<!-- select product modal -->
					<div id="custom_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择微页面</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">页面名称</span>
												<input type="text" class="form-control"  name="page_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="page_search">搜索</button>
										<table id="data-table2" class="table custom_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">标题</th>
													<th class="col-lg-4">创建时间</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					<!-- select product modal -->
					<div id="tag_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择商品分组</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">分组名称</span>
												<input type="text" class="form-control"  name="tag_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="tag_search">搜索</button>
										<table id="data-table3" class="table tag_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">分组名称</th>
													<th class="col-lg-4">创建时间</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			
			<script>
			var index=1;
			$(document).ready(function() {
				$("#product_search").click(function(){
					var product_name=$("input[name='product_name']").val();
					showTable(product_name,index);
				});
				$("#page_search").click(function(){
					var page_name=$("input[name='page_name']").val();
					showTableCustom(page_name,index);
				});
				$("#tag_search").click(function(){
					var tag_name=$("input[name='tag_name']").val();
					showTableTag(tag_name,index);
				});
				
				$(".colorpicker-show-input").spectrum({
			    	showInput: true,
			    	cancelText: "取消",
			        chooseText: "确定",
			        change: function(c) { 
			        }
			    });
				 
				
				<c:forEach items="${navlist}" var="info" varStatus="ind" >
					var param= new Array();
						param[0]='${info.validate_id}';
						param[1]='${info.validate_id_token}';
						param[2]='${info.nav_name}';
						param[3]='${info.nav_page}';
						param[4]='${info.nav_type}';
						param[5]='${info.nav_bgcolor}'; 
						param[6]='${info.state}'; 
					labelClick('${info.nav_type}',param);  
					<c:forEach items="${info.itemList}" var="item" varStatus="itind" >
						paramSet('${info.nav_type}','${item.rowCount}','${item.sort_num}','${item.resNum}','${item.parent_id}','${item.item_name}','${item.item_target_type}','${item.item_target_id}','${item.item_target_url}','${item.item_img1}','${item.item_img2}'); 
					</c:forEach>
				</c:forEach>
				
				$('#select_modal').on('hide.bs.modal', 
					function () {
						if(mflag==0){
							$("#custonDiv1_2 #time_one_target"+index).val(typenum[index]);
							$("#custonDiv1_2 #time_one_target"+index).selectpicker('render');
							$("#custonDiv1_2 #time_one_target"+index).selectpicker('refresh');
						}else{
							typenum[index]=$("#custonDiv1_2 #time_one_target"+index).val();
						}
						mflag=0;
					}
				);
				$('#custom_modal').on('hide.bs.modal', 
					function () {
						if(mflag==0){
							$("#custonDiv1_2 #time_one_target"+index).val(typenum[index]);
							$("#custonDiv1_2 #time_one_target"+index).selectpicker('render');
							$("#custonDiv1_2 #time_one_target"+index).selectpicker('refresh');
						}else{
							typenum[index]=$("#custonDiv1_2 #time_one_target"+index).val();
						}
						mflag=0;
					}
				);
				
			});
			 
			function onNavOk(){
				var type=$("input[name=navType]:checked").val();

				console.log('type为'+type);

				labelClick(type);
				$("#addnav_modal").modal("hide");
			}
			
			function pageChange(checkNum){
				var pageStr="";
				$("div[id^='custonDiv"+checkNum+"'] input[name='pagecheckbox']").each(function(){
					if($(this).prop("checked")){
						if(pageStr==""){
							pageStr=$(this).val();
						}else{
							pageStr=pageStr+","+$(this).val();
						}
					}
				});
				$("div[id^='custonDiv"+checkNum+"'] #nav_page").val(pageStr);
			}
			
			var customNum=0;
			function customClick(num){
				$("div[id^='custonDiv']").removeClass("show");
				$("div[id='custonDiv"+num+"']").addClass("show");
			}
			
			function labelClick(num,obj){
				customNum++;
				var labelH5="";
				var randomNum = (new Date()).valueOf();
				if(num==1){
					labelH5='<li style="background:white;padding:0px;margin:0px;"  onclick="customClick(\'1_'+customNum+'\')">'
			    		 		+'<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb1.png" >'
			    		 		+'<div class="col-md-6 text-left" style="height:40px;padding-top:10px;" >'+(obj ==undefined?"新加方案":obj[2])+'</div>'
			    		 		+'<div class="col-md-6 text-right" style="height:40px;padding-top:10px;">';
						if(obj!=undefined && obj[6]==0){
							labelH5=labelH5	+'<a href="javascript:;" title="启用" onclick="onclickState(1,\''+obj[0]+"','"+obj[1]+'\')" >启用</a>&nbsp;-';
						}else{
							labelH5=labelH5	+'<a href="javascript:;" title="不启用" onclick="onclickState(0,\''+obj[0]+"','"+obj[1]+'\')" >不启用</a>&nbsp;-';
						}	
							labelH5=labelH5	+ '<a href="javascript:;" title="编辑" onclick="customClick(\'1_'+customNum+'\')" >编辑</a>&nbsp;-'
								+'<a href="javascript:;" title="删除" onclick="onclickRemove(\''+(obj ==undefined?"":obj[0])+"','"+(obj ==undefined?"":obj[1])+'\')" >删除</a>&nbsp;-'
			    		 		+'</div><input type="hidden"  name="targetType1" id="targetType1" class="form-control" value="1">'
                		 		+'</li>';
				}else if(num==2){
					labelH5='<li style="background:white;padding:0px;margin:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb2.png" >'
								+'<div class="col-md-6 text-left" style="height:40px;padding-top:10px;" >'+(obj ==undefined?"新加方案":obj[2])+'</div>'
								+'<div class="col-md-6 text-right" style="height:40px;padding-top:10px;">';
						if(obj!=undefined && obj[6]==0){
							labelH5=labelH5	+'<a href="javascript:;" title="启用" onclick="onclickState(1,\''+obj[0]+"','"+obj[1]+'\')" >启用</a>&nbsp;-';
						}else{
							labelH5=labelH5	+'<a href="javascript:;" title="不启用" onclick="onclickState(0,\''+obj[0]+"','"+obj[1]+'\')" >不启用</a>&nbsp;-';
						}	
							labelH5=labelH5	+ '<a href="javascript:;" title="编辑" onclick="customClick(\'1_'+customNum+'\')" >编辑</a>&nbsp;-'
								+'<a href="javascript:;" title="删除" onclick="onclickRemove(\''+(obj ==undefined?"":obj[0])+"','"+(obj ==undefined?"":obj[1])+'\')" >删除</a>&nbsp;-'
			    		 		+'</div><input type="hidden"  name="targetType1" id="targetType1" class="form-control" value="1">'
	            		 		+'</li>';
				}else if(num==3){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb3.png" >'
								+'<div class="col-md-6 text-left" style="height:40px;padding-top:10px;" >'+(obj ==undefined?"新加方案":obj[2])+'</div>'
								+'<div class="col-md-6 text-right" style="height:40px;padding-top:10px;">';
						if(obj!=undefined && obj[6]==0){
							labelH5=labelH5	+'<a href="javascript:;" title="启用" onclick="onclickState(1,\''+obj[0]+"','"+obj[1]+'\')" >启用</a>&nbsp;-';
						}else{
							labelH5=labelH5	+'<a href="javascript:;" title="不启用" onclick="onclickState(0,\''+obj[0]+"','"+obj[1]+'\')" >不启用</a>&nbsp;-';
						}	
							labelH5=labelH5	+ '<a href="javascript:;" title="编辑" onclick="customClick(\'1_'+customNum+'\')" >编辑</a>&nbsp;-'
								+'<a href="javascript:;" title="删除" onclick="onclickRemove(\''+(obj ==undefined?"":obj[0])+"','"+(obj ==undefined?"":obj[1])+'\')" >删除</a>&nbsp;-'
			    		 		+'</div><input type="hidden"  name="targetType1" id="targetType1" class="form-control" value="1">'
	            		 		+'</li>';
				}else if(num==4){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb4.png" >'
								+'<div class="col-md-6 text-left" style="height:40px;padding-top:10px;" >'+(obj ==undefined?"新加方案":obj[2])+'</div>'
								+'<div class="col-md-6 text-right" style="height:40px;padding-top:10px;">';
						if(obj!=undefined && obj[6]==0){
							labelH5=labelH5	+'<a href="javascript:;" title="启用" onclick="onclickState(1,\''+obj[0]+"','"+obj[1]+'\')" >启用</a>&nbsp;-';
						}else{
							labelH5=labelH5	+'<a href="javascript:;" title="不启用" onclick="onclickState(0,\''+obj[0]+"','"+obj[1]+'\')" >不启用</a>&nbsp;-';
						}	
							labelH5=labelH5	+ '<a href="javascript:;" title="编辑" onclick="customClick(\'1_'+customNum+'\')" >编辑</a>&nbsp;-'
								+'<a href="javascript:;" title="删除" onclick="onclickRemove(\''+(obj ==undefined?"":obj[0])+"','"+(obj ==undefined?"":obj[1])+'\')" >删除</a>&nbsp;-'
			    		 		+'</div><input type="hidden"  name="targetType1" id="targetType1" class="form-control" value="1">'
	            		 		+'</li>';
				}else if(num==5){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/dhtb5.png" >'
								+'<div class="col-md-6 text-left" style="height:40px;padding-top:10px;" >'+(obj ==undefined?"新加方案":obj[2])+'</div>'
								+'<div class="col-md-6 text-right" style="height:40px;padding-top:10px;">';
						if(obj!=undefined && obj[6]==0){
							labelH5=labelH5	+'<a href="javascript:;" title="启用" onclick="onclickState(1,\''+obj[0]+"','"+obj[1]+'\')" >启用</a>&nbsp;-';
						}else{
							labelH5=labelH5	+'<a href="javascript:;" title="不启用" onclick="onclickState(0,\''+obj[0]+"','"+obj[1]+'\')" >不启用</a>&nbsp;-';
						}	
							labelH5=labelH5	+ '<a href="javascript:;" title="编辑" onclick="customClick(\'1_'+customNum+'\')" >编辑</a>&nbsp;-'
								+'<a href="javascript:;" title="删除" onclick="onclickRemove(\''+(obj ==undefined?"":obj[0])+"','"+(obj ==undefined?"":obj[1])+'\')" >删除</a>&nbsp;-'
			    		 		+'</div><input type="hidden"  name="targetType1" id="targetType1" class="form-control" value="1">'
	            		 		+'</li>';
				}
				$("#labelH5").append(labelH5);
 
				//复制 .clone(true)
				var divcust=$("#custonDiv"+num).attr('id','custonDiv'+num+"_"+customNum);
// 				var divH5 = $('<div id="custonDiv'+num+"_"+customNum+'" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;"></div>');
// 					divH5.append($(divcust));
				$("#divH5").append(divcust);
				  
				$("div[id^='custonDiv']").removeClass("show");
				$("div[id='custonDiv"+num+"_"+customNum+"']").addClass("show");
				
				if(obj !=undefined ){
					$("#custonDiv"+num+"_"+customNum+" #validate_id").val(obj[0]);
					$("#custonDiv"+num+"_"+customNum+" #validate_id_token").val(obj[1]);
					$("#custonDiv"+num+"_"+customNum+" #nav_name").val(obj[2]);
					$("#custonDiv"+num+"_"+customNum+" #nav_page").val(obj[3]);
					var pageStr=obj[3].split(",");
					for ( var i = 0; i < pageStr.length; i++) {
						$("#custonDiv"+num+"_"+customNum+" input[name=pagecheckbox][value="+pageStr[i]+"]").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pagecheckbox][value="+pageStr[i]+"]").trigger('click');
					}
					if(num!=1){
						$("#custonDiv"+num+"_"+customNum+" #nav_bgcolor").val(obj[5]);
						$(".colorpicker-show-input").spectrum({
					    	showInput: true,
					    	cancelText: "取消",
					        chooseText: "确定",
					        change: function(c) { 
					        }
					    });
					} 
					 
				}
			}
			
			function onclickDelete(obj){
				  $(obj).parent("div").parent("div").remove();
			 }
			
			function paramSet(num,count1,count2,resNum,parent_id,item_name,item_target_type,item_target_id,item_target_url,item_img1,item_img2){
				 if(num==1){
					 if(parent_id=="-1"){
						//$("#custonDiv"+num+"_"+customNum+" #time_one_count"+count1).val(resNum);
						$("#custonDiv"+num+"_"+customNum+" #time_one_name"+count1).val(item_name);
						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).val(item_target_type);
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetId"+count1).val(item_target_id); 
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).val(item_target_url); 
						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).selectpicker('render');
						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).selectpicker('refresh');
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).attr("readonly","readonly");
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).css("display","block"); 
						typenum[count1]=item_target_type;
						if(item_target_type==1 ){
						}else if(item_target_type==2){
						}else if(item_target_type==3){ 
						}else if(item_target_type==99){
							$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).removeAttr('readonly');
						}else{
							$("#custonDiv"+num+"_"+customNum+" #time_one_targetId"+count1).val("0");
							$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).val("");
							$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).css("display","none"); 
						}
// 						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).trigger('change');
					 }else{
						//$("#custonDiv"+num+"_"+customNum+" #time_one_count"+count1+"_"+count2).val(resNum);
						$("#custonDiv"+num+"_"+customNum+" #time_one_name"+count1+"_"+count2).val(item_name);
						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1+"_"+count2).val(item_target_type);
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetId"+count1+"_"+count2).val(item_target_id); 
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1+"_"+count2).val(item_target_url); 
						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1+"_"+count2).selectpicker('render');
						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1+"_"+count2).selectpicker('refresh');
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1+"_"+count2).attr("readonly","readonly");
						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1+"_"+count2).css("display","block"); 
// 						alert(count1+"_"+count2+"----"+item_target_type); 
// 						typenum[num]=item_target_type;
// 						if(item_target_type==1 ){
// 						}else if(item_target_type==2){
// 						}else if(item_target_type==3){ 
// 						}else if(item_target_type==99){
// 							$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1+"_"+count2).removeAttr('readonly');
// 						}else{
// 							$("#custonDiv"+num+"_"+customNum+" #time_one_targetId"+count1+"_"+count2).val("0");
// 							$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1+"_"+count2).val("");
// 							$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1+"_"+count2).css("display","none"); 
// 						}
// 						$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1+"_"+count2).trigger('change');
					} 
				 }else{
					//$("#custonDiv"+num+"_"+customNum+" #time_two_count"+count1).val(resNum); 
					$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).val(item_target_type);
					$("#custonDiv"+num+"_"+customNum+" #time_one_targetId"+count1).val(item_target_id); 
					$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).val(item_target_url); 
					$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).selectpicker('render');
					$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).selectpicker('refresh');
// 					$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).attr("readonly","readonly");
// 					$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).css("display","block"); 
// 					typenum[num]=item_target_type;
// 					if(item_target_type==1 ){
// 					}else if(item_target_type==2){
// 					}else if(item_target_type==3){ 
// 					}else if(item_target_type==99){
// 						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).removeAttr('readonly');
// 					}else{
// 						$("#custonDiv"+num+"_"+customNum+" #time_one_targetId"+count1).val("0");
// 						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).val("");
// 						$("#custonDiv"+num+"_"+customNum+" #time_one_targetUrl"+count1).css("display","none"); 
// 					}
					$("#custonDiv"+num+"_"+customNum+" #time_one_target"+count1).trigger('change');
					
					$("#custonDiv"+num+"_"+customNum+" #imgfileitem"+count1).val(item_img1);
					$("#custonDiv"+num+"_"+customNum+" #imgfileitem"+count1+"_1").val(item_img2);
					initPicture("${imageDomain }", item_img1 ,"#fileitem"+count1,50,50);
					initPicture("${imageDomain }", item_img2 ,"#fileitem"+count1+"_1",50,50);
				 }
			}
			function onclickState(state , validate_id , validate_id_token){
				var title='确定把该菜单方案设为启用吗？';
				if(state==0){
					title='确定把该菜单方案设为不启用吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/design/page/navigationState?mystate="+state+"&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
					}
				}); 
			}
			
			function onclickRemove(validate_id , validate_id_token){
				MConfirm('确定把该菜单方案删除吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/design/page/navigationRemove?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
					}
				}); 
			}
			
			var typenum=new Array();
			var mflag=0; 
			
			function changeType(type,mm){ 
				if(type==0){
					type=$("#custonDiv1_2 #time_one_target"+mm).val();
				}
				if(type==1){
					showTableCustom('',mm);
				}else if(type==2){
					showTableTag('',mm);
				}else if(type==3){
					showTable('',mm);
				}else if(type==99){
					typenum[mm]=type;
					$("#custonDiv1_2 #time_one_targetUrl"+mm).css("display","block"); 
					$('#custonDiv1_2 #time_one_targetUrl'+mm).removeAttr('readonly');
				}else{
					typenum[mm]=type;
					$("#custonDiv1_2 #time_one_targetId"+mm).val("0");
					$("#custonDiv1_2 #time_one_targetUrl"+mm).css("display","none"); 
				}
			} 

			function showTable(product_name,mm){
				index=mm;
				$("#select_modal").modal("show");
				$('.product_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/product/productList.json?product_name='+product_name,
			        columns: [
			             {data: "product_info"},
			             {data: "sale_price" },
			             {data: "stock"},
			             {data: "option"}
			         ],
			        bDestroy:!0,
			    	bLengthChange:!1,
			        bFilter:!1,
			        bAutoWidth:!1,
			        iDisplayLength:5,
			        oLanguage: {
		                oAria: {
		                    sSortAscending: ": 升序排序",
		                    sSortDescending: ": 降序排序"
		                },
		                oPaginate: {
		                    sFirst: "首页",
		                    sLast: "末页",
		                    sNext: "下一页",
		                    sPrevious: "上一页"
		                },
		                sEmptyTable: "没有商品数据",
		                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
		                sInfoEmpty: "当前 0 - 0 条  共  0 条",
		                sInfoFiltered: "(filtered from _MAX_ total entries)",
		                sInfoPostFix: "",
		                sDecimal: "",
		                sThousands: ",",
		                sLengthMenu: "显示 _MENU_ 条",
		                sLoadingRecords: "加载中...",
		                sProcessing: "进行中...",
		                sSearch: "Search:",
		                sSearchPlaceholder: "",
		                sUrl: "",
		                sZeroRecords: "没有商品数据"
		            }
			    });
			}
			 
			function selectProduct(id,name){
				mflag=1;
				$('#custonDiv1_2 #time_one_targetUrl'+index).attr("readonly","readonly");
				$("#custonDiv1_2 #time_one_targetUrl"+index).css("display","block"); 
				//拼接到控件中，方便表单提交时跟着提交
				$("#custonDiv1_2 #time_one_targetId"+index).val(id);
				$("#custonDiv1_2 #time_one_targetUrl"+index).val(name);
				//关闭弹出框
				$(".close").click(); 
			}
			
			
			function showTableCustom(name,mm){
				index=mm;
				$("#custom_modal").modal("show");
				$('.custom_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/design/page/pageList.json?page_name='+name,
			        columns: [
			             {data: "page_name"},
			             {data: "create_time" },
			             {data: "option"}
			         ],
			        bDestroy:!0,
			    	bLengthChange:!1,
			        bFilter:!1,
			        bAutoWidth:!1,
			        iDisplayLength:5,
			        oLanguage: {
		                oAria: {
		                    sSortAscending: ": 升序排序",
		                    sSortDescending: ": 降序排序"
		                },
		                oPaginate: {
		                    sFirst: "首页",
		                    sLast: "末页",
		                    sNext: "下一页",
		                    sPrevious: "上一页"
		                },
		                sEmptyTable: "没有商品数据",
		                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
		                sInfoEmpty: "当前 0 - 0 条  共  0 条",
		                sInfoFiltered: "(filtered from _MAX_ total entries)",
		                sInfoPostFix: "",
		                sDecimal: "",
		                sThousands: ",",
		                sLengthMenu: "显示 _MENU_ 条",
		                sLoadingRecords: "加载中...",
		                sProcessing: "进行中...",
		                sSearch: "Search:",
		                sSearchPlaceholder: "",
		                sUrl: "",
		                sZeroRecords: "没有微页面数据"
		            }
			    });
			}
			
			function showTableTag(name,mm){
				index=mm;
				$("#tag_modal").modal("show");
				$('.tag_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/productTag/tagList.json?tag_name='+name,
			        columns: [
			             {data: "tag_name"},
			             {data: "create_time" },
			             {data: "option"}
			         ],
			        bDestroy:!0,
			    	bLengthChange:!1,
			        bFilter:!1,
			        bAutoWidth:!1,
			        iDisplayLength:5,
			        oLanguage: {
		                oAria: {
		                    sSortAscending: ": 升序排序",
		                    sSortDescending: ": 降序排序"
		                },
		                oPaginate: {
		                    sFirst: "首页",
		                    sLast: "末页",
		                    sNext: "下一页",
		                    sPrevious: "上一页"
		                },
		                sEmptyTable: "没有商品数据",
		                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
		                sInfoEmpty: "当前 0 - 0 条  共  0 条",
		                sInfoFiltered: "(filtered from _MAX_ total entries)",
		                sInfoPostFix: "",
		                sDecimal: "",
		                sThousands: ",",
		                sLengthMenu: "显示 _MENU_ 条",
		                sLoadingRecords: "加载中...",
		                sProcessing: "进行中...",
		                sSearch: "Search:",
		                sSearchPlaceholder: "",
		                sUrl: "",
		                sZeroRecords: "没有商品分组数据"
		            }
			    });
			}
			</script>
						
