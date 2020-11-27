<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
	<!--<![endif]-->

	<head>
		<meta charset="utf-8" />
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<%@include file="../common/header.jsp"%>
		<style>
	 
.contentType {
	height: 60px;
	line-height: 60px;
	border-bottom: 0;
	background-color: #F6F8F9;
	margin-bottom: 0;
}
.contentType li.on {
    color: #44b549;
}
.contentType li {
    text-align: center;
    width: 100px;
    float: left;
    color: #5C5E5C;
    cursor: pointer;
}
.file_picture {
    border: 1px solid #c9c9c9;
    border-top: 0;
    height: 320px;
    background:white; 
}
.create-type__list {
    text-align: center;
}
.create-type__list .create-type__item {
    display: inline-block;
    width: 130px;
    color: #8d8d8d;
    vertical-align: top;
    margin: 30px 10px;
    transition: all .3s;
}
.create-type__list .create-type__item:hover {
   background-color:#F6F8F9;  
}
.create-type__list .create-type__item a {
    color: #8d8d8d;
    display: block;
    height: 100%;
    padding-top: 28px;
    padding-bottom: 34px; 
    box-sizing: border-box;
}
.create-type__list .create-type__item .create-type__icon {
    display: inline-block;
    width: 40px;
    height: 40px;
}
.create-type__icon.file {
    background: url(${pageContext.request.contextPath}/resource/images/weixinMenu/menu_type_list.png) 0 -44px no-repeat;
}
.create-type__icon.new {
    background: url(${pageContext.request.contextPath}/resource/images/weixinMenu/menu_type_list.png) 0 0 no-repeat;
}
.create-type__icon.pic {
    background: url(${pageContext.request.contextPath}/resource/images/weixinMenu/menu_type_list.png) 0 -220px no-repeat;
}
.create-type__list .create-type__item strong {
    font-weight: normal;
    display: block;
}

			li {
				list-style: none;
			}
			
			.nav {
				margin: 0 20px;
				padding: 0;
				height: 43px;
				color: #666;
				line-height: 43px;
				border: 1px solid #c9c9c9;
				background-color: #F7F7F8;
			}
			
			.nav li {
				float: left;
				width: 100px;
				text-align: center;
				cursor: pointer;
			}
			
			.nav li:first-child {
				border-left: 0;
			}
			
			.Select {
				height: 43px;
				color: #333;
				background-color: #fff;
				margin-top: -1px;
				border-top: 1px solid #00BCD4;
				border-left: 1px solid #c9c9c9;
				border-right: 1px solid #c9c9c9;
			}
			
			.div_box {
				border: 1px solid #c9c9c9;
				border-top: 0;
				margin: 0 20px;
				background-color: #fff;
				padding: 20px;
			}
			
			.Newly p {
				font-size: 14px;
				color: #9a9a9a;
			}
			
			.newsContentType {
				height: 60px;
				line-height: 60px;
				border: 1px solid #c9c9c9;
				border-bottom: 0;
				background-color: #F6F8F9;
				margin-bottom: 0;
			}
			
			.newsContentType li {
				width: 100px;
				float: left;
				color: #5C5E5C;
				cursor: pointer;
			}
			
			.newsContentType li:first-child {
				color: #00bcd4;
			}
			
			.content_box {
				border: 1px solid #c9c9c9;
				border-top: 0;
				padding: 20px;
				min-height: 200px;
			}
			
			.con_option {
				width: 400px;
				height: 100px;
				margin: auto;
			}
			
			.con_option li {
				width: 80px;
				height: 80px;
				margin: 20px;
				float: left;
				font-size: 13px;
				text-align: center;
				background-color: #f5f5f5;
			}
			
			.words {
				width: 100% !important;
				height: 300px !important;
				margin-bottom: 20px;
			}
			
			.words li {
				width: 100%;
				height: 100%;
				margin: 0;
			}
			
			.words textarea {
				width: 100%;
				height: 100%;
			}
			
			.local {
				position: relative;
			}
			
			.local_img {
				width: 100%;
				height: 100%;
				position: relative;
			}
			
			.local .local_file {
				width: 100%;
				height: 100%;
				opacity: 0;
				z-index: 10;
				position: absolute;
				top: 0;
			}
			
			.option_list {
				padding-left: 20px;
				padding-top: 20px;
			}
			
			.option_list select {
				margin-top: 10px;
				margin-right: 20px;
				padding: 2px 10px 3px 4px;
			}
			
			.option_list .sex,
			.option_list .region {
				margin-left: 10px;
			}
			/*发送消息*/
			
			.SendOut {
				padding: 20px;
				padding-top: 50px;
			}
			
			.SendOut .delayed {
				width: 100px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border-radius: 4px;
				border: 0;
				margin-right: 20px;
			}
			
			.SendOut .now {
				color: #fff;
				background-color: #00BCD4;
				width: 100px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border-radius: 4px;
				border: 0;
				margin-right: 20px;
			}
			/*延时发送*/
			
			.delay {
				width: 700px;
				height: 500px;
				border: 1px solid #c9c9c9;
				background-color: #fff;
				padding: 20px;
				border-radius: 10px;
				position: fixed;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				z-index: 100;
			}
			
			.delay p {
				width: 500px;
				margin: 0 auto;
				padding: 50px 0;
			}
			
			.delay_content {
				width: 500px;
				line-height: 30px;
				text-align: center;
				margin: 0 auto;
				color: #5E5E5E;
			}
			
			.delay_content select {
				margin: 0 10px;
				line-height: 25px;
				padding: 2px 10px 2px 4px;
				vertical-align: middle;
			}
			/*确定、取消按钮*/
			
			.btn_box {
				width: 230px;
				margin: 0 auto;
				margin-top: 200px;
				overflow: hidden;
			}
			
			.btn_box button {
				width: 100px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border: 0;
				float: left;
				border-radius: 4px;
			}
			
			.btn_box .cancel {
				width: 100px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border: 0;
				float: left;
				border-radius: 4px;
				background-color: #FBFBFB;
				border: 1px solid #E4E8EB;
				color: #5E5E5E;
				margin-right: 30px;
			}
			
			.btn_box .sure {
				background-color: #00BCD4;
				color: #fff;
				width: 100px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border: 0;
				float: left;
				border-radius: 4px;
			}
			/*已发送*/
			
			.table_form {
				width: 100%;
				line-height: 57px;
				text-align: center;
			}
			
			.table_form thead {
				width: 100%;
				color: #9a9a9a;
				background-color: #f6f8f9;
			}
			
			.table_form tbody tr {
				border-bottom: 1px solid #f6f6f6;
			}
			
			.table_form .images {
				width: 50px;
				height: 40px;
				margin-right: 20px;
			}
			
			.table_form .news_type {
				width: 100px;
			}
			
			.table_form .news_con {
				max-width: 20vw;
				line-height: 30px !important;
				padding: 0 10px;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
			
			.table_form .operation {
				width: 200px;
			}
			
			.operation a {
				margin: 0 10px;
			}
			/*发送过消息的用户列表*/
			
			.user_list {
				padding: 20px;
				margin: 20px;
				border: 1px solid #c9c9c9;
				position: relative;
			}
			
			.user_list p {
				padding: 20px 0;
			}
			
			.user_pic {
				width: 80px;
			}
			
			.pic {
				width: 50px;
				height: 40px;
			}
			
			.Return {
				width: 50px;
				height: 30px;
				text-align: center;
				line-height: 30px;
				position: absolute;
				right: 0px;
				top: 0px;
				color: #666;
				cursor: pointer;
			}
		</style>
		<script type="text/javascript">
			window._points = [+new Date()];

			function wx_main(mod) {
				window._points && (window._points[3] = +new Date());
			};

			window.wx = {
				uin: "3298224603" || "0"
			};
		</script>

		<title>群发功能</title>
	</head>

	<body>
		<!-- Secondary sidebar -->
		<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
			<div class="sidebar-content">
				<!-- Sub navigation -->
				<div class="sidebar-category">
					<div class="category-content no-padding">
						<ul class="navigation navigation-alt navigation-accordion">
							<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
							<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
						</ul>
					</div>
				</div>
				<!-- /sub navigation -->
			</div>
		</div>
		<!--  /Secondary sidebar -->

		<!-- Main content -->
		<div class="col-md-13">
			<!-- Page header -->
			<div class="page-header">
				<div class="page-header-content">
					<div class="page-title" style="height:70px;padding-top:20px;">
						<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold">消息群发</span>
				</h4>
					</div>
				</div>
			</div>
			<!-- /page header -->
			<ul class="nav">
				<li class="Select">新建群发消息</li>
				<li>已发送</li>
			</ul>
			<form class="form-horizontal" method="POST" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/weixin/batchSending/doBatchSending">	
			<input type="hidden" name="action_type" id="action_type" value="2">
			<input type="hidden" name="time_type" id="time_type" value="">
			<div class="div_box">
				<div class="order Newly">
					<p>为保障用户体验，微信公众平台严禁恶意营销以及诱导分享朋友圈，严禁发布色情低俗、暴力血腥、政治谣言等各类违反法律法规及相关政策规定的信息。一旦发现，我们将严厉打击和处理。</p>
					<div class="form-group menu_content">
						<div  style="border:1px solid #e1e1e1">  
							<div class="set_content"> 
								
								<div class="file_picture">  
									<ul class="contentType col-md-12"> 
									   <li class="on" value="1"><i class="icon-floppy-disk position-left"></i>图文消息</li>
									   <li value="2"><i class="icon-typography position-left"></i>文字</li>    
									   <li value="3"><i class="icon-images2 position-left"></i>图片</li>
								    </ul>  
									<div class="create-type__list my_file_pic">
										<div class="imageText_select_div1">
						                    <div class="create-type__item">
						                        <a href="javascript:;" class="create-type__link" onclick="openSelectImageText()">
						                            <i class="create-type__icon file"></i>
						                            <strong class="create-type__title">从素材库选择</strong>
						                        </a>
						                    </div>
						                    <div class="create-type__item">
						                        <a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list" class="create-type__link">
						                            <i class="create-type__icon new"></i>
						                            <strong class="create-type__title">自建图文</strong>
						                        </a>
						                    </div>
					                    </div>
					                    <div class="imageText_select_div2" style="display:none;text-align:left;">
					                    	<div>
					                    	<img style="margin-left:2rem; margin-top: 2rem;" name="imageText_select" id="imageText_select" src="" width="200" height="200">
												<div onclick="imageTextSelectDelete();" class="btn btn-sm btn-success">删除</div>
					                    	<input type="hidden" name="content11" id="content11" value="" >
					                    	</div>
					                    	<span id="imageText_title"></span>
					                    </div>
								    </div>
								    <div class="create_type_text my_text" style="display:none;">
								    	<textarea rows="11" cols="5" name="content22" id="content22" class="form-control" 
								    		style="paddig:0px 0px;border-radius:0px;border:0px;"></textarea>
								    	<div class="text-right text-muted">
								    		<span>还可以输入600字</span>  
								    	</div> 
								    </div>
								    <div class="create-type__list my_pic" style="display:none;">
								    	<div class="image_select_div1">
						                    <div class="create-type__item">
						                        <a href="javascript:;" class="create-type__link" onclick="openSelectImage()">
						                            <i class="create-type__icon file"></i>
						                            <strong class="create-type__title">从素材库选择</strong>
						                        </a>
						                    </div>
						                    <div class="create-type__item">
						                        <a href="${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list" class="create-type__link">
						                            <i class="create-type__icon pic"></i>
						                            <strong class="create-type__title">上传图片</strong>
						                        </a>
						                    </div>
					                    </div>
					                    <div class="image_select_div2" style="display:none;text-align:left;">
					                    	<img  style="margin-left:2rem; margin-top: 2rem;" name="image_select" id="image_select" src="" width="200" height="200">
											<div onclick="imageSelectDelete();" class="btn btn-sm btn-success">删除</div>

											<input type="hidden" name="content33" id="content33" value="" >
					                    </div>
								    </div>
								</div>
							</div>  
							
						</div>
					</div>
					<!--选择列表-->
					<div class="option_list">
						群发对象&nbsp;&nbsp;
						<select class="select" name="group_type" id="group_type" style="width:120px;"  onchange="groupChang(this.value)">
							<option value="">全部用户</option>
							<option value="1">按标签选择</option>
						</select>
						<input type="hidden" name="sign_name" id="sign_name" value="${signList[0].sign_name }">
						<select class="select hide" name="sign_id" id="sign_id" style="width:120px;" onchange="setTitleChang('sign_id','sign_name')" >
							<c:forEach items="${signList }" var="info" >
							<option value="${info.sign_id }">${info.sign_name}</option>
							</c:forEach>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;
						性别
						<select class="select" name="sex" id="sex" style="width:120px;">
							<option value="">不限</option>
							<option value="1">男</option>
							<option value="2">女</option>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;
						群发地区
						<input type="hidden" name="region_name" id="region_name" value="全部">
						<select class="select" name="region" id="region" style="width:120px;" onchange="initRegion(this,'province','region_name')">
							<option value="">全部</option>
							<option value="-1">中国</option>
						</select>
						<input type="hidden" name="province_name" id="province_name" value="全部">
						<select class="select hide" style="width:120px;" name="province" id="province"
							onchange="initRegion(this,'city','province_name')" >
							<option value="">全部</option>
						</select>
						<input type="hidden" name="city_name" id="city_name" value="全部">
						<select class="select hide" style="width:120px;" name="city" id="city" onchange="setTitleChang('city','city_name')">
							<option value="">全部</option>
						</select>
					</div>
					<!--/选择列表-->
					<!--发送消息-->
					<div class="SendOut">
						<c:if test="${!empty info}">
					    <span class="text-success text-bold" id="info">${info}</span></c:if>
					    <c:if test="${empty info}">
						<input type="button" class="delayed" value="延时发送">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="now" onclick="saveButtons(this)" value="立即发送"></c:if>
					</div>
					<!--/发送消息-->
					<!--延时发送-->
					<div class="delay" style="display: none;">
						<h4>延时发送</h4>
						<p>你可以选择5分钟后的今、明两天内任意时刻定时群发，成功设置后不支持修改，但在设定的时间之前可取消，取消后不占用群发条数。</p>
						<div class="delay_content">
							发送时间
							<select class="select" name="day" id="day" style="width:100px;" onchange="selectDay(this.value)">
								<option value="1">今天</option>
								<option value="2">明天</option>
							</select>
							<select class="select" name="time" id="time" style="width:80px;" onchange="selectTime(this.value)">
							</select>时
							<select class="select" name="minute" id="minute" style="width:80px;">
							</select>分
							<div>
							</div>
						</div>
						<div class="btn_box">
							<input type="button" class="cancel" value="取消">
							<input type="button" class="sure" onclick="saveButtons(this,1)" value="确定">
						</div>
					</div>
				</div> 
			</div>
			</form>
		</div>
		
			<%@include file="../common/footer.jsp"%>
			<script language="javascript">
				$(function() {
					$('.nav li').click(function() {
						var index = $(this).index();
						if(index==0){
							window.location = "${pageContext.request.contextPath}/center/weixin/batchSending/list";
						}else{
							window.location = "${pageContext.request.contextPath}/center/weixin/batchSending/list?type=1";
						}
						
					});
					
					//					设置延时发送
					$('.delayed').click(function() {
						var action_type=$("#action_type").val();
						if(action_type=="1"){ //文字
							if( $.trim($("#content22").val())==""){
								MAlert("文字不能为空!");
								return ;
							}
						}else if(action_type=="2"){//图文
							if( $.trim($("#content11").val())==""){
								MAlert("请添加素材!");
								return ;
							}
						}else if(action_type=="3"){//表示图片
							if( $.trim($("#content33").val())==""){
								MAlert("请添加素材!");
								return ;
							}
						}
						$('.delay').show();
						selectDay(1);
					});
					//					取消设置延时发送
					$('.cancel').click(function() {
						$('.delay').hide();
					});
					//					确定延时发送
					$('.sure').click(function() {
						$('.delay').hide();
					}); 
					
					//图文消息、文字、图片切换 
					$(".contentType").find("li").each(function(){
						$(this).click(function(){
							$(".contentType").find("li").each(function(){
								$(this).attr("class","");
							});
							$(this).attr("class","on");
							
							if($(this).val()=="1"){//表示图文消息
								$(".my_file_pic").show();
								$(".my_text").hide();
								$(".my_pic").hide();  
								$("#action_type").val("2");
							}else if($(this).val()=="2"){//表示文字
								$(".my_file_pic").hide();
								$(".my_text").show();
								$(".my_pic").hide();
								$("#action_type").val("1");
							}else{//表示图片
								$(".my_file_pic").hide();
								$(".my_text").hide();
								$(".my_pic").show();
								$("#action_type").val("3");
							}
						});
					});  
					
				});
				
				//保存按钮--验证parsley  公用
				function saveButtons(obj,time_type) {
					if(time_type==1){
						$("#time_type").val("1");
					}else{
						$("#time_type").val("");
					}
					var action_type=$("#action_type").val();
					if(action_type=="1"){ //文字
						if( $.trim($("#content22").val())==""){
							MAlert("文字不能为空!");
							return ;
						}
					}else if(action_type=="2"){//图文
						if( $.trim($("#content11").val())==""){
							MAlert("请添加素材!");
							return ;
						}
					}else if(action_type=="3"){//表示图片
						if( $.trim($("#content33").val())==""){
							MAlert("请添加素材!");
							return ;
						}
					}
					MConfirm('消息开始群发后无法撤销，是否确认群发？？','','',function(result) {
						if(result){
							FullScreenShow("数据导入中，请稍后！");
							var form = obj.form;
							form.submit();
						}
					});
				}

				function openSelectImage() {
					commonDialogModal("图片素材选择", "${pageContext.request.contextPath}/center/weixin/weixinReply/imageModal", 1000, 600, '', '');
				}
				
				function returnSelectImages(media_id,images){
					$("#commonDialogModal").modal('hide');
					$("#image_select").attr("src",images);
					$("#content33").val(media_id);
					$(".image_select_div1").hide();  
					$(".image_select_div2").show();  
				}
				
				function imageSelectDelete(){ 
					$("#image_select").attr("src","");
					$(".image_select_div2").hide();  
					$(".image_select_div1").show();  
					$("#content33").val("");
				}
				
				function openSelectImageText() {
					commonDialogModal("图文素材选择", "${pageContext.request.contextPath}/center/weixin/weixinReply/imageTextModal", 1000, 600, '', '');
				}
				
				function returnSelectImagesText(media_id,images,title){
					$("#commonDialogModal").modal('hide');
					$("#imageText_select").attr("src",images);
					$("#content11").val(media_id);
					$("#imageText_title").html(title);
					$(".imageText_select_div1").hide();  
					$(".imageText_select_div2").show();  
				}
				
				function imageTextSelectDelete(){ 
					$("#imageText_select").attr("src","");
					$(".imageText_select_div2").hide();  
					$(".imageText_select_div1").show();  
					$("#content11").val("");
				}
				
				function initRegion(obj,id,name){
					var parent_id=$(obj).val();
					var mtext=$(obj).find("option:selected").text();
					$("#"+name).val(mtext);
					if(parent_id!=""){
						if(id=="province"){
							$("#province").removeClass("hide"); 
							$("#s2id_province").css("display","inline-block"); 
				    	}else if(id=="city"){
							$("#city").removeClass("hide"); 
							$("#s2id_city").css("display","inline-block");  
				    	}
						$.ajax({
						    url:'${pageContext.request.contextPath}/center/publics/publics/selectRegionList',
						    type:'GET', 
						    data:{'parent_id':parent_id},
						    dataType:'json',
						    success:function(result){
						    	result=result.data;
						    	var option="<option value=''>全部</option>";
						    	for ( var i = 0; i < result.length; i++) {
						    		option=option+"<option value='"+result[i].id+"'>"+result[i].region_name+"</option>";
								} 
						    	$("#"+id).html(option);
						    	$("#"+id).select2("val","");//默认选中第一个
						    	$("#"+id+"_name").val("全部");
						    },
						    error:function(xhr,textStatus){
						        console.log('错误');
						    }
						});
					}else{
						if(id=="province"){
							$("#s2id_province").css("display","none"); 
							$("#s2id_city").css("display","none"); 
							$("#province").removeClass("hide"); 
							$("#city").removeClass("hide"); 
				    	}else if(id=="city"){
							$("#city").removeClass("hide"); 
							$("#s2id_city").css("display","none"); 
				    	}
					}
				}
				
				function groupChang(type){
					if(type!=""){
						$("#sign_id").removeClass("hide"); 
						$("#s2id_sign_id").css("display","inline-block"); 
					}else{
						$("#s2id_sign_id").css("display","none");  
						$("#sign_id").removeClass("hide");  
					}
				}
				
				function setTitleChang(id,name){
					$("#"+name).val($("#"+id).find("option:selected").text());
				}
				
				var hh=0;
				var mm=0;
				function selectDay(day){
					var today = new Date();
						hh=today.getHours();
						mm=today.getMinutes();
						
					var minhh=hh;
					var minmm=mm;
					if(day==2){
						minhh=0;
						minmm=0;
					}
					var option="";
			    	for ( var i = minhh; i < 24; i++) {
			    		var tit=i;
			    		if(i<10){
			    			tit="0"+i;
			    		}
			    		option=option+"<option value='"+tit+"'>"+tit+"</option>";
					}
			    	$("#time").html(option);
			    	$('#time').prop('selectedIndex', 0);
			        $("#time").trigger('change');
					
			    	option="";
			    	for ( var i = minmm; i < 60; i++) {
			    		var tit=i;
			    		if(i<10){
			    			tit="0"+i;
			    		}
			    		option=option+"<option value='"+tit+"'>"+tit+"</option>";
					}
			    	$("#minute").html(option);
			    	$('#minute').prop('selectedIndex', 0);
			        $("#minute").trigger('change');
				}
				
				function selectTime(time){ 
					if(time==hh){
						time=mm;
					}else{
						time=0;
					}
					var option="";
					for ( var i = time; i < 60; i++) {
			    		var tit=i;
			    		if(i<10){
			    			tit="0"+i;
			    		}
			    		option=option+"<option value='"+tit+"'>"+tit+"</option>";
					}
			    	$("#minute").html(option);
			    	$('#minute').prop('selectedIndex', 0);
			        $("#minute").trigger('change');
				}
			</script>
	</body>

</html>