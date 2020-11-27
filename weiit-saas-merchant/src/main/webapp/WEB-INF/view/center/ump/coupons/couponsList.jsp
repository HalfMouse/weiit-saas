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
							<%--	<li><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>--%>
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
									class="text-semibold"> 优惠券列表 </span>
							</h4>
						</div>
						<div class="heading-elements"> 
							<ul class="breadcrumb-elements"> 
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-gear position-left"></i>显示字段 <span class="caret"></span></a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_name">优惠券名称</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_price">价值</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_limit">领取限制</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_date">有效期</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_give_count">领取人/次</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_use_count">已使用</label></li>
										<li class="checkbox"><label><input type="checkbox" class="styled" checked="checked" value="coupon_state">状态</label></li>
									</ul>
								</li>
								<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick="Mget('${pageContext.request.contextPath}/center/ump/coupons/create')" ><i class="icon-add position-left"></i>新增优惠券</button></li>
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
								<div class="table-responsive">
									<table id="data-table" class="table">
										<thead>
											<tr>
												<th><input type="checkbox" name="selectAll" onclick="allCheckClick(this)" value="0" /></th>
												<th class="coupon_name">优惠券名称</th>
												<th class="coupon_price">价值</th> 
												<th class="coupon_limit">领取限制</th>
												<th class="coupon_date">有效期</th>
												<th class="coupon_give_count">领取人/剩余库存</th>
												<th class="coupon_use_count">已使用</th>
												<th class="coupon_state">状态</th>
												<th style="padding:0px;margin:0px;text-align:center;">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="info">
											<tr>
												<td><input type="checkbox" name="selectAll" onclick="allCheckClick(this)" value="0" /></td>
												<td>${info.coupon_name}</td>
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
												<td>
													<c:if test="${empty info.max_limit or info.max_limit eq 0}">不限张数</c:if>
													<c:if test="${!empty info.max_limit and info.max_limit ne 0 }">一人${info.max_limit}张</c:if>
													<br/><span class="text-muted">库存：${info.number}</span>
												</td>
												<td>
													<c:if test="${info.use_type==1 }">
														<fmt:formatDate value="${info.start_time }" pattern="yyyy-MM-dd hh:ss:mm"/>
														 至
														<fmt:formatDate value="${info.end_time }" pattern="yyyy-MM-dd hh:ss:mm"/>
													</c:if>
													<c:if test="${info.use_type==2 }">
														领取后${info.from_day }天生效,生效${info.to_day }天
													</c:if>
												</td>
												<td>
												<a href="${pageContext.request.contextPath}/center/ump/coupons/couponsUserList?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}">${info.distribute_count}</a>/${info.number-info.distribute_count}<br>
												<a href="${pageContext.request.contextPath}/center/ump/coupons/couponsGive?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}">派发或推广</a>
												</td>
												<td>${info.used_count }</td>
												<td>
													<c:if test="${info.state == 1 }">
															<a href="javascript:;" title="点击失效" class="btn bg-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.coupon_name}',-1)">生效中</a>
						                           	</c:if>
						                           	<c:if test="${info.state==-1}">
														<a href="javascript:;" title="点击生效" class="btn bg-grey-300 m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.coupon_name}',1)">已失效</a>
													</c:if>
												</td>
												<td>
													<a href="javascript:;" onclick="Mget('${pageContext.request.contextPath}/center/ump/coupons/edit?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}')"  title="编辑" class="btn bg-orange m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">编辑</a>
													&nbsp;&nbsp;
													<a href="javascript:;" onclick="WIremove('${info.validate_id}','${info.validate_id_token}','${info.coupon_name}')" title="删除" class="btn bg-grey m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">删除</a>
												</td>
											</tr>
										</c:forEach>
									</table>
								
								</div>
								<br><br>
								<c:if test="${fn:length(pageInfo.list)>=10}">
								<div id="pager" class="panel-body">
								
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
			
			function mUpdate(id,token,name,state){
				var title="";
				if(state=="-1"){
					title='确定要失效优惠券<label style="color: red;">'+name+'</label> 吗？';
				}
				if(state=="1"){
					title='确定要生效优惠券<label style="color: red;">'+name+'</label> 吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/coupons/state?state="+state+"&validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			 
			function WIremove(id,token,name){
				MConfirm('确定要删除优惠券<label style="color: red;">'+name+'</label> 吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/ump/coupons/remove?validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			</script>
						
