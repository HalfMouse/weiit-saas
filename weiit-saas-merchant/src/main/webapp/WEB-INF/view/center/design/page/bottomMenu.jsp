<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/shopTemplate/user.css">

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>店铺装修</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/design/page/pageList"><i class="icon-html5"></i>微页面</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i class="icon-cube4"></i>底部菜单</a></li>
								<li ><a href="${pageContext.request.contextPath}/center/design/page/navEdit"><i
										class="icon-cube3"></i>底部导航</a></li>
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
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold">店铺导航</span>
							</h4>
						</div> 
					</div>  
				</div>
				<!-- /page header -->
			 
				<!-- Content area -->
				<div class="content" style="padding-top:0px;margin-top:0px;"> 
					<div class="panel-content">
			          <div class="main-content-area">
			               <div class="row">
			                    <div style="width:340px;float:left;">
			                         <div class="widget white" style="width:320px;background:#fafafa;padding-top:0px;margin-top:0px;">
			                        	  <div class="widget-titlebar">
			                         	 	<h5 class="text-white text-center" style="margin-top:7px;" id="nameH5" >底部菜单展示</h5>
			                              </div>
			                              <div class="widget-content ">
			                              	<div class="text-center" > 
			                                   <div class="col-md-11" style="margin-left:20px;margin-top:40px;margin-bottom:40px;">
		                                   			<c:forEach items="${buttonlist}" var="item" varStatus="itind" >
		                                   				<a href="javascript:;" class="ng-binding ng-scope ${(item.state eq -1)?'hide':''}" id="lable${itind.count}">${item.nav_name}&nbsp;&nbsp;&nbsp;</a>
		                                   			</c:forEach>
			                                   </div>
			                                  </div>
			                              </div>
			                         </div>
			                    </div>
			                    <div style="margin-left:350px;">
			                         <div class="row">
										<div class="col-md-12" >
											<div  class="panel panel-flat" style="padding-top:0px;margin-top:0px;">
												<form class="form-horizontal" method="POST"  name="infoForm" id="infoForm"
													action="${pageContext.request.contextPath}/center/design/page/bottomMenuSave" enctype="multipart/form-data" >
													<input type="hidden" name="validate_id" id="validate_id" value=""/>
													<input type="hidden" name="validate_id_token" id="validate_id_token" value=""/> 
													<div class="panel-body" style="padding:0px;margin: 0px;">
														<fieldset class="content-group">
															<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>菜单管理</h4></legend>
															<%--<div class="form-group">
																<label class="control-label col-md-2 text-right">背景：</label>
																<div class="col-md-6">
																	<input type="text" name="bottomColor" id="bottomColor" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty queryParam.bgcolor)?'#f75d1c':queryParam.bgcolor}">
																</div>
															</div> --%>
														</fieldset>
													</div>
													<div class="panel-body"  style="padding:0px;margin: 0px;">
														<input type="hidden"  name="bottom_count" id="bottom_count" value="0">
														<fieldset class="content-group">
															<hr/>
															<div  id="divH5" >
															 
															</div>
															<div class="form-group text-left" style="margin-left:30px; ">
																<button type="button" class="btn btn-default" onclick="labelClick()">+添加菜单</button>
															</div>
															<div class="form-group text-center">
																<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">提交修改<i class="icon-checkmark3 position-right"></i></button>
															</div> 	 
														</fieldset>
													</div>
												</form>  
											</div>											
										</div>
									 </div>

			                    	</div>
			               		</div>
			               </div>
			               
			          </div>
			     	</div><!-- Panel Content -->
					 
			</div>
			
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
					
					<!-- select product modal -->
					<div id="custom_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择微页面</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">页面名称</span>
												<input type="text" class="form-control"  name="custom_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="custom_search">搜索</button>
										<table id="data-table2" class="table custom_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">标题</th>
													<th class="col-lg-4">创建时间</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					<!-- select product modal -->
					<div id="tag_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择商品分组</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">分组名称</span>
												<input type="text" class="form-control"  name="tag_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="tag_search">搜索</button>
										<table id="data-table3" class="table tag_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">分组名称</th>
													<th class="col-lg-4">创建时间</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
		 
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			
			<script>
			
			var index=1;
			$(document).ready(function() {
				$('#infoForm').validationEngine({ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'formError-white',
					scroll: true,
					showOneMessage: true
				});
				
				$("#product_search").click(function(){
					var product_name=$("input[name='product_name']").val();
					showTable(product_name,index);
				});
				$("#custom_search").click(function(){
					var custom_name=$("input[name='custom_name']").val();
					showTableCustom(custom_name,index);
				});
				$("#tag_search").click(function(){
					var tag_name=$("input[name='tag_name']").val();
					showTableTag(tag_name,index);
				});
				
				$(".colorpicker-show-input").spectrum({
			    	showInput: true,
			    	cancelText: "取消",
			        chooseText: "确定",
			        change: function(c) { 
			        }
			    });  
				
				<c:forEach items="${buttonlist}" var="item" varStatus="itind" >
					labelClick('${item.nav_name}','${item.target_type}','${item.target_id}','${item.target_url}','${item.state}'); 
				</c:forEach>
				
				$('#select_modal').on('hide.bs.modal', 
					function () {
						if(mflag==0){
							$("#target"+index).val(typenum[index]);
							$("#target"+index).selectpicker('render');
							$("#target"+index).selectpicker('refresh');
						}else{
							typenum[index]=$("#target"+index).val();
						}
						mflag=0;
					}
				);
				$('#custom_modal').on('hide.bs.modal', 
					function () {
						if(mflag==0){
							$("#target"+index).val(typenum[index]);
							$("#target"+index).selectpicker('render');
							$("#target"+index).selectpicker('refresh');
						}else{
							typenum[index]=$("#target"+index).val();
						}
						mflag=0;
					}
				);
				$('#tag_modal').on('hide.bs.modal', 
					function () {
						if(mflag==0){
							$("#target"+index).val(typenum[index]);
							$("#target"+index).selectpicker('render');
							$("#target"+index).selectpicker('refresh');
						}else{
							typenum[index]=$("#target"+index).val();
						}
						mflag=0;
					}
				);
			});
			  
			var num=0;
			function labelClick(name,target_type,target_id,target_url,state){
				num=num+1;
				var labelH5="";
				labelH5='<div id="bottomDiv'+num+'">'
						+'<div class="form-group">'
						+'	<label class="control-label col-md-2 text-right">名称：</label>'
						+'	<div class="col-md-5"  >'
						+'		<input type="text"  name="name'+num+'" id="name'+num+'" style="width:150px;" class="form-control validate[required]" data-errormessage-value-missing="名称不能为空" value="">'
						+'	</div> <div class="col-md-4"></div>'
						+'<div class="col-md-1" >'
						+'	<a href="javascript:;" title="删除" class="m-r-5" onclick="onclickDelete('+num+')">'
						+'		<i class="icon-trash"></i></a>'
						+'</div>'
						+'</div>'
						+'<div class="form-group ">'
						+'	<label class="control-label col-md-2 text-right">链接：</label>'
						+'	<div class="col-md-3">'
						+'		<select class="select" onchange="changeType(this.value,'+num+')" data-width="100%" style="width:250px;" name="target'+num+'" id="target'+num+'">'
						+'			<option value="0">----请选择链接----</option>';
						<c:forEach items="${linkList}" var="info"> 
							labelH5=labelH5+'<option value="${info.url_type}" >${info.url_content}</option>';
			    		</c:forEach> 
			    	labelH5=labelH5+'</select>'
			    		+'	</div> '
			    		+'    	<div class="col-md-6" id="typeLabel'+num+'">'
						+'			<input type="hidden" class="form-control" name="targetId'+num+'" id="targetId'+num+'" value="0">'
						+'			<input type="text" class="form-control" title="双击修改" style="display:none" ondblclick="changeType(0,'+num+')"  readonly="readonly" name="targetUrl'+num+'" id="targetUrl'+num+'" value="">'
						+'		</div>'
						+'</div>'
						+'<div class="form-group ">'
						+'	<label class="control-label col-md-2 text-right">是否开启：</label>'
						+'	<div class="col-md-5" >'
						+'		<label class="radio-inline">'
						+'			<input type="radio" name="state'+num+'" id="state1'+num+'" class="styled" onchange="radioChange(0,'+num+')" checked="checked" value="0" >'
						+'			开启'
						+'		</label>'
						+'		<label class="radio-inline">'
						+'			<input type="radio" name="state'+num+'" id="state2'+num+'" class="styled" onchange="radioChange(1,'+num+')" value="-1" >'
						+'			关闭'
						+'		</label>'
						+'	</div>'
						+'</div>'
						+'<hr/>'
						+'</div>';  
				$("#divH5").append(labelH5);
				//保存新增的行数，传后台
				$("#bottom_count").val(num);
				   
				if(name !=undefined ){
					$("#name"+num).val(name);
					$("#target"+num).val(target_type);
					$("#targetId"+num).val(target_id);
					$("#targetUrl"+num).val(target_url); 
					$("#state"+num).val(state);

					$("#target"+num).selectpicker('render');
					$("#target"+num).selectpicker('refresh');
					
					$('#targetUrl'+num).attr("readonly","readonly");
					$("#targetUrl"+num).css("display","block"); 
					typenum[num]=target_type;
					if(target_type==1 ){
					}else if(target_type==2){
					}else if(target_type==3){ 
					}else if(target_type==15){
						$('#targetUrl'+num).removeAttr('readonly');
					}else{
						$("#targetId"+num).val("0");
						$("#targetUrl"+num).val("");
						$("#targetUrl"+num).css("display","none"); 
					}
					$("input[name=state"+num+"][value="+state+"]").attr("checked",true);  
				}else{
	 				$("#target"+num).selectpicker('render');
	 				$("#target"+num).selectpicker('refresh');
	 				$("#target"+num).trigger('change');
				}
			}
			
			var typenum=new Array();
			var mflag=0; 
			
			function changeType(type,mm){ 
				if(type==0){
					type=$("#target"+mm).val();
				}
				if(type==1){
					showTableCustom('',mm);
				}else if(type==2){
					showTableTag('',mm);
				}else if(type==3){
					showTable('',mm);
				}else if(type==15){
					typenum[mm]=type;
					$("#targetUrl"+mm).css("display","block"); 
					$('#targetUrl'+mm).removeAttr('readonly');
				}else{
					typenum[mm]=type;
					$("#targetId"+mm).val("0");
					$("#targetUrl"+mm).css("display","none"); 
				}
			}
			
			function onclickDelete(delnum){ 
				  $("#bottomDiv"+delnum).remove();
				  $("#lable"+delnum).addClass("hide");
			}
  
			function radioChange(type,delnum){ 
				if(type==0){ 
					$("#lable"+delnum).removeClass("hide");
				}else{
					$("#lable"+delnum).addClass("hide");
				}
			}

			function showTable(product_name,mm){
				index=mm;
				$("#select_modal").modal("show");
				$('.product_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/product/productList.json?product_name='+product_name,
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
			 
			function selectProduct(id,name){
				mflag=1;
				$('#targetUrl'+index).attr("readonly","readonly");
				$("#targetUrl"+index).css("display","block"); 
				//拼接到控件中，方便表单提交时跟着提交
				$("#targetId"+index).val(id);
				$("#targetUrl"+index).val(name);
				//关闭弹出框
				$(".close").click(); 
			}
			
			
			function showTableCustom(name,mm){
				index=mm;
				$("#custom_modal").modal("show");
				$('.custom_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/design/page/pageList.json?custom_name='+name,
			        columns: [
			             {data: "page_name"},
			             {data: "create_time" },
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
		                sEmptyTable: "没有微页面数据",
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
		                sZeroRecords: "没有微页面数据"
		            }
			    });
			}
			
			function showTableTag(name,mm){
				index=mm;
				$("#tag_modal").modal("show");
				$('.tag_sort_table').DataTable({
			    	ajax: '${pageContext.request.contextPath}/center/productGroup/groupList.json?group_name='+name,
			        columns: [
			             {data: "group_name"},
			             {data: "create_time" },
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
		                sEmptyTable: "没有商品组数据",
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
		                sZeroRecords: "没有商品分组数据"
		            }
			    });
			}
			
			</script>
						
