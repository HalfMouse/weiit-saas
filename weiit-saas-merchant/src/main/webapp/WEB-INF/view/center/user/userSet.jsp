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
								<li><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
								<li><a href="userCashList"><i class="icon-cash"></i>会员提现</a></li>
								<li class="active"><a href="userSet"><i class="icon-gear"></i>会员设置</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation  -->
					
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
										<form class="form-horizontal form-validate-jquery" action="${pageContext.request.contextPath}/center/user/userSetSave" method="post" >
											<fieldset class="content-group">
												<legend class="text-bold">基本设置</legend>
												
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">会员登录方式:</label>
													<div class="col-md-6 text-bold"><input type="hidden" value="${queryParam.LOGINMODE_ID}" name="LOGINMODE_ID">
														<label class="radio-inline"> <input type="radio" class="styled" name="LOGINMODE" ${(queryParam.LOGINMODE eq 1)?"checked":""} value="1"> 手机号码登录</label>
														<label class="radio-inline"> <input type="radio" class="styled" name="LOGINMODE" ${(queryParam.LOGINMODE ne 1)?"checked":""} value="0"> 微信授权登录</label>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">订单交易成功:</label>
													<div class="col-md-6 text-bold"><input type="hidden" value="${queryParam.ORDERSUCCESS_ID}" name="ORDERSUCCESS_ID">
														<label class="radio-inline"> <input type="radio" class="styled" name="ORDERSUCCESS" ${(queryParam.ORDERSUCCESS eq 1)?"checked":""} value="1"> 发送短信通知给会员</label>
														<label class="radio-inline"> <input type="radio" class="styled" name="ORDERSUCCESS" ${(queryParam.ORDERSUCCESS ne 1)?"checked":""} value="0"> 不发送短信给会员</label>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">积分变动:</label>
													<div class="col-md-6 text-bold"><input type="hidden" value="${queryParam.INTEGRALCHANGE_ID}" name="INTEGRALCHANGE_ID">
														<label class="radio-inline"> <input type="radio" class="styled" name="INTEGRALCHANGE" ${(queryParam.INTEGRALCHANGE eq 1)?"checked":""} value="1"> 开启通知提醒</label>
														<label class="radio-inline"> <input type="radio" class="styled" name="INTEGRALCHANGE" ${(queryParam.INTEGRALCHANGE ne 1)?"checked":""} value="0"> 关闭通知提醒</label>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-1 text-bold">余额变动:</label>
													<div class="col-md-6 text-bold"><input type="hidden" value="${queryParam.BALANCECHANGE_ID}" name="BALANCECHANGE_ID">
														<label class="radio-inline"> <input type="radio" class="styled" name="BALANCECHANGE" ${(queryParam.BALANCECHANGE eq 1)?"checked":""} value="1"> 开启通知提醒</label>
														<label class="radio-inline"> <input type="radio" class="styled" name="BALANCECHANGE" ${(queryParam.BALANCECHANGE ne 1)?"checked":""} value="0"> 关闭通知提醒</label>
													</div>
												</div>
											</fieldset>
											<div class="text-center">
												<button type="button" onclick="window.location.reload()" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>&nbsp;&nbsp;&nbsp;&nbsp; 
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
			
						
