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
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<style type="text/css">
 
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
			/*haed*/
			
			.head_ul {
				margin: 0 20px;
				padding: 0;
				height: 43px;
				color: #666;
				line-height: 43px;
				border: 1px solid #c9c9c9;
				background-color: #F7F7F8;
			}
			
			.head_li {
				float: left;
				width: 100px;
				text-align: center;
				cursor: pointer;
			}
			
			.head_li:first-child {
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
			/*/head*/
			/*div_box*/
			
			.div_box {
				margin: 0 20px;
				padding: 20px;
				border: 1px solid #c9c9c9;
				border-top: 0;
				background-color: #fff;
			}
			
			.Key_word {}
			
			.key_top {
				border-bottom: 1px solid #E4E8EB;
				overflow: hidden;
				margin-bottom: 20px;
			}
			
			.key_top p,
			.key_top a {
				float: left;
			}
			
			.key_top p {
				width: 520px;
				line-height: 25px;
				font-size: 14px;
				color: #9a9a9a;
			}
			
			.key_top a {
				margin: 3px 0 0 15px;
			}
			/*switch*/
			
			.Reply_switch {
				width: 42px;
				height: 22px;
				border-radius: 11px;
				float: right;
				overflow: hidden;
				background-color: #c9c9c9;
			}
			
			.switch_ul {
				padding: 0;
				width: 63px;
				height: 22px;
				margin-left: -21px;
			}
			
			.switch_ul li {
				width: 21px;
				height: 22px;
				float: left;
			}
			
			.switch_btn {
				width: 19px !important;
				height: 20px !important;
				margin: 1px 0 0 1px;
				border-radius: 10px;
				background-color: #fff;
			}
			/*/switch*/
			
			.search_ipt {
				width: 280px;
				height: 36px;
				padding: 0 10px;
				border: 1px solid #999;
			}
			
			.reply_btn {
				width: 102px;
				height: 36px;
				float: right;
				border: 0;
				background-color: #00aec3;
				border-radius: 4px;
				color: #fff;
				font-size: 14px;
			}
			
			.search_Reply {
				width: 100%;
				margin-top: 20px;
			}
			
			.search_Reply tr td {
				width: 25%;
				height: 57px;
				line-height: 57px;
				text-align: center;
			}
			
			.search_Reply thead tr {
				background-color: #f0f0f0;
				color: #555;
			}
			
			.search_Reply tbody tr {
				border-bottom: 1px solid #c9c9c9;
			}
			/*添加回复内容*/
			
			.add_reply {
				overflow: hidden;
			}
			
			.add_reply ul {
				float: left
			}
			
			.add_reply .add_left li {
				line-height: 80px;
			}
			/*add_right*/
			
			.add_right input,
			.add_right select {
				height: 36px;
			}
			/*输入规则*/
			
			.Input_rule input {
				width: 830px;
				padding: 0 10px;
				margin: 22px 0 5px 0;
			}
			
			.Input_rule input:focus {
				border: 1px solid #00bcd4;
				padding: 0 11px;
			}
			/*关键词*/
			
			.SelectKeyWords {
				padding-top: 8px;
			}
			
			.SelectKeyWords select,
			.SelectKeyWords input {
				float: left
			}
			
			.SelectKeyWords select {
				width: 130px;
				border-right: 0;
				margin-bottom: 5px;
			}
			
			.SelectKeyWords input {
				width: 700px;
				padding: 0 10px;
				margin-bottom: 5px;
			}
			
			.SelectKeyWords p {
				color: #FA5151;
			}
			/*回复内容*/
			
			.Reply_content {
				padding: 10px 0;
				overflow: hidden;
			}
			
			.puls,
			.content_type {
				float: left;
			}
			
			.puls {
				width: 36px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border-radius: 18px;
				background-color: #fff;
				font-size: 30px;
				color: #c9c9c9;
				margin-right: 15px;
				cursor: pointer;
				border: 1px solid #c9c9c9;
			}
			
			.content_type {
				width: 700px;
				line-height: 36px;
				border: 1px solid #c9c9c9;
				box-shadow: 0px 0px 2px 2px rgba(220, 220, 220, 0.5);
			}
			
			.content_type li {
				width: 100px;
				float: left;
				color: #5C5E5C;
				text-align: center;
				cursor: pointer;
			}
			
			.content_type li:hover {
				font-size: 16px;
				color: #333;
			}
			/*回复方式*/
			
			.Reply_mode {
				padding-top: 35px;
				overflow: hidden;
			}
			
			.Reply_mode .Reply_num {
				float: left;
				margin-right: 20px;
				line-height: 30px;
			}
			
			.Reply_mode input {
				width: 20px;
				height: 20px;
				vertical-align: middle;
				margin: 0 !important;
				margin-top: -5px !important;
			}
			/*确定、取消*/
			
			.bom_btn {
				width: 230px;
				height: 36px;
				margin: 0 auto;
			}
			
			.cancel,
			.sure,
			.btn_cancel,
			.btn_sure,
			.word_cancel,
			.word_sure,
			.img_cancel,
			.img_sure,
			.add_sure,
			.add_cancel {
				float: left;
			}
			
			.cancel,
			.btn_cancel,
			.word_cancel,
			.img_cancel,
			.add_cancel {
				width: 100px;
				height: 36px;
				color: #666;
				margin-right: 30px;
				border: 0;
				border-radius: 4px;
				border: 1px solid #E4E8EB;
				background-color: #FBFBFB;
			}
			
			.sure,
			.btn_sure,
			.word_sure,
			.img_sure,
			.add_sure {
				width: 100px;
				height: 36px;
				border: 0;
				color: #fff;
				border-radius: 4px;
				background-color: #00BCD4;
			}
			/*/add_right*/
			/*选择素材图层*/
			
			.num {
				display: none;
			}
			
			.ImageAndText,
			.text {
				width: 690px;
				height: 616px;
				position: fixed;
				left: 50%;
				top: 50%;
				background-color: #fff;
				transform: translate(-50%, -50%);
				box-shadow: 0 0 2px 2px rgba(220, 220, 220, 0.8);
			}
			
			.ImageAndText h4 {
				margin-left: 20px;
				padding: 20px 0;
			}
			
			.title_ipt {
				height: 30px;
				margin-left: 20px;
				padding-left: 10px;
			}
			
			.go_library {
				width: 100px;
				line-height: 36px;
				border: 0;
				text-align: center;
				float: right;
				margin-right: 20px;
				border-radius: 4px;
				background-color: #00bcd4;
				color: #fff;
			}
			
			.material_list {
				height: 400px;
				overflow: auto;
				padding: 20px 13px;
				margin-top: 20px;
				border-top: 1px solid #E4E8EB;
				border-bottom: 1px solid #E4E8EB;
			}
			
			.list_num {
				float: left;
				margin-bottom: 15px;
				padding: 14px 9px 7px 14px;
				box-shadow: 0 0 2px 2px rgba(220, 220, 220, 0.7);
			}
			
			.list_num:nth-child(odd) {
				margin-right: 14px;
			}
			
			.list_title {
				font-size: 20px;
				color: #666;
			}
			
			.list_img {
				width: 293px;
				height: 170px;
			}
			
			.list_time {
				margin-top: 12px;
				color: #bbb;
				font-size: 13px;
			}
			
			.list_time span {
				padding-left: 20px;
			}
			
			.btn_box,
			.word_box,
			.img_box,
			.add_box {
				width: 230px;
				margin: 0 auto;
				margin-top: 10px;
			}
			/*添加回复文字*/
			
			.text {
				padding: 20px;
			}
			
			.num h4 {
				margin-bottom: 30px;
			}
			
			.words {
				width: 640px;
				height: 355px;
				resize: none;
				border: 1px solid #E4E8EB;
			}
			
			.control {
				width: 640px;
				height: 37px;
				line-height: 37px;
				font-size: 14px;
				color: #9a9a9a;
				border: 1px solid #E4E8EB;
				border-top: 0;
				margin-top: -5px;
				background-color: #fff;
			}
			/*添加图片*/
			
			.image {
				width: 800px;
				height: 621px;
				position: fixed;
				top: 80px;
				left: 50%;
				transform: translateX(-50%);
				background-color: #fff;
				box-shadow: 0 0 2px 2px rgba(220, 220, 220, 0.7);
			}
			
			.image h4 {
				padding-left: 20px;
			}
			
			.image_content {
				height: 493px;
				border-top: 1px solid #c9c9c9;
				border-bottom: 1px solid #c9c9c9
			}
			
			.content_left,
			.content_right {
				float: left
			}
			/*content_left*/
			
			.content_left {
				width: 190px;
				height: 493px;
				border-right: 1px solid #E4E8EB;
				position: relative;
			}
			
			.Grouping {
				padding-left: 0
			}
			
			.Grouping li {
				line-height: 45px;
				padding-left: 14px;
				cursor: pointer;
				border-bottom: 1px solid #f5f5f5;
			}
			
			.newGrouping {
				position: absolute;
				bottom: 0;
				width: 190px;
				line-height: 50px;
				text-align: center;
				cursor: pointer;
				border-top: 1px solid #E4E8EB;
			}
			/*content_right*/
			
			.content_right {
				width: 609px;
				height: 493px;
			}
			
			.right_top {
				height: 60px;
				position: relative;
				border-bottom: 1px solid #c9c9c9;
			}
			
			.right_top span {
				position: absolute;
				top: 20px;
				right: 140px;
				font-size: 14px;
				color: #9a9a9a;
			}
			
			.file_box {
				width: 98px;
				height: 34px;
				text-align: center;
				line-height: 34px;
				border-radius: 4px;
				background-color: #fff;
				border: 1px solid #e4e8eb;
				position: absolute;
				top: 10px;
				right: 20px;
			}
			
			.file_sub {
				width: 100%;
				height: 100%;
				opacity: 0;
				position: absolute;
				top: 0;
			}
			
			.file_btn {
				width: 100%;
				height: 100%;
			}
			
			.right_bom {
				width: 606px;
				height: 400px;
				padding: 0 5px;
				overflow: auto;
			}
			
			.img_list {
				width: 120px;
				height: 150px;
				margin: 10px 12px;
				float: left;
			}
			
			.img_src {
				width: 120px;
				height: 120px;
			}
			
			.img_title {
				border: 1px solid #c9c9c9;
				border-top: 0;
				line-height: 30px;
				text-align: center;
				margin: 0;
			}
			/*新建分组*/
			
			.addGrouping {
				position: absolute;
				border: 1px solid #c9c9c9;
				border-radius: 5px;
				padding: 20px;
				background-color: #fff;
				display: none;
			}
			
			.addGrouping input {
				border: 1px solid #c9c9c9;
				height: 36px;
				padding: 0 5px;
			}
			/*收到消息回复*/
			
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
				border-left: 1px solid #c9c9c9;
				border-right: 1px solid #c9c9c9;
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
			
			.countenance {
				padding: 10px 20px;
				border: 1px solid #c9c9c9;
			}
			
			.Smiling_face {
				cursor: pointer;
			}
			
			.countenance .num_words {
				float: right;
			}
			
			.ReplyBtn_box {
				padding: 20px;
				overflow: hidden;
			}
			
			.Preservation,
			.delete {
				float: left;
				width: 100px;
				height: 36px;
				text-align: center;
				line-height: 36px;
				border: 0;
				border-radius: 5px;
			}
			
			.Preservation {
				background-color: #00BCD4;
				color: #fff;
				margin: 0 20px;
			}
			
			.dedlete {
				border: 1px solid #E4E8EB;
				background-color: #FBFBFB;
				color: #5E5E5E;
			}
			/*/div_box*/
		</style>

		<%@include file="../common/header.jsp"%>
	</head>

	<body>

		<!-- Secondary sidebar -->
		<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
			<div class="sidebar-content">
				<!-- Sub navigation -->
				<div class="sidebar-category">
					<div class="category-content no-padding">
						<ul class="navigation navigation-alt navigation-accordion">
							<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
						</ul>
					</div>
				</div>
				<!-- /sub navigation -->
			</div>
		</div>
		<!--  /Secondary sidebar -->

		<!-- Content area -->
		<div class="content">
			<ul class="nav  nav-tabs"> 
				<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo" style="border-left:0px;border-top:0px;"><i class="icon-qrcode position-left"></i>公众号授权</a></li>
				<li><a href="${pageContext.request.contextPath}/center/setting/payment"><i class="fa fa-wechat position-left"></i>微信支付</a></li>
				<li><a href="${pageContext.request.contextPath}/center/weixin/templateMessage/list"><i class="icon-bubble-lines4 position-left"></i>模板消息</a></li>
				<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/weixinReply/list"><i class="icon-file-text2 position-left"></i>自动回复</a></li>
			</ul>
			<ul class="head_ul">
				<li class="head_li ">关键词回复</li>
				<li class="head_li Select">收到消息回复</li>
				<li class="head_li">被关注时回复</li>
			</ul>
			
			<form class="form-horizontal" method="POST" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/weixin/weixinReply/save">
			<input type="hidden" name="reply_id" value="${reply.replyMap.reply_id}">
			<input type="hidden" name="action_type" value="2">
			<input type="hidden" name="reply_type" id="reply_type" value="${(empty reply.replyMap.reply_type)?2:reply.replyMap.reply_type}">
			<div class="div_box">
				<!--被关注时回复-->
				<div class="order Key_word" >
					<div class="key_top">
						<span class="text-success text-bold" id="info">${info }</span>
						<h3>自动回复</h3>
						<p>通过编辑内容或关键词规则，快速进行自动回复设置。如具备开发能力，可更灵活地使用该功能查看详情关闭自动回复之后，将立即对所有用户生效。</p>
						<a href="#">查看详情</a>
						<!--自动回复开关按钮-->
						<div class="Reply_switch">
							<ul class="switch_ul">
								<li class="switch_left"></li>
								<li class="switch_btn"></li>
								<li class="switch_right"></li>
							</ul>
						</div>
						<!--/自动回复开关按钮-->
					</div>
					<div class="form-group menu_content">
						<div  style="border:1px solid #e1e1e1">  
							<div class="set_content"> 
								
								<div class="file_picture">  
									<ul class="contentType"> 
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
					                    	<img  style="margin-left:2rem; margin-top: 2rem;" name="imageText_select" id="imageText_select" src="<c:if test="${reply.replyMap.reply_type eq 2}">${reply.imageTextMap.cover_img}</c:if>" width="200" height="200">
											<div onclick="imageTextSelectDelete();" class="btn btn-sm btn-success">删除</div>
					                    	<input type="hidden" name="content11" id="content11" value="<c:if test="${reply.replyMap.reply_type eq 2}">${reply.imageTextMap.media_id}</c:if>" >
					                    	</div>
					                    	<div class="text-left text-success" style="margin-left: 9rem;" id="imageText_title"><c:if test="${reply.replyMap.reply_type eq 2}">${reply.imageTextMap.title}</c:if></div>
					                    </div>
								    </div>
								    <div class="create_type_text my_text" style="display:none;">
								    	<textarea rows="11" cols="5" name="content22" id="content22" class="form-control" 
								    		style="paddig:0px 0px;border-radius:0px;border:0px;"><c:if test="${reply.replyMap.reply_type eq 1}">${reply.replyMap.reply_content}</c:if></textarea>
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
					                    	<img style="margin-left:2rem; margin-top: 2rem;" name="image_select" id="image_select" src="<c:if test="${reply.replyMap.reply_type eq 3}">${reply.imageMap.image_url}</c:if>" width="200" height="200">
											<div onclick="imageSelectDelete();" class="btn btn-sm btn-success">删除</div>
					                    	<input type="hidden" name="content33" id="content33" value="<c:if test="${reply.replyMap.reply_type eq 3}">${reply.imageMap.media_id}</c:if>" >
					                    </div>
								    </div>
								</div>
							</div>  
							
						</div>
					</div>
					
					<div class="ReplyBtn_box">
						<input type="button" class="Preservation" onclick="saveButtons(this)" value="保存">
						<c:if test="${!empty reply.replyMap.reply_id}"> 
							<input type="button" class="delete" onclick="buttonDelete();" value="删除回复" >
						</c:if>
					</div>
						
				</div>
			</div>
			</form>
		</div>

		<!-- #modal-dialog -->
		<%@include file="../common/footer.jsp"%>
		<script>
			$(function() {
				//			头部选项
				$('.head_li').click(function() {
					var index = $(this).index();
					if(index==0){
						window.location = "${pageContext.request.contextPath}/center/weixin/weixinReply/list?action_type=3";
					}else if(index==1){
						window.location = "${pageContext.request.contextPath}/center/weixin/weixinReply/list?action_type=2";
					}else{
						window.location = "${pageContext.request.contextPath}/center/weixin/weixinReply/list?action_type=1";
					}
				});
				//	switch开关
				$('.Reply_switch').click(function() {
					if($('.switch_ul').css('margin-left') == '-21px') {
						window.location = "${pageContext.request.contextPath}/center/weixin/weixinReply/updateState?action_type=2&reply_type_id=${reply.replyTypeMap.id}&state=1";
					} else {
						window.location = "${pageContext.request.contextPath}/center/weixin/weixinReply/updateState?action_type=2&reply_type_id=${reply.replyTypeMap.id}&state=-1";
					}
				});
				if("${reply.replyTypeMap.state}"=="1"){
					$('.switch_ul').css('margin-left', '0px');
					$('.Reply_switch').css('background-color', '#00BCD4');
				}
 
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
							$("#reply_type").val("2");
						}else if($(this).val()=="2"){//表示文字
							$(".my_file_pic").hide();
							$(".my_text").show();
							$(".my_pic").hide();
							$("#reply_type").val("1");
						}else{//表示图片
							$(".my_file_pic").hide();
							$(".my_text").hide();
							$(".my_pic").show();
							$("#reply_type").val("3");
						}
					});
				});  
				
				var reply_type="${reply.replyMap.reply_type}";
				if(reply_type=="1"){ //文字
					$(".contentType").find("li").eq(1).click();
				}else if(reply_type=="2"){//图文
					$(".contentType").find("li").eq(0).click(); 
					$(".imageText_select_div1").hide();  
					$(".imageText_select_div2").show();  
				}else if(reply_type=="3"){//表示图片
					$(".contentType").find("li").eq(2).click(); 
					$(".image_select_div1").hide();  
					$(".image_select_div2").show();  
				}
				
			}); 

			//保存按钮--验证parsley  公用
			function saveButtons(obj) {
				var reply_type=$("#reply_type").val();
				if(reply_type=="1"){ //文字
					if( $.trim($("#content22").val())==""){
						MAlert("文字不能为空!");
						return ;
					}
				}else if(reply_type=="2"){//图文
					if( $.trim($("#content11").val())==""){
						MAlert("请添加素材!");
						return ;
					}
				}else if(reply_type=="3"){//表示图片
					if( $.trim($("#content33").val())==""){
						MAlert("请添加素材!");
						return ;
					}
				}
				var form = obj.form;
				form.submit();
			}

			function mUpdate(reply_id, status) {
				window.location = "${pageContext.request.contextPath}/admin/proxyPublicReplyUpdateStatus0.html?status=" + status + "&reply_id=" + reply_id;
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
 
			
			function buttonDelete(){
				MConfirm('删除后，关注该公众号的用户将不再接收该回复，确定删除？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/weixin/weixinReply/remove?action_type=2&reply_id=${reply.replyMap.reply_id}";
					}
				});
			}
		</script>
	</body>

</html>