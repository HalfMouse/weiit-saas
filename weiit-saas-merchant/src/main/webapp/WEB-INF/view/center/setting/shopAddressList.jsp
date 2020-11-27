<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-credit-card"></i>支付/交易</a></li>
								<li><a href="${pageContext.request.contextPath}/center/setting/expressList"><i class="icon-truck"></i>物流配送</a></li>
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
								<li><a href="shopInfo" ><i class="icon-home8 position-left"></i>店铺基本信息</a></li>
								<li><a href="shopCertification"><i class="icon-vcard position-left"></i>实名认证</a></li>
								<li class="active"><a href="shopAddress"  style="border-top:0px;"><i class="icon-address-book position-left"></i>商家地址库</a></li>
							</ul> 
							<!-- /tabs -->
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
								<div class="panel-body">
									<div style="float:left;">
										<a href="shopAddressAdd" class="btn bg-blue">新增地址</a>
									</div> 	
								</div>
								<form class="form-horizontal"  name="searchform" id="searchform" action="" method="post" >	
									<div class="table-responsive">
										<table  id="data-table"  class="table">
											<thead>
												<tr > 
													<th>联系人名称</th>
													<th>联系号码</th> 
													<th>所在地区</th>
													<th>街道地址</th>
													<th>邮政编码</th>
													<th>发货地址</th> 
													<th>退货地址</th>
													<th width="80">操作</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${pageInfo.list}" var="info">
							                    <tr>
							                        <td>${info.contact_name}</td>
							                        <td>${info.phone}</td>
							                        <td>${info.proName}/${info.cityName}/${info.disName}</td>
							                        <td>${info.address}</td>
							                        <td>${info.zip_code}</td>  
							                        <td>
							                           	<c:if test="${info.shipping_type ==1}">
							                           		<span class="label label-warning">默认</span> 
							                           	</c:if>
							                           	<c:if test="${info.shipping_type !=1}">
															<a href="javascript:;" title="点击设为默认" class="btn btn-info m-r-5 m-b-5"
																style="height: 22px; padding-top: 0px;"
																onclick="mUpdateShipping(${info.address_id})">设为默认</a>
														</c:if>
							                        </td>
							                        <td>
							                           	<c:if test="${info.return_type ==1 }">
							                           		<span class="label label-warning">默认</span> 
							                           	</c:if>
							                           	<c:if test="${info.return_type !=1 }">
															<a href="javascript:;" title="点击设为默认" class="btn btn-info m-r-5 m-b-5"
																style="height: 22px; padding-top: 0px;"
																onclick="mUpdateReturn(${info.address_id})">设为默认</a>
														</c:if>
							                        </td>
							                        <td>
														<ul class="icons-list">
															<li><a href="${pageContext.request.contextPath}/center/setting/shopAddressEdit?address_id=${info.address_id}" title="编辑" >
																<i class="icon-pencil7"></i></a></li>
								                           	<li><a href="javascript:;" title="删除" onclick="WIremove('${info.address_id}','${info.contact_name}')" >
																<i class="icon-trash"></i></a></li>
														</ul>
													</td>
							                    </tr>
							                </c:forEach>
											</tbody>
										</table>
									</div>
									<div id="pager" class="panel-body"></div>
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

function mUpdateShipping(id){
	MConfirm('确定要设该地址为默认发货地址吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/setting/shopAddressStatus?shipping_type=1&address_id="+id;
		}
	}); 
}

function mUpdateReturn(id){
	MConfirm('确定要设该地址为默认退货地址吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/setting/shopAddressStatus?return_type=1&address_id="+id;
		}
	}); 
}
 
function WIremove(id,name){
	MConfirm('确定要删除地址库 <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/setting/shopAddressRemove?address_id="+id;
		}
	});
}

  </script>
			
