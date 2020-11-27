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
								<li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i class="icon-diamond"></i>场景营销</a></li>
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
								<span class="text-semibold"> 搭配套餐 </span>
							</h4>
						</div>
					</div>
				</div>
				<!-- Content area -->
				<div class="content">
					
					 <form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
				 		action="${pageContext.request.contextPath}/center/ump/package/save" method="post" >
						<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
						<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/> 
						<input type="hidden" name="idsCount" id="idsCount" value="${(!empty itemList )?'fn:length(itemList)':'0'}"/>
					<div class="row">
						<div class="col-md-12">
							<!-- 表单验证开始 -->
							<div class="panel panel-flat">

								<div class="panel-body">
									
									<div class="info">
											<fieldset class="content-group">
												<legend class="text-bold">
												<h5>搭配套餐活动信息</h5>
												</legend>
												
												<div class="form-group">
													<label class="control-label col-md-2 text-bold text-right">活动名称:</label>
													<div class="col-lg-3">
														<div class="input-group">
															<input type="text" class="form-control input-rounded" name="package_name" id="package_name" required="required" value="${infoMap.package_name}"  title="选输入活动名称"> 
														</div>
													</div>
												</div>
												<div class="form-group" id="fixed_div">
													<label class="col-md-2 control-label text-bold text-right">生效时间</label>	
													<div class="col-md-5">
									                    <div class="col-sm-12 input-group">
													        <div class="input-group"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
													           <input type="text" class="form-control pickadate-translated" name="start_time" id="start_time" value="${infoMap.start_time}"  onchange="judgeDate(1)">
										                       <span class="input-group-addon">--</span>
										                       <input type="text" class="form-control pickadate-translated" name="end_time" id="end_time" value="${infoMap.end_time}" onchange="judgeDate(2)">	
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
										      	<c:forEach items="${itemList}" var="info" varStatus="ind">
										      		<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right">活动商品1:</label>
														<div class="col-md-3">
															<select name="product_id${ind.count-1}"  class="select" > 
																<option value="5" ${(info.product_id eq 5)?"selected":""}>钢化玻璃门 铝合金推拉门地弹门 双开钢化玻璃门</option>
																<option value="6" ${(info.product_id eq 6)?"selected":""}>德式木门装甲门 铸铝门防盗安全子母门</option>
																<option value="7" ${(info.product_id eq 7)?"selected":""}>满欣甲级防盗门通风窗进户门大门安全门中门子母门指纹锁入户门 </option>
																<option value="8" ${(info.product_id eq 8)?"selected":""}>凤铝断桥铝门窗封阳台铝合金门窗隔音门窗平移门阳光房定制 </option>
																<option value="9" ${(info.product_id eq 9)?"selected":""}>厂家直销印尼进口菠萝格原木门素门100%纯天然实木门房间门定制</option>
															</select> 
														</div>
													</div>
										      	</c:forEach>
										      	<c:if test="${empty itemList}">
										      	<div class="form-group">
													<label class="control-label col-md-2 text-bold text-right">活动商品1:</label>
													<div class="col-md-3">
														<select name="product_id0"  class="select" > 
															<option value="5" ${(infoMap.product_id eq 5)?"selected":""}>钢化玻璃门 铝合金推拉门地弹门 双开钢化玻璃门</option>
															<option value="6" ${(infoMap.product_id eq 6)?"selected":""}>德式木门装甲门 铸铝门防盗安全子母门</option>
															<option value="7" ${(infoMap.product_id eq 7)?"selected":""}>满欣甲级防盗门通风窗进户门大门安全门中门子母门指纹锁入户门 </option>
															<option value="8" ${(infoMap.product_id eq 8)?"selected":""}>凤铝断桥铝门窗封阳台铝合金门窗隔音门窗平移门阳光房定制 </option>
															<option value="9" ${(infoMap.product_id eq 9)?"selected":""}>厂家直销印尼进口菠萝格原木门素门100%纯天然实木门房间门定制</option>
														</select> 
													</div>
												</div> 
												<div class="form-group">
													<label class="control-label col-md-2 text-bold text-right">活动商品2:</label>
													<div class="col-md-3">
														<select name="product_id1"  class="select" > 
															<option value="5" ${(infoMap.product_id eq 5)?"selected":""}>钢化玻璃门 铝合金推拉门地弹门 双开钢化玻璃门</option>
															<option value="6" ${(infoMap.product_id eq 6)?"selected":""}>德式木门装甲门 铸铝门防盗安全子母门</option>
															<option value="7" ${(infoMap.product_id eq 7)?"selected":""}>满欣甲级防盗门通风窗进户门大门安全门中门子母门指纹锁入户门 </option>
															<option value="8" ${(infoMap.product_id eq 8)?"selected":""}>凤铝断桥铝门窗封阳台铝合金门窗隔音门窗平移门阳光房定制 </option>
															<option value="9" ${(infoMap.product_id eq 9)?"selected":""}>厂家直销印尼进口菠萝格原木门素门100%纯天然实木门房间门定制</option>
														</select> 
													</div>
												</div> 
												</c:if>
												<div class="form-group">
													<label class="control-label col-md-2 text-bold text-right">套餐价格:</label>
													<div class="col-md-3">
														<input type="hidden" name="total_price" id="total_price" value="88" number="true"/>
														<input type="text" class="form-control" name="package_price" id="package_price" value="${infoMap.package_price}" number="true"/>
							                        </div>     
												</div> 
										      	<div class="form-group">
													<label class="col-md-2 control-label text-bold text-right">
														<font color="red"> * </font>状态
													</label>
													<div class="col-md-4">
														<label class="radio-inline">
															<input type="radio"  id="state1" name="state" ${infoMap.state ne -1?"checked":""}   value="0" class="styled" >
															生效
														</label>
														<label class="radio-inline">
															<input type="radio"  id="state2" name="state" value="-1" ${infoMap.state eq -1?"checked":""}  class="styled" >
															不生效
														</label>
													</div>
												</div>
											</fieldset>
									</div>
									 
									<div class="text-right">
										<button type="button" id="buttonsave" onclick="saveButton()" class="btn btn-primary">创建搭配套餐活动<i class="icon-arrow-right14 position-right"></i></button>
										<button type="button" class="btn btn-default" onclick="javascript:history.back(-1)">返回 <i class="icon-reload-alt position-right"></i></button>				
									</div>
								</div>
							</div>
							<!-- /form validation -->
						</div>
					 </div>
				 	</form>	

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script> 
			var rowNum=2;
			$(document).ready(function() { 
				//<c:if test="${!empty itemList}">
				//	rowNum=${fn:length(itemList)};
				//</c:if>
				//<c:if test="${empty itemList}">
				//	addRow();
				//</c:if>
			});
			
			function addRow(){
				var trStr="<tr>"
					+'<td>'+(rowNum+1)+'</td>'
					+'<td>'
					+'	满'
					+'	<input type="text" name="meet_price'+rowNum+'" id="meet_price'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>'
					+'	<select name="meet_type'+rowNum+'" id="meet_type'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;line-height:1.5384616">'
					+'		<option value="0">元</option>'
					+'		<option value="1">件</option>'
					+'	</select>'
					+'</td>'
					+'<td>'
					+'	<div class="control-label col-md-11">'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="cash_type'+rowNum+'" id="cash_type'+rowNum+'" class="styled" value="1">'
					+'			减现金'
					+'			<input type="text" name="cash_price'+rowNum+'" id="cash_price'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>元'
					+'		</label>'
					+'		<br>'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="discount_type'+rowNum+'" id="discount_type'+rowNum+'" class="styled" value="1">'
					+'			打折&nbsp;&nbsp;'
					+'		<input type="text" name="discount_price'+rowNum+'" id="discount_price'+rowNum+'" style="width:50px;border:1px solid #ddd;height:26px;padding:7px 12px;line-height:1.5384616"/>折'
					+'		</label>'
					+'		<br>'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="shipping_free'+rowNum+'" id="shipping_free'+rowNum+'" class="styled" value="1">'
					+'			免邮'
					+'		</label>'
					+'		<br>'
					+'		<label class="checkbox-inline">'
					+'			<input type="checkbox" name="coupon_type'+rowNum+'" id="coupon_type'+rowNum+'" class="styled" value="1">'
					+'			送优惠券'
					+'			<select name="coupon_id'+rowNum+'" id="coupon_id'+rowNum+'" style="width:200px;border:1px solid #ddd;height:26px;line-height:1.5384616">'
					+'				<option value="0">未选择</option>'
					+'				<option value="1">优惠券1</option>'
					+'				<option value="2">优惠券2</option>'
					+'			</select>'
					+'		</label>'
					+'	</div>'
					+'</td>'
					+'<td>';
				if(rowNum!=0){
					trStr=trStr+'<a href="javascript:;" onclick="delRowTupian(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a>'
				}
					+'</td>'
				+'</tr>';
				$("#data-table").append(trStr); 
				rowNum++;
			}
			
			function delRowTupian(nowTr){
				$(nowTr).parent().parent().remove();
			} 
			
			 
			function judgeDate(type){
				var startTime = $("#start_time").val();
				var endTime = $("#end_time").val();
				if(startTime == "" || endTime ==""){
					return false;
				}
				$("#dateDiv").attr("style","display:none;"); 
				$("#dateMsg").html(""); 
				
			    var start=new Date(startTime.replace("-", "/").replace("-", "/"));  	  
			    var end=new Date(endTime.replace("-", "/").replace("-", "/"));  
			    if(end<start){
			    	MAlert("开始时间应不小于结束时间");
			    	if(type==1){
			    		$("#start_time").val("");
			    	}else{
			    		$("#end_time").val("");
			    	}
			       return false;
			    }else{
			       return true;
			    }
			}
			
			function saveButton(){
				$("#buttonsave").attr("disabled", true); 
				
				var startTime = $("#start_time").val();
				var endTime = $("#end_time").val();
				if(startTime == "" || endTime ==""){
					$("#dateDiv").attr("style","display:block;"); 
					$("#dateMsg").html("生效时间不能为空"); 
					$("#buttonsave").removeAttr("disabled"); 
					if(!$("#infoForm").validate().form()){
						return false;
					}
					return false;
				}else{
					$("#dateDiv").attr("style","display:none;"); 
					$("#dateMsg").html(""); 
				}
				if(!$("#infoForm").validate().form()){
					$("#buttonsave").removeAttr("disabled");
					return false;
				} 
				$("#idsCount").val(rowNum);
				FullScreenShow("数据提交中，请稍后！");
				$("#infoForm").submit();
			}
			 
			</script>
						
