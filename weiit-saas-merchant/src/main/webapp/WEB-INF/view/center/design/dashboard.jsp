<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/visualization/echarts/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/charts/echarts/charts.js"></script>
<style>
	.phone_box {
		width: 250px;
		height: 560px;
		margin: 0 40px 60px 0;
		float: left;
	}
	
	.phone {
		width: 250px;
		height: 495px;
		background-image: url(${pageContext.request.contextPath}/resource/images/phone.png);
		background-repeat: no-repeat;
		background-size: 100% 100%;
		margin-bottom: 20px;
		position: relative;
	}
	
	.back {
		display: none;
		width: 218px;
		height: 380px;
		cursor: pointer;
		position: absolute;
		top: 60px;
		left: 15px;
		background-color: rgba(0, 0, 0, 0.8);
	}
	
	.erweima {
		width: 130px;
		height: 130px;
		position: absolute;
		top: 40%;
		left: 50%;
		transform: translate(-50%, -60%);
	}
	
	.Scan {
		position: absolute;
		top: 56%;
		left: 50%;
		transform: translateX(-50%);
		color: #fff;
		width: 136px;
		font-size: 14px;
	}
	
	.Choice {
		width: 135px;
		height: 40px;
		margin: 0 auto;
		overflow: hidden;
	}
	
	.Choice input,
	.Choice .Use {
		cursor: pointer;
		float: left;
		line-height: 30px;
		vertical-align: middle;
	}
	
	.Choice input {
		width: 20px;
		height: 20px;
		margin-right: 15px;
	}
	
	.Use {
		border: 1px solid #c9c9c9;
		width: 90px;
		height: 30px;
		text-align: center;
		border-radius: 5px;
		background-color: #f9f9f9;
	}
	
	.options {
		border: 1px solid #00bcd4;
		color: #00bcd4;
	}
</style>
<!-- Main content -->
<div class="content-wrapper">

	<!-- Content area -->
	<div class="content">
		<div id="phone_box" class="phone_box">
			<div class="phone">
				<div class="back">
					<img class="erweima" src="${pageContext.request.contextPath}/resource/images/logo_bg.jpg">
					<p class="Scan">微信扫一扫,预览模板</p>
				</div>
			</div>
			<div class="Choice">
				<input type="radio" name="use">
				<div class="Use">使用此模板</div>
			</div>
		</div>
	</div>

	<!-- /main content -->
	<%@include file="../common/footer.jsp" %>

	<script>
		$(function() {
			$('.phone', this).on('mouseenter', function() {
				$('.back', this).show()
			}).on('mouseleave', function() {
				$('.back', this).hide()
			})
			$('.Choice', this).on('click', function() {
				$('.Use').removeClass('options');
				$('.Use', this).addClass('options');
				$('.Use', this).prev().prop('checked', 'checked');
			});
		});
	</script>