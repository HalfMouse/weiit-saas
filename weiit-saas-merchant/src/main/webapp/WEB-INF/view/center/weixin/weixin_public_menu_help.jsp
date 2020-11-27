<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title></title>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<%@include file="../common/header.jsp"%>
</head>
<body >

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
	<div class="sidebar-content">
		<!-- Sub navigation -->
		<div class="sidebar-category">
			<div class="category-content no-padding">
				<ul class="navigation navigation-alt navigation-accordion">
					<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
					<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
					<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
					<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
				</ul>
			</div>
		</div>
		<!-- /sub navigation -->
	</div>
</div>	
<!--  /Secondary sidebar -->	

	<!-- begin #content -->
		<div id="content" class="content">
			<div class="wrapper  clearfix">
              <div class="btn-group m-r-5">
              		<a href="#" class="btn btn-success btn-sm p-l-20 p-r-20" onclick="javascript:history.go(-1);">返回</a>                                                
              </div>
            </div>	
			
			<!-- begin row -->
			<div class="row">
                <!-- begin col-12 -->
			    <div class="col-md-12">
			        <!-- begin panel -->
                    <div class="panel panel-inverse">
                        <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-repeat"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
                            <h4 class="panel-title">新手必读</h4>
                        </div>
                        <div class="panel-body">
                            <form action="/" method="POST">
								<div id="wizard">
									
									<!-- begin wizard step-1 -->
									<div>
                                        <fieldset>
                                            <legend class="pull-left width-full">微信公众号配置</legend>
                                            <!-- begin row -->
                                            <div class="row">
                                                <!-- begin col-12 -->
                                                <div class="col-md-12">
													<p>
													<font style='color:red;font-size:16px;font-weight:bold;'>1、公众号自定义菜单设置</font>
													<br>
													<font face="微软雅黑"><font size="4">一、功能路径</font></font><br>
													</font><font face="微软雅黑"><font size="3"><font color="#696969">微云时代后台————公众号管理——微信菜单自定义</font></font></font><font color="#696969"><br>
													</font><br>
													<font color="#ff8c00"><font face="微软雅黑"><font size="4">二、操作流程</font></font><br>
													</font><font size="3"><font color="#696969"><font face="微软雅黑">1.</font><font face="微软雅黑">开启菜单；</font></font></font><br>
													<font size="3"><font color="#696969"><font face="微软雅黑">2.点击添加一级菜单，设置回复内容，选择跳转URL,如果需要二级菜单，此项无需不设置</font></font></font><br>
													<font size="3"><font color="#696969"><font face="微软雅黑">3.点击添加二级菜单，设置回复内容，选择跳转URL</font></font></font><br>
													<font size="3"><font color="#696969"><font face="微软雅黑">4.点击同步配置到微信</font></font></font>
													<font face="微软雅黑"><font size="3"><font color="#000000"><br>
													</font></font></font><br>
													<font color="#ff8c0"><font face="微软雅黑"><font size="4">
													<img src="http://image.1taotuan.com/4283d437-b49e-41b5-a15f-2f30edfa3d87"  width="100%"/>
													<img src="http://image.1taotuan.com/57f96d25-3991-4b06-9f5e-56043f30ad52"  width="100%"/>
													<br>
													<br>

													</p>
													<p>
													<font face="微软雅黑"><font size="4">三、场景案例</font></font>
													<br>
													<img src="http://image.1taotuan.com/adbf0697-67cd-4686-9746-d66dfeb49aee"  width="30%" height="40%"/>
													<br>
													<br>
													</p>								
                                                </div>
                                                <!-- end col-12 -->
                                                
                                            </div>
                                            <!-- end row -->
										</fieldset>
									</div>
									<!-- end wizard step-1 -->
								</div>
							</form>
                        </div>
                    </div>
                    <!-- end panel -->
                </div>
                <!-- end col-12 -->
            </div>
            <!-- end row -->
		</div>
		<!-- end #content -->

	
	<%@include file="../common/footer.jsp"%>
	<script src="${pageContext.request.contextPath}/admin/assets/js/form-wizards.demo.min.js"></script>
	<script>
			$(document).ready(function() {
				TableManageTableTools.init();
 
				FormWizard.init();
				
		
			});

		
		</script>
</body>
</html>