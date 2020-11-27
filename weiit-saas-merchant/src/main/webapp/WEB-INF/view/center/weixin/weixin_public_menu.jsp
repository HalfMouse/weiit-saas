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
		<style>
			.custom {
				width: 1100px;
				height: 770px;
				margin-left: 50px;
				margin-top: 50px;
				background-color: #fff;
				box-shadow: 0 0 2px 2px rgba(220, 220, 220, 0.8);
			}
			
			.title {
				line-height: 70px;
				color: #666;
				font-size: 26px;
				padding: 0 20px;
			}
			
			.menu_box {
				width: 1100px;
				height: 700px;
				border-top: 1px solid #c9c9c9;
				background-color: #fff;
				position: relative;
			}
			
			.mobile-width-2 {
				height: 592px !important;
				padding: 20px 0 0 20px;
				width: 270px;
				margin-right: 20px;
				position: relative;
			}
			
			.mobile-width-2 .phone {
				width: 270px;
				height: 550px;
				position: absolute;
			}
			
			.mobile-width-2,
			.diy_menu,
			.son_menu {
				float: left
			}
			
			.diy_menu {
				display: none;
			}
			
			.back {
				width: 234px;
				height: 340px;
				position: absolute;
				top: 125px;
				left: 38px;
				background-color: #f5f5f5;
			}
			/*左边菜单栏*/
			
			ul {
				padding: 0 !important;
				margin: 0 !important;
			}
			
			li {
				list-style: none;
			}
			
			.menu_bar {
				padding: 447px 0 0 19px;
				position: absolute;
				color: #616161;
			}
			
			.menu_bar .Main_menu {
				width: 232px;
				height: 37px;
				line-height: 37px;
				color: #fff;
				font-size: 16px;
				padding: 0;
				margin: 0 !important;
			}
			
			.menu_bar li {
				float: left;
				width: 207px;
				color: #666;
				border-right: 1px solid #D0D0D0;
				text-align: center;
				background-color: #FAFAFA;
				cursor: pointer;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
			
			.state_li {
				border-right: 0 !important;
				border: 1px solid #00BCD4 !important;
				color: #00BCD4 !important;
				height: 41px !important;
				line-height: 41px !important;
				margin-top: -2px;
			}
			
			.menu_bar li:first-child {
				width: 37px;
			}
			
			.menu_bar li:last-child {
				border-right: 0;
			}
			/*子菜单*/
			
			.Submenu {
				margin-left: 37px;
				background-color: #fff;
				color: #616161;
				position: absolute;
				left: 0px;
				bottom: 130px;
				border: 1px solid #f0f0f0;
			}
			
			.Submenu li {
				text-align: center;
				border-bottom: 1px solid #D0D0D0;
				line-height: 37px;
				cursor: pointer;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
			/*右边自定义菜单选项*/
			
			.diy_menu,
			.son_menu {
				width: 700px;
				height: 550px;
				border: 1px solid #c9c9c9;
				background-color: #fff;
				border-radius: 10px;
				margin-left: 20px;
				margin-top: 20px;
				padding: 10px;
				position: relative;
				z-index: 0;
			}
			
			.Prompt {
				color: orangered;
				position: absolute;
				bottom: 0px;
				left: 20px;
			}
			
			.menu_title {
				float: left;
			}
			
			.delete_menu {
				float: right;
			}
			
			.add_menu {
				border-top: 1px solid #c9c9c9;
				padding: 10px;
				margin-top: 40px;
				overflow: hidden;
			}
			
			.add_menu h6 {
				font-size: 14px;
				color: #A7A7AA;
			}
			
			.menu_name,
			.ipt_box {
				float: left;
				margin-top: 20px;
				line-height: 30px;
			}
			
			.ipt_box {
				padding-left: 20px;
			}
			
			.ipt_box .ipt_name {
				width: 300px;
				height: 30px;
			}
			/*保存发布、预览*/
			
			.btn_box,
			.btn_box1,
			.btn_box2,
			.img_box {
				width: 230px;
				height: 37px;
				position: absolute;
				bottom: 20px;
				left: 50%;
				transform: translateX(-50%);
			}
			
			.btn_box button,
			.btn_box1 button,
			.btn_box2 button,
			.img_box button {
				width: 100px;
				height: 36px;
				line-height: 36px;
				text-align: center;
				line-height: 36px;
				border: 0;
				font-size: 14px;
				border-radius: 4px;
				float: left;
			}
			
			.btn_box .Preservation,
			.btn_box1 .Release {
				margin-right: 30px;
				color: #fff;
				background-color: #00BCD4;
			}
			
			.btn_box .preview,
			.btn_box1 .look {
				border: 1px solid #e4e8eb;
				background-color: #fbfbfb;
				color: #5E5E5E;
			}
			/*子菜单*/
			
			.son_menu {
				width: 700px;
				display: none;
			}
			
			.son_con {
				overflow: hidden;
				line-height: 30px;
			}
			
			.son_con p {
				width: 100px;
				line-height: 30px;
				padding-left: 10px;
				float: left
			}
			
			.son_con input {
				width: 20px;
				height: 20px;
				margin: 0 !important;
				vertical-align: middle;
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
				text-align: center;
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
				height: 150px !important;
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
			
			.web,
			.WeChat {
				padding: 20px;
				margin: 20px;
				height: 200px;
				border: 1px solid #c9c9c9;
				margin-top: 0;
				line-height: 30px;
			}
			
			.web p {
				font-size: 14px;
				color: #8D8D8D;
			}
			
			.web input {
				width: 300px;
				margin-left: 20px;
				height: 30px;
				padding: 0 10px;
				border: 1px solid #c9c9c9;
			}
			
			.WeChat {
				position: relative;
			}
			
			.WeChat p {
				width: 380px;
				position: absolute;
				top: 50px;
				left: 50%;
				transform: translateX(-50%);
			}
			
			.WeChat .binding {
				width: 100px;
				height: 30px;
				text-align: center;
				line-height: 30px;
				border: 0;
				border: 1px solid #c9c9c9;
				border-radius: 3px;
				background-color: #fff;
				position: absolute;
				top: 100px;
				left: 50%;
				transform: translateX(-50%);
			}
			/*选择素材*/
			
			.ImageAndText {
				display: none;
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
				margin: 0;
				margin-left: 20px;
				padding: 5px 0;
			}
			
			.ImageAndText .ul_type {
				height: 30px;
				margin-bottom: 20px !important;
				border-bottom: 1px solid #f0f0f0;
			}
			
			.ul_type li {
				float: left;
				width: 80px;
				text-align: center;
				line-height: 30px;
				cursor: pointer;
			}
			
			.select_li {
				color: #00bcd4;
				border-bottom: 1px solid #00bcd4;
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
				width: 100%;
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
			
			.btn_box2 .btn_cancel {
				border: 1px solid #e4e8eb;
				background-color: #fbfbfb;
				margin-right: 30px;
				color: ##5E5E5E;
			}
			
			.btn_box2 .btn_sure {
				background-color: #00bcd4;
				color: #fff;
			}
			/*选择图片*/
			
			.image {
				width: 800px;
				height: 621px;
				display: none;
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
				color: #666;
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
			
			.img_box .img_cancel {
				margin-right: 30px;
				border: 1px solid #c9c9c9;
				background-color: #fbfbfb;
			}
			
			.img_box .img_sure {
				background-color: #00bcd4;
				color: #fff;
			}
		</style>
		<%@include file="../common/header.jsp"%>
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.all.min.js"></script>
		<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
		<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
	</head>

	<body style="background:#F8F9FB">

		<!-- Secondary sidebar -->
		<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
			<div class="sidebar-content">
				<!-- Sub navigation -->
				<div class="sidebar-category">
					<div class="category-content no-padding">
						<ul class="navigation navigation-alt navigation-accordion">
							<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
							<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/menu/proxyPublicMenu0"><i class="icon-mobile"></i>自定义菜单</a></li>
							<li><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
						</ul>
					</div>
				</div>
				<!-- /sub navigation -->
			</div>
		</div>
		<!--  /Secondary sidebar -->
		<div class="custom">
			<div class="title">自定义菜单</div>
			<!-- begin row -->
			<div class="menu_box">
				<!-- begin col-6 -->
				<div id="iframe-wrap" class="mobile-width-2">
					<img class="phone" src="${pageContext.request.contextPath}/resource/images/phone.png">
					<div class="back"></div>
					<div class="menu_bar">
						<!--主菜单-->
						<ul class="Main_menu"></ul>
					</div>
					<!--子菜单-->
					<div class="Submenu"></div>
				</div>
				<div class="diy_menu">
					<p class="menu_title">用户中心</p>
					<a class="delete_menu" style="display: none;">删除该菜单</a>
					<div class="add_menu">
						<h6>已添加子菜单，仅可设置菜单名称</h6>
						<p class="menu_name">菜单名称</p>
						<div class="ipt_box">
							<input placeholder="请输入菜单名称" value="" class="ipt_name">
							<h6>字数不能超过4个汉字或者8个字母</h6>
						</div>
					</div>
					<p class="Prompt">菜单完成后请点击”保存并发布“同步到手机</p>
				</div>
				<!--保存发布、预览-->
				<div class="btn_box">
					<button class="Preservation">保存并发布</button>
					<button class="preview">预览</button>
				</div>
				<!--子菜单-->
				<div class="son_menu">
					<p class="menu_title"></p>
					<a class="delete_menu">删除该菜单</a>
					<div class="add_menu">
						<p class="menu_name">子菜单名称</p>
						<div class="ipt_box">
							<input placeholder="请输入菜单名称" value="" class="ipt_name">
							<h6>字数不能超过4个汉字或者8个字母</h6>
						</div>
					</div>
					<div class="son_con">
						<p>子菜单内容</p>
						<input type="radio" class="son_opt" name="son" value="发送消息" checked="checked">发送消息
						<input type="radio" class="son_opt" name="son" value="跳转网页">跳转网页
						<input type="radio" class="son_opt" name="son" value="跳转小程序">跳转小程序
					</div>
					<div class="type_box">
						<div class="num news_bottom">
							<ul class="newsContentType">
								<li>图文消息</li>
								<li>文字</li>
								<li>图片</li>
								<li>语音</li>
							</ul>
							<div class="content_box">
								<ul class="con_option">
									<li class="get">从素材库选取</li>
									<li>自建图文</li>
								</ul>
								<ul class="words con_option" style="display: none;">
									<li>
										<textarea></textarea>
									</li>
								</ul>
								<ul class="con_option" style="display: none;">
									<li class="get_img">从素材库选取</li>
									<li class="local">
										<div class="local_img">本地图片</div>
										<input type="file" class="local_file">
									</li>
								</ul>
							</div>
						</div>
						<div class="num web" style="display: none;">
							<p>订阅者点击该子菜单会跳转到以下链接</p>
							页面地址<input type="text" placeholder="请输入地址链接">
						</div>
						<div class="num WeChat" style="display: none;">
							<p>自定义菜单可跳转已绑定的小程序,本公众号尚未绑定小程序.</p>
							<button class="binding">前往绑定</button>
						</div>
					</div>
					<p class="Prompt">菜单完成后请点击”保存并发布“同步到手机</p>
				</div>
				<!--选择图文-->
				<div class="ImageAndText">
					<h4>选择素材</h4>
					<ul class="ul_type">
						<li>已发送</li>
						<li class="select_li">素材库</li>
						<li>历史记录</li>
					</ul>
					<input class="title_ipt" placeholder="标题">
					<button class="go_library">前往素材库</button>
					<div class="material_list">
						<div class="list_num">
							<p class="list_title">这里是标题</p>
							<img class="list_img" src="http://img5.imgtn.bdimg.com/it/u=1613173503,2102668646&fm=27&gp=0.jpg">
							<p class="list_time">活动<span>2018.05.01</span></p>
						</div>
					</div>
					<div class="btn_box2">
						<button class="btn_cancel">取消</button>
						<button class="btn_sure">确定</button>
					</div>
				</div>
				<!--选择图片-->
				<div class="num image">
					<h4>选择图片</h4>
					<div class="image_content">
						<div class="content_left">
							<ul class="Grouping">
								<li>全部图片(2)</li>
								<li>未分组(1)</li>
								<li>分组1(1)</li>
							</ul>
							<div class="newGrouping">新建分组</div>
						</div>
						<div class="content_right">
							<div class="right_top">
								<span>大小不超过5M</span>
								<div class="file_box">
									<div class="sub_btn">上传文件</div>
									<input type="file" class="file_sub">
								</div>
							</div>
							<div class="right_bom">
								<div class="img_list">
									<img class="img_src">
									<p class="img_title">1.png</p>
								</div>
							</div>
						</div>
					</div>
					<div class="img_box">
						<button class="img_cancel">取消</button>
						<button class="img_sure">确定</button>
					</div>
					<div class="addGrouping"> 新建分组
						<input type="text">
						<div class="add_box">
							<button class="add_cancel">取消</button>
							<button class="add_sure">确定</button>
						</div>
					</div>
				</div>
				<!--保存发布、预览-->
				<div class="btn_box1">
					<button class="Release">保存并发布</button>
					<button class="look">预览</button>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function() {
				var menu_list = ['键盘', '商城', '主页', '+']; //底部导航栏(主菜单)
				var son_menu = [
					['键盘', '商城', '+'],
					['键盘', '商城', '哈哈', '+'],
					['键盘', '商城', '嘿嘿', '+'],
					['键盘', '商城', '+']
				]; //子菜单
				var last = parseInt(menu_list.length) - 1; //底部导航栏的‘+’号
				var input_value = ''; //输入菜单的input值
				var homeW = 232;
				//	计算菜单宽度
				function list_width(homeW) {
					var list_w = (232 - 37) / (menu_list.length - 1) + 'px';
					$('.menu_bar ul li').eq(0).css('width', '37px').siblings().css('width', list_w);
				}

				function manu(list) {
					//渲染主菜单
					var main = '';
					for(var i = 0; i < list.length; i++) {
						main += '<li class="home_btn">' + list[i] + '</li>';
					}
					$('.menu_bar ul').html(main);
				}
				manu(menu_list);
				list_width(homeW)
				$('.ipt_name').change(function() {
					input_value = $(this).val()
				});
				$('.newsContentType li').click(function() {
					$(this).css('color', '#00bcd4').siblings().css('color', '#5C5E5C')
					var index = $(this).index();
					$('.con_option').eq(index).show().siblings().hide()
				});
				//				获取input获得焦点时有无内容用来判断是添加菜单还是修改菜单
				var name;
				$('.ipt_name').on('focus', function() {
					name = $(this).val();
				});
				//	主菜单保存并发布
				$('.Preservation').click(function(homeW) {
					if(input_value == '') {
						alert('请输入名称')
					} else {
						if(menu_list[index] == name) {
							menu_list.splice(index, 1, input_value);
							manu(menu_list);
							list_width(homeW)
							last = parseInt(menu_list.length) - 1
						} else {
							$('.Submenu').hide();
							switch(menu_list.length) {
								case 1:
								case 2:
								case 3:
								case 4:
									menu_list.splice(-1, 0, input_value);
									manu(menu_list);
									list_width(homeW)
									last = parseInt(menu_list.length) - 1
									break;
								case 5:
									if(menu_list[4] == '+') {
										menu_list.splice(-1, 1, input_value);
										manu(menu_list);
										list_width(homeW);
										last = parseInt(menu_list.length) - 1;
										$('.Submenu').hide();
									} else {
										alert('最多只能添加4个主菜单')
									}
									break;
								default:
									return
							}
						}
						input_value = '';
					}
					$('.ipt_name').val(''); //清空input的value
				});

				//				点击主菜单
				var index; //主菜单的index
				$('.menu_bar ul').on('click', '.home_btn', function() {
					index = $(this).index();
					var list_w = (232 - 37) / (menu_list.length - 1)
					$(this).addClass('state_li').siblings().removeClass('state_li');
					if(index > 0 && index <= last) {
						$('.delete_menu').show(); //显示删除菜单
						$('.ipt_name').val($(this).text());
						$('.Submenu').show();
						//					渲染子菜单
						if($(this).text() != '+') {
							function child(list) {
								//渲染子菜单
								var son = '';
								son += '<ul class="son_ul">'
								for(var j = 0; j < list.length; j++) {
									son += '<li class="son_li">' + list[j] + '</li>';
								}
								son += '</ul>'
								$('.Submenu').html(son);
							}
							child(son_menu[index - 1]);
							var list_w = (232 - 37) / (menu_list.length - 1);
							var sub_left = (37 + list_w * (index - 1));
							$('.Submenu').css('width', list_w + 'px');
							$('.Submenu').css('left', sub_left + 'px');
						};
						$('.diy_menu').show();
						$('.son_menu').hide();
						$('.btn_box').show();
						$('.btn_box1').hide()
						if($(this).text() == '+') {
							$('.ipt_name').val(''); //清空input的value
							$('.diy_menu').show();
							$('.delete_menu').hide();
							$('.Submenu').hide()
						}
					} else if(index == 0) {
						$('.diy_menu').hide();
						$('.Submenu').hide()
					};
				});
				//				点击子菜单
				var son_index; //子菜单的index
				$('.Submenu').on('click', 'li', function() {
					son_index = $(this).index();
					$(this).addClass('state_li').siblings().removeClass('state_li');
					$('.ipt_name').val($(this).text());
					$('.diy_menu').hide();
					$('.son_menu').show();
					$('.btn_box').hide();
					$('.btn_box1').show()
					if($(this).text() == '+') {
						$('.ipt_name').val(''); //清空input的value
					}
				});
				//				选择图文素材
				$('.get').click(function() {
					$('.ImageAndText').show()
				});
				$('.btn_cancel').click(function() {
					$('.ImageAndText').hide()
				});
				$('.ul_type li').click(function() {
					$(this).addClass('select_li').siblings().removeClass('select_li')
				});
				//				选择图片
				$('.get_img').click(function() {
					$('.image').show()
				});
				$('.Grouping').on('click', 'li', function() {
					$(this).css('color', '#00bcd4').siblings().css('color', '#666')
				})
				$('.img_cancel').click(function() {
					$('.image').hide()
				});
				//	子菜单保存并发布
				$('.Release').click(function(homeW) {
					if(input_value == '') {
						alert('请输入子菜单名称')
					} else {
						if(son_menu[index - 1][son_index] == name) {
							son_menu[index - 1].splice(son_index, 1, input_value);
							child(son_menu[index - 1]);
						} else {
							if(son_menu[index - 1].length > 0 && son_menu[index - 1].length <= 5) {
								if(son_menu[index - 1].length == 5) {
									if(son_menu[index - 1][4] == '+') {
										son_menu[index - 1][4] = input_value;
									} else {
										alert('只能添加这么多')
									}
								} else {
									son_menu[index - 1].splice(-1, 0, input_value);
								};
								child(son_menu[index - 1]);
							}
						}
					}
					input_value = '';
					$('.ipt_name').val(''); //清空input的value
				});

				function child(list) {
					//渲染子菜单
					var son = '';
					son += '<ul class="son_ul">'
					for(var j = 0; j < list.length; j++) {
						son += '<li class="son_li">' + list[j] + '</li>';
					}
					son += '</ul>'
					$('.Submenu').html(son);
				}
				//				选择子菜单跳转的方式
				$('.son_opt').click(function() {
					console.log($(this).index())
					var sonMenu_index = $(this).index() - 1;
					$('.num ').eq(sonMenu_index).show().siblings().hide();
				});
			});
		</script>
	</body>

</html>