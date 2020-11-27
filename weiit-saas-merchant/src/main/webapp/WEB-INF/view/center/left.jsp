<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="weiyun" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!-- Page container -->
<div class="page-container">

	<!-- Page content -->
	<div class="page-content">

		<!-- Main sidebar -->
		<div class="sidebar sidebar-main">
			<div class="sidebar-content">

				<!-- Main navigation -->
				<div class="sidebar-category sidebar-category-visible">
					<div class="category-content no-padding">
						<ul class="navigation navigation-main navigation-accordion">
							
							<li><a href="${pageContext.request.contextPath}/center/dashboard/dashboard" target="rightIframe"><i class="icon-home4"></i> <span>概况</span></a></li>	
							<li><a href="${pageContext.request.contextPath}/center/design/page/pageList" target="rightIframe"><i class="icon-store"></i> <span>店铺</span></a></li>
							
							<li class="navigation-header"><span>数据</span> <i class="icon-menu" title="数据"></i></li>
							<li><a href="${pageContext.request.contextPath}/center/product/onSaleList" target="rightIframe"><i class="icon-price-tag3"></i> <span>商品</span></a></li>	
							<li><a href="${pageContext.request.contextPath}/center/order/orderList" target="rightIframe"><i class="icon-file-text"></i> <span>订单</span></a></li>	
							<li><a href="${pageContext.request.contextPath}/center/user/userList" target="rightIframe"><i class="icon-user"></i> <span>客户</span></a></li>
							<li><a href="${pageContext.request.contextPath}/center/analyse/dashboard" target="rightIframe"><i class="icon-chart"></i> <span>数据</span></a></li>	
							
							<li class="navigation-header"><span>我的</span> <i class="icon-menu" title="我的"></i></li>
							<li><a href="${pageContext.request.contextPath}/center/ump/dashboard" target="rightIframe"><i class="icon-puzzle2"></i> <span>营销</span></a></li>	
							<li><a href="${pageContext.request.contextPath}/center/setting/shopInfo" target="rightIframe"><i class="icon-gear"></i> <span>设置</span></a></li>
						</ul>
					</div>
				</div>
				<!-- /main navigation -->
			</div>
		</div>
		<!-- /main sidebar -->
	</div>
</div>
<!-- /page container -->
