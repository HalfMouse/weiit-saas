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
								<li class="active"><a href="starOrderList"><i class="icon-flag7"></i>加星订单</a></li>
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
							<h4><i class="icon-home2 position-left"></i>加星订单</h4>
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
					<!-- Search field -->
					<form class="form-horizontal" name="searchform" id="searchform" action=""  method="post">
			         		
					<div class="panel panel-flat"  >
						<div class="panel-body">
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
										 <select class="bootstrap-select" data-width="100%" name="state" id="state">
											<option value="" <c:if test="${queryParam.state=='' }">selected="selected"</c:if>>--全部--</option>
											<option value="0" <c:if test="${queryParam.state=='0' }">selected="selected"</c:if>>待付款</option>
											<option value="1" <c:if test="${queryParam.state=='1' }">selected="selected"</c:if>>待发货</option>
											<option value="2" <c:if test="${queryParam.state=='2' }">selected="selected"</c:if>>待收货</option>
											<option value="4" <c:if test="${queryParam.state=='4' }">selected="selected"</c:if>>交易完成</option>
											<option value="-1" <c:if test="${queryParam.state=='-1' }">selected="selected"</c:if>>已取消</option>
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
											<input type="text" class="form-control pickadate-translated" name="startTime" id="startTime" onchange="judgeDate()" value="${queryParam.startTime}">
											<span class="input-group-addon">--</span> 
											<input type="text" class="form-control pickadate-translated" name="endTime" id="endTime" onchange="judgeDate()" value="${queryParam.endTime}">
										</div>
									</div>
								</div>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							</div>
			            
						</div>
					</div>
					<!-- /search field -->
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
						<div class="table-responsive">
							<table id="data-table" class="table">
								<thead>
									<tr>
										<th class="col-xs-3">商品详情</th>
										<th class="col-xs-1">销售价</th> 
										<th class="col-xs-1">数量</th> 
										<th class="col-xs-1">订单总额</th>
										<th class="col-xs-1">状态/操作</th>
										<th class="col-xs-1">用户账户</th>
										<th class="col-xs-3">用户收货信息</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageInfo.list}" var="info">
									<tr>
										<td colspan="6"  style="border-right:0px;">
										<span class="text-muted">订单编号:&nbsp;${info.order_num }  </span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="text-muted">下单时间:</span>&nbsp;<span class="text-success text-bold"> <fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="text-muted">更新时间:</span>&nbsp;<span class="text-success text-bold"><fmt:formatDate value="${info.update_time }" pattern="yyyy-MM-dd HH:mm:ss"/> </span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span class="text-muted">共${fn:length(info.ordersDetailList)}件商品</span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
										<td style="padding:0,20px;margin:0px;text-align:right;border-left:0px;">
											<c:if test="${info.star_state eq 1}">
												<a href="javascrip:;" onclick="WIStar(${info.validate_id},'${info.validate_id_token}','${info.order_num }',0)" 
													class="text-blue text-bold" title="取消加星">取消加星</a>&nbsp;-&nbsp;
											</c:if>
											<c:if test="${info.star_state ne 1}">
												<a href="javascrip:;" onclick="WIStar(${info.validate_id},'${info.validate_id_token}','${info.order_num }',1)" 
													class="text-blue text-bold" title="加星">加星</a>&nbsp;-&nbsp;
											</c:if>
											<a href="${pageContext.request.contextPath}/center/order/orderDetail?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" class="text-blue text-bold">查看详情</a>
										</td>
									</tr>
									<c:forEach items="${info.ordersDetailList}" var="detail" varStatus="i">
									<tr>
										<td>
											<table>
												<tr>
												<td><img src="${imageDomain }${detail.product_img}_300x300" width="80px" height="80px"></td>
												<td>${detail.product_name }
													<br/>规格：${detail.spec_content }
												</td>
												</tr>
											</table>
										</td>
										<td>￥${detail.sale_price }</td> 
										<td>${detail.count }</td> 
										<c:if test="${i.index == 0 }">
											<td rowspan="${fn:length(info.ordersDetailList)}">
												${info.total_price}<br/>
												(含运费${info.express_money})
											</td>
											<td rowspan="${fn:length(info.ordersDetailList)}">
												<c:if test="${info.state==0 }">待付款</c:if> 
												<c:if test="${info.state==1 }">待发货</c:if>
												<c:if test="${info.state==2 }">待收货</c:if> 
												<c:if test="${info.state==4 }">交易完成</c:if>
												<c:if test="${info.state==-1 }">交易取消</c:if>
												<c:if test="${!empty info.express_num }">
													<br><br><a href="javascript:;" title="点击查看物流详细信息" onclick="oncheckExpress('${info.express_num}','${info.express_code}')">查看物流</a>
												</c:if>
												<c:if test="${info.state==0 }"><br><br>
												    <a href="javascrip:;" class="btn btn-sm btn-danger" style="height: 22px;padding-top: 0px;" 
												    	onclick="toUpdateStatus(${info.validate_id},'${info.validate_id_token}','${info.order_num }',-1)">关闭订单</a>
												</c:if>
												<c:if test="${info.state==1 }">
												    <br><br>
												    <a href="#edit_modal" data-toggle="modal" class="btn btn-sm btn-info" style="height: 22px;padding-top: 0px;" 
												    	onclick="shipOrder('${info.validate_id}','${info.validate_id_token}','${info.order_num }','${info.user_id }')">发货</a>
												</c:if>
											</td>
											<td rowspan="${fn:length(info.ordersDetailList)}">
												${info.user_name }
											</td>
										</c:if> 
										<td>收货人：${info.consignee }<br>
										手机号：${info.phone }<br>
										收货地址：${info.address }<br>
										</td>
									</tr>
									</c:forEach>
								</c:forEach>	 
								</tbody>
							</table>
			
						</div>
						
						<div id="pager" class="panel-body">												
						</div>
					</div>
					
					</form>
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			
			<!-- Edit modal -->
			<div id="edit_modal" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h5 class="modal-title">发货</h5>
						</div>
						<div class="modal-body">
							<form class="form-horizontal form-validate-jquery" id="shipForm" action="${pageContext.request.contextPath}/center/order/shipOrder" method="post">
								<fieldset class="content-group">				
									 <div class="form-group">
										<label class="control-label col-md-3"><font color="red"> * </font>物流公司 </label>
										<div class="col-md-7">
											<select  class="bootstrap-select" data-live-search="true" data-width="100%" name="express_template_id" required="required">												
												<c:if test="${fn:length(expressList) == 0}">
						                       		<option value="">请选择</option>
						                        </c:if>
						                     	<c:forEach items="${expressList}" var="info" varStatus="ind">
						                         	<option value="${info.id}">${info.express_name}</option>
						                    	</c:forEach>													
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-3"><font color="red"> * </font>物流单号 </label>
										<div class="col-md-7">
											<input type="text" class="form-control input-rounded" name="express_num" id="express_num" required="required">
										</div>
									</div>
								</fieldset>
								<div class="text-right">
									<input type="hidden" name="express_type" value="0"/>
									<input type="hidden" name="validate_id"  id="validate_id" value="0"/>
									<input type="hidden" name="validate_id_token"  id="validate_id_token" value="0"/>
									<input type="hidden" name="user_id"  id="user_id" value="0"/>
									<input type="hidden" name="order_num"  id="order_num" value="0"/>
									<button type="reset" class="btn btn-default" id="resetButton">重置 <i class="icon-reload-alt position-right"></i></button>
									<button type="button" class="btn btn-primary" onclick="ship();">发货 <i class="icon-arrow-right14 position-right"></i></button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- /edit modal -->
	  
			
			<!-- 显示物流信息弹出框  -->
			<%@include file="../publics/express.jsp" %>
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
			
			//关闭订单
			function toUpdateStatus(validate_id,validate_id_token,order_num,state){
				MConfirm('确定关闭订单编号<label style="color: red;">'+order_num+'</label> 的订单吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/order/orderCancel?stateOld=${queryParam.state}&state="+state+"&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
					}
				});	
			}
			
			function WIStar(validate_id,validate_id_token,order_num,status){
				var title='确定要对订单 <label style="color: red;">'+order_num+'</label> 加星吗？';
				if(status==0){
					title='确定要取消订单 <label style="color: red;">'+order_num+'</label> 的加星吗？';
				}
				var url="${pageContext.request.contextPath}/center/order/starOrder?state=${queryParam.state}&star_state="+status+"&validate_id="+validate_id+"&validate_id_token="+validate_id_token;
				Mremove("get",url,title);
			}
			
			 
			function ship(){
				if($("#express_template_id").val()==""){
					 alert("请选择物流公司！");
					 return;
				 }
				 if($("#express_num").val()==""){
					 alert("请填写物流运单号！");
					 return;
				 }
				 $("#shipForm").submit();
			}
			
			function shipOrder(orderId,validate_id_token,orderNum,userId){
				 $("#validate_id").val(orderId);
				 $("#validate_id_token").val(validate_id_token);
				 $("#order_num").val(orderNum);
				 $("#user_id").val(userId);
			}

			</script>