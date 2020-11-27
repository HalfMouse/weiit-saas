<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="../common/header.jsp" %>
<link href="${pageContext.request.contextPath}/resource/css/style.min.css" rel="stylesheet" />
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
								<li class="active"><a href="refundOrderList"><i class="icon-warning"></i>维权订单</a></li>
								<li><a href="starOrderList"><i class="icon-flag7"></i>加星订单</a></li>
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
			<div class="breadcrumb-line"> 
				<ul class="breadcrumb">
					<li><a href="#"><i class="icon-home2 position-left"></i> 订单管理</a></li>
					<li class="active">订单详情</li>
				</ul>
			</div>
		</div>

	<!-- begin #content -->
	<div id="content" class="content">
		<!-- Invoice template -->
		<div class="panel panel-white">
			<div class="panel-heading">
				<h6 class="panel-title">退款详情</h6>
				<div class="heading-elements">
					<span class="btn btn-default btn-xs heading-btn">
						<a href="javascript:;" onclick="window.print()">
						<i class="fa fa-print m-r-5"></i> 打印</a>
					</span>
				</div>
			</div> 
			
			
			<div class="panel-body no-padding-bottom"> 
				
				 <ul class="nav nav-pills col-sm-12  alert-primary">
				 	<li class="${(order.state eq 0)?'active':''} col-sm-3 text-center">
						<c:if test="${order.state eq 0}"><a href="javascript:;" ></c:if>
						1.买家申请<c:if test="${order.refund_type eq 1}">仅退款</c:if><c:if test="${order.refund_type eq 2}">退货退款</c:if>
						<i class="icon-arrow-right15 position-right"></i>
						<c:if test="${order.state eq 0}"></a></c:if>
					</li>
					<c:if test="${order.refund_type eq 1}">
						<li class="${(order.state eq 3 or order.state eq 4 or order.state eq -1)?'active':''} col-sm-3 text-center">
							<c:if test="${(order.state eq 3 or order.state eq 4 or order.state eq -1)}"><a href="javascript:;" ></c:if>
								2.退换完毕
								<i class=" icon-check position-right"></i>
							<c:if test="${(order.state eq 3 or order.state eq 4 or order.state eq -1)}"></a></c:if>
						</li>
					</c:if>
					<c:if test="${order.refund_type eq 2}">
						<li class="${(order.state eq 1)?'active':''} col-sm-3 text-center">
							<c:if test="${order.state eq 1}"><a href="javascript:;" ></c:if>
							2.等待买家退货
								<i class="icon-arrow-right15 position-right"></i> 
							<c:if test="${order.state eq 1}"></a></c:if>
						</li>
						<li class="${(order.state eq 2)?'active':''} col-sm-3 text-center">
							<c:if test="${order.state eq 2}"><a href="javascript:;" ></c:if>
								3.商家确认退款
								<i class="icon-arrow-right15 position-right"></i>
							<c:if test="${order.state eq 2}"></a></c:if>
						</li>
						<li class="${(order.state eq 3 or order.state eq 4 or order.state eq -1)?'active':''} col-sm-3 text-center">
							<c:if test="${(order.state eq 3 or order.state eq 4 or order.state eq -1)}"><a href="javascript:;" ></c:if>
								4.退换完毕
								<i class=" icon-check position-right"></i>
							<c:if test="${(order.state eq 3 or order.state eq 4 or order.state eq -1)}"></a></c:if>
						</li>	
					</c:if>
				</ul>
			
				<div class="row">
					<table id="data-table" class="col-md-12" >
						<tr>
							<td style="border:1px solid #CCCCCC;padding-left:10px;" class="col-md-5">
								<h5 class="text-bold" >维权信息</h5>
								<ul class="list-condensed list-unstyled">
									<li>
										<table>
											<tr>
											<td><img src="${imageDomain }${order.product_img}_300x300" width="80px" height="80px"></td>
											<td><div style="margin-bottom:5px;">${order.product_name }</div>
												<span class="text-muted">规格:${order.spec_content }</span>
											</td>
											</tr>
										</table>  
									</li>
									<li>订单编号：<a href="${pageContext.request.contextPath}/center/order/orderDetail?validate_id=${infoMap.validate_id}&validate_id_token=${infoMap.validate_id_token}" class="text-blue text-bold">${infoMap.order_num }</a></li>
									<li>成交时间：<fmt:formatDate value="${infoMap.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
									<li>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：￥${order.sale_price}*${order.count}(数量)</li> 
									<li>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;费：${infoMap.express_money}</li>
									<li>商品总价：￥${order.pay_price}</li>
									<li>发货物流信息：<c:if test="${empty infoMap.express_num}">无物流信息</c:if>
										<c:if test="${!empty infoMap.express_num}"><a href="javascript:;" title="点击查看物流" class="text-blue text-bold"
											onclick="oncheckExpress('${infoMap.express_num}','${infoMap.express_code}')">${infoMap.express_num}</a></c:if>
									</li>
									<li><hr style= "border:1px dotted #CCCCCC;margin:0px;padding:0px;" ></li>
									
									<li>退款编号：${order.refund_num }</li>
									<li>退款申请时间：<fmt:formatDate value="${order.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
									<li>退款金额：￥${order.refund_money}</li>
									<li>退款要求：<c:if test="${order.refund_type eq 1}">仅退款</c:if><c:if test="${order.refund_type eq 2}">退货退款</c:if></li>
									<li>原&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;因：${order.refund_reason}</li>
									<li>说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明：${order.remark}</li>
									<li>
									<c:if test="${ !empty order.imgArr }">
									<c:forEach items="${order.imgArr}" var="img">
										<a href="${imageDomain}/${img}" target="_blank">
											<img src="${imageDomain}/${img}?100" width="60px" height="60px">
										</a>
									</c:forEach>
									</c:if>
									</li>
								</ul><br/><br/>
							</td>
							<td style="border:1px solid #CCCCCC;padding-left:10px;padding-top:10px;" valign="top">
								<c:if test="${order.state eq 3}">
									<h5 class="text-bold" ><i class="icon-star-half position-left"></i>退款成功</h5>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退款成功时间：：<fmt:formatDate value="${order.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
									<br/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退款总金额：<span class="text-danger">￥${order.refund_money}</span>
									<hr style= "border:1px dotted #CCCCCC;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									退货物流信息：<c:if test="${empty order.express_num}"><span class="text-danger">未退货</span></c:if>
										<c:if test="${!empty order.express_num}"><a href="javascript:;" title="点击查看物流" class="text-blue text-bold"
											onclick="oncheckExpress('${order.express_num}','${order.express_code}')">${order.express_num}</a></c:if>
									<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								<c:if test="${order.state eq -1}">
									<h5 class="text-bold" ><i class="icon-star-half position-left"></i>退款关闭</h5>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关闭时间：&nbsp;&nbsp;<fmt:formatDate value="${order.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/><br/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div class="form-group">
										<label class="col-sm-2 control-label text-right">拒绝理由：</label>
										<div class="col-sm-9" style="padding-left:0px;">
											<textarea cols="50" rows="10" style="border-style:none;"  readonly="readonly">${order.refusal_reason}</textarea>
										</div>
									</div>
								</c:if>
								<c:if test="${order.state eq 4}">
									<h5 class="text-bold" ><i class="icon-star-half position-left"></i>卖家已驳回</h5>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;驳回时间：&nbsp;&nbsp;<fmt:formatDate value="${order.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/><br/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div class="form-group">
										<label class="col-sm-2 control-label text-right">驳回理由：</label>
										<div class="col-sm-9" style="padding-left:0px;">
											<textarea cols="50" rows="10" style="border-style:none;"  readonly="readonly">${order.refusal_reason}</textarea>
										</div>
									</div>
								</c:if>
								<c:if test="${order.state eq 0}">
									<h5 class="text-bold" ><i class="icon-star-half position-left"></i>商家处理退款申请:</h5>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收到买家<c:if test="${order.refund_type eq 1}">仅退款</c:if><c:if test="${order.refund_type eq 2}">退货退款</c:if></li>申请，请尽快处理
									<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								<c:if test="${order.state eq 1}">
									<h5 class="text-bold" ><i class="icon-star-half position-left"></i>等待买家退货:</h5>
									<hr style= "border:1px dotted #CCCCCC;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									退货物流信息：<c:if test="${empty order.express_num}"><span class="text-danger">未退货</span></c:if>
										<c:if test="${!empty order.express_num}"><a href="javascript:;" title="点击查看物流" class="text-blue text-bold"
											onclick="oncheckExpress('${order.express_num}','${order.express_code}')">${order.express_num}</a></c:if>
									<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								<c:if test="${order.state eq 2}">
									<h5 class="text-bold" ><i class="icon-star-half position-left"></i>商家确认退款:</h5>
									<hr style= "border:1px dotted #CCCCCC;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									退货物流信息：<c:if test="${empty order.express_num}"><span class="text-danger">未退货</span></c:if>
										<c:if test="${!empty order.express_num}"><a href="javascript:;" title="点击查看物流" class="text-blue text-bold"
											onclick="oncheckExpress('${order.express_num}','${order.express_code}')">${order.express_num}</a></c:if>
									<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								<c:if test="${order.refund_type eq 1 and order.state eq 0}">
									<button type="button"  data-toggle="modal" data-target="#authOK_modal" class="btn btn-sm btn-primary">同意买家退款申请<i class="icon-checkmark3 position-right"></i></button>
								</c:if>
								<c:if test="${order.refund_type eq 2}">
									<c:if test="${order.state eq 0}">
										<button type="button" class="btn btn-sm btn-primary" onclick="onAuthState()">同意买家退货申请<i class="icon-checkmark3 position-right"></i></button>
									</c:if>
									<c:if test="${order.state eq 2}">
										<button type="button"  data-toggle="modal" data-target="#authOK_modal" class="btn btn-sm btn-primary">确认退货退款完成<i class="icon-checkmark3 position-right"></i></button>
									</c:if>
								</c:if>
								<c:if test="${order.state eq 0 or order.state eq 2}">
									<button type="button"  data-toggle="modal" data-target="#authNo_modal" class="btn btn-sm btn-default">拒绝退款<i class="icon-cross3 position-right"></i></button>
								</c:if>
								
								<a href="javascript:history.back(-1)" id="qua1" class="btn btn-sm btn-default" >返回</a>	
							</td>
						</tr>
					
					</table>
				
					  
					
				</div>
			</div>

			 
		</div>
		<!-- /invoice template -->

	</div>
	<!-- end #content --> 
	</div>
	<!-- end Main content -->

<!-- Edit modal -->
<div id="authOK_modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">维权处理</h2>
			</div>
			<div class="modal-body" style="padding-top:0px;margin-top:0px;">
				<form class="form-horizontal form-validate-jquery" name="okForm" id="okForm" action="" method="post" >
					<fieldset class="content-group">
						<div class="form-group">
							<ul class="nav nav-pills col-sm-12  alert-danger">
								<li class="col-sm-12 text-center" style="padding-top:10px;padding-bottom:10px;">
									提示：若需要买家退货，请您确认收货后再同意买家退款申请， <br/>
									您确认后，退款将退回至买家付款账户；
								</li>
							</ul>
						</div> 
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">处理方式：</label>
							<div class="col-sm-5" style="padding-top:10px; ">
								<c:if test="${order.refund_type eq 1}">仅退款</c:if>
								<c:if test="${order.refund_type eq 2}">退货退款</c:if>
							</div>
						</div> 
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">退款金额：</label>
							<div class="col-sm-5" style="padding-top:10px; ;">
								<span class="text-danger">￥${order.refund_money}</span>
							</div>
						</div>
					</fieldset>
					<div class="text-right">
						<button type="button" class="btn btn-primary" onclick="onAuthOk()">同意</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>
<!-- /edit modal -->

<!-- Edit modal -->
<div id="authNo_modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">维权处理</h2>
			</div>
			<div class="modal-body" style="padding-top:0px;margin-top:0px;">
				<form class="form-horizontal form-validate-jquery" name="updateForm" id="updateForm" 
					action="${pageContext.request.contextPath}/center/order/refundOrderCheck?state=4&validate_id=${order.validate_id}&validate_id_token=${order.validate_id_token}" method="post" >
					<fieldset class="content-group">
						<div class="form-group" style="padding-top:20px;">
							<label class="col-sm-2 control-label text-right">处理方式：</label>
							<div class="col-sm-5" style="padding-top:10px;">
								<c:if test="${order.refund_type eq 1}">仅退款</c:if>
								<c:if test="${order.refund_type eq 2}">退货退款</c:if>
							</div>
						</div> 
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">退款金额：</label>
							<div class="col-sm-5" style="padding-top:10px;">
								<span class="text-danger">￥${order.refund_money}</span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label text-right">拒绝理由：</label>
							<div class="col-sm-8">
								<textarea rows="5" cols="10" name="refusal_reason" placeholder="请填写你的拒绝理由" class="form-control" required="required"></textarea>
							</div>
						</div> 
					</fieldset>
					<div class="text-right">
						<button type="button" class="btn btn-danger" onclick="onAuthNo()"  >拒绝退款</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">取消</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>
<!-- /edit modal -->

<!-- 显示物流信息弹出框  -->
<%@include file="../publics/express.jsp" %>	
<%@include file="../common/footer.jsp" %> 

<script>
function onAuthState(){
	MConfirm('确认要同意买家退货申请吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/order/refundOrderCheck?state=1&validate_id=${order.validate_id}&validate_id_token=${order.validate_id_token}";
		}
	});
}

function onAuthOk(){
	window.location="${pageContext.request.contextPath}/center/order/refundOrderCheck?state=3&validate_id=${order.validate_id}&validate_id_token=${order.validate_id_token}";
}

function onAuthNo(){ 
	if(!$("#updateForm").validate().form()){
		return false;
	}
	$("#updateForm").submit();
}
 
</script>