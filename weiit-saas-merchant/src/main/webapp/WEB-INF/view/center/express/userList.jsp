<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>配送方式及运费</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="userList"><i class="icon-users"></i>物流公司管理</a></li>
								<li><a href="userCardList"><i class="icon-vcard"></i>运费模板设置</a></li>
								<li><a href="userLevelList"><i class="icon-lan2"></i>会员等级管理</a></li>
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
						<div class="page-title">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 会员管理 </span>
							</h4>
						</div>
					</div>
					<div class="breadcrumb-line">
						<ul class="breadcrumb">
							<li><a href="index.html"><i class="icon-home2 position-left"></i>会员管理</a></li>
							<li class="active">会员列表</li>
						</ul>
			
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
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_id"> ID</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_account">账户</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_password"> 密码</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_name"> 用户名</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_phone"> 手机</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_balance"> 余额</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_create_time"> 注册时间</label></li>
									<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="user_column_user_disabled"> 状态</label></li>
								</ul>
							</li>
						</ul>
					</div>
			
				</div>
				<!-- /page header -->
			
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/users/user/list" method="post">
								<div style="margin-left: -10px;">
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">账号</span> <input type="text" class="form-control" placeholder="" name="user_account" value="${queryParam.user_account }">
										</div>
									</div>
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">用户名</span> <input type="text" class="form-control" placeholder="" name="user_name" value="${queryParam.user_name }">
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
												<th><input type="checkbox" name="selectAll" onclick="allCheckClick(this)" value="0" /></th>
												<th class="user_column_user_id">ID</th>
												<th class="user_column_user_account">账户</th> 
												<th class="user_column_user_name">用户名</th>
												<th class="user_column_user_phone">手机</th>
												<th class="user_column_user_balance">余额</th>
												<th class="user_column_user_id">用户地址</th>
												<th class="user_column_user_create_time">注册时间</th>
												<th class="user_column_user_disabled">状态</th>
												<th width="80">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="user">
											<tr>
												<td><input type="checkbox" name="ids" value="${user.user_id }|${user.validate_id_token}"></td>
												<td>${user.user_id }</td>
												<td>${user.user_account }</td>
												<td>${user.user_name }</td>
												<td>${user.user_phone }</td>
												<td>
													<a href="${pageContext.request.contextPath}/center/users/user/balanceList?user_id=${user.user_id}" >${user.balance}</a>
												</td>
												<td>
													<a href="${pageContext.request.contextPath}/center/users/user/addressList?user_id=${user.user_id}" >查看地址</a>
												</td>
												<td><fmt:formatDate value="${user.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>	
												<td >
													<c:if test="${user.is_disabled != -1 }">正常</c:if>
													<c:if test="${user.is_disabled == -1 }">禁用</c:if>
												</td>
												<td>
													<c:if test="${user.is_disabled != -1 }">
						                           		<a href="javascript:;" title="点击禁用" class="btn btn-warning m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${user.validate_id},'${user.validate_id_token}','${user.user_account}',-1)">禁用</a>
						                           	</c:if>
						                           	<c:if test="${user.is_disabled==-1}">
														<a href="javascript:;" title="点击启用" class="btn btn-success m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${user.validate_id},'${user.validate_id_token}','${user.user_account}',1)">启用</a>
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</table>
			
								</div>
								<div id="pager" class="panel-body"> 
									<div style="margin-left: -20px; margin-bottom: 20px;">
										<button type="button" class="btn btn-default">
											<input type="checkbox" name="selectAll" onclick="allCheckClick(this)" value="1" />&nbsp;全选/不选
										</button>&nbsp;&nbsp;&nbsp;
										<button type="button" onclick="BatchWIremove(-1)" class="btn btn-default" data-toggle="modal" data-target="#remove_batch_modal">
											批量禁用
										</button>&nbsp;&nbsp;&nbsp;
										<button type="button" onclick="BatchWIremove(0)" class="btn btn-default" data-toggle="modal" data-target="#remove_batch_modal">
											批量启用
										</button>
									</div> 
								</div>
							</form>
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
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
			});
			 
			function mUpdate(id,token,name,status){
				var title="";
				if(status=="-1"){
					title='确定要禁用账户<label style="color: red;">'+name+'</label> 吗？';
				}
				if(status=="0"){
					title='确定要启用账户<label style="color: red;">'+name+'</label> 吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/users/user/status?is_disabled="+status+"&validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			 
			 //批量禁用，启用
			function BatchWIremove(is_disabled){
				var title="";
				if(is_disabled==-1){
					title='确定要批量禁用选择账户吗,禁用后用户无法登录？';
				}
				if(is_disabled==0){
					title='确定要批量启用选择账户吗？';
				}
				MremoveBath("input[name='ids']","${pageContext.request.contextPath}/center/users/user/statusBatch?is_disabled="+is_disabled,title);
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
			</script>
						
