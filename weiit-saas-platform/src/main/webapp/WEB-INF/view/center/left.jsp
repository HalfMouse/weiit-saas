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
							
							<!-- 显示概况 --> 
							<li><a href="javascript:openOnRight('${pageContext.request.contextPath}/center/order/dashboard');" target="rightIframe"><i class="icon-home4"></i> <span>概况</span></a></li>
							
							<c:forEach items="${sessionScope.menuList }" var="menu">
								<weiyun:hasAnyRoles name="${menu.resource_sign }">
									
									<li><a href="#"><i class="${menu.css_icon }"></i> <span>${menu.resource_name }</span></a>
											<ul>
												<c:forEach items="${menu.children }" var="second">
													<c:choose>
														<c:when test="${fn:length(second.children)>0 }">
															<weiyun:hasAnyRoles name="${second.resource_sign }">
															<li>
																<a href="#"><i class="${second.css_icon }"></i> ${second.resource_name }</a>
																<ul>
																	<c:forEach items="${second.children }" var="third"><weiyun:hasAnyRoles name="${third.resource_sign }">
																	<li><a href="javascript:openOnRight('${pageContext.request.contextPath}${third.rest_url}');" target="rightIframe"><i class="${third.css_icon }"></i>${third.resource_name }</a></li>
																	</weiyun:hasAnyRoles></c:forEach>
																</ul>
															</li>
															</weiyun:hasAnyRoles>
														</c:when>
														<c:otherwise>
														<weiyun:hasAnyRoles name="${second.resource_sign }">
															<li><a href="javascript:openOnRight('${pageContext.request.contextPath}${second.rest_url}');" target="rightIframe"><i class="${second.css_icon }"></i>${second.resource_name }</a></li>
														</weiyun:hasAnyRoles>
														</c:otherwise>
													</c:choose>	
												</c:forEach>
											</ul>
										</li>
								</weiyun:hasAnyRoles>
							</c:forEach>
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

