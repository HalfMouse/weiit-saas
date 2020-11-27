<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>营销服务</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<%--<li><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>--%>
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
						<div class="page-title"  style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 优惠券会员列表 </span>
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
							<form class="form-horizontal" name="searchform" id="searchform" 
								action="${pageContext.request.contextPath}/center/ump/coupons/couponsUserList" method="post">
								<input type="hidden" name="validate_id" id="validate_id" value="${queryParam.validate_id}"/>
								<input type="hidden" name="validate_id_token" id="validate_id_token" value="${queryParam.validate_id_token}"/>
								<div style="margin-left: -10px;">
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">优惠券</span>
											<input type="text" class="form-control" id="coupons_name" name="coupons_name" readonly="readonly" value="${coupon.coupon_name}">
										</div>
									</div>
									<div class="col-md-3">
										<div class="input-group">
											<span class="input-group-addon">会员账号</span> <input type="text" class="form-control" placeholder="" name="user_account" value="${queryParam.user_account }">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
								<br> <br>
								<div class="table-responsive">
									<table id="data-table" class="table">
										 <thead>
											<tr > 
												<th><input type="checkbox" class="styled" name="allCheck" onclick="allCheckClick(this)" value="" /></th>
												<th>会员/昵称</th>
												<th>会员账号</th>
												<th>优惠描述</th>
												<th>领取时间</th>	
												<th>使用情况</th>
												<th>领取方式</th>
												<th width="80">操作</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${pageInfo.list}" var="info">
						                    <tr>
						                        <td><input type="checkbox" class="styled" name="ids" value="${info.id }"></td>
												<td><img src="${info.user_img}" width="40" height="40"/>&nbsp;&nbsp;${info.user_name }</td>
												<td>${info.user_account }</td>
												<td>
													<c:if test="${info.type==1 }">
														${info.coupon_price}
													</c:if>
													<c:if test="${info.type==2 }">
														${info.coupon_discount }折
													</c:if>
													<c:if test="${info.type==3 }">
														${info.random_min_price }~${info.random_max_price }
													</c:if>
													<br/>
													<span class="text-muted">
													<c:if test="${info.is_condition==-1 }">
														无限制
													</c:if>
													<c:if test="${info.is_condition==1 }">
														最低消费:${info.condition_price }元
													</c:if>
													</span>
												</td>
												<td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
												<td>
													<c:if test="${info.state==0 }"><span class="text-muted">未使用</span></c:if>
													<c:if test="${info.state==-1 }"><span class="text-danger">已过期</span></c:if>
													<c:if test="${info.state==1 }"><span class="text-muted">使用时间:<fmt:formatDate value="${info.update_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span></c:if>
												</td>
												<td style="height: 22px; padding-top: 6px; padding-bottom: 0px;">									
													商家派送												
												</td>
												<td>
													<a href="javascript:;" title="回收优惠券" onclick="sendCoupon('${info.id}','${info.user_name}')" class="btn bg-orange m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">回收优惠券</a>
												</td>
						                    </tr>
						                </c:forEach>
									</table>
			
								</div>
								<c:if test="${fn:length(pageInfo.list)>=10}">
									<div id="pager" class="panel-body"> 
										<div style="margin-left: -20px; margin-bottom: 20px;">
											<label class="btn btn-default">
												<input type="checkbox" class="styled"  name="selectAll" onclick="allCheckClick(this)" value="1" />&nbsp;全选/不选
											</label>&nbsp;&nbsp;&nbsp;
											<button type="button" onclick="BatchCoupon()" class="btn btn-default" data-toggle="modal" data-target="#remove_batch_modal">
												批量回收
											</button>&nbsp;&nbsp;&nbsp;
											<button type="button" class="btn btn-default" onclick="allCoupon()"><i class="icon-paperplane"></i> 全部回收</button>
										</div> 
									</div>
								</c:if>
							</form>
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			
			<script>
			$(document).ready(function() {
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			});
		 	
			function allCoupon(id,name){
				MConfirm('确定要回收查询全部用户优惠券吗？','','',function(result) {
					if(result){
						var url="${pageContext.request.contextPath}/center/ump/coupons/couponsUserRemove?type=2";
						$('#searchform').attr("action",url);
						$('#searchform').submit();
					}
				});
			}
			function BatchCoupon(){
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
					MAlert('请至少选择一个用户进行回收！');
					return;
				}
				MConfirm('确认对选择用户批量回收优惠券吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/coupons/couponsUserRemove?type=1&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&ids="+idStr ;
					}
				});
			}
			 
			function sendCoupon(userId,userName){
				MConfirm('确定要 回收用户<label style="color: red;">'+userName+'</label> 优惠券吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/coupons/couponsUserRemove?type=0&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&id="+userId;
					}
				});
			}
		 
			  
			</script>
						
