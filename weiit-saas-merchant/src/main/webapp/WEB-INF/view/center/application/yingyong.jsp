<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/visualization/echarts/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/charts/echarts/charts.js"></script>
			
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:260px;">
				<div class="sidebar-content">
			
					<!-- Action buttons -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>我的应用</span>
							<ul class="icons-list">
								<li><a href="#" data-action="collapse"></a></li>
							</ul>
						</div>
			
						<div class="category-content">
							<div class="row">
								<div class="col-xs-6">
									<button class="btn bg-warning-400 btn-block btn-float btn-float-lg" type="button"><i class="icon-display"></i> <span>我的项目</span></button>
									<button class="btn bg-purple-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>了解应用</span></button>
								</div>
											
								<div class="col-xs-6">
									<button class="btn bg-info-400 btn-block btn-float btn-float-lg" type="button"><i class="icon-cloud"></i> <span>云市场</span></button>
									<button class="btn bg-green btn-block btn-float btn-float-lg" type="button"><i class="icon-file-text2"></i> <span></span>企业测评</button>
								</div>
							</div>
						</div>
					</div>
					<!-- /action buttons -->
								
					<!-- Revisions -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>最近使用项目</span>
							<ul class="icons-list">
								<li><a href="#" data-action="collapse"></a></li>
							</ul>
						</div>
			
						<div class="category-content">
							<ul class="media-list">
								<li class="media">
									<div class="media-left">
										<a href="#" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><i class="icon-mobile2"></i></a>
									</div>
			
									<div class="media-body">
										微信商城1.0版本系统
										<div class="media-annotation">2017-10-04</div>
									</div>
								</li>
			
								<li class="media">
									<div class="media-left">
										<a href="#" class="btn border-warning text-warning btn-flat btn-rounded btn-icon btn-sm"><i class="icon-display"></i></a>
									</div>
												
									<div class="media-body">
										门店餐饮系统
										<div class="media-annotation">2017-08-04</div>
									</div>
								</li>
			
							</ul>
						</div>
					</div>
					<!-- /revisions -->
								
					<!-- Revisions -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>他们在使用</span>
							<ul class="icons-list">
								<li><a href="#" data-action="collapse"></a></li>
							</ul>
						</div>
			
						<div class="category-content">
							<ul class="media-list">
								<li class="media">
									<div class="media-left">
										<a href="#" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><i class="icon-git-pull-request"></i></a>
									</div>
			
									<div class="media-body">
										微邦互联科技使用 <a href="#">门店餐饮系统</a> 收款99.00元
										<div class="media-annotation">1分钟前</div>
									</div>
								</li>
			
								<li class="media">
									<div class="media-left">
										<a href="#" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><i class="icon-git-pull-request"></i></a>
									</div>
			
									<div class="media-body">
										微邦互联科技使用 <a href="#">门店餐饮系统</a> 收款99.00元
										<div class="media-annotation">1分钟前</div>
									</div>
								</li>
								<li class="media">
									<div class="media-left">
										<a href="#" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><i class="icon-git-pull-request"></i></a>
									</div>
			
									<div class="media-body">
										微邦互联科技使用 <a href="#">门店餐饮系统</a> 收款99.00元
										<div class="media-annotation">1分钟前</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!-- /revisions -->
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header">

					<!-- Header content -->
					<div class="page-header-content">
						<div class="page-title">
							<h4><i class="icon-home2 position-left"></i>应用</h4>
							<ul class="breadcrumb position-right">
								<li><a href="index.html">应用</a></li>
								<li class="active"> 应用项目列表</li>
							</ul>
							
						</div>

						<div class="heading-elements">
							<a href="#" class="btn bg-blue btn-labeled heading-btn"><b><i class="icon-diff-added"></i></b> 创建项目</a>
							<a href="#" class="btn btn-default btn-icon heading-btn"><i class="icon-gear"></i></a>
						</div>
					</div>
					<!-- /header content -->
				</div>
				<!-- /page header -->

				<!-- Content area -->
				<div class="content">
						
					
						<!-- Search results -->
						<div class="content-group">
	
							<div class="search-results-list content-group">
								<!-- Tasks grid -->
								<div class="text-center content-group text-muted content-divider">
									<span class="pt-10 pb-10">我的项目</span>
								</div>
								<!--/Tasks grid  -->
								
								<div class="row">
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/1204035a-1490-40d9-aa92-fd6f77f56916" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/1204035a-1490-40d9-aa92-fd6f77f56916" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>管理项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">微信商城-服务号版</a></h6>
												<span class="text-muted">让每一个中小型企业快速搭建自己的服务号商城</span>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/40e997ab-9d5a-4493-a00b-d4994a1e8fe9" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/40e997ab-9d5a-4493-a00b-d4994a1e8fe9" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>管理项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">微信商城-小程序版</a></h6>
												<span class="text-muted">让每一个中小型企业快速搭建自己的小程序商城.</span>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/e709e105-f494-434c-a4d4-58a5cbbe52ec" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/e709e105-f494-434c-a4d4-58a5cbbe52ec" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>管理项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">外卖商城-服务号版</a></h6>
												<span class="text-muted">专门针对外卖行业的的微信电商解决方案</span>
											</div>
										</div>
									</div>
								</div>
								
								<!-- Tasks grid -->
								<div class="text-center content-group text-muted content-divider">
									<span class="pt-10 pb-10">推荐项目</span>
								</div>
								<!--/Tasks grid  -->
								
								<div class="row">
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>创建项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">单店微信商城-【服务号】</a></h6>
												<span class="text-muted">快速搭建自己的微信商城</span>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>创建项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">多商户微信商城-【服务号】</a></h6>
												<span class="text-muted">快速搭建自己的微信商城</span>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>创建项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">O2O微信商城-【服务号】</a></h6>
												<span class="text-muted">快速搭建自己的微信商城</span>
											</div>
										</div>
									</div>
									<div class="col-md-3">
										<div class="thumbnail">
											<div class="thumb">
												<img src="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" alt="" width="268" height="526">
												<div class="caption-overflow">
													<span>
														<a href="http://image.1taotuan.com/4c4e0022-9de5-41b3-9add-54b5dc54904c" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-zoomin3"></i>预览</a>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>创建项目</a>
													 </span>
												</div>
											</div>
	
											<div class="caption">
												<h6 class="text-bold"><a href="#" class="text-default">智慧社区-【服务号】</a></h6>
												<span class="text-muted">快速搭建自己的微信商城</span>
											</div>
										</div>
									</div>
								</div>
		                    </div>
	
						</div>
						<!-- /search results -->

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
			
			<script>
			$(function() {

			    // Reverse last 3 dropdowns orientation
			    $('.content > .row').slice(-1).find('.dropdown, .btn-group').addClass('dropup');


			    // Multiple switchery toggles
			    if (Array.prototype.forEach) {
			        var elems = Array.prototype.slice.call(document.querySelectorAll('.switch-mode'));

			        elems.forEach(function(html) {
			            var switchery = new Switchery(html);
			        });
			    }
			    else {
			        var elems = document.querySelectorAll('.switch-mode');

			        for (var i = 0; i < elems.length; i++) {
			            var switchery = new Switchery(elems[i]);
			        }
			    }
			    
			});

			</script>		
