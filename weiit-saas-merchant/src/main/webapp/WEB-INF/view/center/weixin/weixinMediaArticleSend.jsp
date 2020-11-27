<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<meta name="referrer" content="never">
<style>
.Exhibition {
	width: 252px;
	height: 400px;
	margin: -450px 0 0 18px;
	padding: 10px;
	position:absolute;
}

.Exhibition, .right {
	float: left;
}

.con {
	border-radius: 6px;
	background: white;
}

.con_img {
	height: 144px;
    overflow: hidden;
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
    justify-content: center;
    -webkit-box-align: center;
    -webkit-align-items: center;
    align-items: center;
}

.con_content {
	font-size: 13px;
	width: 210px;
	line-height: 30px;
	min-height: 22px;
	color:white;
	margin-top:-50px;
	word-break: break-all; 
	word-wrap:break-word; 
	margin-left: 6px;
	font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif;
}

.whole {
	line-height: 60px;
	font-size: 14px;
	margin-left: 5px;
	width:180px;
	height:60px;
	word-break: break-all; 
	word-wrap:break-word; 
	border-top: 1px solid #E4E8EB;
}

.whole .More {
	float: right;
	margin-right:3px;
}

img {
    height: auto;
    max-width: 100%;
    vertical-align: middle;
    border: 0;
}
.img-wrap img {
    width: 100%;
}

img { 
    display: inline-block;
}
img {
    cursor: pointer;
}
img {
    vertical-align: middle;
}
img {
    display: block;
}
</style> 
<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default"
	style="width: 180px">
	<div class="category-content no-padding">
		<ul class="navigation navigation-alt navigation-accordion">
			<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
		</ul>
	</div>
</div>
<!--  /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper"> 
	<!-- Content area -->
	<div class="content">
		<ul class="nav  nav-tabs"> 
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list" style="border-left:0px;border-top:0px;"><i class="fa fa-file-image-o position-left"></i>我的图文</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list"><i class="fa fa-photo position-left"></i>我的图片</a></li>
		</ul>
		<!-- Navbar navigation -->
		<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">

			<div class="panel-body">
				
				<div class="row">
					<div class="col-md-4" style="width:350px;" id="step1">
					
						<div class="panel-heading">
							<h6 class="panel-title">1、选择发送的图文</h6>
						</div>
				      	<div class="panel panel-flat">
					  		<div class="panel-body">   
					  			
								<table class="table datatable-basic2 bg-grey">
									<thead style="display:none;">
										<tr>
											<th  class="text-center">图文</th>
											<th  class="text-center">标题</th> 
											<th class="text-center">操作</th> 
										</tr>
									</thead>
									<tbody>
										
										<c:forEach items="${pageInfo.list }" var="ar">
										<tr>
											<td><img src="${ar.cover_img }" width="80"/></td>
											<td style="widht:220px;word-wrap:break-word;word-break:break-all;">${ar.title }</td> 
											<td><input type="checkbox"  name="article_id"  value="${ar.id }" title="${ar.title }" cover_img="${ar.cover_img}" /></td>	
										</tr>
										</c:forEach>
										
									</tbody>
								</table> 
					  		</div> 
					  	</div>    
					  	 
					  	   
					</div>
					<div class="col-md-4" style="width:350px;display:none;" id="step2">
					
						<div class="panel-heading">
							<h6 class="panel-title">2、调整图文顺序</h6>
						</div>
				   		<div class="panel panel-flat">
					  		<div class="panel-body">   
					  			<div class="panel-heading">
									<h6 class="panel-title">主图文</h6>
								</div>
					  		
					  			<table id="main_content" class="table bg-grey" > 
									<tr>
										<td><img src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png" width="80"/></td>
										<td width="200" style="word-wrap:break-word;word-break:break-all;">美妆丨冬天怎么化妆？这是我见过最好的答案！</td>
										<td><a  style="color:white;"><i class="icon-arrow-up15"></i></a>&nbsp;<a  style="color:white;"><i class="icon-arrow-down15"></i></a></td>	
									</tr> 
								</table>
								 
								<div class="panel-heading">
									<h6 class="panel-title">副图文</h6>
								</div> 
					  			<table id="list_content" class="table bg-grey">
									<tr>
										<td><img src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png" width="80"/></td>
										<td width="200" style="word-wrap:break-word;word-break:break-all;">美妆丨冬天怎么化妆？这是我见过最好的答案！</td>
										<td><a  style="color:white;"><i class="icon-arrow-up15"></i></a>&nbsp;<a href="" style="color:white;"><i class="icon-arrow-down15"></i></a></td>	
									</tr>
									<tr>
										<td><img src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png" width="80"/></td>
										<td  width="200" style="word-wrap:break-word;word-break:break-all;">美妆丨冬天怎么化妆？这是我见过最好的答案！</td>
										<td><a style="color:white;"><i class="icon-arrow-up15"></i></a>&nbsp;<a href="" style="color:white;"><i class="icon-arrow-down15"></i></a></td>	
									</tr>
								</table>
							 
					  		</div>
					  	</div> 
					  	
					</div>
					 
					<div class="col-md-4" style="display:none;" id="step3">
						<img src="${pageContext.request.contextPath}/resource/images/phone.png" style="width: 290px;height: 588px;">   
			

				       <div class="Exhibition">
							<div class="con">
								<div class="con_img">
								<img class="main_img" src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png" >
								</div>
								<p class="con_content">2018世界杯，真伪球迷</p>
								<div class="list">
									<div class="row">
										<br>
										<div class="col-md-9"  style="margin-left:5px;">
											<span class="text-muted" style="word-break: break-all; word-wrap:break-word; ">美妆丨冬天怎么化妆？这是我见过</span>
										</div>
										<div class="col-md-3" style="margin-left:-5px;">
											<img src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png" width="40" height="40"/>
										</div>
										<br>
									</div>
									 
									<div class="row"> 
										<br>
										<div class="col-md-9"  style="margin-left:5px;">  
											<span class="text-muted" style="word-break: break-all; word-wrap:break-word; ">美妆丨冬天怎么化妆？这是我见过</span>
										</div> 
										<div class="col-md-3" style="margin-left:-5px;">
											<img src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png" width="40" height="40"/>
										</div>
										<br>
									</div>
								</div>
								<br>
							</div>
						</div>       
					
					</div>
					
				</div>
			   
			  <br> <br>
			 <div class="text-center">
				
				<button type="button" class="btn btn-default" onclick="reset()">图文重选</button>
				
				<button type="button" class="btn btn-primary" onclick="next()">选择会员发送</button>
				<form action="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/selectUser" method="post" id="infoForm">
				</form>
			 </div>
			
			</div> 
		</div>
		<!-- /navbar navigation -->
	</div>
				
</div>


<%@include file="../common/footer.jsp" %>
<style>
.dataTables_filter{
    position: relative;
    display: block; 
    float: left;
    margin:0 0 20px -3px;
}
.dataTables_filter input{
    outline: 0;
    width: 300px;
    height: 36px;
    padding: 7px 12px;
    padding-right: 34px;
    font-size: 13px;
    line-height: 1.5384616;
    color: #333333;
    background-color: #ffffff;
    border: 1px solid #dddddd;
    border-radius: 3px;
}
.dataTables_paginate{
    float: right;
    text-align: right;
    margin: 20px 0 20px 20px;
    font-size:x-small;
}
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td{
	padding:10px 8px;
}
</style> 
<script>
var array=new Array();

$(document).ready(function() { 
   
	 // Setting datatable defaults
    $.extend( $.fn.dataTable.defaults, {
        autoWidth: true,
        language: {
            search: '',
            lengthMenu: '',
            paginate: { 'first': '第一页', 'last': '尾页', 'next': '上一页', 'previous': '下一页' } 
        }
    });


    // Basic datatable
    $('.datatable-basic2').DataTable();
    $('.dataTables_filter input[type=search]').attr('placeholder','请输入标题');
	 
		
	 $('.dataTables_info').hide();
	 $(".dataTables_empty").html("没有图文");
	 
	 $("input[name=article_id]").click(function(){
		
		 if($(this).prop("checked")){
			 var data={pic:$(this).attr("cover_img"),title:$(this).attr("title"),id:$(this).val()};
			 array.push(data);
		 }else{
			 var data={pic:$(this).attr("cover_img"),title:$(this).attr("title"),id:$(this).val()};
			 for(var i=0;i<array.length;i++){
				 if(array[i].id==data.id){
					 array.splice(i,1);
				 }
			 } 
		 }
		 //判断是否显示step2，step3
		 if(array.length>0){
		    changge(array); 
			$("#step2").show();
			$("#step3").show();
		 }else{
			$("#step2").hide();
			$("#step3").hide();
		 }
	 });
	 //从其他页面返回时
	 $("input[name=article_id]").each(function(){
		 if($(this).prop("checked")){
			 var data={pic:$(this).attr("cover_img"),title:$(this).attr("title"),id:$(this).val()};
			 array.push(data);
		 }
	 });
	 //判断是否显示step2，step3
	 if(array.length>0){
	    changge(array); 
		$("#step2").show();
		$("#step3").show();
	 }else{
		$("#step2").hide();
		$("#step3").hide();
	 }

});


function changge(array){
	//1更换主图文信息
	var tr='<tr>'+
			'<td><img src="'+array[0].pic+'" width="80"/></td>'+
			'<td width="200" style="word-wrap:break-word;word-break:break-all;">'+array[0].title+'</td>'+
			'<td><a style="color:white;"  onclick="upclick('+array[0].id+')"><i class="icon-arrow-up15"></i></a>&nbsp;<a  style="color:white;" onclick="downclick('+array[0].id+')"><i class="icon-arrow-down15"></i></a></td>'+	
 		  '</tr>';
	$("#main_content").html(tr);
	
	//2更换副图文信息
	var list=""; 
	for(var i=1;i<array.length;i++){
		
		list+='<tr>'+
				'<td><img src="'+array[i].pic+'" width="80"/></td>'+
				'<td width="200" style="word-wrap:break-word;word-break:break-all;">'+array[i].title+'</td>'+
				'<td><a style="color:white;" onclick="upclick('+array[i].id+')"><i class="icon-arrow-up15"></i></a>&nbsp;<a  style="color:white;" onclick="downclick('+array[i].id+')"><i class="icon-arrow-down15"></i></a></td>'	
			 '</tr>'; 
	}
	$("#list_content").html(list);
	
	//3渲染模型效果
	$(".Exhibition").find(".main_img").attr("src",array[0].pic);
	$(".Exhibition").find(".con_content").html(array[0].title); 
	
	var rows="";
	for(var i=1;i<array.length;i++){
		rows+='<div class="row">'+ 
					'<br>'+
					'<div class="col-md-9"  style="margin-left:5px;">'+
						'<span class="text-muted" style="word-break: break-all; word-wrap:break-word; ">'+array[i].title+'</span>'+
					'</div>'+
					'<div class="col-md-3" style="margin-left:-5px;">'+
						'<img src="'+array[i].pic+'" width="40" height="40"/>'+
						'</div>'+
					'<br>'+
				'</div>';
					  
	}
	$(".Exhibition").find(".list").html(rows); 
} 

function upclick(id){
	var index;
	for(var i=0;i<array.length;i++){
		if(array[i].id==id){
			index=i;
		}
	}
	if(index!=0){
		var temp=array[index-1];
		
	 	array[index-1]=array[index];
	 	array[index]=temp;
	}
	 changge(array);  
}
function downclick(id){
	var index;
	for(var i=0;i<array.length;i++){
		if(array[i].id==id){
			index=i;
		} 
	}
	if(index!=array.length-1){
		var up=array[index+1];
		var down=array[index];
		
	 	array[index]=up;
	 	array[index+1]=down;
	 	
	}
	 changge(array); 
}

function reset(){
	$("input[name=article_id]").each(function(){
		$(this).attr("checked",false);
	});
	 array=new Array();
	 //判断是否显示step2，step3
	 if(array.length>0){
		$("#step2").show();
		$("#step3").show();
	 }else{
		$("#step2").hide();
		$("#step3").hide();
	}
}
function next(){
	
	if(array.length>0){
		var ids="";
		for(var i=0;i<array.length;i++){
			ids+=array[i].id+"";
			if(i!=array.length-1){
				ids+=",";
			}
		}
		$("#infoForm").html("<input type='hidden' name='ids' value="+ids+">");
		$("#infoForm").submit();
	}else{
		MAlert('最少选择一个图文'); 
		return;
	}
}
</script>
