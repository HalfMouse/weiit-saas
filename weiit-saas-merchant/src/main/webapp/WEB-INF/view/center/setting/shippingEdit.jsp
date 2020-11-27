<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-credit-card"></i>支付/交易</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/setting/expressList"><i class="icon-truck"></i>物流配送</a></li>
								<li><a href="${pageContext.request.contextPath}/center/account/password"><i class="icon-key"></i> 修改密码</a></li>
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
							<!-- Tabs -->
							<ul class="nav  nav-tabs"> 
								<li><a href="expressList" ><i class="icon-truck position-left"></i>物流公司管理</a></li>
								<li  class="active"><a href="shippingList" style="border-top:0px;"><i class="icon-clipboard3 position-left"></i>运费模板设置</a></li>
							</ul> 
							<!-- /tabs -->
							
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								<div class="panel-body">
									<form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
								 		action="${pageContext.request.contextPath}/center/setting/shippingSave" method="post"  >
										<input type="hidden" name="shipping_id" id="shipping_id" value="" />
										<input type="hidden" name="areasIdsCount" id="areasIdsCount" />
										<fieldset class="">
											<div class="form-group">
												<label class="control-label col-md-1"> 模板名称<span class="text-danger">*</span> </label>
												<div class="col-md-4">
													<input type="text" class="form-control" name="shipping_name" id="shipping_name" 
														required="required"  title="选输入模板名称">
												</div>
											</div>
									 		<div class="form-group">
										     	<label class="control-label col-md-1"> 状态<span class="text-danger">*</span></label>
										     	<div class="col-md-6">
										     		<label class="radio-inline"> 
										     			<input type="radio" class="styled" name="shipping_config" id="shipping_config0" 
										     				onclick="shippingConfigRadio('0')" checked="checked" value="0">
															按重量
													</label>
													<label class="radio-inline">
														<input type="radio" class="styled" name="shipping_config" id="shipping_config1" 
															onclick="shippingConfigRadio('1')" value="1">
															按件数
													</label>
													<label class="radio-inline">
														<input type="radio" class="styled" name="shipping_config" id="shipping_config2" 
															onclick="shippingConfigRadio('2')" value="2">
															按体积
													</label>
										     	</div>
									      	</div>
									      	<div id="guigeDivMM" >
					                          	<div class="col-md-12">
					                              <div class="form-group">
					                                <label class="control-label col-md-1">配送区域设置<span class="text-danger">*</span></label>
					                                <div class="col-md-10 " id="guigeDivNN">
					                                  	<table id="testTable" class="table table-striped table-bordered ">
					                                   	<tbody>
									   						<tr>
										   						<td class="cl1">可配送至</td>
												        		<td class="cl1"><span id="startspan">首重(g)</span></td>
													    		<td class="cl1">运费(元)</td>
													    		<td class="cl1"><span id="addspan">续重(g)</span></td>
													    		<td class="cl1">续费(元)</td>
													    		<td class="cl1">管理</td>
												    		</tr>
												    		<c:if test="${empty shipmentDetailList}">
												    		<tr>
											        		 	 <td class="cl1"><input type="hidden" class="form-control input-sm" name="areasIdslist0" id="areasIdslist0" value="0" > 
											        			   	<input type="hidden" class="form-control input-sm" name="areasNameslist0" id="areasNameslist0" value="默认运费" />
											        			   	默认运费</td> 
											        			 <td class="cl1" style="width:100px"><input type="number" class="form-control input-sm" name="startStandardlist0" id="startStandardlist0"
											        			  	style="width:100px" required="required" digits="true" ></td> 
											    	    		 <td class="cl1" style="width:90px"><input type="number" class="form-control input-sm" name="startFeelist0" id="startFeelist0"
											    	    		  	style="width:90px" required="required" number="true"></td> 
											    	    		 <td class="cl1" style="width:100px"><input type="number" class="form-control input-sm" name="addStandardlist0" id="addStandardlist0"
											    	    	 		style="width:100px" required="required" digits="true"  ></td> 
											    	    		 <td class="cl1" style="width:90px"><input type="number" class="form-control input-sm" name="addFeelist0" id="addFeelist0" 
											    	    		 	style="width:90px" required="required" number="true"></td> 
											    	    		 <td class="cl1" style="width:70px"> </td> 
											    	  		  </tr>
											    	  		 </c:if>
											    	  		 <c:if test="${!empty shipmentDetailList}">
											    	    	 <c:forEach items="${shipmentDetailList}" var="info" varStatus="ind"> 
											    	    	 <tr>
											        		 	 <td class="cl1"><input type="hidden" class="form-control input-sm" name="areasIdslist${ind.count-1}" id="areasIdslist${ind.count-1}" value="${info.areas_ids}" > 
											        			   	<input type="hidden" class="form-control input-sm" name="areasNameslist${ind.count-1}" id="areasNameslist${ind.count-1}" value="${info.areas_names}" />
											        			   	<span id="areaNameSpan${ind.count-1}">${info.areas_names}</span>&nbsp;&nbsp;
											        			   	<c:if test="${ind.count!=1}">
											        			   	<a href="#modal-alert-quyu" data-toggle="modal" onclick="toModalQuyu(${ind.count-1})"><i class="fa fa-pencil-square-o"></i>编辑</a>
											        			 	</c:if>
											        			 </td>
											        			 <td class="cl1" style="width:100px"><input type="number" class="form-control input-sm" name="startStandardlist${ind.count-1}" id="startStandardlist${ind.count-1}"
											        			  	style="width:100px" required="required" digits="true" value="${info.start_standard}" ></td> 
											    	    		 <td class="cl1" style="width:90px"><input type="number" class="form-control input-sm" name="startFeelist${ind.count-1}" id="startFeelist${ind.count-1}"
											    	    		  	style="width:90px" required="required" number="true" value="${info.start_fee}" ></td> 
											    	    		 <td class="cl1" style="width:100px"><input type="number" class="form-control input-sm" name="addStandardlist${ind.count-1}" id="addStandardlist${ind.count-1}"
											    	    	 		style="width:100px" required="required" digits="true" value="${info.add_standard}" ></td> 
											    	    		 <td class="cl1" style="width:90px"><input type="number" class="form-control input-sm" name="addFeelist${ind.count-1}" id="addFeelist${ind.count-1}" 
											    	    		 	style="width:90px" required="required" number="true" value="${info.add_fee}" ></td> 
											    	    		 <td class="cl1" style="width:70px">
											    	    		 	<c:if test="${ind.count>1}">
											    	    		 	<a href="javascript:;" onclick="delRowArea(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a>
											    	    		 	</c:if>
											    	    		 </td> 
											    	    	 </tr>
											    	    	 </c:forEach>
											    	    	 </c:if>
					                                  	</tbody>
					                                  	</table> 
								                   	<a href="#modal-alert-quyu" data-toggle="modal" class="btn btn-info" onclick="toModalQuyu()"><i class="fa fa-plus"></i>新增配送区域</a>
					                                </div>
					                              </div>
					                              </div> 
					                           </div>
									      	 
										</fieldset> 
										<div class="text-center">
											<button type="button" onclick="saveButton(this)" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
											&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)" id="qua1" class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
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

<div id="modal-alert-quyu" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content" style="width:850px;margin-left:-100px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title  text-bold">选择区域</h2>
			</div>
			<div class="modal-body"  style="height:450px; ">
				<c:forEach items="${provinceList}" var="province" >
				 	<div id="provId${province.id}" class="form-group col-xs-3" style="margin-bottom:15px;">
				 		<label class="checkbox-inline" onMouseOver="javascript:mshow(this,'cityDiv${province.id}');" > 
                       		 <input type="checkbox" class="parCheck${province.id}" name="provinceids" id="provinceids"  onclick="clickCity(this,'cityClass${province.id}');" 
                       		 	value="${province.id}" title="${province.region_name }" />${province.region_name }
                        </label> 
	                </div>
	                <c:set var="num" value="0"></c:set>
	                <c:set var="index" value="0"></c:set>
	                <c:forEach items="${cityList}" var="city" varStatus="ind33">
	                	<c:if test="${city.parent_id==province.id}">
	                		<c:if test="${num==0}">
	                			<c:set var="num" value="1"></c:set>
	                			<div id="cityDiv${province.id}" class="form-group col-xs-4 mdivcity" 
	                				style="z-index:999;margin-bottom:15px;position:absolute;display:none;border:1px solid silver;background-color:White"
	                				 >
	                		</c:if>
					 		<label class="checkbox-inline">
	                       		 <input type="checkbox"  name="provinceids" id="provinceids"  class="cityClass${province.id}" 
	                       		 	onclick="clickCityIds(this,'${province.id}');" 
	                       		 	value="${city.id}" title="${city.region_name }" />${city.region_name }
	                        </label>
	                        <c:choose>
	                        	<c:when test="${index==1}">
	                        		<br/><c:set var="index" value="0"></c:set>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<c:set var="index" value="1"></c:set>
	                        	</c:otherwise>
	                       	</c:choose>
		                </c:if>
		                <c:if test="${num==1 && ind33.count==fn:length(cityList) }"></div></c:if>
				    </c:forEach>
			    </c:forEach>
			    
			  	<div class="text-center col-xs-12" style="margin-bottom:0px;" > 
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="quyuCheckOK()" >添加
						<i class="icon-checkmark3 position-right"></i></button>&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-default" data-dismiss="modal">取消 
						<i class="icon-cross3 position-right"></i></button>
				</div> 
			</div>
			
		   
		</div>
	</div>
</div>				
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
<script> 
var rowCount=1;
$(document).ready(function() {
	<c:if test="${!empty infoMap &&  !empty infoMap.shipping_id}">
		$("#shipping_id").val("${infoMap.shipping_id}");
		$("#shipping_name").val("${infoMap.shipping_name}");  
 
       	$("input[name=shipping_config][value=${infoMap.shipping_config}]").prop("checked",true);
       	$("input[name=shipping_config][value=${infoMap.shipping_config}]").trigger('click');
 
       	<c:if test="${fn:length(shipmentDetailList)>0}">
       		rowCount=${fn:length(shipmentDetailList)};
       	</c:if>
	</c:if>
});

function shippingConfigRadio(mtype){
	if(mtype=='0'){
		$("#startspan").html("首重(g)");
		$("#addspan").html("续重(g)");
	}else if(mtype=='1'){ 
		$("#startspan").html("首件(个)");
		$("#addspan").html("续件(个)");
	}else if(mtype=='2'){
		$("#startspan").html("首件(立方厘米)");
		$("#addspan").html("续件(立方厘米)");
	}
}


function delRowArea(nowTr){
	$(nowTr).parent().parent().remove();
} 

function addArea(areaIds,areaName){
	var tr = '<tr><td class="cl1"><input type="hidden" class="form-control input-sm" name="areasIdslist'+rowCount+'" id="areasIdslist'+rowCount+'" value="'+areaIds+'" />'
			+'<input type="hidden" class="form-control input-sm" name="areasNameslist'+rowCount+'" id="areasNameslist'+rowCount+'" value="'+areaName+'" />'
			+'<span id="areaNameSpan'+rowCount+'">'+areaName+'</span>&nbsp;&nbsp;<a href="#modal-alert-quyu" data-toggle="modal" onclick=\'toModalQuyu('+rowCount+')\'><i class="fa fa-pencil-square-o"></i>编辑</a></td>' 
			+'<td class="cl1" style="width:100px"><input type="text" class="form-control input-sm" name="startStandardlist'+rowCount+'" id="startStandardlist'+rowCount+'" ' 
			+	' style="width:100px" required="required" digits="true" ></td>' 
    		+'<td class="cl1" style="width:90px"><input type="text" class="form-control input-sm" name="startFeelist'+rowCount+'" id="startFeelist'+rowCount+'" ' 
    		+	' style="width:90px" required="required" number="true"></td>' 
    		+'<td class="cl1" style="width:100px"><input type="text" class="form-control input-sm" name="addStandardlist'+rowCount+'" id="addStandardlist'+rowCount+'" ' 
    		+	' style="width:100px" required="required" digits="true" ></td>'  
    		+'<td class="cl1" style="width:90px"><input type="text" class="form-control input-sm" name="addFeelist'+rowCount+'" id="addFeelist'+rowCount+'" ' 
    		+	' style="width:90px" required="required" number="true" ></td>'  
    		+'<td class="cl1" style="width:70px"><a href="javascript:;" onclick="delRowArea(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a></td></tr>' ; 

    rowCount++;	 
    $("#testTable").find("tbody").append(tr);
}

var rowNum=0;
function toModalQuyu(mcount){
	var idsCheck = $("input[name='provinceids']");
	idsCheck.prop("checked", false);
	rowNum=0;
	if(mcount!=undefined){
		rowNum=mcount;
		var areaIds = $("#areasIdslist"+mcount).val();
		var idsarr=areaIds.split(",");
		idsCheck.each(function(a){ 
			if(idsarr.indexOf($(this).val()) !== -1){
				$(this).prop("checked", true);
			}
	    });
	}
}
function quyuCheckOK(){
	var idsCheck = $("input[name='provinceids']");
	var quyuids="";
	var quyunames="";
	idsCheck.each(function(a){ 
		if ($(this).prop("checked")) {
			if(quyuids==""){
				quyunames = $(this).attr("title");
				quyuids = $(this).val();
			}else{
				quyunames = quyunames +","+ $(this).attr("title");
				quyuids = quyuids +","+ $(this).val();
			} 
		}
    });
	if(quyuids!=""){
		if(rowNum==0){
			addArea(quyuids,quyunames);
		}else{
			$("#areasIdslist"+rowNum).val(quyuids);
			$("#areasNameslist"+rowNum).val(quyunames);
			$("#areaNameSpan"+rowNum).html(quyunames);
		}
	} 
}

//保存按钮 
function saveButton(obj){
	if(!$("#infoForm").validate().form()){
		$(obj).removeAttr("disabled");
		return false;
	}
	$("#areasIdsCount").val(rowCount);  
	FullScreenShow("数据提交中，请稍后！");
	$("#infoForm").submit();
} 

function mshow(obj,id) { 
	$(".mdivcity").each(function(){
		$(this).css("display", "none");
	});
	
	var objDiv = $("#"+id+""); 
	$(objDiv).css("display","block"); 
	$(objDiv).css("left", $(obj).offset().left -160 ); 
	$(objDiv).css("top", $(obj).offset().top -70 ); 
}
function mhide(obj,id) { 
	var objDiv = $("#"+id+""); 
	$(objDiv).css("display", "none"); 
}

function stopPropagation(e) { 
	if (e.stopPropagation){
		e.stopPropagation();
	} else {
		e.cancelBubble = true; 
	}
}

$(document).bind('click',function(){
	$(".mdivcity").each(function(){
		$(this).css("display", "none");
	});
});
$(".mdivcity").bind('click',function(e){ 
	stopPropagation(e); 
});


function clickCity(obj,id) { 
	var allCheck = $("input."+id);
	if ( $(obj).prop("checked") ) {		
		allCheck.prop("checked", true);
	} else {
		allCheck.prop("checked", false);
	} 
}
function clickCityIds(obj,id) {
	var selectInput = $("input.cityClass"+id+":checked");
	var size = selectInput.size();
	if(size==0){
		$("input.parCheck"+id).prop("checked", false);
	}else{
		$("input.parCheck"+id).prop("checked", true);
	}
}

  </script>
			
