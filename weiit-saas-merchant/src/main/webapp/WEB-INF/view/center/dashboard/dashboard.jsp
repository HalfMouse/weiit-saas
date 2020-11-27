<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp"%>
<link href="${pageContext.request.contextPath}/resource/css/jquery.pagewalkthrough.css" rel="stylesheet" type="text/css">
<meta name="referrer" content="never">
<!-- Main content -->
<div class="content-wrapper">

	<!-- Content area -->
	<div class="content">

		<div class="row">
			<div class="col-md-12">
				<div class="my">
					<form class="form-horizontal form-validate-jquery">
						<div class="form-group" style="background: ">
							<label class="col-md-2" style="max-width:120px;"> 
							 	<a href="${pageContext.request.contextPath}/center/setting/shopInfo"><img src="${imageDomain }${shopMap.shop_logo }" class="img-circle" width="128" height="128"/></a>
							</label> 
							<div class="col-md-6" style="margin-left: 5rem; border-right: 1px solid white;">
								<span class="text-bold text-muted">
								<br>店铺名称:${shopMap.shop_name}<br>
								</span>
								<br>
								<span class="text-bold text-muted">店铺认证:</span>
									<c:if test="${shopMap.is_auth eq -1 or shopMap.is_auth==null}"><span class="text-default text-bold"><i class="icon-shield-check"></i>未认证</span></c:if>
									<c:if test="${shopMap.is_auth eq 0}"><span class="text-warning text-bold"><i class="icon-shield-check"></i>认证中</span></c:if>
							    	<c:if test="${shopMap.is_auth eq 1}"><span class="text-success text-bold"><i class="icon-shield-check"></i>已认证</span></c:if>
								<br><br> 
								<span class="text-muted text-bold">有效期:</span>
								<span class="text-success text-bold"><fmt:formatDate value="${sessionScope.merchant.version_expire_time}" pattern="yyyy-MM-dd hh:mm:ss"/></span><br>
								
								
							</div>
							<div class="col-md-6 step_frequent" >
								<br>
								<br>
								<br>
								<div >
									<a href="${pageContext.request.contextPath}/center/product/releaseOne?saleOld=1" class="btn btn-xs bg-blue btn-icon" onclick=""><i class="icon-diff-added position-left"></i>添加商品</a>&nbsp;
									<a href="${pageContext.request.contextPath}/center/design/page/pageList" class="btn btn-xs btn-default" onclick=""><i class="icon-hammer position-left"></i>店铺装修</a>&nbsp;
									<a href="javascript:;" class="btn btn-xs btn-default" onclick="hoverShowDiv(this)" onmouseout="hoverHiddendiv()"><i class="icon-mobile position-left"></i>访问店铺</a>&nbsp;
								</div>
							</div>
						</div>
						<div class="form-group" style="background: #F7F7F7">
							<br> 
							<div class="container-fluid">
									<div class="row text-center">
										<div class="col-md-2 step_sending">
											<div class="content-group ">
												<a href="${pageContext.request.contextPath}/center/order/orderList?state=1">
												<h6 class="text-bold"  style="font-size:22px;"><span class="text-bold text-info">${orderMap.no_send_order_count}</span></h6>
												<h4><span class="text-bold text-muted" style="color:#555">待发货订单</span></h4>
												</a>
											</div> 
										</div>
										<div class="col-md-2 step_rights">
											<div class="content-group">
												<a href="${pageContext.request.contextPath}/center/order/refundOrderList?state=0">
												<h6 class="text-bold"  style="font-size:22px;"><span class="text-bold text-danger">${orderMap.after_sale_order_count}</span></h6>
												<h4><span class="text-bold" style="color:#555">维权订单</span></h4>
												</a>
											</div>
										</div>
										<div class="col-md-2">
											<div class="content-group">
												<h6 class="text-bold text-success"  style="font-size:22px;">${orderMap.today_count}</h6>
												<h4><span class="text-bold" style="color:#555">今日订单</span></h4>
											</div>
										</div>
										<div class="col-md-2">
											<div class="content-group">
												<h6 class="text-bold text-success"  style="font-size:22px;"><fmt:formatNumber type="number" value="${orderMap.today_total}" pattern="0.00" maxFractionDigits="2"/></h6>
												<h4><span class="text-bold" style="color:#555">今日交易额</span></h4> 
											</div>
										</div>
										<div class="col-md-2">
											<div class="content-group">
												<h6 class="text-bold text-muted"  style="font-size:22px;">${orderMap.yesterday_count}</h6>
												<h4><span class="text-bold text-muted">昨日订单</span></h4>
											</div>
										</div>
										<div class="col-md-2">
											<div class="content-group">
												<h6 class="text-bold text-muted"  style="font-size:22px;"><fmt:formatNumber type="number" value="${orderMap.yesterday_total}" pattern="0.00" maxFractionDigits="2"/> </h6>
												<h4><span class="text-bold text-muted">昨日交易额</span></h4>
											</div>
										</div>
										
									</div>
								</div>
								<br>
						</div>

						<div class="form-group" style="background: #F7F7F7">

							<div class="col-md-9" style="margin-left: 20px; border-right: 1px solid white;">
								<br>
								<h3>
									<span class="text-bold text-muted ">开启小程序商城</span>
								</h3>
								<br>
								<br> <span class="text-bold text-muted">条件:绑定微信小程序，将店铺拓展到小程序。如果你已经有“认证小程序”，更可以进入控制台管理发布。</span><br>
								<c:if test="${sessionScope.miniPublicInfo eq null }">
								<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span> <br>
								</c:if>
								<c:if test="${sessionScope.miniPublicInfo!=null }">
								<span class="text-bold text-muted">进度:</span><span class="text-bold text-success">已授权</span> <br>
								</c:if>
								<br>
								<br>

							</div>
							<div class="col-md-2" style="margin-left: 20px;">
								<br>
								<br>
								<br>
								<a href="${pageContext.request.contextPath}/center/miniprogram/miniPublicInfo" class="btn bg-blue btn-block btn-float btn-float-lg" id="step_maStart" >
										<i class="icon-cube4"></i><span>进入控制台</span>
									</a>
							</div>
						</div>
						
						<div class="form-group" style="background: #F7F7F7">

							<div class="col-md-9" style="margin-left: 20px; border-right: 1px solid white;">
								<br>
								<h3 class="mpStart">
									<span class="text-bold text-muted ">开启微信公众号微商城</span>
								</h3>
								<br>
								<br> <span class="text-bold text-muted">条件:绑定微信公众号，将店铺拓展到微信上。如果你是“认证订阅号”或“认证服务号”，可以进入控制台管理图文、自定义菜单、群发、自动回复。</span><br>
								<c:if test="${sessionScope.publicInfo eq null }">
								<span class="text-bold text-muted">进度:</span><span class="text-bold text-danger">未完成</span> <br>
								</c:if>
								<c:if test="${sessionScope.publicInfo!=null }"> 
								<span class="text-bold text-muted">进度:</span><span class="text-bold text-success">已授权</span> <br>
								</c:if>
								<br>
								<br>

							</div>
							<div class="col-md-2" style="margin-left: 20px;">
								<br>
								<br>
								<br>
								<a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo" class="btn bg-blue btn-block btn-float btn-float-lg" id="step_mpStart">
									<i class="icon-cube4"></i><span>进入控制台</span>
								</a>
							</div>
						</div>
						
						
					</form>
				</div>
			</div>
		</div>

	</div>
	<!-- /content area -->

</div>

<!-- <div style="width:300px;height:300px;border:1px solide #aaccff;position:absolute;top:130px;right:10px;"> 
	请用微信扫一扫!<br/>
	<img src="${imageDomain}/${shopMap.shop_qr_code}" width="200px" height="200px" />
</div> -->
<div style="width:120px;height:120px;border:1px solide #aaccff;position:absolute;top:30px;right:10px;display:none;" id="divHover"> 
	<c:choose>
		<c:when test="${sessionScope.miniPublicInfo!=null }">
			<p>请用微信扫一扫<br>
				<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${sessionScope.miniPublicInfo.qrcode_url }" width="100px" height="100px">
   		 	</p>
		</c:when>
		<c:otherwise>
			<c:if test="${sessionScope.publicInfo!=null }">
				<p>请用微信扫一扫<br>
					<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=${sessionScope.publicInfo.qrcode_url }" width="100px" height="100px">
   				 </p>
			</c:if>
			<c:if test="${sessionScope.publicInfo==null }">
				<span class="text-danger">请先授权</span> 
			</c:if>
		</c:otherwise>
	</c:choose>
</div>


<div id="walkthrough-content" style="display: none">
	<div id="walkthrough-1">

		<h1><span><img src="${pageContext.request.contextPath}/resource/images/intro/robot_top.png"></span><span class=" text-bold">欢迎来到${shopMap.shop_name}的后台店铺，小蜗在此恭候多时，
一起来体验${shopMap.shop_name}的功能吧！</span></h1>
	</div>

	<div id="walkthrough-2">
		<span >如果有新的订单，请点击这里查看需要发货的订单，及时跟进，了解最新订单状况。</span>
	</div>

	<div id="walkthrough-3">
		<span >这里可以查看客户发出的订单维权信息，让您能在第一时间收到客户反馈的意见并且处理维权订单。</span>
	</div>

	<div id="walkthrough-4">
		<span >这里是快捷通道，发布商品，装修精美店面  都可以点击过来！</span>
	</div>

	<div id="walkthrough-5">
		<span >小程序控制台，一键授权，系统自动发布审核，无需更多操作！方便简捷，进来开启你的小程序之旅吧</span>
	</div>
	<div id="walkthrough-6">
		<span >公众号控制台，您可以在这里完成 文章发布、自定义菜单、模板消息、自动回复，图文推送等操作，一个后台轻松管理</span>
	</div>
</div>


<!-- /main content -->
<%@include file="../common/footer.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.pagewalkthrough.js"></script>
<script>
$(function() {
    // Set up tour
	if(${sessionScope.page_dashboard ==null}){
        $('body').pagewalkthrough({
            name: 'introduction',
            steps: [
                { popup: {content: '#walkthrough-1',type: 'modal'}
                },
                {wrapper: 'div.step_sending',popup: {content: '#walkthrough-2',type: 'tooltip',position: 'bottom'}
                },
                {wrapper: 'div.step_rights',popup: {content: '#walkthrough-3',type: 'tooltip',position: 'bottom'}
                },
                {wrapper: 'div.step_frequent',popup: {content: '#walkthrough-4',type: 'tooltip',position: 'left'}
                },
                {wrapper: '#step_maStart',popup: {content: '#walkthrough-5',type: 'tooltip',position: 'left'}
                },
                {wrapper: '#step_mpStart',popup: {content: '#walkthrough-6',type: 'tooltip',position: 'left'}
                }
            ]

        });

        // Show the tour
        $('body').pagewalkthrough('show');
	}
});
</script>

<script>
	function hoverShowDiv(obj) {
		$("#divHover").show();
	}

	function hoverHiddendiv() {
		$("#divHover").hide();
	}
</script>