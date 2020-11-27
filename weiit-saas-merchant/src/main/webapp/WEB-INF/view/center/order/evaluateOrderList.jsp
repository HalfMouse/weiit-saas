<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/header.jsp"%>
 
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>订单管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="orderList"><i class="icon-menu6"></i>所有订单</a></li>
								<li><a href="refundOrderList"><i class="icon-warning"></i>维权订单</a></li>
								<li><a href="starOrderList"><i class="icon-flag7"></i>加星订单</a></li>
								<li class="active"><a href="evaluateOrderList"><i class="icon-star-empty3"></i>评价管理</a></li>
								<li><a href="orderSet"><i class="icon-gear"></i>订单设置</a></li>
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
							<h4><i class="icon-home2 position-left"></i>评价管理</h4>
						</div>
			
						<div class="heading-elements">
							<div class="heading-btn-group">
								<a href="#" class="btn btn-link btn-float has-text"><i class="icon-bars-alt text-primary"></i><span>数据统计</span></a>
							</div>
						</div>
					</div>
				</div>
				<!-- /page header -->
			
				<!-- Content area -->
				<div class="content">
					<!-- Tabs -->
					<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs"> 
						<li <c:if test="${empty queryParam.score }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/evaluateOrderList"><i class="icon-grid5 position-left"></i>全部评论</a></li>
						<li <c:if test="${queryParam.score==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/evaluateOrderList?score=1"><i class=" icon-heart5 position-left"></i>好评</a></li>
						<li <c:if test="${queryParam.score==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/evaluateOrderList?score=2"><i class=" icon-heart6 position-left"></i>中评</a></li>
						<li <c:if test="${queryParam.score==3 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/center/order/evaluateOrderList?score=3"><i class="icon-heart-broken2 position-left"></i>差评</a></li>
					</ul>
					<!-- /tabs -->
					<!-- Search field -->
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action=""  method="post">
			         		<div class="row">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">商品名称：</span> <input type="text"
											class="form-control" placeholder="" name="product_name" value="${queryParam.product_name}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">订单号：</span> <input type="text"
											class="form-control" placeholder="" name="order_num" value="${queryParam.order_num}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">状态</span>
										 <select class="bootstrap-select" data-width="100%" name="is_show"id="is_show">
											<option value="" <c:if test="${queryParam.is_show=='' }">selected="selected"</c:if>>--全部--</option>
											<option value="0" <c:if test="${queryParam.is_show=='0' }">selected="selected"</c:if>>显示</option>
											<option value="-1" <c:if test="${queryParam.is_show=='-1' }">selected="selected"</c:if>>不显示</option>
										</select>
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">是否回复</span>
										 <select class="bootstrap-select" data-width="100%" name="state"id="state">
											<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--全部--</option>
											<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>未回复</option>
											<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>已回复</option>
										</select>
									</div>
								</div>
								<br>
								<br>
								<br>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">会员号：</span> <input type="text"
											class="form-control" placeholder="" name="user_name" value="${queryParam.user_name}">
									</div>
								</div>
								<div class="col-md-5">
									<div class="input-group">
										<span class="input-group-addon">订单时间</span>
										<div class="input-group">
											<input type="text" class="form-control pickadate-translated" name="startTime" id="startTime" value="${queryParam.startTime}">
											<span class="input-group-addon">--</span> 
											<input type="text" class="form-control pickadate-translated" name="endTime" id="endTime" value="${queryParam.endTime}">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							</div>
							</form>
			            
						</div>
					</div>
					<!-- /search field -->
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
						<div class="table-responsive">
							<table id="data-table" class="table">
								<thead>
									<tr>
										<th class="col-xs-4">商品信息</th>
										<th class="col-xs-1">会员信息</th>
										<th class="col-xs-1">评分</th>
										<th class="col-xs-4">内容</th>
										<th class="col-xs-1">状态</th>
										<th class="col-xs-1">操作</th>
									</tr>
								</thead>
								<tbody> 
								<c:forEach items="${pageInfo.list}" var="info">
									<tr>
										<td colspan="8"  style="border-right:0px;">
										<span class="text-muted">订单编号:&nbsp;${info.order_num }  </span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="text-muted">评价时间:</span>&nbsp;<span class="text-success text-bold"> <fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
												<td><img src="${imageDomain }${info.product_img}_300x300" width="80px" height="80px"></td>
												<td>${info.product_name }
													<br/>规格：${info.spec_content }
												</td>
												</tr>
											</table>
										</td>
										<td>${info.user_name}</td>  
										<td><span class="text-danger">
											<c:if test="${info.score==1 }">好评</c:if> 
											<c:if test="${info.score==2 }">中评</c:if>
											<c:if test="${info.score==3 }">中评</c:if>
											</span>
										</td>
										<td>${info.evaluate_desc}<br/>
											<c:forEach items="${info.imgArr}" var="img">
												<a href="${imageDomain}/${img}" target="_blank">
												<img src="${imageDomain }${img}_300x300" width="30px" height="30px">
												</a>
											</c:forEach>
											<br/>
											<c:if test="${info.state eq 0}">
												<a href="javascript:;" title="回复" onclick="oncheckReplys('${info.validate_id}','${info.validate_id_token}')">点击回复</a>
											</c:if>
											<c:if test="${info.state eq 1}">
												<span class="text-danger">商家回复：</span>${info.evaluate_reply}
											</c:if>
										</td>
										<td> 
											<c:if test="${info.is_show ne -1 }">显示</c:if> 
											<c:if test="${info.is_show eq -1 }">隐藏</c:if> 
										</td>
										<td>
											<c:if test="${info.is_show ne -1 }">
											<a href="javascript:;" onclick="oncheckShow('${info.validate_id}','${info.validate_id_token}',-1)"
												title="隐藏 " class="text-danger">隐藏</a>
											</c:if>
											<c:if test="${info.is_show eq -1 }">
											<a href="javascript:;" onclick="oncheckShow('${info.validate_id}','${info.validate_id_token}',0)"
												title="显示" class="text-danger">显示</a>
											</c:if>
										</td>
									</tr> 
								</c:forEach>	 		
										 
									
								</tbody>
							</table>
			
						</div>
						
						<div id="pager" class="panel-body">												
						</div>
					</div>
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			
<!-- Edit modal -->
<div id="reply_modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">评价回复</h2>
			</div>
			<div class="modal-body" style="padding-top:0px;margin-top:0px;">
				<form class="form-horizontal" name="updateForm" id="updateForm" 
					action="${pageContext.request.contextPath}/center/order/evaluateEdit" method="post" >
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">评价回复：</label>
							<div class="col-sm-8" style="padding-top: 10px;">
								<textarea rows="4" cols="10" name="evaluate_reply" placeholder="请填写评价回复" class="form-control validate[required]"
									data-errormessage-value-missing="请填写评价回复" ></textarea>
							</div>
						</div> 
					</fieldset>
					<div class="text-right">
						<input type="hidden" name="state" id="state" value="1">
						<input type="hidden" name="validate_id" id="validate_id" value="">
						<input type="hidden" name="validate_id_token" id="validate_id_token" value="">
						<button type="button" class="btn btn-danger" onclick="saveButton(this,'数据提交中，请稍后。。。')"  >确认</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>
<!-- /edit modal -->
			  
			
			<!-- 显示物流信息弹出框  -->
			<%@include file="../common/footer.jsp"%>
			<script>
			$(document).ready(function() {
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			    
				$('#updateForm').validationEngine({ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'formError-white',
					scroll: true,
					showOneMessage: true
				}); 
			});
			 
			function oncheckReplys(validate_id,validate_id_token){
				$('#validate_id').val(validate_id);
				$('#validate_id_token').val(validate_id_token);
				$('#reply_modal').modal('show');
			}
			
			function oncheckShow(validate_id,validate_id_token,status){
				var title='确定要隐藏该条评论吗？';
				if(status==0){
					title='确定要显示该条评论吗？';
				}
				var url="${pageContext.request.contextPath}/center/order/evaluateEdit?is_show="+status+"&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
				Mremove("get",url,title);
			}
			</script>