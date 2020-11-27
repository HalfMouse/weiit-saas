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
					
					<div class="col-md-4">
						<img src="${pageContext.request.contextPath}/resource/images/phone.png" style="width: 290px;height: 588px;">   
				       <div class="Exhibition">
							<div class="con">
								<div class="con_img">
								<img class="" src="${list.get(0).cover_img }">
								</div>
								<p class="con_content">${list.get(0).title }</p>
								<input type="hidden" name="id" value="${list.get(0).id }"/>
								<div class="list">
									<c:forEach items="${list }" var="ar" begin="1">
									<div class="row">
										<br>
										<div class="col-md-9"  style="margin-left:5px;">
											<span class="text-muted" style="word-break: break-all; word-wrap:break-word; ">${ar.title }</span>
										</div>
										<div class="col-md-3" style="margin-left:-5px;">
											<img src="${ar.cover_img }" width="40" height="40"/>
										</div>
										<br>
									</div>
									<input type="hidden" name="id" value="${ar.id }"/>
									</c:forEach>
								</div>
								<br>
							</div>
						</div>        
					 
					</div>
					
					<div class="col-md-8">
					
						<div class="panel-heading">
							<h6 class="panel-title"><input type="radio"  name="send_type" value="1" checked/>推送方式1：选择要发送的会员</h6>
						</div>
				      	<div class="panel panel-flat">
					  		<div class="panel-body">   
								<div class="table-responsive">
									<table class="table datatable-basic2 bg-grey">
									<thead style="display:none;">
										<tr>
											<tr>
												<th>头像</th>
												<th>会员账号</th> 
												<th>最后登录时间</th>
												<th width="80"></th>
											</tr>
										</tr>
									</thead>
									<tbody>
										
										<c:forEach items="${userList }" var="user">
											<tr>
												<td><img src="${user.user_img }" width="40" height="40"/></td>
												<td>${user.user_name }</td>
												<td><fmt:formatDate value="${user.update_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
												<td><input type="checkbox"  name="user_id"  value="${user.user_id }" /></td>	
											</tr>
										</c:forEach>
										
									</tbody> 
								</table> 
								</div> 
					  		</div>
					  	</div>    
					  	
					  	<br>
					  	
					  	<div class="panel-heading">
								<h6 class="panel-title"><input type="radio" name="send_type" value="2"/>推送方式2：按照标签组</h6>
						</div>
				      	<div class="panel panel-flat">
				      		
					  		<div class="row" style="margin-left:30px;margin-top:30px;">
					  			<c:forEach items="${signList }" var="sign">
					  			<input type="checkbox" name="sign_id" value="${sign.sign_id }">${sign.sign_name } &nbsp;
					  			</c:forEach>
					  		</div>
					  		<br><br>
					  	</div>    
					  	   
					  	<br>
					  	
					  	<div class="panel-heading">
							<h6 class="panel-title"><input type="radio" name="send_type" value="3"/>推送方式3：全部会员</h6>
						</div>
				      	
					</div>
				</div>
			   
			  <br> <br> 
			 <div class="text-center">
			 	<span class='text-danger text-bold'>${info }</span>
				<form action="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/sendToWeixin" method="post" id="infoForm">
				<button type="button" class="btn btn-default" onclick="window.history.back();">返回上一步</button>
				
				<button type="button" class="btn btn-primary" id="confirm_send">确定发送</button>
				</form>
			 </div>
			
			</div> 
		</div>
		<!-- /navbar navigation -->
	</div>
				
</div>



<style>

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
<%@include file="../common/footer.jsp" %>
<script>
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
    $('.dataTables_filter input[type=search]').attr('placeholder','请输入会员昵称');
	 
		
	 $('.dataTables_info').hide();
	 $(".dataTables_empty").html("没有用户");
	 
	 $("#confirm_send").click(function(){
		 var ids="";
		 $("input[name='id']").each(function(){
			 if(ids==""){
				 ids=$(this).val();
			 }else{
				 ids=ids+","+$(this).val();
			 }
		 });
		 if($('input:radio[name="send_type"]:checked').val()==1){//按照查询用户进行发送图文
				 var user_ids="";
				$("input[name='user_id']").each(function(){
					 if($(this).prop("checked")){
						 if(user_ids==""){
							 user_ids=$(this).val();
						 }else{
							 user_ids=user_ids+","+$(this).val();
						 }
						
					 }
				});
				if(user_ids==""){
					MAlert("当发送方式为1时，请至少选择一个用户推送");
					return;
				}else{
					$("#infoForm").html("<input type='hidden' name='ids' value='"+ids+"'><input type='hidden' name='type' value='1'><input type='hidden' name='user_ids' value='"+user_ids+"'>");
				}
		 }else if($('input:radio[name="send_type"]:checked').val()==2){//按照标签组发送图文
			 var sign_ids="";
				$("input[name='sign_id']").each(function(){
					 if($(this).prop("checked")){
						 if(sign_ids==""){
							 sign_ids=$(this).val();
						 }else{
							 sign_ids=sign_ids+","+$(this).val();
						 }
					 }
				});
				if(sign_ids==""){
					MAlert("当发送方式为2时，请至少选择一个标签组推送");
					return;
				}else{
					$("#infoForm").html("<input type='hidden' name='ids' value='"+ids+"'><input type='hidden' name='type' value='2'><input type='hidden' name='sign_ids' value='"+sign_ids+"'>");
				}
		 }else if($('input:radio[name="send_type"]:checked').val()==3){//全部发送
				 $("#infoForm").html("<input type='hidden' name='ids' value='"+ids+"'><input type='hidden' name='type' value='3'>"); 
		 }
		 
		 $("#buttonsave").attr("disabled", true); 
		 FullScreenShow("图文正在推送，请耐心等待，最长不超过3分钟完成");
		 $("#infoForm").submit();
	 });
		
});


</script>