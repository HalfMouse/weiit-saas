<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 意见反馈 </span>
							</h4>
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
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
								<br> <br>
								<div class="table-responsive">
									<table id="data-table"
										class="table">
										<thead>
											<tr>
												<th class="user_column_user_shop">所属商户</th>
												<th class="user_column_user_name">会员/昵称</th>
												<th class="user_column_user_account"> 意见内容</th>
												<th class="user_column_user_create_time">反馈时间</th>
												<th width="80">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="user">
											<tr>
												<td>${user.shop_name }</td>
												<td>${user.user_name }</td>
												<td>${user.suggest }</td>
												<td><fmt:formatDate value="${user.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>	
												<td>
												   	<a href="javascript:;" title="删除" onclick="WIremove(${user.validate_id},'${user.validate_id_token}','${user.user_name}')" >
														删除</a>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div id="pager" class="panel-body"></div>
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
			 
			function WIremove(id,token,name){
				MConfirm('确定要删除用户 <label style="color: red;">'+name+'</label> 的反馈吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/shop/suggestRemove?validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			</script>
						
