<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>

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
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> 
					<span class="text-semibold">积分商城 </span>
				</h4>
			</div> 
		</div>
	</div>
	
	<!-- Content area -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
		 	<div class="panel-heading" >
				<h5 class="panel-title text-default text-bold" >${title}</h5>
			</div>
				 
			<div class="panel-body">
			 	<form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
			 		action="${pageContext.request.contextPath}/center/ump/integral/save"
			 		method="post"  enctype="multipart/form-data" >
					<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
					<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
					<fieldset class="">


						<div class="form-group">
							<label class="control-label col-md-2 text-bold text-right" ><font color="red">
								* </font>选择商品:</label>
							<div class="col-md-2" style="width: 260px;height: 240px">
								<div class="dropzone2" id="single_product_div" style="min-height:150px;">
									<div class="dz-preview2" style="width:100%;min-height:223px;margin:0">
										<div class="dz-details" style="width:100%;min-height:185px;">
											<img src="${imageDomain }${infoMap.product_img}"
												 style="width:100%;min-height:199px;"/>
										</div>
										<a onclick="showTable('')" class="dz-remove btn btn-warning btn-xs"
										   data-toggle="modal" data-target="#select_modal"><i
												class="fa fa-plus"></i>+挑选商品</a>
									</div>
									<input type="hidden" name="product_id" value="${infoMap.product_id }"/>
									<input type="hidden" name="item_id" value="${infoMap.item_id }"/>
									<div class='validation-error-label' id="product_id_error"
										 style="display:none;">请选择商品
									</div>
									<div class='validation-error-label' id="item_id_error"
										 style="display:none;">请选择商品规格
									</div>
								</div>
							</div>
						</div>
				      	<div class="form-group">
					     	<label class="col-sm-2 control-label text-right"> <span class="text-danger">*</span>销售价：</label>
					     	<div class="col-sm-2">
					        	<div class="input-group">
									<input type="text" class="form-control" name="sale_price" id="sale_price"
										required="required" number="true" title="销售价必须为数字" value="${infoMap.sale_price }">
									<span class="input-group-addon">￥</span> 
								</div> 
					      	</div>
				      	</div>
				      	<div class="form-group">
					     	<label class="col-sm-2 control-label text-right"> <span class="text-danger">*</span>兑换价：</label>
					     	<div class="col-sm-2">
					        	<div class="input-group">
									<input type="text" class="form-control" name="integral_price" id="integral_price"
										required="required" number="true" title="兑换价必须为数字" value="${infoMap.integral_price }">
									<span class="input-group-addon">￥</span> 
								</div> 
					      	</div>
				      	</div>

				      	<div class="form-group">
					     	<label class="col-sm-2 control-label text-right"> <span class="text-danger">*</span>每人限购：</label>
					     	<div class="col-sm-2">
					        	<div class="input-group">
									<input type="text" class="form-control" name="max_limit" id="max_limit"
										required="required" number="true" title="数量必须为整数" value="${infoMap.max_limit }">
									<span class="input-group-addon">个/件</span> 
								</div> 
					      	</div>
				      	</div>
				      	<div class="form-group">
					     	<label class="col-sm-2 control-label text-right"> <span class="text-danger">*</span>兑换所需积分：</label>
					     	<div class="col-sm-2">
					        	<input type="text" class="form-control" name="integral" id="integral"
										required="required" digits="true" title="积分必须为整数" value="${infoMap.integral }">
					      	</div>
				      	</div>
						<c:if test="${infoMap.state == 0}"></c:if>
				 		<div class="form-group">
					     	<label class="col-sm-2 control-label text-right"> <span class="text-danger">*</span>状态：</label>
					     	<div class="col-sm-6">
					     		<label class="radio-inline"> 
					     			<input type="radio" class="styled" name="state" id="status1" checked="checked" <c:if test="${infoMap.state == 0}">checked="checked"</c:if> value="0">
										上架
								</label>
								<label class="radio-inline">
									<input type="radio" class="styled" name="state" id="status0" <c:if test="${infoMap.state == -1}">checked="checked"</c:if>value="-1">
										下架
								</label>
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
		<!-- /bordered striped table -->

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
								<input type="text" class="form-control" name="product_name" value=""
									   placeholder="支持模糊匹配">
							</div>
						</div>

						&nbsp;&nbsp;
						<button class="btn bg-blue" type="button" id="product_search">搜索</button>
						<table id="data-table" class="table product_sort_table table-hover">
							<thead>
							<tr>
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


		<div id="sku_modal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h5 class="modal-title">选择规格</h5>
					</div>

					<div class="modal-body">
						<table id="sku-table" class="table sku_sort_table table-hover">
							<thead>
							<tr>
								<th class="col-lg-4">规格</th>
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


	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
<%@include file="../../common/footer.jsp" %>
<script>
<%--var ue = UE.getEditor('editor');--%>
<%--$(document).ready(function() {--%>
 <%----%>
	<%--<c:if test="${!empty infoMap &&  !empty infoMap.validate_id}">--%>
		<%--$("#validate_id").val("${infoMap.validate_id}");--%>
		<%--$("#validate_id_token").val("${infoMap.validate_id_token}");--%>
       	<%----%>
       	<%--$("#coupon_id").val("${infoMap.coupon_id}"); --%>
       	<%--$("#coupon_name").val("${infoMap.coupon_Name}"); --%>
       	<%----%>
		<%--$("#product_name").val("${infoMap.product_name}");--%>
       	<%--$("#imgfiles").attr('src','${imageDomain }/${infoMap.product_img}'); --%>
    	<%--$("#product_img").val("${infoMap.product_img}");--%>
    	<%--$("#smarket_price").val("${infoMap.smarket_price}");--%>
    	<%--$("#sale_price").val("${infoMap.sale_price}");--%>
       	<%--$("#stock").val("${infoMap.stock}"); --%>
       	<%--$("#exchange_count").val("${infoMap.exchange_count}"); --%>
       	<%--$("#integral").val("${infoMap.integral}"); --%>
 <%----%>
       	<%--$("input[name=state][value=${infoMap.state}]").prop("checked",true);--%>
       	<%--$("input[name=state][value=${infoMap.state}]").trigger('click');--%>
       	<%----%>
       	<%--var type="${infoMap.publish_type}";--%>
       	<%--$("input[name=publish_type][value="+type+"]").prop("checked",true);--%>
       	<%--if(type=='0'){  --%>
    		<%--$("#typeDiv11").attr("style","display:block;"); --%>
    		<%--$("#typeDiv22").attr("style","display:none;"); --%>
    	<%--}else if(type=='1'){ --%>
    		<%--$("#typeDiv11").attr("style","display:none;"); --%>
    		<%--$("#typeDiv22").attr("style","display:block;"); --%>
    	<%--}--%>
       	<%----%>
	  	<%--ue.addListener("ready", function () {--%>
	    	<%--// editor准备好之后才可以使用--%>
	    	<%--ue.setContent('${infoMap.product_desc}');--%>
	 	<%--});--%>
	<%--</c:if>--%>
	<%----%>
	<%----%>
<%--});--%>


function showTable(product_name) {
    $('.product_sort_table').DataTable({
        ajax: '${pageContext.request.contextPath}/center/ump/integral/productList.json?product_name=' + product_name,
        columns: [
            {data: "product_name"},
            {data: "sale_price"},
            {data: "stock"},
            {data: "option"}
        ],
        bDestroy: !0,
        bLengthChange: !1,
        bFilter: !1,
        bAutoWidth: !1,
        iDisplayLength: 5,
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




function showSku(product_id) {
    console.log("showSku"+product_id);
    $('.sku_sort_table').DataTable({
        ajax: '${pageContext.request.contextPath}/center/ump/bargain/skuList.json?product_id=' + product_id,
        columns: [
            {data: "specDesc"},
            {data: "sale_price"},
            {data: "stock"},
            {data: "option"}
        ],
        bDestroy: !0,
        bLengthChange: !1,
        bFilter: !1,
        bAutoWidth: !1,
        iDisplayLength: 5,
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


function selectProduct(id) {
//        var img = $(".able_product_" + id).parent().parent().find("img").attr("src");
    //拼接到商品插件中
//        $("#single_product_div").find(".dz-details").find("img").attr("src", img);
    //拼接到控件中，方便表单提交时跟着提交
    //关闭弹出框
    $(".close").click();

    $("#sku_modal").modal('show');
    showSku(id);

}

function selectItem(id) {
    var price = $(".able_item_" + id).attr("price");
    /*var stock = $(".able_item_" + id).attr("stock");*/
    var product_id = $(".able_item_" + id).attr("product_id");
    var specDescs = $(".able_item_" + id).attr("specDesc");


    var img = $(".able_item_" + id).attr("product_img");

    $("#single_product_div").find(".dz-details").find("img").attr("src", img);


    $("input[name='product_id']").val(product_id);
    $("#product_id_error").hide();

    $("input[name='sale_price']").val(price);

   /* $("input[name='stock']").val(stock);*/
    $("input[name='item_id']").val(id);
    $(".skuName").val(specDescs);

    $("#min_price").removeAttr("class");
    $("#min_price").attr("class","form-control validate[required,custom[number],max["+price+"]]");
    $("#min_price").removeAttr("data-errormessage-range-overflow");
    $("#min_price").attr("data-errormessage-range-overflow","底价不能高于原价"+price);

    console.log($("input[name='item_id']").val());
    $("#item_id_error").hide();

    //关闭弹出框
    $(".close").click();

}



function saveButton(obj){
	/*$(obj).attr("disabled", true);
	var publishType=$('input:radio[name="publishType"]:checked').val();
	if(publishType=="1"){
		var coupon_name=$("#coupon_name").val();
		if(coupon_name==""){
			MAlert("发布方式为优惠券时，请选择优惠券！");
			$(obj).removeAttr("disabled");
			return false;
		}
		$("#smarketPrice").val("0");
		$("#salePrice").val("0");
	}
	if(!$("#infoForm").validate().form()){
		$(obj).removeAttr("disabled");
		return false;
	}*/
	$("#infoForm").submit();
}
 

</script>