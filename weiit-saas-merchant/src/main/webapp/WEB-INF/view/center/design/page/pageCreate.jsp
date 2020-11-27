<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
<style>
	.content {
		padding: 20px 20px;
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
	}

	.content-wrapper {
		position: relative;
	}

</style>
			<!-- Secondary sidebar -->
<img src="http://wstore-1255653546.image.myqcloud.com/weiit_shop_platform/2018-07-12/94a09977-3b56-44bd-ae05-c1b2056c25f9.png" >
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>店铺装修</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li  class="active"><a href="${pageContext.request.contextPath}/center/design/page/pageList"><i class="icon-html5"></i>微页面</a></li>
								<li ><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i class="icon-cube4"></i>底部菜单</a></li>
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
				<!-- Content area -->
				<div class="content" >
					<iframe  src="${sessionScope.fitDomain}?pageStyle=${sessionScope.style}&templateId=${sessionScope.templateId}&token=${sessionScope.token}"  frameborder="0"  width="100%" height="100%"></iframe>
<%--
					<iframe  src="${pageContext.request.contextPath}/pageAddOrEdit?pageStyle=${sessionScope.style}&templateId=${sessionScope.templateId}&token=${sessionScope.token}"  frameborder="0"  width="100%" height="100%"></iframe>
--%>
				</div>
				<!-- /content area -->
				
				
			
				
			</div>
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			
			<script>
			$(document).ready(function() { 
				if("${infoMap.global_type}"!=""){
					$("input[name=global_type][value=${infoMap.global_type}]").prop("checked",true);
					$("input[name=global_type][value=${infoMap.global_type}]").trigger('click'); 
					globalClick('${infoMap.global_type}','${infoMap.global_bg1}','${infoMap.global_bg2}');
				}
			}); 
			
			function globalClick(type,bg1,bg2){
				$("#global_bg1").val(bg1);
				$("#global_bg2").val(bg2);
				$("#globalImg").attr("src","${pageContext.request.contextPath}/resource/images/custom/global"+type+".png?1");
			}
			
			</script>
						
