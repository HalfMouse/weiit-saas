<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
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
								<li><a href="userList"><i class="icon-users"></i>会员管理</a></li>
								<li class="active"><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
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
				
				<!-- Content area -->
				<div class="content">
						
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">

								<div class="panel-body">
									
									<div class="auto">
										<form class="form-horizontal" action="" method="post"  enctype="multipart/form-data">
											<fieldset class="content-group">
												<legend class="text-bold">
												<h5>发卡方式一：自动领取</h5>
												<span class="text-muted">说明：想要给您的客户派送会员卡片，您可通过发送链接或二维码的方式给客户完成自动领卡.</span>
												</legend>
												
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">发卡链接:</label>
													<div class="col-lg-3">
														<div class="input-group">
															<input type="text" name="input_group" class="form-control" readonly value="https://kdt.im/th2o-h" required="required" placeholder="">
															<div class="input-group-addon">复制</div>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">发卡二维码:</label>
													<div class="col-md-3 text-bold">
														<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhAQMAAAAEfUA5AAAABlBMVEUAAAD///+l2Z/dAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC7ElEQVRYhe2YO86rMBCFB1FQegfJRiKxLTrIzlgKS6CkQPieM2Mbw/8ormTfW8SFFfKFyJ7HmbHF/zIm+dAP/Vu6CoZ/ez+v/SKP7u3bGd+0/wFdmwVzzwkgpz1fA31I7/G7Fyi2U57ykUszKvbocopP49F5vz3qUjVYN7lgqzulJZXyXypSiaObvtnRjkd4f5yxrYp0fTlEU7+0c/deLlS9/3IeFK950ntsFKEa7boqTust2hM9p4rUDBY+nTSMpeW8CYzdftWcAjQZZ0ZIYVXMRrhx/Iaqa7eqNA2HVSEhTu8f0nAzlBbG5FGFNt7WouPR7de4UkrXdrvbnn6/ZmgVKqqiJlrJ+9tTI9EbhSWliXYuRy3G5VyQy1dlr72XAcq/qMzB4pmqFKNaJSdJJVBpshVAtK7A8bvDd3v0fjlqxWbPtH14Uh4yS1qhohG5t3oU8rqZ85Cc8O/FgybDrN3IFNLGV6Cish5XZb50XyhqqKe0DLLWoLlWncoV4+rt5QlBafVfDpYshECKjXJ0SjlIvRKVtD2taldKSzbM5AY5U4VOiYqtb5ALtekQq5L4nU+VvRylL60KJYHPlMEoN6MtdihZNahF0yChMbz2DLtYeQo9/7VaFaRTXBW1PWRorqLRkrDzE51HCNFKVJQKi1JO1dPWx0LSQKF1SVXK0VX7U00IelCjPVNRyhwLqXhrnc2m5WmqOHYoDHU6o9bdwPtMTqdOHmtQOwWeYtr56MHQNav40tiaEBWptgvBYDzoZNWKITBb1GEcPHyXp6IVW5KK3uqg1fOHfhepr0JTjEc3RqpjDWqGxt9r3SpP1yDmGBrtr7vGmn8PbXbWeGSsQ9VMzAW5Uc1fKjBkbmCXZifw4vS8Z1BbRYPl1ABKQmV6qkIQrestBMoTJuzI7r6ymCxNGejDeV2UUxo7vGFaV4kK70bOuO+XPK5ID70JtLa29+WprcVlzpvllgt6kG10WzIe/57+PD70Q3+kfwA+OYrtS3zBfgAAAABJRU5ErkJggg=="/>
													</div>
												</div>
											</fieldset>
										</form>
									</div>
									
									<div class="give">
										<legend class="text-bold">
										<h5>发卡方式二：手动派卡</h5>
										<span class="text-muted">说明：除上面自动领卡方式外，您还可以给您的客户以手工方式派送会员卡片.</span>
										</legend>
										
										<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
											<div style="margin-left: -10px;">
												<div class="col-md-3">
													<div class="input-group">
														<span class="input-group-addon">会员昵称</span> <input type="text" class="form-control" placeholder="" name="user_name" value="${queryParam.user_name}">
													</div>
												</div>
												<div class="col-md-3">
													<div class="input-group">
														<span class="input-group-addon">会员账号</span> <input type="text" class="form-control" placeholder="" name="user_account" value="${queryParam.user_account}">
													</div>
												</div>
												<div class="col-md-3">
													<div class="input-group">
														<span class="input-group-addon">手机</span> <input type="text" class="form-control" placeholder="" name="user_phone" value="${queryParam.user_phone}">
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
															<th class="user_column_user_account">会员/昵称</th> 
															<th class="user_column_user_name">会员账号</th>
															<th class="user_column_user_phone">手机</th>
															<th class="user_column_user_create_time">注册时间</th>
															<th class="user_column_user_disabled">最后登录时间</th>
															<th width="80">操作</th>
														</tr>
													</thead>
													<c:forEach items="${pageInfo.list}" var="user">
														<tr>
															<td><input type="checkbox" class="styled" name="ids" value="${user.user_id}"></td>
															<td><img src="${user.user_img}" width="40" height="40"/>&nbsp;&nbsp;${user.user_name }</td>
															<td>${user.user_account }</td>
															<td>${user.user_phone }</td> 
															<td><fmt:formatDate value="${user.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>	
															<td >
																<fmt:formatDate value="${user.update_time}" pattern="yyyy-MM-dd hh:mm:ss"/>
															</td> 
															<td>
																<a href="javascript:;" title="派发" onclick="sendCard('${user.user_id}','${user.user_name}')" class="btn bg-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">开卡</a>
															</td>
														</tr>
													</c:forEach>
												</table>
						
											</div>
											<div id="pager" class="panel-body"> 
												<div style="margin-left: -20px; margin-bottom: 20px;">
													<label class="btn btn-default"  > 
														<input type="checkbox" class="styled" name="selectAll" onclick="allCheckClick(this)" value="1" />&nbsp;全选/不选
													</label>&nbsp;&nbsp;&nbsp;
													<button type="button" onclick="batchSendCard()" class="btn btn-default" data-toggle="modal" data-target="#remove_batch_modal">
														批量开卡
													</button>
												</div> 
											</div>
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
			
			<%@include file="../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script>
			$(document).ready(function() {
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			});
			 
			function sendCard(userId,userName){
				MConfirm('确定要给用户<label style="color: red;">'+userName+'</label> 发放会员卡吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/user/userCardGiveSave?type=0&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&user_id="+userId;
					}
				});
			}
		    
			function batchSendCard(){
				var idStr="";
				var idsCheck = $("#data-table input[name='ids']");
				idsCheck.each(function(i){
					if ($(this).prop("checked") ) {		
						if(idStr==""){
							idStr=$(this).val();
						}else{
							idStr=idStr+","+$(this).val();
						}
					}
			    });
				if(idStr==""){
					MAlert('请至少选择一个用户进行开卡！');
					return;
				}
				MConfirm('确认对选择用户批量开卡吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/user/userCardGiveSave?type=1&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&userIds="+idStr ;
					}
				});
			}
			</script>
						
