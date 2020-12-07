<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="weiyun" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/header.jsp" %>

			<!-- Main content -->
			<div class="content-wrapper">
				
				<!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 系统管理 </span>
							</h4>
						</div>
					</div>

					<div class="breadcrumb-line">
						
						<ul class="breadcrumb">
							<li><a href="index.html"><i class="icon-home2 position-left"></i> 系统管理</a></li>
							<li><a href="角色管理.html">角色管理</a></li>
							<li class="active">角色列表</li>
						</ul>
						<ul class="breadcrumb-elements">
							<!-- <li><a href="#"><i class="icon-folder-upload3 position-left"></i> 文件上传</a></li>
							<li><a href="#"><i class="icon-folder4 position-left"></i> 新建文件夹</a></li>
							 -->
							
							
							<weiyun:hasPermission name="manager:showColumns">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<i class="icon-gear position-left"></i>
									显示字段
									<span class="caret"></span>
								</a>

								<ul class="dropdown-menu dropdown-menu-right">
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="role_column_role_id"> ID</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="role_column_role_name">角色名称</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="role_column_role_sign"> 角色类型</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="role_column_description"> 角色描述</label></li>
								</ul>
							</li>
							</weiyun:hasPermission>
							<weiyun:hasPermission name="role:insert">
							<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick='WIADD()' data-toggle='modal'  data-target='#edit_modal'><i class="icon-add position-left"></i>创建角色</button></li>
							</weiyun:hasPermission>
						</ul>
						
					</div>
				</div>
				
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
							<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/system/role/list" method="post">
								<div class="col-md-3">
										<div class="input-group">
												<span class="input-group-addon">角色名称</span>
												<input type="text" class="form-control" placeholder="" name="role_names" value="${queryParam.role_names }">
										</div>
								</div>
								
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							<br>
							<br>
							<div class="table-responsive">
								<table id="data-table" class="table table-bordered table-striped">
									<thead>
										<tr >
											<th>
											<input type="checkbox" name="allCheck" onclick="allCheckClick(this)" value="" />
											</th>
											<th class="role_column_role_id">ID</th>
											<th class="role_column_role_name">角色名称</th>
											<th class="role_column_role_sign">角色类型</th>
											<th class="role_column_description">角色描述</th>
											<th width="100">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${pageInfo.list}" var="role">
						                    <tr>
						                    
						                         <td>
						                         	<input type="checkbox" name="ids" value="${role.role_id }">
						                         </td>
						                        <td>${role.role_id}</td>
						                        <td>${role.role_name}</td>
						                        <td>${role.role_sign}</td>
						                        <td>${role.description}</td>
						                        <td>
													<ul class="icons-list">
														 <c:if test="${sessionScope.role_sign!=role.role_sign}">
														<weiyun:hasPermission name="role:edit">
														<li><a href="#" onclick="WIedit('${role.validate_id}','${role.validate_id_token }')" data-toggle="modal" data-target="#edit_modal"><i class="icon-pencil7"></i></a></li>
														</weiyun:hasPermission>
														<weiyun:hasPermission name="role:delete">
														<li><a href="#" onclick="WIremove('${role.validate_id}','${role.validate_id_token }')"data-toggle="modal" data-target="#remove_modal"><i class="icon-trash"></i></a></li>
														</weiyun:hasPermission>
														<weiyun:hasPermission name="role:authorize">
														<li><a href="javascript:;" onclick="WIauthorize('${role.validate_id}','${role.validate_id_token }')" title="分配权限"><i class="icon-user-lock"></i></a></li>
														</weiyun:hasPermission>
														</c:if>
													</ul>
												</td>
						                    </tr>
						                </c:forEach>
									</tbody>
								</table>
								
							</div>

							<div id="pager" class="panel-body">	
							</div>
							</form>
							</div>						
					</div>
					
					<!-- /bordered striped table -->
					
					<!-- Edit modal -->
					<div id="edit_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">编辑角色</h5>
								</div>
	
								<div class="modal-body">
									<form class="form-horizontal form-validate-jquery" action="${pageContext.request.contextPath}/center/system/role/save" method="post">
											<fieldset class="content-group">
												<div class="form-group">
													<label class="control-label col-md-2">角色名称 </label>
													<div class="col-md-9">
														<input type="text" class="form-control input-rounded" name="role_name" required="required" >
													</div>
												</div>
												<div class="form-group" style="display:none;">
													<label class="control-label col-md-2">角色类型</label>
													<div class="col-md-6">
														<select class="bootstrap-select" name="role_sign" id="role_sign" data-width="100%">
															<option value="SUPPER">超管</option>
															<option value="ADMIN">渠道商</option>
															<option value="USER" selected>商户</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">角色描述</label>
													<div class="col-md-9">
														<textarea rows="5" cols="5" name="description"  class="form-control" required="required" placeholder=""></textarea>
													</div>
												</div>
											</fieldset>
	
											<div class="text-right">
												<input type="hidden" name="validate_id" value=""/>
												<input type="hidden" name="validate_id_token" value=""/>
												<button type="reset" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>
												<button type="submit" class="btn btn-primary">提交 <i class="icon-arrow-right14 position-right"></i></button>
												
											</div>
										</form>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /edit modal -->
					
					

				</div>
				<!-- /content area -->

			</div>
			<!-- /main content -->
<%@include file="../common/footer.jsp" %>
<script>
$(document).ready(function() {
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});
function WIADD(){
	$("#edit_modal").find(".modal-title").html("新增角色");
	$("#edit_modal").find("#validate_id").attr("value","");
	$("#edit_modal").find("#validate_id_token").attr("value","");
}
function WIedit(validate_id,validate_id_token){
	$("#edit_modal").find(".modal-title").html("编辑角色");
	$.ajax({
	    url:'${pageContext.request.contextPath}/center/system/role/view?validate_id='+validate_id+"&validate_id_token="+validate_id_token,
	    type:'GET', 
	    data:null,
	    dataType:'json',
	    success:function(result){
	        var result=result.data;
	        $("input[name='validate_id']").attr("value",validate_id);
	        $("input[name='validate_id_token']").attr("value",validate_id_token);
	        $("input[name='role_name']").attr("value",result.role_name);
	        //$("input[name='description']").attr("value",result.description);
	        $("textarea[name='description']").text(result.description);
	    },
	    error:function(xhr,textStatus){
	        console.log('错误');
	    }
	});
}
function WIremove(validate_id,validate_id_token){
	var url="${pageContext.request.contextPath}/center/system/role/remove?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
	Mremove("get",url);
}
function WIauthorize(validate_id,validate_id_token){
	window.location="${pageContext.request.contextPath}/center/system/role/authorize?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
}

</script>