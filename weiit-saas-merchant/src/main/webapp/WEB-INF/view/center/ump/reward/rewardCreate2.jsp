<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
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
								<li><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="${pageContext.request.contextPath}/center/ump/spread"><i class="icon-sphere3"></i>我要推广</a></li>
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
								<i class="icon-arrow-left52 position-left"></i> 
								<span class="text-semibold"> 满减送 </span>
							</h4>
						</div>
					</div>
				</div>
				<!-- Content area -->
				<div class="content">
					
					
						<div class="row">
							<div class="col-md-12">
								<!-- 表单验证开始 -->
								<div class="panel panel-flat">
	
									<div class="panel-body">
										<form action="${pageContext.request.contextPath}/center/ump/reward2/rewardCreate2Save" class="form-horizontal form-validate-jquery"  method="post" >
										<div class="info">
												<fieldset class="content-group">
													<legend class="text-bold">
													<h5>满减送活动信息</h5>
													</legend>
													
													<div class="form-group">
														<label class="control-label col-md-1 text-bold">活动名称:</label>
														<div class="col-lg-3">
															<div class="input-group">
																<input type="text" class="form-control input-rounded" name="reward_name" id="reward_name" required="required"   title="选输入活动名称"> 
															</div>
														</div>
													</div>
													<div class="form-group" id="fixed_div">
														<label class="col-md-1 control-label text-bold">生效时间</label>	
														<div class="col-md-5">
										                    <div class="col-sm-12 input-group">
														        <div class="input-group"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
														           <input type="text" class="form-control" name="start_time" id="start_time">
											                       <span class="input-group-addon">--</span>
											                       <input type="text" class="form-control" name="end_time" id="end_time">	
														        </div>
														     </div>
														 </div> 						
													</div>
													<div class="form-group" id="dateDiv" style="display: none;">
												     	<label class="col-md-1 control-label text-right"> </label>
												     	<div class="col-md-5">
												     		<font color="red" id="dateMsg" ></font>
													    </div>
											      	</div>
											      	<div class="form-group">
														<label class="col-md-1 control-label">
															<font color="red"> * </font>状态
														</label>
														<div class="col-md-4">
															<label class="radio-inline">
																<input type="radio"  name="state"  value="0" class="styled" checked>
																生效
															</label>
															<label class="radio-inline">
																<input type="radio"  name="state" value="-1" class="styled" >
																不生效
															</label>
														</div>
													</div>
												</fieldset>
										</div>
										
										<div class="rule">
											<legend class="text-bold">
											<h5>优惠设置</h5>
											</legend> 
												<div class="table-responsive">
													<table id="data-table" class="table table-bordered ">
														<thead>
															<tr class="bg-grey-300">
																<th class="user_column_user_account">层级</th> 
																<th class="user_column_user_name">优惠门槛</th>
																<th class="user_column_user_phone">优惠方式(可多选)</th>
																<th width="80">操作</th>
															</tr>
														</thead>
															<tr>
																<td>1</td>
																<td>
																	满
																	<input type="text"  style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>
																	<select name="meet_type" style="width:50px;border:1px solid #ddd;height:26px;line-height:1.5384616">
																		<option value="0">元</option>
																		<option value="1">件</option>
																	</select>
																</td>
																<td>
																	<div class="control-label col-md-11">
																		<label class="checkbox-inline">
																			<input type="checkbox" name="discount_type" class="styled" value="1">
																			减现金
																			<input type="text" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>元
																		</label>
																		<br>
																		<label class="checkbox-inline">
																			<input type="checkbox"  name="discount_type" class="styled" value="2">
																			打折&nbsp;&nbsp;
																			<input type="text"  style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>折
																		</label>
																		<br>
																		<label class="checkbox-inline">
																			<input type="checkbox" name="discount_type" class="styled"  value="3">
																			免邮
																		</label>
																		<br>
																		<label class="checkbox-inline">
																			<input type="checkbox" name="discount_type" class="styled" value="4">
																			送优惠券</label>
																			<select style="width:200px;border:1px solid #ddd;height:26px;line-height:1.5384616">
																				<option value="0" >未选择</option>
																				<option value="1">优惠券1</option>
																				<option value="2">优惠券2</option>
																			</select>
																		
																	</div>
																</td>
																<td>
																	<a href="javascript:;"><i class="fa fa-trash-o fa-lg"></i>删除</a>
																</td>
															</tr>
													</table>
													<br/>
													<a href="javascript:;" onclick="addRow()">新增一级优惠</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="text-muted">最多可设置五个层级 (每级优惠不累加)</span>
												</div>
										</div>
										<br>
										
										<div class="text-right">
											<button type="submit" id="submit" class="btn btn-primary">创建满减送活动<i class="icon-arrow-right14 position-right"></i></button>
											<button type="button" class="btn btn-default" onclick="javascript:history.back(-1)">返回 <i class="icon-reload-alt position-right"></i></button>				
										</div>
										</form>
									</div>
								</div>
								<!-- /form validation -->
							</div>
						 </div>

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script> 
			$(document).ready(function() { 
				
			});
			
			
			
			</script>
						
