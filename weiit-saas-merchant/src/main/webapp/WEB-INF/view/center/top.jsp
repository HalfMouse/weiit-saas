<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="weiyun" uri="http://shiro.apache.org/tags"%>
<!-- Main navbar -->
<div class="navbar navbar-inverse" style="position:fixed; top:0; left: 0; width: 100%" >
	<div class="navbar-header">
		<a class="navbar-brand" href="index.html"><img
			src="${pageContext.request.contextPath}/resource/images/logo_light.png"
			alt=""></a>

		<ul class="nav navbar-nav pull-right visible-xs-block">
			<li><a data-toggle="collapse" data-target="#navbar-mobile"><i
					class="icon-tree5"></i></a></li>
			<li><a class="sidebar-mobile-main-toggle"><i
					class="icon-paragraph-justify3"></i></a></li>
		</ul>
	</div>

	<div class="navbar-collapse collapse" id="navbar-mobile">
		<ul class="nav navbar-nav">
			<li><a class="sidebar-control sidebar-main-toggle hidden-xs" onclick="onleft()"><i class="icon-paragraph-justify3"></i></a></li>
		</ul>

		<ul class="nav navbar-nav navbar-right">
			<!-- <li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-comment-discussion"></i>
						<span class="visible-xs-inline-block position-right">系统消息</span>
						<span class="badge bg-warning-400">2</span>
					</a>
					
					<div class="dropdown-menu dropdown-content width-350">
						<div class="dropdown-content-heading">
							系统消息
							
						</div>

						<ul class="media-list dropdown-content-body">
							<li class="media">
								<div class="media-left">
									<img src="assets/images/placeholder.jpg" class="img-circle img-sm" alt="">
									<span class="badge bg-danger-400 media-badge">5</span>
								</div>

								<div class="media-body">
									<a href="#" class="media-heading">
										<span class="text-semibold">新用户通知</span>
										<span class="media-annotation pull-right">04:58</span>
									</a>

									<span class="text-muted">感谢您的使用，对我们产品的大力支持.</span>
								</div>
							</li>
						</ul>
						<div class="dropdown-content-footer">
							<a href="#" data-popup="tooltip" title="所有消息"><i class="icon-menu display-block"></i></a>
						</div>
					</div>
				</li> -->
				<li class="dropdown dropdown-user">
				<a class="dropdown-toggle" data-toggle="dropdown"> 
					<img src="${pageContext.request.contextPath}/resource/images/placeholder.jpg" alt=""> <span>${sessionScope.merchant.account } </span> 
					<i class="caret"></i>
				</a>

				<ul class="dropdown-menu dropdown-menu-right">
					 <li><a href="${pageContext.request.contextPath}/center/account/version"  target='rightIframe'>
					 <span class="badge badge-warning pull-right"> 
					 <c:if test="${empty sessionScope.merchant.version_num }">试用版</c:if>
					 <c:if test="${!empty sessionScope.merchant.version_num }">${sessionScope.merchant.version_name }</c:if>
					 </span>
					 <i class="icon-versions"></i>系统版本</a>
					 </li> 
					<!-- <li><a href="${pageContext.request.contextPath}/center/account/myInfo" target='rightIframe'><i class="icon-user-plus"></i>我的账户</a></li>-->
					 
					<li><a href="${pageContext.request.contextPath}/center/file/picture/list?parent_id=-1" target='rightIframe'><i class="icon-file-picture"></i>我的文件</a></li> 
					<li class="divider"></li>
					<li><a href="${pageContext.request.contextPath}/center/account/password" target='rightIframe' ><i class="icon-key"></i>修改密码</a></li>
					<li><a href="${pageContext.request.contextPath}/center/account/logout" ><i class="icon-switch2"></i>退出</a></li>
				</ul>
			 </li>
		</ul>
	</div>
</div>
<!-- /main navbar -->
<script>
var leii=0;
function onleft(){
	if(leii==0){
		leii=1;
		$("#left").css("width","50px");
		$("#right").css("padding-left","50px");
	}else{
		leii=0;
		$("#left").css("width","110px");
		$("#right").css("padding-left","110px");
	}
}
function closeForm(){
	$("#frequentResource").parent().removeClass("open");
}

</script>