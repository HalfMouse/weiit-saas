<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>客户管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="userList"><i class="icon-users"></i>会员管理</a></li>
								<li><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
								<li><a href="userCashList"><i class="icon-cash"></i>会员提现</a></li>
								<li><a href="userSet"><i class="icon-gear"></i>会员设置</a></li>
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
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 会员管理 </span>
							</h4>
						</div>
						<div class="heading-elements" >
							<ul class="breadcrumb-elements">
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-file-excel position-left"></i> 导出 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li><a href="javascript:exportExcel('xlsx')"><i class="icon-file-excel"></i> Excel导出</a></li>
										<li><a href="javascript:exportExcel('csv')"><i class="icon-file-excel"></i> CSV导出</a></li>
									</ul>
								</li>
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_name">会员/昵称 </label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_account">会员账号</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_phone"> 手机</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_balance"> 余额</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_integral"> 积分</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_address">用户地址</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_create_time">最后登录时间</label></li>
										
									</ul>
								</li>
							</ul>
						</div>
					</div>
					
			
				</div>
				<!-- /page header -->
			
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
								<div style="margin-left: -10px;">
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">用户名</span> <input type="text" class="form-control" placeholder="" name="user_name" value="${queryParam.user_name }">
										</div>
									</div>
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">账号</span> <input type="text" class="form-control" placeholder="" name="user_account" value="${queryParam.user_account }">
										</div>
									</div>
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">手机</span> <input type="text" class="form-control" placeholder="" name="user_phone" value="${queryParam.user_phone }">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
								<br> <br>
								<div class="table-responsive">
									<table id="data-table"
										class="table">
										<thead>
											<tr>
												<th><input type="checkbox" class="styled" name="allCheck" onclick="allCheckClick(this)" value="0" /></th>
												<th class="user_column_user_name">会员/昵称</th>
												<th class="user_column_user_account"> 会员账号</th> 
												<th class="user_column_user_phone">手机</th>
												<th class="user_column_user_balance">余额</th>
												<th class="user_column_user_integral">积分</th>
												<th class="user_column_user_open_id_type">账号类型</th>
												<th class="user_column_user_address">用户地址</th>
												<th class="user_column_user_create_time">最后登录时间</th>
												<th width="80">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="user">
											<tr>
												<td><input type="checkbox" class="styled" name="ids" value="${user.user_id }|${user.validate_id_token}"></td>
												<td><img src="${user.user_img}" width="40" height="40"/>&nbsp;&nbsp;${user.user_name }
													<br>
													<c:forEach items="${user.signList }" var="sign">
														<span class="btn-info">
														${sign.sign_name }&nbsp; 
														</span>&nbsp;
													</c:forEach>
												</td>
												<td>${user.user_account }</td>
												<td>${user.user_phone }</td>
												<td>
													<a href="${pageContext.request.contextPath}/center/user/balanceList?user_id=${user.user_id}" ><span class="text-blue text-bold">${user.balance}</span></a>
												</td>
												<td>
													<a href="${pageContext.request.contextPath}/center/user/integralList?user_id=${user.user_id}" ><span class="text-orange text-bold">${user.integral}</span></a>
												</td>
												<td>
													<c:if test="${user.open_id_type eq 0}"><span class="text-danger">小程序</span></c:if>
													<c:if test="${user.open_id_type eq 1 }"><span class="text-danger">服务号</span></c:if>
												</td>
												<td>
													<a href="${pageContext.request.contextPath}/center/user/addressList?user_id=${user.user_id}" >查看地址</a>
												</td>
												<td><fmt:formatDate value="${user.update_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>	
												<td>
													
													<a href="javascript:;" onclick="changeBalanceOrIntegral('${user.validate_id}','${user.validate_id_token}',1)" title="充值余额" class="btn bg-blue m-r-5 m-b-5" style="height: 22px;padding-top: 0px;"  data-toggle="modal" data-target="#banlance_dialog">充值余额</a>
													&nbsp;&nbsp;
													<a href="javascript:;" onclick="changeBalanceOrIntegral('${user.validate_id}','${user.validate_id_token}',2)" title="赠送积分" class="btn bg-orange m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" data-toggle="modal" data-target="#integral_dialog">赠送积分</a>
												</td>
											</tr>
										</c:forEach>
									</table>
			
								</div>
								<div id="pager" class="panel-body"> 
									<label class="btn btn-default" style="padding:3px 3px;" > 
										<input type="checkbox" name="selectAll" class="styled" onclick="allCheckClick(this)" value="1" />&nbsp;全选/不选
									</label>
					                <button type="button" class="btn btn-default" style="padding:3px 3px;" onclick="BatchWIeditTag()">
							         	<i class=" icon-pencil7"></i> 批量打标签</button>&nbsp;&nbsp;&nbsp;
								</div>
							</form> 
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
			 		<!-- chongzhi modal -->
					<div id="banlance_dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="width: 400px;">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">充值余额</h5>
								</div>

								<form action="${pageContext.request.contextPath}/center/user/changeBalanceOrIntegral" id="infoForm" class="form-horizontal" method="post">
									<div class="modal-body">
										<div class="form-group">
											<div class="col-sm-10">
												<input type="text" class="form-control validate[required,custom[number]]" name="balance" id="balance" value="100" data-errormessage-value-missing="充值金额不能为空" data-errormessage-custom-error="必须是金额类型" />
											</div>
										</div>
									</div>

									<div class="modal-footer" style="text-align: center;">
										<input type="hidden" name="validate_id" class="validate_id" value=""/>
										<input type="hidden" name="validate_id_token" class="validate_id_token" value=""/>
										<input type="hidden" name="type"  value="1"/>
										<button type="submit" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div id="integral_dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="width: 400px;">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">赠送积分</h5>
								</div>

								<form action="${pageContext.request.contextPath}/center/user/changeBalanceOrIntegral" id="infoForm2"  class="form-horizontal" method="post">
									<div class="modal-body">
										<div class="form-group">
											<div class="col-sm-10">
												<input type="text" class="form-control validate[required,custom[integer]]" name="integral" id="integral" value="100" data-errormessage-value-missing="赠送积分不能为空" data-errormessage-custom-error="必须是整数类型" />
											</div>
										</div>
									</div>
 
									<div class="modal-footer" style="text-align: center;">
										<input type="hidden" name="validate_id" class="validate_id" value=""/>
										<input type="hidden" name="validate_id_token" class="validate_id_token" value=""/>
										<input type="hidden" name="type"  value="2"/>
										<button type="submit" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<!-- /chongzhi modal -->
					
					<!-- 选择标签组 -->
					<div id="dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="width: 560px;">
								<div class="modal-header" style="background:white;">
									<button type="button" class="close" onclick="dialogClose()" data-dismiss="modal">&times;</button>
								</div>

								<form action="${pageContext.request.contextPath}/center/user/userSignLogAdd" class="form-horizontal" method="post">
									<div class="modal-body">
										<div class="form-group">
										 	<label class="col-md-3 text-right">标签组 ：</label>
											<div class="col-md-5">
												<c:forEach items="${signList }" var="sign">
													<input type="checkbox" name="sign_id" class="styled"  value="${sign.sign_id }"/>&nbsp;${sign.sign_name }
												</c:forEach>
											</div>
										</div>
										
									</div> 

									<div class="modal-footer" style="text-align: center;">
										<input type="hidden" name="ids" id="ids" value=""/> 
										<button type="submit" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm btn-default" onclick="dialogClose()">取消</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<!-- 选择标签组 -->
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			
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
			    $("#integral").TouchSpin({
					min: -100000,
					max:100000,
				    step: 100,
				    prefix: '赠送积分'
				 });
			    
			    /*默认监听表单onbulr验证*/
				$('#infoForm').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				});
			    
				 /*默认监听表单onbulr验证*/
				$('#infoForm2').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				});
			});
			function changeBalanceOrIntegral(id,token,type){
				if(type==1){
					$("#banlance_dialog").find(".validate_id").val(id);
					$("#banlance_dialog").find(".validate_id_token").val(token);
				}
				if(type==2){
					$("#integral_dialog").find(".validate_id").val(id);
					$("#integral_dialog").find(".validate_id_token").val(token);
				}
			}
			//excel导出
			function exportExcel(fileType){
				var exportClassName="com.weiit.web.admin.user.service.UserService";
				var	exportMethodName="selectList";
				var	exportExcelName="会员列表";
				var	exportTitles="用户账号,用户密码,用户名,用户积分,用户余额,用户手机,地区";
				var	exportFields="user_account,user_password,user_name,integral,balance,user_phone,region";	
				commonExportList("searchform",exportClassName,exportMethodName,exportExcelName,exportTitles,exportFields,fileType);
			}
			function BatchWIeditTag(){
				var ids="";
				$("input[name='ids']").each(function(){
					 if($(this).prop("checked")){
						 var valueStr=$(this).val().split("|"); 
						 if(ids==""){
							 ids=valueStr[0];
						 }else{
							 ids=ids+"|" +valueStr[0];
						 }
					 }
				});
				if(ids==""){
					MAlert("请至少选择一个会员进行打标签！");
					return;
				}else{
					$("#dialog").addClass("in");
					$("#dialog").show(); 
					$("#dialog").find("#ids").val(ids); 
				}
			}
			function dialogClose(){
				$("#dialog").removeClass("in"); 
				$("#dialog").hide();  
			}
			</script>
						
