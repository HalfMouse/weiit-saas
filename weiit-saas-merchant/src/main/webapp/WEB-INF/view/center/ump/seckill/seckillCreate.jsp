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
								<li><a href="scene"><i class="icon-diamond"></i>场景营销</a></li>
								<li><a href="spread"><i class="icon-sphere3"></i>我要推广</a></li>
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
								<span class="text-semibold"> 秒杀</span>
							</h4>
						</div>
					</div>
				</div>
				<!-- Content area -->
				<div class="content">
					
					 <form class="form-horizontal" id="infoForm" name="infoForm" action="${pageContext.request.contextPath}/center/ump/seckill/save" method="post" >
						<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
						<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/> 
						 
						<div class="row">
							<div class="col-md-12">
								<!-- 表单验证开始 -->
								<div class="panel panel-flat">
	
									<div class="panel-body">
										
										<div class="info">
												<fieldset class="content-group">
													<legend class="text-bold">
													<h5>秒杀活动信息</h5>
													</legend>
													<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right"><font color="red"> * </font>活动名称:</label>
														<div class="col-md-4">
															<input type="text" class="form-control validate[required,maxSize[20]]" name="seckill_name"  value="${infoMap.seckill_name}" placeholder="秒杀活动名称不要超过20个字" data-errormessage-value-missing="秒杀活动名称不能为空" data-errormessage-range-overflow="秒杀活动名称不要超过20个字"> 
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right"><font color="red"> * </font>选择商品:</label>
														<div class="col-md-2">
												              <div class="dropzone2" id="single_product_div" style="min-height:150px;">
												                  	<div class="dz-preview2" style="width:100%;min-height:140px;margin:0"> 
																	<div class="dz-details" style="width:100%;min-height:110px;"> 
																	 <img src="${imageDomain }${infoMap.product_img}" style="width:100%;min-height:108px;"/> 
																	</div> 
																	<a onclick="showTable('')" class="dz-remove btn btn-warning btn-xs"   data-toggle="modal" data-target="#select_modal" ><i class="fa fa-plus"></i>+挑选商品</a>
																	</div>
																	<input type="hidden" name="product_id" value="${infoMap.product_id }"/>
																	<div  class='validation-error-label' id="product_id_error" style="display:none;">请选择商品</div>
												               </div>
														</div>
													</div> 
													
													<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right"><font color="red"> * </font>秒杀价格:</label>
														<div class="col-md-3">
															 <input type="text" class="form-control validate[required,custom[number]]" name="seckill_price" id="seckill_price" value="${infoMap.seckill_price }" data-errormessage-value-missing="请输入秒杀价格"  data-errormessage-custom-error="必须是金额类型"/>
								                        </div>     
													</div> 
													<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right"><font color="red"> * </font>秒杀库存:</label>
														<div class="col-md-3">
															<input type="text" class="form-control validate[required,custom[integer]]" name="stock"  id="stock" value="${infoMap.stock}"  data-errormessage-value-missing="秒杀库存必须设置" data-errormessage-custom-error="必须是整数"/>
								                        </div>     
													</div> 
													<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right"><font color="red"> * </font>活动标签:</label>
														<div class="col-md-3">
															<div class="input-group">
																<input type="text" class="form-control validate[required]" name="description" value="${infoMap.description}" data-errormessage-value-missing="选输入活动标签" placeholder="比如:1元秒杀" > 
															</div>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-2 text-bold text-right" style="padding-top:15px;">订单取消:</label>
														<div class="col-md-8">
															<label class="radio-inline" style="padding-left:0px;">
																<input type="text" class="form-control validate[required,custom[integer]]" style="width:100px;" name="overtime" value="${infoMap==null?'5':infoMap.overtime}" id="overtime" data-errormessage-value-missing="订单取消设置有误"/>
															</label>
															<label class="radio-inline" style="padding-left:0px;">
																<span class="text-muted">买家多少分钟未支付订单，订单将取消</span> 
															</label>
								                        </div>     
													</div>  
													
													<div class="form-group">
														<label class="col-md-2 control-label text-bold text-right">
															<font color="red"> * </font>每人限购
														</label>
														<div class="col-md-4">
															<label class="radio-inline">
																<input type="radio"  name="maxLimitType"  value="1" class="styled" <c:if test="${infoMap.max_limit eq null or infoMap.max_limit==null }">checked="checked"</c:if>>
																不限
															</label>
															<label class="radio-inline">
																<input type="radio"  name="maxLimitType" value="2" class="styled" <c:if test="${infoMap.max_limit!=null and infoMap.max_limit>0 }">checked="checked"</c:if>>
																限制
															</label>
														</div>
													</div>
													<div class="form-group <c:if test="${infoMap eq null or infoMap.max_limit==null }">hide</c:if>" id="maxLimit_div">
													    <label class="col-md-2 control-label"></label>
														<div class="col-md-4">
															<div class="col-sm-6 input-group" > 
								                               <input type="text" class="form-control validate[required,custom[integer]]" name="max_limit" id="max_limit" value="${infoMap.max_limit }" data-errormessage-value-missing="选择限购时限购数必须设置"  data-errormessage-custom-error="必须是整数"/>
								                               <span class="input-group-addon">个/件</span>
								                        	</div>
								                        </div>                     
													</div> 
													
													<div class="form-group" id="fixed_div">
														<label class="col-md-2 control-label text-bold text-right"><font color="red"> * </font>活动时间</label>	
														<div class="col-md-5">
										                    <div class="col-sm-12 input-group">
														        <div class="input-group"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
														           	<input type="text" class="form-control validate[required]" name="start_time" id="start_time" value="${infoMap.start_time }"  data-errormessage-value-missing="设置活动开始时间">
											                       <span class="input-group-addon">--</span>
											                       <input type="text" class="form-control validate[required]" name="end_time" id="end_time" value="${infoMap.end_time }"   data-errormessage-value-missing="设置活动结束时间">
														        </div>
														     </div> 	
														 </div>			
													</div>
													
											      	<div class="form-group">
														<label class="col-md-2 control-label text-bold text-right"><font color="red"> * </font>状态</label>
														<div class="col-md-4">
															<label class="radio-inline">
																<input type="radio" name="state"  value="1" class="styled" <c:if test="${infoMap.state eq null or infoMap.state==1 }">checked="checked"</c:if> >
																生效
															</label>
															<label class="radio-inline">
																<input type="radio" name="state" value="-1" class="styled" <c:if test="${infoMap.state!=null and infoMap.state==-1 }">checked="checked"</c:if> >
																不生效
															</label>
														</div>
													</div>
												</fieldset>
										</div> 
										
										<div class="text-right">
											<button type="button" id="save_btn"  class="btn btn-primary">创建秒杀<i class="icon-arrow-right14 position-right"></i></button>
											<button type="button" class="btn btn-default" onclick="javascript:history.back(-1)">返回 <i class="icon-reload-alt position-right"></i></button>				
										</div>
									</div>
								</div>
								<!-- /form validation -->
							</div>
						 </div>
				 	</form>	
					
					
					<!-- select product modal -->
					<div id="select_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择商品</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">商品标题</span>
												<input type="text" class="form-control"  name="product_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="product_search">搜索</button>
										<table id="data-table" class="table product_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">商品</th>
													<th class="col-lg-2">价格</th>
													<th class="col-lg-2">库存</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					
				</div>
				<!-- /content area -->
				
				
				
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script>
			$(document).ready(function() {
				//日期控件加载
			 	$("#start_time").datetimepicker({
			        format: "YYYY/MM/DD HH:mm:ss",
			        defaultDate:"${infoMap.start_time}"
			    });
			    $("#end_time").datetimepicker({
			        format: "YYYY/MM/DD HH:mm:ss",
			        defaultDate:"${infoMap.end_time}"
			    });
			    $("#start_time").on("dp.change",
			    function(e) {
			        $("#end_time").data("DateTimePicker").minDate(e.date)
			    });
			    $("#end_time").on("dp.change",
			    function(e) {
			        $("#start_time").data("DateTimePicker").maxDate(e.date)
			    });
			 	 //优惠形式控件加载
				 $("#seckill_price").TouchSpin({
					min: 0,
					step: 0.01,
					decimals: 2,
				    postfix: '元'
				 });
				 $("#stock").TouchSpin({
					min: 1,
					postfix: '个/件'
				});
				
				 
				//领取设置
				$("input[name=maxLimitType]").click(function(e){
					if($(this).val()=='1'){
						$("#maxLimit_div").addClass("hide");
					}else{
						$("#maxLimit_div").removeClass("hide");
					}
				});
				//商品搜索点击
				$("#product_search").click(function(){
					var product_name=$("input[name='product_name']").val();
					showTable(product_name);
				});
				/*默认监听表单onbulr验证*/
				$('#infoForm').validationEngine({ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'formError-white',
					scroll: true,
					showOneMessage: true
				}); 
				//表单提交
				$("#save_btn").click(function(){
					$("#save_btn").attr("disabled", true);
					if($("input[name='product_id']").val()==""){
						$("#product_id_error").show();
					}else{
						$("#product_id_error").hide();
					}
					if(!$('#infoForm').validationEngine("validate")){
						$("#save_btn").removeAttr("disabled");
						return false;
					}else{
						FullScreenShow("数据提交中，请稍后！");
						$("#infoForm").submit();
					}
						
				});
			});
			</script>
			<script>
			function showTable(product_name){
				
				$('.product_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/ump/seckill/productList.json?product_name='+product_name,
			        columns: [
			             {data: "product_info"},
			             {data: "sale_price" },
			             {data: "stock"},
			             {data: "option"}
			         ],
			        bDestroy:!0,
			    	bLengthChange:!1,
			        bFilter:!1,
			        bAutoWidth:!1,
			        iDisplayLength:5,
			        oLanguage: {
		                oAria: {
		                    sSortAscending: ": 升序排序",
		                    sSortDescending: ": 降序排序"
		                },
		                oPaginate: {
		                    sFirst: "首页",
		                    sLast: "末页",
		                    sNext: "下一页",
		                    sPrevious: "上一页"
		                },
		                sEmptyTable: "没有商品数据",
		                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
		                sInfoEmpty: "当前 0 - 0 条  共  0 条",
		                sInfoFiltered: "(filtered from _MAX_ total entries)",
		                sInfoPostFix: "",
		                sDecimal: "",
		                sThousands: ",",
		                sLengthMenu: "显示 _MENU_ 条",
		                sLoadingRecords: "加载中...",
		                sProcessing: "进行中...",
		                sSearch: "Search:",
		                sSearchPlaceholder: "",
		                sUrl: "",
		                sZeroRecords: "没有商品数据"
		            }
			    });
			}
		    
			function selectProduct(id){
				var img=$(".able_product_"+id).parent().parent().find("img").attr("src");
				//拼接到商品插件中
				$("#single_product_div").find(".dz-details").find("img").attr("src",img);
				//拼接到控件中，方便表单提交时跟着提交
				$("input[name='product_id']").val(id);
				//关闭弹出框
				$(".close").click();
				$("#product_id_error").hide();
			}
			
			</script>
						
