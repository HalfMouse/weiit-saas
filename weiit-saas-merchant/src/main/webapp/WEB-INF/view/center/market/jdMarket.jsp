<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content">
							<a href="#" class="btn bg-orange btn-rounded btn-block btn-xs">发布商品</a>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/product/onSaleList"><i class="icon-price-tag3"></i>出售中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/soldOutList"><i class="icon-flag3"></i>库存紧张商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/forSaleList"><i class="icon-make-group"></i>仓库中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productImport/list"><i class="icon-import"></i> 商品导入</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/market/jdMarket"><i class="icon-sphere"></i> 商品集市同步</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span class="text-semibold"> 商品集市</span>
							</h4>
						</div>
					</div>
			
				</div>
				<!-- /page header -->


				<!-- Content area -->
				<div class="content">
					<!-- Tabs -->
					<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
						<li class="active"><a href="jdMarket" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><img src="http://member.koudaiqifu.cn/statics/img/tab_icon/jd.png" alt="">京东商品</a></li>
					 	<li><a href="suningMarket" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><img src="http://member.koudaiqifu.cn/statics/img/tab_icon/sn.png" alt=""> 苏宁商品</a></li>
					 	<li><a href="tmallMarket" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><img src="http://member.koudaiqifu.cn/statics/img/tab_icon/zy.png" alt="">天猫商品</a></li> 
						<li><a href="recommendMarket" class="btn border-primary text-primary btn-flat btn-rounded btn-icon btn-sm"><img src="http://member.koudaiqifu.cn/statics/img/tab_icon/jx.png" alt=""> 精选商品</a></li> 
					</ul>
					<!-- /tabs -->
					<!-- Search field -->
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<form class="form-horizontal form-validate-jquery" name="searchform" id="searchform" action=""  method="post">
			         		<div class="row">
								<div class="col-md-3">
									<div class="input-group">
										<span class="input-group-addon">商品名称：</span> <input type="text"
											class="form-control" placeholder="" name="product_name" value="">
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">一级分类</span> <select
											class="bootstrap-select" data-width="100%" name="status"
											id="state">
											<option value="">--全部--</option>
											<option value="" selected>--3C数码--</option>
										</select>
									</div>
								</div>
								<div class="col-md-2">
									<div class="input-group">
										<span class="input-group-addon">二级分类</span> <select
											class="bootstrap-select" data-width="100%" name="status"
											id="state">
											<option value="">--全部--</option>
											<option value="" selected>--电脑配件--</option>
										</select>
									</div>
								</div>
								
								&nbsp;&nbsp;
								<button class="btn bg-blue" type="submit">搜索</button>
							</div>
							</form>
			            
						</div>
					</div>
					<!-- /search field -->
					
					<div class="panel panel-flat">
						<div class="table-responsive">
							<table id="data-table" class="table">
								<thead>
									<tr>
										<th><input type="checkbox" name="selectAll" onclick="allCheckClick(this)" value="0" /></th>
										<th class="col-xs-5">商品名称</th>
										<th class="col-xs-1">市场价</th>
										<th class="col-xs-1">会员价</th>
										<th class="col-xs-1">总库存</th>
										<th class="col-xs-1">总销量</th>
										<th class="col-xs-2">供应商</th>
										<th class="col-xs-1">操作</th>
									</tr>
								</thead>
								<tbody>
										<tr>
											<td><input type="checkbox" name="ids" value=""></td>
											<td>
												<img src="http://image1.suning.cn/uimg/b2c/newcatentries/0000000000-000000000101691973_1_400x400.jpg" width="80px" height="80px">
												云南白药牙膏留兰香型120g
											</td>
											<td>¥21.60</td>
											<td>¥21.17</td>
											<td>300</td>
											<td>60</td>
											<td>京东</td>
											<td>
											<a href="#">挑选</a>
											</td>
										</tr>
										<tr>
											<td><input type="checkbox" name="ids" value=""></td>
											<td>
												<img src="http://img10.360buyimg.com/n7/g10/M00/16/00/rBEQWFFuKEgIAAAAAAHN6rn5plEAAETQwGeeYkAAc4C539.jpg" width="80px" height="80px">
												 快美特 汽车车载车用座式香水消臭剂 L23 海洋Natural SPA
											</td>
											<td>¥21.60</td>
											<td>¥21.17</td>
											<td>300</td>
											<td>60</td>
											<td>京东</td>
											<td>
											<a href="#">挑选</a>
											</td>
										</tr>
										<tr>
											<td><input type="checkbox" name="ids" value=""></td>
											<td>
												<img src="http://img10.360buyimg.com/n7/g15/M03/08/00/rBEhWlIkOMEIAAAAAAGOjCgVTrMAACsggOW5XMAAY6k094.jpg" width="80px" height="80px">
												 山泽（SAMZHE）SM-8822 HDMI数字高清线 2米
											</td>
											<td>¥21.60</td>
											<td>¥21.17</td>
											<td>300</td>
											<td>60</td>
											<td>京东</td>
											<td>
											<a href="#">挑选</a>
											</td>
										</tr>
								</tbody>
							</table>
			
						</div>
						
						<div id="pager" class="panel-body">
					
								<div style="margin-left: -10px; margin-bottom: 20px;">
									<button type="button" class="btn btn-default">
										<input type="checkbox" name="selectAll" onclick="allCheckClick(this)" value="1" />&nbsp;全选/不选
									</button>
									<button type="button" onclick="BatchWIremove()" class="btn btn-default" data-toggle="modal" data-target="#remove_batch_modal">
										<i class="icon-trash"></i> 批量删除
									</button>
								</div>
						</div>
					</div>
					
					
				</div>
				<!-- /content area -->
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
			
