<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

<style>@charset "UTF-8"; .flipInY,.pulse { -webkit-animation-duration:1s; -webkit-animation-fill-mode:both } body { min-width:100%; font-size:12px; line-height:1.5em; font-family:"Helvetica Neue",STHeiti,"Microsoft YaHei",Verdana,Arial,Tahoma,sans-serif } .header,.viewer { min-width:1200px } ol,ul { margin:0; padding:0; list-style:none } li a, a:focus, a:hover{ text-decoration:none; } ::-webkit-scrollbar-thumb { width:6px; border-radius:3px; background:#aaa } ::-webkit-scrollbar,::-webkit-scrollbar-track,::-webkit-scrollbar-track-piece { width:0; border-radius:3px; background:#fff } .cate-container { width:100% } .cate-container ul.cate-list { width:100%; padding:0 10px; overflow-x:scroll } .cate-container ul.cate-list>li { position:relative; float:left; width:33.33%; height:308px; background-color:#fff } .cate-container ul.cate-list>li>.search>.form-control { border-color:#eee; border-bottom-width:0; border-radius:2px 2px 0 0 } .cate-container ul.cate-list>li>ul.cate-tree { height:308px; overflow-y:scroll; border:1px solid #eee } .cate-container ul.cate-list>li>ul.cate-tree>li>a { position:relative; display:block; padding:3px 18px 3px 10px; color:#333; cursor:pointer; line-height:2.4 } .cate-container ul.cate-list>li>ul.cate-tree>li>a.child:after { content:">"; position:absolute; top:50%; right:10px; height:24px; line-height:24px; margin-top:-12px; font-family:FontAwesome; font-style:normal; font-weight:400 } .cate-container ul.cate-list>li>ul.cate-tree>li.active>a,.cate-container ul.cate-list>li>ul.cate-tree>li:hover>a { background-color:#D9D9D9; color:#f60 } .cate-container ul.cate-list>li>ul.cate-tree>li:hover>span.edit-tab { display:block } .cate-container ul.cate-list>li:nth-child(3n-2) { left:-10px } .cate-container ul.cate-list>li:nth-child(3n-1) { left:0 } .cate-container ul.cate-list>li:nth-child(3n) { left:10px } .cate-container ul.cate-list>li.last-item>ul.cate-tree>li>a:after { content:"" } .cate-container ul.cate-list:after { visibility:hidden; display:block; font-size:0; content:" "; clear:both; height:0 } .cate-container .cate-search-top { padding-bottom:10px } .cate-container .cate-search-top>select.form-control { display:inline; width:229px; border-color:#eee } .cate-container .select-text { position:relative; padding:10px; background-color:#f9f9f9 } .cate-container .select-text .text { color:#f60 } .cate-container .select-text .text label { margin-bottom:0 } .cate-container .select-text:before { content:''; position:absolute; top:-18px; left:30px; height:0; width:0; border:solid transparent; border-width:9px; border-bottom-color:#f9f9f9 } label.cate-select-label>i { font-style:normal } label.cate-select-label>i:after { content:">"; margin:0 3px } label.cate-select-label:last-child>i:after { content:"" }</style></head>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-content">
							<a href="${pageContext.request.contextPath}/center/product/releaseOne" class="btn bg-orange btn-rounded btn-block btn-xs">发布商品</a>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li ${(empty productSession.saleOld or productSession.saleOld eq 1)?"class='active'":""} ><a href="${pageContext.request.contextPath}/center/product/onSaleList"><i class="icon-price-tag3"></i>出售中的商品</a></li>
								<li ${(productSession.saleOld eq 2)?"class='active'":""}><a href="${pageContext.request.contextPath}/center/product/soldOutList"><i class="icon-flag3"></i>库存紧张商品</a></li>
								<li ${(productSession.saleOld eq 3)?"class='active'":""}><a href="${pageContext.request.contextPath}/center/product/forSaleList"><i class="icon-make-group"></i>仓库中的商品</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productTag/list"><i class="icon-price-tags"></i> 商品标签</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productGroup/list"><i class="icon-paragraph-justify2"></i> 商品分组</a></li>
								<li><a href="${pageContext.request.contextPath}/center/productImport/list"><i class="icon-import"></i>商品导入</a></li>
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
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">发布商品</span>
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
					<li class="active col-sm-3 text-center">
						<a href="javascript:;" > 1.选择商品品类
							<i class="icon-arrow-right15 position-right"></i>
							<i class="icon-arrow-right15 position-right"></i></a></li>
					<li class="col-sm-3 text-center">
						<a href="javascript:;" onclick="secondStep();"> 2.编辑基本信息
							<i class="icon-arrow-right15 position-right"></i>
							<i class="icon-arrow-right15 position-right"></i></a></li>
					<li class="col-sm-3 text-center">
							<span  style="color:black;">3.编辑商品详情
							<i class=" icon-check position-right"></i></span></li>
				</ul>

				<form action="" method="POST" name="form-wizard" id="form-wizard" >
					<div id="wizard" class="bwizard clearfix">
						<div class="well">
							<div class="wizard-step-1 bwizard-activated" id="step1"> 
									<!-- begin row -->
									<div class="row">
										<div class="cate-container goods-add-model ng-scope">

											<ul class="cate-list">
												<li>
													<ul id="firstCate" class="cate-tree J_Cate0">
														 
													</ul>
												</li>
												<!-- end ngRepeat: (key, cate) in vm.cates track by $index -->
												<li>
													<ul id="secondCate" class="cate-tree J_Cate1">

													</ul>
												</li>
												<!-- end ngRepeat: (key, cate) in vm.cates track by $index -->
												<li>
													<ul id="thirdCate" class="cate-tree J_Cate2">

													</ul>
												</li>
												<!-- end ngRepeat: (key, cate) in vm.cates track by $index -->
											</ul>
											<div class="select-text">
												您当前选择的类目是： <span class="text"> <label> <i
														id="firstCurrent" class="ng-binding ng-scope"></i>
												</label> <label> <i id="secondCurrent"
														class="ng-binding ng-scope"></i>
												</label> <label> <i id="thirdCurrent"
														class="ng-binding ng-scope"></i>
												</label>
												</span>
											</div>
											<input type="hidden" id="firstCateId" name="firstCateId" />
											<input type="hidden" id="secondCateId" name="secondCateId" />
											<input type="hidden" id="thirdCateId" name="thirdCateId" />
											<input type="hidden" id="firstCateName" name="firstCateName" />
											<input type="hidden" id="secondCateName" name="secondCateName" /> 
											<input type="hidden" id="thirdCateName" name="thirdCateName" />
										</div>
									</div>
									<!-- end row -->
								 
							</div>
						</div>
						<ul class="pager bwizard-buttons"> 
							<li class="next" role="button" aria-disabled="false"><a
								href="javascript:;" onclick="secondStep();">下一步 →</a></li>
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
var firstId="${productSession.firstCateId}";
var secondId="${productSession.secondCateId}";
var thirdId="${productSession.thirdCateId}";
 
$(document).ready(function() {
 
 $("#firstCate").find("li").each(function(){
 	 $(this).click(function(){
 		 $("#firstCate").find("li").each(function(){
          	$(this).attr("class","");
          });
  		$(this).attr("class","active");
  	});
 });
 
 getFirstCate('firstCate','-1');
 
if(secondId!="" && secondId!="0" ){
  setTimeout(function () { 
	getSecondCate("secondCate","${productSession.firstCateId}","${productSession.firstCateName}");
 
 	setTimeout(function () { 
 		getThirdCate("thirdCate","${productSession.secondCateId}","${productSession.secondCateName}");
	 	if( thirdId!="" && thirdId!="0"){	
	 		setTimeout(function () { 
	 			getCateId('${productSession.thirdCateId}','${productSession.thirdCateName}');
	 			setTimeout(function () { 
	 				firstId="";
	     			secondId="";
	     			thirdId="";
	 			}, 500);
	 		}, 200);
	 	 } 	
     }, 200);
   }, 200);
}

 if('${saveStatus}'==1){
 	MAlert("商品发布成功!");
 }
 
});
function allowDistribution(isAllowDistribution) {
 if (isAllowDistribution == '1') {
   $("#distributionTotalPriceDiv").attr("class", "form-group show");
 } else {
   $("#distributionTotalPriceDiv").attr("class", "form-group hidden");
   $("#distributionTotalPrice").attr("value", "0");
 }

}
 
//根据选择分类类型获取一级分类
function getFirstCate(firstCate,cateId){
	  $("#firstCurrent").html("");
	  $("#secondCurrent").html("");
	  $("#thirdCurrent").html("");
	  $("#firstCateId").val("");
	  $("#secondCateId").val("");
	  $("#thirdCateId").val("");
	  $("#firstCateName").val("");
	  $("#secondCateName").val("");
	  $("#thirdCateName").val("");
	  
	  $("#firstCate").children().filter('li').remove();
	  $("#secondCate").children().filter('li').remove();
	  $("#thirdCate").children().filter('li').remove(); 
	  var url = "${pageContext.request.contextPath}/center/product/productCate?parent_id="+cateId;
	  $.post(url, null,
		function (result){
		  try{
	    	var date= eval("("+result+")");
	   	 	if(date.code=='0'){
	   	 	    date = date.data ; 
		   	 	var mmid="";
	   	 		var mmname="";
				$.each(date, function (i, cate) {   
					var li ="";
					if( cate.cate_id==firstId ){
						mmid=cate.cate_id;
						mmname=cate.cate_name;
						 li = '<li class="active"><a class="ng-binding child" onclick="getSecondCate(\'secondCate\',\''+cate.cate_id+'\',\''+cate.cate_name+'\')">'+cate.cate_name+'</a></li>';
					}else{
						 li = '<li><a class="ng-binding child" onclick="getSecondCate(\'secondCate\',\''+cate.cate_id+'\',\''+cate.cate_name+'\')">'+cate.cate_name+'</a></li>';
					}
					$("#"+firstCate+"").append(li);
 				});
				$("#firstCateId").val(mmid);
				$("#firstCurrent").html(mmname);
				$("#firstCateName").val(mmname);
		     } else{
  	 	         alert(date.message);
  	 	     }
		  }catch(oException){
			  alert("和服务器交互失败:" + oException.message);
		  }
	});
}
//根据选择分类类型获取二级分类
function getSecondCate(firstCate,cateId,cateName){
	  $("#firstCateId").val(cateId);
	  $("#firstCurrent").html(cateName);
	  $("#firstCateName").val(cateName);
	  
	  $("#secondCurrent").html("");
	  $("#thirdCurrent").html("");
	  $("#secondCateId").val("");
	  $("#thirdCateId").val("");
	  $("#secondCateName").val("");
	  $("#thirdCateName").val("");
	  
	  $("#secondCate").children().filter('li').remove();
	  $("#thirdCate").children().filter('li').remove(); 
	  var url = "${pageContext.request.contextPath}/center/product/productCate?parent_id="+cateId;
	  $.post(url, null,
     	function (result){
		  try{
	    	var date= eval("("+result+")");
	   	 	if(date.code=='0'){
	   	 	    date = date.data ; 
				$.each(date, function (i, cate) {
					var li ="";
					if( cate.cate_id==secondId ){
						 li = '<li class="active"><a class="ng-binding child" onclick="getThirdCate(\'thirdCate+\',\''+cate.cate_id+'\',\''+cate.cate_name+'\')">'+cate.cate_name+'</a></li>';
					}else{
						var li = '<li><a class="ng-binding child" onclick="getThirdCate(\'thirdCate+\',\''+cate.cate_id+'\',\''+cate.cate_name+'\')">'+cate.cate_name+'</a></li>';
					}
					$("#secondCate").append(li);
 				});
		    		 
		     }else{
  	 	         alert(date.message);
  	 	     }
		  }catch(oException){
			  alert("和服务器交互失败:" + oException.message);
		  }
		});
	  $("#firstCate").find("li").each(function(){
	   	 $(this).click(function(){
	   		 $("#firstCate").find("li").each(function(){
	            	$(this).attr("class","");
	         });
	    	 $(this).attr("class","active");
	   	});
     });
}

//根据选择分类类型获取三级分类
function getThirdCate(firstCate,cateId,cateName){
	  $("#secondCateId").val(cateId);
	  $("#secondCurrent").html(">"+cateName);
	  $("#secondCateName").val(cateName);
	  
	  $("#thirdCurrent").html("");
	  $("#thirdCateId").val("");
	  $("#thirdCateName").val("");
	  
	  $("#thirdCate").children().filter('li').remove(); 
	  var url = "${pageContext.request.contextPath}/center/product/productCate?parent_id="+cateId;
	  $.post(url, null,
	 	function (result){
		  try{
	    	var date= eval("("+result+")");
	   	 	if(date.code=='0'){
	   	 	    date = date.data ; 
				$.each(date, function (i, cate) {
					var li ="";
					if( cate.cate_id==thirdId ){
						 li = '<li class="active"><a class="" onclick="getCateId(\''+cate.cate_id+'\',\''+cate.cate_name+'\')">'+cate.cate_name+'</a></li>';
					}else{
						var li = '<li><a class="" onclick="getCateId(\''+cate.cate_id+'\',\''+cate.cate_name+'\')">'+cate.cate_name+'</a></li>';
					}
					$("#thirdCate").append(li);
 				});
		     }else{
  	 	         alert(date.message);
  	 	     }
		  }catch(oException){
			  alert("和服务器交互失败:" + oException.message);
		  }
		});
	  $("#secondCate").find("li").each(function(){
	  	 $(this).click(function(){
	  		 $("#secondCate").find("li").each(function(){
	           	$(this).attr("class","");
	           });
	   		$(this).attr("class","active");
	   	});
  	 }); 
}

function getCateId(cateId,cateName){
	  $("#thirdCateId").val(cateId);
	  $("#thirdCurrent").html(">"+cateName);
	  $("#thirdCateName").val(cateName);
	  
	  $("#thirdCate").find("li").each(function(){
	  	  $(this).click(function(){
	  		 $("#thirdCate").find("li").each(function(){
	           	$(this).attr("class","");
	           });
	   		$(this).attr("class","active");
	   	 });
  	  });
}

function secondStep(){
	  if($("#firstCateId").val()==""){
		  MAlert("请选择至少一级目录！");
		  return;
	  }
	  if( ( $("#secondCateId").val()=="" && $.trim($("#secondCate").text())!="")
			  || ($("#thirdCateId").val()=="" && $.trim($("#thirdCate").text())!="") ){
		  MAlert('请选择下级目录！'); 
		  return;
	  }
	  $('#form-wizard').attr('action', '${pageContext.request.contextPath}/center/product/releaseTwo?oneflag=1');
	  $("#form-wizard").submit();
}
</script>