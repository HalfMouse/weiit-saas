<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

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
								<li class="active"><a href="orderSet"><i class="icon-gear"></i>订单设置</a></li>
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
									<div class="profile">
										<form class="form-horizontal" id="infoFrom" name="infoFrom" action="${pageContext.request.contextPath}/center/order/orderSetSave" method="post" >
											<fieldset class="content-group">
												<legend class="text-bold"><h4>订单设置</h4></legend>

												<div class="form-group">
													<label class="control-label col-md-2 text-bold">下单成功通知:</label>
													<div class="col-md-6 text-bold"><input type="hidden" value="${queryParam.MESSAGE_ID}" name="MESSAGE_ID">
														<label class="radio-inline"> <input type="radio" class="styled" name="MESSAGE" ${(queryParam.MESSAGE ne 0)?"checked":""} value="1"> 短信提醒商家</label>
														<label class="radio-inline"> <input type="radio" class="styled" name="MESSAGE" ${(queryParam.MESSAGE eq 0)?"checked":""} value="0"> 不提醒商家</label>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2 text-bold">维权订单通知:</label>
													<div class="col-md-6 text-bold"><input type="hidden" value="${queryParam.REFUND_ID}" name="REFUND_ID">
														<label class="radio-inline"> <input type="radio" class="styled" name="REFUND" ${(queryParam.REFUND ne 0)?"checked":""} value="1"> 短信提醒商家</label>
														<label class="radio-inline"> <input type="radio" class="styled" name="REFUND" ${(queryParam.REFUND eq 0)?"checked":""} value="0"> 不提醒商家</label>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2 text-bold">订单过期时间:</label>
													<div class="col-md-8 text-bold">
														<div class="input-group col-md-3"><input type="hidden" value="${queryParam.EXPIRATIONTIME_ID}" name="EXPIRATIONTIME_ID">
															<input type="text" name="EXPIRATIONTIME" class="form-control validate[required,custom[integer]]" value="${queryParam.EXPIRATIONTIME}"
																data-errormessage-value-missing="订单过期时间不能为空" data-errormessage-custom-error="必须是整数" >
															<div class="input-group-addon">分钟</div>
														 </div>
														 <span class="text-muted">注：为保证购物通畅，过期时间不得小于30分钟。</span>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-2 text-bold">自动收货时间:</label>
													<div class="col-md-8 text-bold">
														<div class="input-group col-md-3"><input type="hidden" value="${queryParam.ORDERTIME_ID}" name="ORDERTIME_ID">
															<input type="text" name="ORDERTIME" class="form-control validate[required,custom[integer]]" value="${queryParam.ORDERTIME}"
																data-errormessage-value-missing="自动收货时间不能为空" data-errormessage-custom-error="必须是整数">
															<div class="input-group-addon">天</div>
														 </div>
														 <span class="text-muted">注：自动收货时间，最低7天</span>
													</div>
												</div>
											</fieldset>
											<div class="text-center">
												<button type="button" onclick="window.location.reload()" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button> &nbsp;&nbsp;&nbsp;&nbsp;
												<button type="submit" class="btn btn-primary">更新<i class="icon-arrow-right14 position-right"></i></button>
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

<script>
$(document).ready(function() {
	$('#infoFrom').validationEngine({
		promptPosition: 'bottomRight',
		addPromptClass: 'formError-white',
		scroll: true,
		showOneMessage: true
	});
});
 </script>