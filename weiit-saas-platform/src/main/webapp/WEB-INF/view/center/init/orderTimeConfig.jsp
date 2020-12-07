<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>

<!-- Main content -->
<div class="content-wrapper">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height: 70px; padding-top: 20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold"> 收费服务项目 </span>
				</h4>
			</div>
		</div>
	</div>
	<!-- /page header -->

	<!-- Content area -->
	<div class="content">

		<!-- Tabs -->
		<ul class="nav  nav-tabs">
			<li><a href="${pageContext.request.contextPath}/center/service/list" style="border-left:0px;border-top:0px;">收费服务项目</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/service/orderTimeConfig">订购时长配置</a></li>
			<li><a href="${pageContext.request.contextPath}/center/service/versionList">版本收费配置</a></li>
		</ul>
		<!-- /tabs -->

		<!-- 表单验证开始 -->
		<div class="panel panel-flat" style="margin-top: -20px; border-top: 0px;">
			<div class="panel-body">
				<div class="alert alert-primary no-border">
					<button type="button" class="close" data-dismiss="alert">
						<span>&times;</span><span class="sr-only">关闭</span>
					</button>
					<span class="text-semibold">
						订购时长配置时请注意，现订购时长主要分为(7天免费使用、1个月折扣、3个月折扣、6个月折扣、12个月折扣、24个月折扣、36个月折扣)<br>
					<br>订购时长后，需要开启才会生效，
					</span> <spanclass="text-semibold">开启后的折扣设置在商家缴费时会出现选择项</span> 
						<span class="text-warning">不能频繁改动套订购时长设置</span>。 
				</div>

				<form class="form-horizontal" id="configForm" action="${pageContext.request.contextPath}/center/service/orderTimeConfigEdit" method="post" >
					<fieldset class="content-group">
						<div class="form-group">
							<label class="control-label col-md-2 text-right">7天试用：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="7_day_order_time_discount">
									<option value="0.0" ${day7.order_time_discount=='0.0'?'selected':'' }>免费</option>
									<option value="3.0" ${day7.order_time_discount=='3.0'?'selected':'' }>3折</option>
									<option value="4.0" ${day7.order_time_discount=='4.0'?'selected':'' }>4折</option>
									<option value="5.0" ${day7.order_time_discount=='5.0'?'selected':'' }>5折</option>
									<option value="6.0" ${day7.order_time_discount=='6.0'?'selected':'' }>6折</option>
									<option value="6.5" ${day7.order_time_discount=='6.5'?'selected':'' }>6.5折</option>
									<option value="7.0" ${day7.order_time_discount=='7.0'?'selected':'' }>7折</option>
									<option value="7.5" ${day7.order_time_discount=='7.5'?'selected':'' }>7.5折</option>
									<option value="8.0" ${day7.order_time_discount=='8.0'?'selected':'' }>8折</option>
									<option value="8.5" ${day7.order_time_discount=='8.5'?'selected':'' }>8.5折</option>
									<option value="9.0" ${day7.order_time_discount=='9.0'?'selected':'' }>9折</option>
									<option value="9.5" ${day7.order_time_discount=='9.5'?'selected':'' }>9.5折</option>
									<option value="10" ${day7.order_time_discount=='10'?'selected':'' }>不打折</option>
								</select>
								<label class="radio-inline"> <input type="radio" class="styled" name="7_day_order_time_state"  value="1" ${day7.state==1?'checked':'' }> 开启</label>
								<label class="radio-inline"> <input type="radio" class="styled" name="7_day_order_time_state" value="0" ${day7.state==0?'checked':'' }> 关闭</label>
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-md-2 text-right">1个月：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="1_month_order_time_discount">
									<option value="0.0" ${month1.order_time_discount=='0.0'?'selected':'' }>免费</option>
									<option value="3.0" ${month1.order_time_discount=='3.0'?'selected':'' }>3折</option>
									<option value="4.0" ${month1.order_time_discount=='4.0'?'selected':'' }>4折</option>
									<option value="5.0" ${month1.order_time_discount=='5.0'?'selected':'' }>5折</option>
									<option value="6.0" ${month1.order_time_discount=='6.0'?'selected':'' }>6折</option>
									<option value="6.5" ${month1.order_time_discount=='6.5'?'selected':'' }>6.5折</option>
									<option value="7.0" ${month1.order_time_discount=='7.0'?'selected':'' }>7折</option>
									<option value="7.5" ${month1.order_time_discount=='7.5'?'selected':'' }>7.5折</option>
									<option value="8.0" ${month1.order_time_discount=='8.0'?'selected':'' }>8折</option>
									<option value="8.5" ${month1.order_time_discount=='8.5'?'selected':'' }>8.5折</option>
									<option value="9.0" ${month1.order_time_discount=='9.0'?'selected':'' }>9折</option>
									<option value="9.5" ${month1.order_time_discount=='9.5'?'selected':'' }>9.5折</option>
									<option value="10" ${month1.order_time_discount=='10'?'selected':'' }>不打折</option>
								</select>
								<label class="radio-inline"> <input type="radio" class="styled" name="1_month_order_time_state"  value="1" ${month1.state==1?'checked':'' }> 开启</label>
								<label class="radio-inline"> <input type="radio" class="styled" name="1_month_order_time_state" value="0"  ${month1.state==0?'checked':'' }> 关闭</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2 text-right">6个月：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="6_month_order_time_discount">
									<option value="0.0" ${month6.order_time_discount=='0.0'?'selected':'' }>免费</option>
									<option value="3.0" ${month6.order_time_discount=='3.0'?'selected':'' }>3折</option>
									<option value="4.0" ${month6.order_time_discount=='4.0'?'selected':'' }>4折</option>
									<option value="5.0" ${month6.order_time_discount=='5.0'?'selected':'' }>5折</option>
									<option value="6.0" ${month6.order_time_discount=='6.0'?'selected':'' }>6折</option>
									<option value="6.5" ${month6.order_time_discount=='6.5'?'selected':'' }>6.5折</option>
									<option value="7.0" ${month6.order_time_discount=='7.0'?'selected':'' }>7折</option>
									<option value="7.5" ${month6.order_time_discount=='7.5'?'selected':'' }>7.5折</option>
									<option value="8.0" ${month6.order_time_discount=='8.0'?'selected':'' }>8折</option>
									<option value="8.5" ${month6.order_time_discount=='8.5'?'selected':'' }>8.5折</option>
									<option value="9.0" ${month6.order_time_discount=='9.0'?'selected':'' }>9折</option>
									<option value="9.5" ${month6.order_time_discount=='9.5'?'selected':'' }>9.5折</option>
									<option value="10" ${month6.order_time_discount=='10'?'selected':'' }>不打折</option>
								</select>
								<label class="radio-inline"> <input type="radio" class="styled" name="6_month_order_time_state"  value="1" ${month6.state==1?'checked':'' }> 开启</label>
								<label class="radio-inline"> <input type="radio" class="styled" name="6_month_order_time_state" value="0"  ${month6.state==0?'checked':'' }> 关闭</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2 text-right">12个月：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="12_month_order_time_discount">
									<option value="0.0" ${month12.order_time_discount=='0.0'?'selected':'' }>免费</option>
									<option value="3.0" ${month12.order_time_discount=='3.0'?'selected':'' }>3折</option>
									<option value="4.0" ${month12.order_time_discount=='4.0'?'selected':'' }>4折</option>
									<option value="5.0" ${month12.order_time_discount=='5.0'?'selected':'' }>5折</option>
									<option value="6.0" ${month12.order_time_discount=='6.0'?'selected':'' }>6折</option>
									<option value="6.5" ${month12.order_time_discount=='6.5'?'selected':'' }>6.5折</option>
									<option value="7.0" ${month12.order_time_discount=='7.0'?'selected':'' }>7折</option>
									<option value="7.5" ${month12.order_time_discount=='7.5'?'selected':'' }>7.5折</option>
									<option value="8.0" ${month12.order_time_discount=='8.0'?'selected':'' }>8折</option>
									<option value="8.5" ${month12.order_time_discount=='8.5'?'selected':'' }>8.5折</option>
									<option value="9.0" ${month12.order_time_discount=='9.0'?'selected':'' }>9折</option>
									<option value="9.5" ${month12.order_time_discount=='9.5'?'selected':'' }>9.5折</option>
									<option value="10" ${month12.order_time_discount=='10'?'selected':'' }>不打折</option>
								</select>
								<label class="radio-inline"> <input type="radio" class="styled" name="12_month_order_time_state"  value="1" ${month12.state==1?'checked':'' }> 开启</label>
								<label class="radio-inline"> <input type="radio" class="styled" name="12_month_order_time_state" value="0"  ${month12.state==0?'checked':'' }> 关闭</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2 text-right">24个月：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="24_month_order_time_discount">
									<option value="0.0" ${month24.order_time_discount=='0.0'?'selected':'' }>免费</option>
									<option value="3.0" ${month24.order_time_discount=='3.0'?'selected':'' }>3折</option>
									<option value="4.0" ${month24.order_time_discount=='4.0'?'selected':'' }>4折</option>
									<option value="5.0" ${month24.order_time_discount=='5.0'?'selected':'' }>5折</option>
									<option value="6.0" ${month24.order_time_discount=='6.0'?'selected':'' }>6折</option>
									<option value="6.5" ${month24.order_time_discount=='6.5'?'selected':'' }>6.5折</option>
									<option value="7.0" ${month24.order_time_discount=='7.0'?'selected':'' }>7折</option>
									<option value="7.5" ${month24.order_time_discount=='7.5'?'selected':'' }>7.5折</option>
									<option value="8.0" ${month24.order_time_discount=='8.0'?'selected':'' }>8折</option>
									<option value="8.5" ${month24.order_time_discount=='8.5'?'selected':'' }>8.5折</option>
									<option value="9.0" ${month24.order_time_discount=='9.0'?'selected':'' }>9折</option>
									<option value="9.5" ${month24.order_time_discount=='9.5'?'selected':'' }>9.5折</option>
									<option value="10" ${month24.order_time_discount=='10'?'selected':'' }>不打折</option>
								</select>
								<label class="radio-inline"> <input type="radio" class="styled" name="24_month_order_time_state"  value="1" ${month24.state==1?'checked':'' }> 开启</label>
								<label class="radio-inline"> <input type="radio" class="styled" name="24_month_order_time_state" value="0"  ${month24.state==0?'checked':'' }> 关闭</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2 text-right">36个月：<span
								class="text-danger">*</span></label>
							<div class="col-md-2">
								<select class="select" name="36_month_order_time_discount">
									<option value="0.0" ${month36.order_time_discount=='0.0'?'selected':'' }>免费</option>
									<option value="3.0" ${month36.order_time_discount=='3.0'?'selected':'' }>3折</option>
									<option value="4.0" ${month36.order_time_discount=='4.0'?'selected':'' }>4折</option>
									<option value="5.0" ${month36.order_time_discount=='5.0'?'selected':'' }>5折</option>
									<option value="6.0" ${month36.order_time_discount=='6.0'?'selected':'' }>6折</option>
									<option value="6.5" ${month36.order_time_discount=='6.5'?'selected':'' }>6.5折</option>
									<option value="7.0" ${month36.order_time_discount=='7.0'?'selected':'' }>7折</option>
									<option value="7.5" ${month36.order_time_discount=='7.5'?'selected':'' }>7.5折</option>
									<option value="8.0" ${month36.order_time_discount=='8.0'?'selected':'' }>8折</option>
									<option value="8.5" ${month36.order_time_discount=='8.5'?'selected':'' }>8.5折</option>
									<option value="9.0" ${month36.order_time_discount=='9.0'?'selected':'' }>9折</option>
									<option value="9.5" ${month36.order_time_discount=='9.5'?'selected':'' }>9.5折</option>
									<option value="10" ${month36.order_time_discount=='10'?'selected':'' }>不打折</option>
								</select>
								<label class="radio-inline"> <input type="radio" class="styled" name="36_month_order_time_state"  value="1" ${month36.state==1?'checked':'' }> 开启</label>
								<label class="radio-inline"> <input type="radio" class="styled" name="36_month_order_time_state" value="0"  ${month36.state==0?'checked':'' }> 关闭</label>
							</div>
						</div>
						<div class="text-center">
							<button class="btn bg-blue" type="submit" id="save_btn_ma">更新配置</button>
						</div>
					</fieldset>

				</form>
			</div>

		</div>
		<!-- /form validation -->

	</div>
	<!-- /content area -->

</div>

<!-- /main content -->
<%@include file="../common/footer.jsp"%>

