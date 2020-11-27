<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@  taglib  uri="http://java.sun.com/jsp/jstl/functions"   prefix="fn"%> 
<%@include file="../common/header.jsp"%>
<%--<meta name="referrer" content="never">--%>
<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
								<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
								<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
								<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
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
					<ul class="nav  nav-tabs"> 
						<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo" style="border-left:0px;border-top:0px;"><i class="icon-qrcode position-left"></i>公众号授权</a></li>
						<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="fa fa-wechat position-left"></i>微信支付</a></li>
						<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/templateMessage/list"><i class="icon-bubble-lines4 position-left"></i>模板消息</a></li>
						<li><a href="${pageContext.request.contextPath}/center/weixin/weixinReply/list"><i class="icon-file-text2 position-left"></i>自动回复</a></li>
					</ul>
					<!-- Navbar navigation --> 
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;min-height:500px;">  
								<div class="panel-body">
									<div class="alert alert-primary no-border">
										<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
										<span class="text-semibold">
										公众号必须是</span>
										<span class="text-warning">已经认证</span>
										<span class="text-semibold">才可以设置模板消息，并且要求已经开通了</span><span class="text-warning">模板消息</span><span class="text-semibold">可以进行自动设置，自动设置后默认是全部模板消息开启的，如需要关闭请点击开关。</span>
										<br> <br>
										<a href="javascript:;"  onclick="autoSet('${pageContext.request.contextPath}/center/weixin/templateMessage/autoSet')" class="btn bg-success  btn-icon" >自动设置</a>
									</div>
									<c:if test="${!empty mytemplateList }">
									<div class="table-responsive">
										<table id="data-table"
											class="table"> 
											<thead>
												<tr>
													<th>模板编号</th>
													<th>模板名</th>
													<th>回复内容</th> 
													<th>模板ID</th>
													<th>状态</th>
												</tr>
											</thead> 
												
												<c:forEach items="${mytemplateList }" var="template">
												<tr>
													<td>${template.template_type_num }</td>
													<td>${template.template_msg_name }</td>
													<td>${fn:replace(template.template_type_content, "}}", "}}<br>")}</td>
													<td>${template.wx_template_id }</td>
													<td>
													<a href="javascript:;" style="padding:0px;margin: 0px;" onclick="updateTemplateState('${template.template_msg_id}','${template.state }')">
														<input type="checkbox"  value="0" class="state" <c:if test="${template.state==1 }">checked</c:if>>
													</a>
													</td>
												</tr>
												</c:forEach>
												
										</table>
									</div>
									</c:if>
									
								</div>
							</div>
							<!-- /form validation -->
		
			<!-- /content area -->
		</div>
		<!-- /main content -->
<%@include file="../common/footer.jsp"%>
<script>
$(document).ready(function(){
	$('#infoForm').validationEngine({ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'formError-white',
		scroll: true,
		showOneMessage: true
	}); 
	
	$(".state").each(function(i,e){
		 new Switchery(e, { color: '#00BCD4'}); 
	}); 
   
});

function autoSet(url){
	FullScreenShow("公众号自动设置模板消息最长可能需要1分钟，请耐心等待.");
	window.location.href=url;
} 

function updateTemplateState(template_msg_id,state){
	window.location.href="${pageContext.request.contextPath}/center/weixin/templateMessage/templateState?template_msg_id="+template_msg_id+"&state="+state;
} 
</script>