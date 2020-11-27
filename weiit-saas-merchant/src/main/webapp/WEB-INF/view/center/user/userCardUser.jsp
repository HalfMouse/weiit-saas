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
			<div class="content-wrapper " >
				<!-- Content area -->
				<div class="content">
				
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
								<div style="margin-left: -10px;">
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">会员卡</span>
											<input type="text" class="form-control" id="card_name" name="card_name" readonly="readonly" value="${cardInfo.card_name}">
										</div>
									</div>
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">会员名</span>
											<input type="text" class="form-control" id="user_name" name="user_name" value="${queryParam.user_name}">
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
											<tr > 
												<th><input type="checkbox" class="styled" name="allCheck" onclick="allCheckClick(this)" value="" /></th>
												<th>头像</th>
												<th>会员名</th>
												<th>会员卡名称</th>
												<th>领取时间</th>	 
												<th>操作</th>	
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${pageInfo.list}" var="info">
						                    <tr>
						                    	<td><input type="checkbox" class="styled" name="ids" value="${info.validate_id }|${info.validate_id_token}"></td>
						                        <td><img src="${info.user_img}" width="40" height="40"/></td>
												<td>${info.user_name }</td>
												<td> 
													${info.card_name }
												</td>
												<td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												 <td> 
													 <a href="javascript:;" title="退卡" onclick="cancelUserCard('${info.validate_id}','${info.validate_id_token }','${info.user_name}')" >
														退卡</a>
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
										<button type="button" onclick="BatchCancelUsers()" class="btn btn-default" data-toggle="modal" data-target="#remove_batch_modal">
											批量退卡
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
			
			function cancelUserCard(validate_id,validate_id_token,user_name){ 
				var url="${pageContext.request.contextPath}/center/user/userCardGiveRemove?card_id=${queryParam.validate_id}&card_id_token=${queryParam.validate_id_token}&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
				Mremove("get",url,'确定要给用户 <label style="color: red;">'+user_name+'</label> 退卡吗？');
			}
			
			function BatchCancelUsers(){
				var url="${pageContext.request.contextPath}/center/user/userCardGiveRemove?card_id=${queryParam.validate_id}&card_id_token=${queryParam.validate_id_token}";
				MremoveBath("input[name='ids']",url,'确定要给选择的用户批量退卡吗？');
			}
			</script>