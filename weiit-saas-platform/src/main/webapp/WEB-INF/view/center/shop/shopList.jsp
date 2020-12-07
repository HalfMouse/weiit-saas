<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 商户列表 </span>
							</h4>
						</div>
					</div>  
				</div>
				<!-- /page header -->
				
				<!-- Content area -->
				<div class="content"> 
				 
					<!-- 表单验证开始 -->
					<div class="panel panel-flat">
						<div class="alert alert-primary no-border">
							<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
							<span class="text-semibold">
							1、蜗店的渠道商合作伙伴，拥有自行开通商户的权利，开通商户后，才可以登录蜗店系统。<br><br>
							</span>
							<span class="text-semibold">2、商户开通成功后，渠道商可以看到自己开通过的商户列表，商户可以使用其账户登录商户系统:</span><a href="http://www.wstore.me">www.wstore.me</a><br><br>
							<span class="text-warning">3、渠道商开通商户，会从渠道账户扣除余额，开通后，可以在右上方点击账户头像-->收支明细查看，不支持退款.</span>
							  
						</div>
						<form class="form-horizontal"  name="searchform" id="searchform" 
							action="${pageContext.request.contextPath}/center/shop/shopList" method="post" >	
							
							<div class="panel-body">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">登录账号</span> <input type="text"
											class="form-control" placeholder="" name="shop_name" value="${queryParam.shop_name}">
									</div>
								</div>
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">商户名称</span> <input type="text"
											class="form-control" placeholder="" name="order_num" value="${queryParam.order_num}">
									</div>
								</div>
								<c:if test="${sessionScope.role_sign=='ADMIN'}">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">创建人</span> <input type="text"
											class="form-control" placeholder="" name="search_manager_name" value="${queryParam.search_manager_name}">
									</div>
								</div>
								</c:if>
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
								 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 <c:if test="${sessionScope.role_sign=='USER'}">
								   <a href="${pageContext.request.contextPath}/center/shop/shopMerchantAdd" class="btn bg-blue">新增商户</a>
								 </c:if>
							</div>

							<div class="table-responsive">
								<table  id="data-table"  class="table">
									<thead>
										<tr > 
											<th>登录账号</th> 
											<th>账号来源</th>
											<th>店铺名称</th>
											<c:if test="${sessionScope.role_sign=='ADMIN'}">
											<th>企业名字或姓名</th>
											<th>营业执照或身份证</th>
											<th>状态</th>
											<th>实名认证</th>
											</c:if>
											<th>创建人</th>
											<th>创建时间</th>
											<th>到期时间</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${pageInfo.list}" var="info">
					                    <tr>
					                        <td>${info.account}</td>
					                        <td>
					                        	<c:if test="${info.type eq 0}">渠道系统开通</c:if>
					                        	<c:if test="${info.type eq 1}">产品官网注册</c:if>
					                        	<c:if test="${info.type eq 2}">服务号注册</c:if>
					                        </td>
					                        <td>${info.shop_name}</td>
					                        <c:if test="${sessionScope.role_sign=='ADMIN'}">
					                        <td>${info.name}</td>
					                        <td>${info.auth_no}</td>
					                        <td>
					                           	<c:if test="${info.locked ==0}">
					                           		<a href="javascript:;" title="点击禁用" class="btn btn-success m-r-5 m-b-5"
														style="height: 22px; padding-top: 0px;"
														onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.account}',-1)">启用</a>
					                           	</c:if>
					                           	<c:if test="${info.locked==-1}">
													<a href="javascript:;" title="点击启用" class="btn btn-warning m-r-5 m-b-5"
														style="height: 22px; padding-top: 0px;"
														onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.account}',0)">禁用</a>
												</c:if>
					                        </td>
					                        <td>
					                        <c:if test="${info.c_state==-1 }">未认证</c:if>
					                        <c:if test="${info.c_state==0 }">待审核</c:if>
					                        <c:if test="${info.c_state==1 }">已认证</c:if>
					                        </td>
					                        </c:if>
					                         <td>${info.create_manager_name}</td>
					                        <td><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					                        <td><fmt:formatDate value="${info.version_expire_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					                        <td>
					                        	<c:if test="${sessionScope.role_sign=='ADMIN'}">
														<c:if test="${info.c_state==0 || info.c_state==1 }">
														<a href="${pageContext.request.contextPath}/center/shop/shopCreate?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}&shop_id=${info.shop_id}" title="实名通过" >查看实名信息</a>
														</c:if>
														<c:if test="${!empty info.shop_id}">
															<a href="javascript:;" onclick="shopInit(${info.shop_id})" title="开通店铺" >数据初始化</a>
														</c:if>
												</c:if>
												<c:if test="${sessionScope.role_sign=='USER'}">
													<c:if test="${empty info.shop_id}">
													<!-- <a href="${pageContext.request.contextPath}/center/shop/shopCreate?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}&shop_id=${info.shop_id}" title="开通店铺" >开通店铺</a> -->  
													</c:if>
												</c:if>
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
				<!-- /content area -->
				
			</div>
			
			<!-- 选择行业 -->
			<div id="demo_dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
				<div class="modal-dialog modal-lg" style="padding-left:10%;">
					<div class="modal-content" style="width: 560px;">
						<div class="modal-header" >
							<button type="button" class="close" onclick="dialogClose()" data-dismiss="modal">&times;</button>
							<h5 class="modal-title" id="modalTitle">选择行业</h5>
						</div>
						<form action="${pageContext.request.contextPath}/center/shop/init" class="form-horizontal" method="post">
							<input type="hidden" name="shop_id" id="shop_id" value="">
							<div class="modal-body">
								<div class="form-group">
								 	<label class="col-md-3 text-right" style="padding-top:10px;">所属行业 ：</label>
									<div class="col-md-5">
										<select name="demo_id" id="demo_id" class="select">
											<c:forEach items="${businessList}" var="info">
												<option value="${info.business_id}">${info.business_name}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="modal-footer" style="text-align: center;">
								<button type="button" onclick="saveButton(this,'数据初始化中，请稍后！');" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-sm btn-default" onclick="dialogClose()">取消</button>
							</div>
						</form>
					</div>
				</div>
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
  

if("${sessionScope.role_sign}"=="ADMIN"){
	
	function mUpdate(id,validate_id_token,name,state){
		var title="";
		if(state=="-1"){
			title='确定要禁用账号 <label style="color: red;">'+name+'</label> 吗？禁用后该账户将不能登录商户系统，请慎重考虑！';
		}
		if(state=="0"){
			title='确定要启用账号 <label style="color: red;">'+name+'</label> 吗？启用后该账户可以登录商户系统.';
		}
		MConfirm(title,'','',function(result) {
			if(result){
				window.location="${pageContext.request.contextPath}/center/shop/shopState?locked="+state+"&validate_id="+id+"&validate_id_token="+validate_id_token;
			}
		});
	}
	
	function shopInit(shop_id){
		$("#demo_dialog").addClass("in");
		$("#demo_dialog").show(); 
		$("#demo_dialog").find("#shop_id").val(shop_id);  
	}
	function dialogClose(){
		$("#demo_dialog").removeClass("in"); 
		$("#demo_dialog").hide();  
	}
}

</script>
			
