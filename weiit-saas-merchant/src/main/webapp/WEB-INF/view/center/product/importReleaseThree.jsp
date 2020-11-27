<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.config.js"></script>
        <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.all.min.js"></script>
        <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
        <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
        <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>					

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content">
							<a href="${pageContext.request.contextPath}/center/product/releaseOne?saleOld=1" class="btn bg-orange btn-rounded btn-block btn-xs">发布商品</a>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="${pageContext.request.contextPath}/center/product/onSaleList"><i class="icon-price-tag3"></i>出售中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/soldOutList"><i class="icon-flag3"></i>库存紧张商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/product/forSaleList"><i class="icon-make-group"></i>仓库中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productTag/list"><i class="icon-price-tags"></i> 商品标签</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productGroup/list"><i class="icon-paragraph-justify2"></i> 商品分组</a></li>
								<li class="active"><a href="${pageContext.request.contextPath}/center/productImport/list"><i class="icon-import"></i> 商品导入</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper" >
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content" >
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold"> 商品导入 </span>
				</h4>
			</div>
		</div>
	</div>

	<!-- Content building -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">

			<div class="panel-body">
				<ul class="nav nav-pills col-sm-12  alert-primary">
					<li class="col-sm-3 text-center">
						<span  style="color:black;"> 1.选择商品品类
							<i class="icon-arrow-right15 position-right"></i>
							<i class="icon-arrow-right15 position-right"></i></span></li>
					<li class="col-sm-3 text-center">
						<a href="javascript:;" onclick="checkStep22();"> 2.编辑基本信息
							<i class="icon-arrow-right15 position-right"></i>
							<i class="icon-arrow-right15 position-right"></i></a></li>
					<li class="active col-sm-3 text-center">
						<a href="javascript:;" > 3.编辑商品详情
							<i class=" icon-check position-right"></i></a></li>
				</ul>

				<form class="form-horizontal" action="" name="form-wizard" id="form-wizard"  method="POST" >
					<div id="wizard" class="bwizard clearfix">
						<div class="well">
							<div class="wizard-step-1 bwizard-activated" id="step1" style="margin-top:20px">
								<div class="form-group">
 									 <script id="editor" type="text/plain" style="width:100%;height:300px;"></script>
								</div>
							</div>
						</div>
						<ul class="pager bwizard-buttons">
							 <li class="previous " role="button" aria-disabled="true">
		                        <a href="javascript:;"  onclick="checkStep22();">← 上一步</a></li>
		                     <li class="next" id="buttonli" role="button" aria-disabled="false">
		                       <a href="javascript:;" id="buttonsave"  onclick="saveProduct();">完成保存</a></li>
						</ul>
					</div>
				</form>
			</div>

		</div>
		<!-- /bordered striped table -->
	</div>
	<!-- /content building -->
</div>
<!-- /main content -->
 
<%@include file="../common/footer.jsp" %>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var ue = UE.getEditor('editor');

$(document).ready(function() {
  //UE.getEditor('editor').setContent("ddd");
   ue.addListener("ready", function () {
    	// editor准备好之后才可以使用
    	ue.setContent('${productSession.editorValue}');
  });
	
});

function allowDistribution(isAllowDistribution) {
  if (isAllowDistribution == '1') {
    $("#distributionTotalPriceDiv").attr("class", "form-group show");
  } else {
    $("#distributionTotalPriceDiv").attr("class", "form-group hidden");
    $("#distributionTotalPrice").attr("value", "0");
  }

}

function checkStep11(){
	  $('#form-wizard').attr("action", "${pageContext.request.contextPath}/center/productImport/releaseOne?oneflag=1" );
	  $("#form-wizard").submit();
}

function checkStep22(){
	  $('#form-wizard').attr("action", "${pageContext.request.contextPath}/center/productImport/releaseTwo?oneflag=1" );
	  $("#form-wizard").submit();
}

function saveProduct(){
	  $("#buttonli").addClass("disabled");
	  $("#buttonsave").removeAttr('href');
	  $("#buttonsave").removeAttr('onclick');
	  $('#form-wizard').attr('action', '${pageContext.request.contextPath}/center/productImport/save'  );
	  $("#form-wizard").submit();
}
</script>