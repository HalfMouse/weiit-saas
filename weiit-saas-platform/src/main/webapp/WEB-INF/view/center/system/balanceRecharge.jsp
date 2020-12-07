<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>

<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height: 70px; padding-top: 20px;">
				<h4>
					<a href="javascript:history.back(-1)"><i class="icon-arrow-left52 position-left"></i></a> <span class="text-semibold"> 余额充值 </span>
				</h4>
			</div>
		</div>
		
		<div class="panel panel-flat" style="margin-top: -20px; border-top: 0px;">
			<div class="panel-body">
			
				<form class="form-horizontal" id="infoForm" action="${pageContext.request.contextPath}/center/manager/balancePrewOrder" method="post" >
					<fieldset class="content-group">
						<div class="form-group">
							<label class="control-label col-md-1 text-right">预存金额：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="package">
									<option value="1">3580+赠送2300</option>
									<option value="2">5880+赠送5500</option>
									<option value="3">19800+赠送21000</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-1 text-right"></label>
							<div class="col-md-2">
								<button class="btn bg-orange" type="button" onclick="saveButton()" id="save_btn">立即支付</button>
							</div>
						</div>
						
					</fieldset>

				</form>
				
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert">
						<span>&times;</span><span class="sr-only">关闭</span>
					</button>
					<span class="text-semibold">
						温馨提示:<br>
						1、我们走的是微信官方的微信支付通道进行充值，充值完成，会立马到账。<br>
						2、充值后的余额可以进行服务购买，不可退还。<br>
						3、如充值赠送数目有异议，可以联系客服人员,客服热线：18565660736</span>。<br><br>
					
					<span class="text-warning">注意：如想要更多优惠与福利赠送，请联系相关负责人，合作走签约模式进行。</span>
					
						
				</div>

				
			</div>

		</div>
	</div>
	<!-- /page header -->

</div>

<!-- /main content -->
<%@include file="../common/footer.jsp"%>
<script>
function saveButton(){
	$("#save_btn").attr("disabled", true);
	
	FullScreenShow("数据提交中，请稍后！");
	$("#infoForm").submit();
}
</script>
