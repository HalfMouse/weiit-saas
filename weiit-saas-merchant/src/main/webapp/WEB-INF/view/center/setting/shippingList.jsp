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
									<div style="float:left;">
										<a href="shippingAdd" class="btn bg-blue">新增运费模板</a>
									</div> 	
								</div>
								<form class="form-horizontal"  name="searchform" id="searchform" action="" method="post" >	
									<div class="table-responsive">
										<c:forEach items="${pageInfo.list}" var="info"> 
										<table  id="data-table"  class="table table-condensed">
											<tbody>
												<tr style="background: #EAF8FF">
													<td colspan="5">${info.shipping_name }
														<div class="pull-right">
															最后编辑时间:
															<fmt:formatDate value="${info.update_time }" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;
															<a href="javascript:;" title="复制模板" onclick="onshippingCopy(${info.shipping_id},'${info.shipping_name}')">
																<i class="fa fa-copy"></i>复制模板</a> &nbsp;&nbsp;
															<a href="${pageContext.request.contextPath}/center/setting/shippingEdit?shipping_id=${info.shipping_id}" title="修改" >
																<i class="fa fa-edit"></i>修改</a> &nbsp;&nbsp;
															<a href="javascript:;" title="删除" onclick="WIremove(${info.shipping_id},'${info.shipping_name}')">
																<i class="fa fa-trash-o"></i>删除</a>
														</div>
													</td>
												</tr>
												<tr>
													<td style="text-align: left; width: 58%;">可配送至</td>
													<td style="text-align: center;"><c:if
															test="${info.shipping_config eq 0}">首重(g)</c:if> <c:if
															test="${info.shipping_config eq 1}">首件(个)</c:if> <c:if
															test="${info.shipping_config eq 2}">首件(立方米)</c:if></td>
													<td style="text-align: center;">首费(元)</td>
													<td style="text-align: center;"><c:if
															test="${info.shipping_config eq 0}">续重(g)</c:if> <c:if
															test="${info.shipping_config eq 1}">续件(个)</c:if> <c:if
															test="${info.shipping_config eq 2}">续件(立方米)</c:if></td>
													<td style="text-align: center;">续费(元)</td>
												</tr>
												<c:forEach items="${shipmentDetailList}" var="detail"
													varStatus="i">
													<c:if test="${detail.shipping_id==info.shipping_id }">
														<tr>
															<td style="text-align: left; width: 58%;">${detail.areas_names}</td>
															<td style="text-align: center;">${detail.start_standard}</td>
															<td style="text-align: center;">${detail.start_fee}</td>
															<td style="text-align: center;">${detail.add_standard}</td>
															<td style="text-align: center;">${detail.add_fee}</td>
														</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
										</c:forEach>
									</div>
									<!-- 
									<div id="pager" class="panel-body"></div>
									 -->
								 </form>
							</div>
							<!-- /form validation -->
						</div>
					 </div>
					
					
				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
<script> 
$(document).ready(function() {
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});

function onshippingCopy(id,name){
	MConfirm('确定要复制运费模板 <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/setting/shippingCopySave?shipping_id="+id+"&ts="+new Date().getTime();	
		}
	}); 
}
 
function WIremove(id,name){
	MConfirm('确定要删除运费模板 <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/setting/shippingRemove?shipping_id="+id;
		}
	});
}
 
  </script>
			
