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
			
				<form class="form-horizontal"  method="post" >
					<fieldset class="content-group">
						<div class="form-group">
							<label class="col-md-1 text-right">订单编号：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<span class="text-bold">${payOrderInfo.out_trade_no }</span>
								<input type="hidden" name="out_trade_no" id="out_trade_no" value="${payOrderInfo.out_trade_no }"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-1 text-right">支付金额：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<span class="text-success text-bold"><fmt:formatNumber type="number" value="${payOrderInfo.pay_price }" pattern="0.00" maxFractionDigits="2" /> </span>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-md-1 text-right"></label>
							<div class="col-md-3" style="width:220px;">
								<img src="${imageDomain }${payOrderInfo.weixin_qr_code }" height="200" width="200" class="ep-wxpay-qrcode">
								<div style="height:30px;line-height:30px;background-color:#00c800;font-size:12px;color:#fff;width:200px;text-align:center;margin-bottom:20px;">请打开手机微信，扫一扫完成支付</div> 
							</div>
							<div class="col-md-2">
								<img src="${pageContext.request.contextPath}/resource/images/ep_sys_wx_tip.jpg">
							</div>
						</div>
						<div class="form-group" id="showState" style="display:none;">
							<label class="col-md-1 text-right"></label>
							<div class="col-md-3">
								<a class="btn border-success text-success btn-flat btn-icon btn-rounded btn-sm"><i class="icon-checkmark3"></i></a>
								<span class="text-bold text-success">订单付款成功,请刷新当前页面.</span>
							</div>
						</div>
						
					</fieldset>

				</form>
				

				
			</div>

		</div>
	</div>
	<!-- /page header -->

</div>

<!-- /main content -->
<%@include file="../common/footer.jsp"%>
<script>
//启动定时器

var timeout = false; //启动及关闭按钮  
checkOrderState();
function checkOrderState()  
{  
  if(timeout) return;  
  $.ajax({
	    url:'${pageContext.request.contextPath}/center/manager/balanceRechargeCheck',
	    type:'POST',
	    data:{"out_trade_no":$("#out_trade_no").val()},
	    dataType:'json',
	    success:function(result){
	    	console.log(result)
	    	if(result.code==0){
	    		if(result.data.state==1){
	    			$("#showState").show();
	    			timeout=true;
	    		}else{
	    			$("#showState").hide();
	    		} 
	    	}else{
	    		$("#showState").hide();
	    	}
	    },
	    error:function(xhr,textStatus){
	    }
  });
  setTimeout(checkOrderState,2000); //time是指本身,延时递归调用自己,100为间隔调用时间,单位毫秒  
}  


</script>
