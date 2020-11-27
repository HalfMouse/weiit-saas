<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="shopInfo"><i class="icon-store"></i>店铺设置</a></li>
								<li  class="active"><a href="shopTestEvaluation"><i class="icon-medal"></i>店铺测评</a></li>
								<li><a href="protocol"><i class="icon-file-text2"></i>服务协议</a></li>
								<li><a href="securityTrade"><i class="icon-file-check"></i>消费保障</a></li>
								<li><a href="payment"><i class="icon-credit-card"></i>支付/交易</a></li>
								<li><a href="delivery"><i class="icon-truck"></i>物流配送</a></li>
								<li><a href="password"><i class="icon-key"></i> 修改密码</a></li>
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
							<!-- 表单验证开始 -->
							<div class="panel panel-flat" >

								<div class="panel-body">
									<div class="my">
										<form class="form-horizontal form-validate-jquery" action="" method="post"  enctype="multipart/form-data">
											<fieldset class="content-group">
												<legend class="text-bold"><h5>店铺测评</h5></legend>
											</fieldset>
											<div class="form-group" style="background:#EFEFEF">
												<label class="control-label col-md-1">
													<img src="${pageContext.request.contextPath}/resource/images/placeholder.jpg" class="img-circle"/>
												</label>
												<div class="col-md-9" style="margin-left:20px;border-right:1px solid white;">
													<span class="text-bold text-muted">
														
														<br>店铺名称:香港代购官网<br><br>
														注册时间:2017-06-12 16:30:47<br>
														<br>测评结果:&nbsp;<span class="text-bold text-orange">新手</span>
													</span>
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br><a href="javascript:;"  class="btn bg-orange btn-rounded btn-icon" onclick="" ><i class="icon-search4"></i>马上检测</a>
												</div>
											</div>
											
											<div class="form-group" style="background:#EFEFEF">
												
												<div class="col-md-10" style="margin-left:20px;border-right:1px solid white;">
													<br><h3><span class="text-bold text-muted">创建店铺</span></h3><br><br>
													<span class="text-bold text-muted">条件:注册帐号，并成功创建店铺，即算完成任务</span><br>
													<span class="text-bold text-muted">进度:</span><span class="text-bold text-success">完成</span>
													<br><br><br>
													
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br>
													<button class="btn bg-slate-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>学习指引</span></button>
												</div>
											</div>
											
											<div class="form-group" style="background:#EFEFEF">
												
												<div class="col-md-10" style="margin-left:20px;border-right:1px solid white;">
													<br><h3><span class="text-bold text-muted">绑定微信公众号</span></h3><br><br>
													<span class="text-bold text-muted">条件:绑定微信公众号，将店铺拓展到微信上。如果你是“认证订阅号”或“认证服务号”，还可以直接在后台和粉丝进行实时会话，更可以开启高级的“客户”管理模块。点击右侧“任务教程”进行设置吧。</span><br>
													<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span>
													<br><br><br>
													
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br>
													<button class="btn bg-slate-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>学习指引</span></button>
												</div>
											</div>
											
											<div class="form-group" style="background:#EFEFEF">
												
												<div class="col-md-10" style="margin-left:20px;border-right:1px solid white;">
													<br><h3><span class="text-bold text-muted">商品上架</span></h3><br><br>
													<span class="text-bold text-muted">条件:注进入“商品”管理页面，并尝试自己上架一件商品</span><br>
													<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span>
													<br><br><br>
													
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br>
													<button class="btn bg-slate-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>学习指引</span></button>
												</div>
											</div>
											
											<div class="form-group" style="background:#EFEFEF">
												
												<div class="col-md-10" style="margin-left:20px;border-right:1px solid white;">
													<br><h3><span class="text-bold text-muted">完善店铺信息</span></h3><br><br>
													<span class="text-bold text-muted">条件:需要你补充一些相关信息，以便我们提供更有针对性的店铺诊断和运营服务。填写商家信息登记表并提交即可完成任务。</span><br>
													<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span>
													<br><br><br>
													
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br>
													<button class="btn bg-slate-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>学习指引</span></button>
												</div>
											</div>
											
											<div class="form-group" style="background:#EFEFEF">
												
												<div class="col-md-10" style="margin-left:20px;border-right:1px solid white;">
													<br><h3><span class="text-bold text-muted">装修店铺主页</span></h3><br><br>
													<span class="text-bold text-muted">条件:店铺主页即你的店铺门面。我们提供了多样的主页模板，你可以根据自己的需要去定制、装修你的主页。现在进入“店铺”栏目 - “微页面”，尝试修改店铺主页的内容，即可完成任务。</span><br>
													<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span>
													<br><br><br>
													
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br>
													<button class="btn bg-slate-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>学习指引</span></button>
												</div>
											</div>
											
											<div class="form-group" style="background:#EFEFEF">
												
												<div class="col-md-10" style="margin-left:20px;border-right:1px solid white;">
													<br><h3><span class="text-bold text-muted">有第一笔收入</span></h3><br><br>
													<span class="text-bold text-muted">条件:产生第一笔订单，有买家完成付款既算完成任务。你可以自己测试购买一次，体验下购买流程，也算完成任务哦~</span><br>
													<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span>
													<br><br><br>
													
												</div>
												<div class="col-md-1" style="margin-left:20px;">
													<br><br><br>
													<button class="btn bg-slate-300 btn-block btn-float btn-float-lg" type="button"><i class="icon-play"></i> <span>学习指引</span></button>
												</div>
											</div>
											
										</form>
									</div>
								</div>
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
			var weixin_pay = document.querySelector('.weixin_pay');
		    new Switchery(weixin_pay, { color: '#00BCD4'});
		    
		    var ali_pay = document.querySelector('.ali_pay');
		    new Switchery(ali_pay, { color: '#00BCD4'});
		    
		    var hd_pay = document.querySelector('.hd_pay');
		    new Switchery(hd_pay, { color: '#00BCD4'});
		    
		    var bank_pay = document.querySelector('.bank_pay');
		    new Switchery(bank_pay, { color: '#00BCD4'});
			</script>