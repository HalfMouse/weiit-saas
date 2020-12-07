<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
							<li><a href="index.html"><i class="icon-home2 position-left"></i>系统管理</a></li>
							<li class="active">管理员列表</li>
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
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="manager_column_manager_id"> ID</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="manager_column_account_name">登录账户</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked"  value="manager_column_manager_name"> 管理员名称</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled"  value="manager_column_description"> 描述说明</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked"  value="manager_column_create_time"> 创建时间</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked"  value="manager_column_update_time"> 修改时间</label></li>
								</ul>
							</li>
							</weiyun:hasPermission>
							<weiyun:hasPermission name="manager:insert">
							<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick='WIADD()' data-toggle='modal'  data-target='#edit_modal'><i class="icon-add position-left"></i>创建管理员</button></li>
							</weiyun:hasPermission>
						</ul>
					</div>
					
				</div>
				<!-- /page header -->
				
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
							
							<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/system/manager/list" method="post">
								<div class="col-md-3">
										<div class="input-group">
												<span class="input-group-addon">管理员名称</span>
												<input type="text" class="form-control" placeholder="" name="manager_names" value="${queryParam.manager_names }">
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
											<th><input type="checkbox" name="allCheck" onclick="allCheckClick(this)" value="" /></th>
											<th class="manager_column_manager_id">ID</th>
											<th class="manager_column_account_name">登录账户</th>
											<th class="manager_column_manager_name">管理员名称</th>
											<th>账户余额</th>
											<th class="manager_column_description">描述说明</th>
											<th class="manager_column_create_time">创建时间</th>
											<th class="manager_column_update_time">修改时间</th>
											<th width="100">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${pageInfo.list}" var="manager">
						                    <tr>
						                         <td>
						                         <input type="checkbox" name="ids" value="${manager.manager_id }">
						                         </td>
						                          <!-- 
						                         <c:forEach items="${queryParam.tableColumns }" var="column">
						                         	<c:if test="${column.column_type=='datetime' }">
						                         	<td class="column_${column.column_name }"><fmt:formatDate value="${manager[column.column_name]}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						                         	</c:if>
						                         	<c:if test="${column.column_type!='datetime' }">
						                         	<td class="column_${column.column_name }">${manager[column.column_name]}</td>
						                         	</c:if>
						                         </c:forEach>
						                        -->
						                        <td >${manager.manager_id}</td>
						                         <td >${manager.account_name}</td>
						                        <td >${manager.manager_name}</td>
						                        <th>
						                        <c:if test="${manager.manager_id!=sessionScope[sessionUserKey].manager_id }">
						                        <span class="text-success" id="balance${manager.manager_id }"></span><br>
						                        <a  class="btn btn-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="queryBalance('${manager.validate_id}','${manager.validate_id_token }')">查询余额</a>
						                        <a  class="btn btn-warning m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="yucun('${manager.validate_id}','${manager.validate_id_token }')" data-toggle="modal" data-target="#banlance_dialog">预存余额</a>
						                        </c:if>
						                        </th>
						                        <td >${manager.description}</td>
						                        <td ><fmt:formatDate value="${manager.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						                        <td ><fmt:formatDate value="${manager.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						                         
						                        <td>
													<ul class="icons-list">
														<c:if test="${manager.manager_id!=sessionScope[sessionUserKey].manager_id }">
														<weiyun:hasPermission name="manager:edit">
														<li><a href="#" onclick="WIedit('${manager.validate_id}','${manager.validate_id_token }')" data-toggle="modal" data-target="#edit_modal" title="编辑"><i class="icon-pencil7"></i></a></li>
														</weiyun:hasPermission>
														<weiyun:hasPermission name="manager:delete">
														<li><a href="#" onclick="WIremove('${manager.validate_id}','${manager.validate_id_token }')"data-toggle="modal" data-target="#remove_modal" title="删除"><i class="icon-trash"></i></a></li>
														</weiyun:hasPermission>
														<li><a href="#" onclick="WIeditPassword('${manager.validate_id}','${manager.account_name }','${manager.validate_id_token }')"data-toggle="modal" data-target="#edit_password_modal" title="设置密码"><i class="icon-cogs"></i></a></li>
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
									<h5 class="modal-title">编辑管理员</h5>
								</div>
	
								<div class="modal-body">
									<form class="form-horizontal form-validate-jquery" action="${pageContext.request.contextPath}/center/system/manager/save" method="post">
											<fieldset class="content-group">
												<div class="form-group">
													<label class="control-label col-md-2">登录账户 </label>
													<div class="col-md-9">
														<input type="text" class="form-control input-rounded" name="account_name" required="required" >
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">登录密码 </label>
													<div class="col-md-9">
														<input type="password" class="form-control input-rounded showPass" name="password" required="required" autocomplete="new-password" >
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">管理员名称 </label>
													<div class="col-md-9">
														<input type="text" class="form-control input-rounded" name="manager_name" required="required" >
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">角色类型</label>
													<div class="col-md-6">
														<div class="multi-select-full">
															<select class="bootstrap-select" name="role_sign" id="role_sign" required="required">
																<option value="" >--请选择角色类型--</option>
																<c:forEach items="${roleList }" var="role">
																	<option value="${role.role_id }">${role.role_name }</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">描述说明</label>
													<div class="col-md-9">
														<textarea rows="5" cols="5" name="description" class="form-control" required="required" placeholder=""></textarea>
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

					<!-- Edit modal -->
					<div id="edit_password_modal" class="modal fade" role="dialog2">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">管理员密码设置</h5>
								</div>
	
								<div class="modal-body">
									<form class="form-horizontal" id="editPass" action="${pageContext.request.contextPath}/center/system/manager/editManagerPassword" method="post">
											<fieldset class="content-group">
												<div class="form-group">
													<label class="control-label col-md-2">登录账户 </label>
													<div class="col-md-9">
														<input type="text" class="form-control input-rounded" name="account_name" readonly="readonly">
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2">登录密码 </label>
													<div class="col-md-9">
														<input type="password" class="form-control input-rounded" name="password"  required="required" >
													</div>
												</div>
												
											</fieldset>
	
											<div class="text-right">
												<input type="hidden" name="validate_id" value=""/>
												<input type="hidden" name="validate_id_token" value=""/>
												<button type="button" class="btn btn-primary" onclick="submitEditPass()">提交 <i class="icon-arrow-right14 position-right"></i></button>
											</div>
										</form>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /edit modal -->
		            
		            <!-- 预存余额 -->
		            <div id="banlance_dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="width: 400px;">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">预存余额</h5>
								</div>

								<form action="${pageContext.request.contextPath}/center/manager/addBalance" id="infoForm" class="form-horizontal" method="post">
									<div class="modal-body">
										<div class="form-group">
											<div class="col-sm-10">
												<input type="text" class="form-control validate[required,custom[number]]" name="balance" id="balance" value="10000" data-errormessage-value-missing="预存金额不能为空" data-errormessage-custom-error="必须是金额类型"/>
											</div>
										</div>
									</div>

									<div class="modal-footer" style="text-align: center;">
										<input type="hidden" name="validate_id" class="validate_id" value=""/>
										<input type="hidden" name="validate_id_token" class="validate_id_token" value=""/>
										<button type="submit" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
									</div>
								</form>
							</div>
						</div>
					</div>

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
    
    $("#balance").TouchSpin({
		min: -100000,
		max:100000,
	    step: 100,
	    decimals: 2,
	    prefix: '充值金额'
	 });
    
    /*默认监听表单onbulr验证*/
	$('#infoForm').validationEngine("attach",{ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'blackPopup formError-small',
		scroll: true,
		showOneMessage: true
	}); 
    
});
function WIADD(){
	$("#edit_modal").find(".modal-title").html("新增管理员");
	$("#edit_model").find("#manager_id").attr("value","");
	$(".showPass").parent().parent().show();
	$(".showPass").prop("required","required");
	$("input[name='validate_id']").attr("value","");
	$("input[name='validate_id_token']").attr("value","");
	$("input[name='manager_name']").attr("value","");
	$("input[name='account_name']").attr("value","");
	$("textarea[name='description']").text("");
	$('.bootstrap-select').selectpicker('val',"");
    
	
   
}
function WIedit(validate_id,validate_id_token){
	$("#edit_modal").find(".modal-title").html("编辑管理员");
	$.ajax({
	    url:'${pageContext.request.contextPath}/center/system/manager/view?validate_id='+validate_id+'&validate_id_token='+validate_id_token,
	    type:'GET', 
	    data:null,
	    dataType:'json',
	    success:function(result){
	        var result=result.data;
	        $("input[name='validate_id']").attr("value",validate_id);
	        $("input[name='validate_id_token']").attr("value",validate_id_token);
	        $("input[name='manager_name']").attr("value",result.manager_name);
	        $("input[name='account_name']").attr("value",result.account_name);
	        $(".showPass").parent().parent().hide();
	        $(".showPass").prop("required","");
	        $("select[name='role_sign']").attr("value",result.role_sign);
	      // $("select[name='role_sign']").attr("role_sign");
	   
	        $("textarea[name='description']").text(result.description);
	    
	       
	        //初始化select
	        $.ajax({
			    url:'${pageContext.request.contextPath}/center/system/manager/selectRolesByManagerId',
			    type:'POST', 
			    data:{"manager_id":validate_id},
			    dataType:'json',
			    success:function(result){
			    	$.each(result,function(index,item){
			            $('.bootstrap-select').selectpicker('val', item.role_id);
			    	});
			    },
			    error:function(xhr,textStatus){
			        console.log('加载resource列表错误');
			    }
	        });
	    },
	    error:function(xhr,textStatus){
	        console.log('错误');
	    }
	});
}

function WIeditPassword(validate_id,account_name,validate_id_token){
	document.getElementById("editPass").validate_id.value=validate_id;
	document.getElementById("editPass").validate_id_token.value=validate_id_token;
	document.getElementById("editPass").account_name.value=account_name;
}
function submitEditPass(){
	if(document.getElementById("editPass").password.value.length<5){
		 new PNotify({title: '提示操作',text: '密码不足五位',addclass: ''});
	}else{
		document.getElementById("editPass").submit();
	}
}
function WIremove(validate_id,validate_id_token){
	var url="${pageContext.request.contextPath}/center/system/manager/remove?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
	Mremove("get",url);
}

function queryBalance(validate_id,validate_id_token){
	$.ajax({
	    url:'${pageContext.request.contextPath}/center/manager/queryBalance',
	    type:'POST', 
	    data:{"validate_id":validate_id,"validate_id_token":validate_id_token},
	    dataType:'json',
	    success:function(result){
	    	console.log(result);
	    	if(result.code==0){
	    		$("#balance"+validate_id).html(result.data.last_balance);
	    	}else{
	    		$("#balance"+validate_id).html("0.00");
	    	}
	    },
	    error:function(xhr,textStatus){
	        console.log('查询余额异常');
	        $("#balance"+validate_id).html("0.00");
	    }
    });
}

function yucun(validate_id,validate_id_token){
	$("#banlance_dialog").find(".validate_id").val(validate_id);
	$("#banlance_dialog").find(".validate_id_token").val(validate_id_token);
}
</script>