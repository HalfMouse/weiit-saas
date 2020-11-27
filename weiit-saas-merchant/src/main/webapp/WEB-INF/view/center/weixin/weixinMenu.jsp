<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<meta name="referrer" content="never">
<link href="${pageContext.request.contextPath}/resource/css/icons/fontawesome/styles.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<div class="sidebar sidebar-secondary sidebar-default" style="width: 180px"> 
	<div class="category-content no-padding">
		<ul class="navigation navigation-alt navigation-accordion">
			<li><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i class="icon-gear"></i>基本设置</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i class="icon-images3"></i>图文管理</a></li>
			<li><a href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i class="icon-users4"></i>消息群发</a></li>
			<li class="active"><a href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i class="icon-mobile"></i>自定义菜单</a></li>
		</ul>
	</div>
</div>
 <style>



#edui1_iframeholder{
	max-height:320px;
}

ul, ol, li, dl {
	list-style-type: none;
}

a:link, a:visited {
	color: #575757;
	text-decoration: none;
}

a {
	text-decoration: none;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0.35);
}
a:hover{
text-decoration: none;
}
a:link, a:visited {
	color: #575757;
	text-decoration: none;
}

a { 
	text-decoration: none;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0.35);
}


/***********************/
.body_left{
	width:350px;
} 
.body_right{
	min-width:600px;
	max-width:1200px;
	background:#f4f5f9;
	height:600px;
}
.mobile{
	width:320px;
	height:600px;
	border:1px solid #e1e1e1;
}
.mobile .header{
	border-bottom:1px solid #e1e1e1;
	width:320px;
	padding:20px;
	height:64px;
	float:left;
	background:url("${pageContext.request.contextPath}/resource/images/weixinMenu/wx_menu_header.png") no-repeat
}
.mobile .bd{
	position:absolute;
	bottom:0;
	right:0;
	left:0;
	float:left;
	width:319px;
	margin-left:11px;
	margin-bottom:-9px; 
}
.bd .menu_footer {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    border-top: 1px solid #e7e7eb;
    background: transparent url(${pageContext.request.contextPath}/resource/images/weixinMenu/wx_menu_footer.png) no-repeat 0 0;
    background-position: 0 0;
    background-repeat: no-repeat;
}
.bd .menu_list {
    height: 50px;
    margin-left:19px; 
}
.son_con{
    width: 16px;
    height: 16px;
    margin: 0 !important;
    vertical-align: sub;
}
.menu_list li.size1 {
    position: relative;
    text-align:center;
    float: left;
    width: 100%;
    border-right:1px solid #e1e1e1;
}
.menu_list li.size2 {
    position: relative;
    text-align:center;
    float: left;
    width: 50%;
    border-right:1px solid #e1e1e1;
}
.menu_list li.size3 {
    position: relative;
    text-align:center;
    float: left;
    width: 33.2%;
    border-right:1px solid #e1e1e1;
}

.menu_list {
	height: 50px;
}

.menu_list li>a {
	font-size: 15px;
	box-sizing: border-box;
	border-bottom: 0;
	display: block;
	text-decoration: none;
	line-height: 50px;
	text-align: center;
	background:#FAFAFA;   
}

.menu_list li>a:hover {
	font-size: 15px;
	box-sizing: border-box;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	border-bottom: 0;
	display: block;
	line-height: 50px;
	text-decoration: none;
	text-align: center; 
	background: #F2F2F2; 
}

.menu_list li>a:only-child span {
	background: none;
	padding-left: 0;
}

.menu_list li>a.on {
	display: block;
	border:1px solid #44b549;
	color:#44b549;
}
.menu_list li>a.on span {
	color:#44b549;
}

.menu_list li>a.on+dl {
	display: block;
}
/*
.menu_list li>a span {
	color: #4f4d4f;
	display: -webkit-box;
	padding-left: 16px;
	text-decoration: none;
	background:
		url(${pageContext.request.contextPath}/resource/images/weixinMenu/1.svg#2)
		no-repeat 4px 18px;
	-webkit-background-size: 9px auto;
	text-shadow: 0px 1px 0px #ffffff;
}*/
.menu_list dl {
	display: none;
	position: absolute;
	z-index: 220;
	bottom: 60px;
	left: 40px;
	width: 90px;
	margin-left: -39px;
	border-radius: 5px;
	background:#FAFAFA;
	background-size: 100%; 
	border:1px solid #e1e1e1; 
}
.menu_list dl.size2 {
	position: absolute;
	z-index: 220;
	bottom: 60px;
	left: 40px;
	width: 137px;
	margin-left: -39px;
	border-radius: 5px;
	background:#FAFAFA;
	background-size: 100%; 
	border:1px solid #e1e1e1; 
}
/*, .nav4 dl:after*/
.menu_list dl:before {
	content: "";
	display: inline-block;
	position: absolute;
	z-index: 240;
	bottom: 0;
	left: 45%;
	width: 10px;
	height: 8px;
	background:
		url(${pageContext.request.contextPath}/resource/images/weixinMenu/1.svg#2)
		no-repeat center -55px;
	-webkit-background-size: 10px auto;
	bottom: -7px;
	margin-left: -5px;
}

.menu_list dl dd:hover {
	color: white;
	border-radius: 5px;
}

.menu_list dl dd a {
	font-size: 15px;
	display: block;
	color: #4f4d4f;
	text-shadow: 0px 1px 0px #ffffff;
	white-space: pre;
	overflow: hidden;
	border-bottom:1px solid #e1e1e1;
	text-overflow: ellipsis; 
}
.menu_list dl dd a.on {
	border:1px solid #44b549;
	color:#44b549;
}

.menu_list dl dd a:hover {
	font-size: 15px;
	display: block;
	color: #4f4d4f;
	text-shadow: 0px 1px 0px #ffffff;
	white-space: pre;
	overflow: hidden;
	background: #EFEFEF;  
	text-overflow: ellipsis;
}

.menu_list dl dd {
	line-height: 45px;
	text-align: center;
	background: -webkit-gradient(linear, 0 0, 100% 0, from(rgba(194, 194, 194, 0.8)),
		to(rgba(194, 194, 194, 0.8)), color-stop(50%, rgba(194, 194, 194, 0.8)));
	background-size: 80% 1px;
	background-repeat: no-repeat; 
	background-position: center bottom;
	
}
 
.menu_list dl dd a {
	font-size: 15px;
	display: block;
	color: #4f4d4f;
	text-shadow: 0px 1px 0px #ffffff;
	white-space: pre;
	overflow: hidden;
	text-overflow: ellipsis;
}
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
.set_content{
	border:1px solid #e1e1e1;
}
.set_content.error{
	border:1px solid red; 
}
</style> 
<div class="content-wrapper">
	<div class="content">
	
		<div class="panel panel-flat">  
		  <div class="panel-body"> 
		 	
		 	<div class="alert alert-primary no-border">
				<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span></button>
				<span class="text-semibold">1、由于微信接口延迟，菜单修改后最长可能需要30分钟才会更新。如需即时查看，可先取消关注，再重新关注。</span><br>
				<span class="text-semibold">2、请确保触发关键词唯一，否则可能出现错乱。</span><br>
				<span class="text-semibold text-warning">3、添加小程序前确认公众号为认证服务号，公众号和小程序主体一致且已关联，并且小程序已经授权给蜗店才可以绑定.如需要帮助联系：0755-36953215。</span>
			</div>
		 	<div class="row" style="height:750px;"> 
		 		<!-- 左边手机模型 -->
		 		<div class="col-md-5 body_left">
		 		
			 			<!-- mobile开始 -->
						<div class="mobile">
							<div class="header">
								<h5 class="text-white text-center" style="margin-top:7px;"><c:if test="${sessionScope.publicInfo!=null }">${sessionScope.publicInfo.nick_name }</c:if><c:if test="${sessionScope.publicInfo eq null }">公众号名称</c:if></h5>
							</div>
							<!-- 底部菜单 -->
							<div class="bd">
								<div class="menu_footer">
									<ul class="menu_list">
								
									</ul>
								</div>
							</div>
							<!-- 底部菜单结束 -->
						</div>
						<!-- mobile结束 -->
		 		</div>
		 		<!-- 手机模型结束 -->
		 		
		 		<!-- 右边设置内容 -->
		 		<div class="col-md-7">
		 			<div class="panel panel-flat body_right" style="display:none;">
						<div class="panel-body" style="margin-top:-10px;"> 
							<form class="form-horizontal" method="POST" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/user/userCardSave">
								
								<div class="form-group">
									<label class="control-label col-md-3">菜单名称</label>
									<div class="col-md-9 text-right">
										<a href="javascript:;" onclick="deleteMenu()" class="delete_menu" style="color:#576b95;">删除菜单</a>
									</div>  
									
								</div>
								<hr>
								<div class="form-group">
									<label class="control-label col-md-3" style="max-width:80px;">菜单名称</label>
									<div class="col-md-8" style="max-width:230px;">
										<input type="text" name="menu_name" class="form-control" placeholder="">
										<span class="text-danger menu_name_error"></span><br>
										<span class="text-muted menu_label">字数不超过4个汉字或8个字母</span>
									</div>  
								</div>
								<span class="text-muted menu_info"></span>
								<div class="form-group menu_type" >
									<label class="control-label col-md-3" style="max-width:80px;">菜单内容</label>
									<div class="col-md-8">
                                           <input type="radio" name="type" value="1" class="son_con" checked>发送消息
                                           <input type="radio" name="type" value="2" class="son_con">跳转网页
                                           <input type="radio" name="type" value="3" class="son_con">自定义文章
                                           <input type="radio" name="type" value="4" class="son_con">跳转小程序
									</div> 
								</div>
								<div class="form-group menu_content">
									<div>   
										<div class="set_content"> 
											
											<div class="file_picture">  
												<ul class="contentType"> 
												   <li class="on" value="1"><i class="icon-floppy-disk position-left"></i>图文消息</li>
												   <li value="2"><i class="icon-typography position-left"></i>文字</li>    
												   <li value="3"><i class="icon-images2 position-left"></i>图片</li>
											    </ul>  
												<div class="create-type__list my_file_pic">
													<div class="select_picture_file_div" style="">
									                    <div class="create-type__item">
									                        <a href="javascript:;" class="create-type__link" data-toggle="modal" data-target="#picture_file_dialog">
									                            <i class="create-type__icon file"></i>
									                            <strong class="create-type__title">从素材库选择</strong>
									                        </a>
									                    </div>
									                    <div class="create-type__item">
									                        <a  href="javascript:Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list')" class="create-type__link">
									                            <i class="create-type__icon new"></i> 
									                            <strong class="create-type__title">自建图文</strong>
									                        </a>
									                    </div>
								                    </div>
								                   <div class="col-md-3 select_picture_file_div_prew" style="display:none;margin-top:10px;margin-left:10px;"> 
														<div class="thumbnail" style="width:250px;">
															<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
																<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=http://mmbiz.qpic.cn/mmbiz_png/aibFoqKgttUdibc7BJtlKoVjaLWiarnJSoEJ9F5I2wkygDHTEWHoVg29zePcOOc216ictqSSygiajw3dOSyh3sM4SJA/0?wx_fmt=png" alt="">
																		
															</div>
															 <div class="panel-heading" style="height:50px">
																										
															</div>
															<div style="float:right;margin-right:-40px;margin-top:-20px;font-size:16px;"><a  class="picture_file_del">删除</a></div>
														</div>
														
													</div>
											    </div>
											    <div class="create_type_text my_text" style="display:none;">
											    	<textarea rows="11" cols="5" class="form-control text-content" style="paddig:0px 0px;border-radius:0px;border:0px;"></textarea>
											    	<div class="text-right text-muted">
											    		<span>还可以输入600字</span>  
											    	</div> 
											    </div>
											    <div class="create-type__list my_pic" style="display:none;">
											    	<div class="select_picture_div">
									                    <div class="create-type__item">
									                        <a href="javascript:;" class="create-type__link"  data-toggle="modal" data-target="#picture_dialog">
									                            <i class="create-type__icon file"></i>
									                            <strong class="create-type__title">从素材库选择</strong>
									                        </a>
									                    </div>
									                    <div class="create-type__item"> 
									                        <a  href="javascript:Mget('${pageContext.request.contextPath}/center/weixin/weixinMediaImages/list')" class="create-type__link">
									                            <i class="create-type__icon pic"></i>
									                            <strong class="create-type__title">上传图片</strong>
									                        </a>
									                    </div>
								                    </div>
								                    <div class="col-md-3 select_picture_div_prew" style="display:none;margin-top:10px;margin-left:10px;"> 
														<div class="thumbnail" style="width:250px;">
															<div class="thumb" style="height:120px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
																<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&url=http://mmbiz.qpic.cn/mmbiz_png/aibFoqKgttUdibc7BJtlKoVjaLWiarnJSoEJ9F5I2wkygDHTEWHoVg29zePcOOc216ictqSSygiajw3dOSyh3sM4SJA/0?wx_fmt=png" alt="">
															</div>
															<div style="float:right;margin-right:-40px;margin-top:-20px;font-size:16px;"><a  class="file_del">删除</a></div>
														</div>
														
													</div>
											    </div>
											</div>
											
											<div class="web_link" style="display:none;background:white;min-height:150px;"> 
												<br>
												<div class="form-group"> 
													<label class="control-label col-md-12 text-muted">订阅者点击该子菜单会跳到以下链接</label>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3" style="max-width:80px;">页面地址</label>
													<div class="col-md-9" >
														
														<select class="bootstrap-select select_link_url" name="select_link_url" style="max-width:230px;"> 
															<option value="-1">--请选择链接页面--</option> 
															<c:forEach items="${linkList }" var="link"> 
																<option value="${link.url_pattern}">${link.url_content }</option>
															</c:forEach>   
														</select> 
														<button type="button" class="btn btn-default link_info" style="display:none;"></button>
														<br><br> 
														<div style="display:none;" class="show_link_div" style="max-width:330px;"> 
														 <input type="text" name="link_url" class="form-control link_url" placeholder="路径需要带有http://">
														 <span class="text-danger text-bold show_link_error"></span>
														 </div>
													</div> 
												</div>
												 <br><br>
											</div>
											
											<div class="my_blog" style="display:none;background:white;max-height:320px;">
												<script id="editor" type="text/plain" style="width:100%;height:240px;"></script> 
											</div>
											
											<div class="mini_app" style="display:none;background:white;height:150px;">
												<div class="form-group" style="margin-top:40px;">    
													<div class="col-md-6" style="margin-top:20px;"> 
													 <input type="text" name="mini_app_id" class="form-control mini_app_id" placeholder="输入公众号关联过的小程序的AppId">
													</div>
												</div>
												<span class="text-muted">&nbsp;&nbsp;自定义菜单可跳转已绑定的小程序，必须确定您所输入的AppId已经跟公众号关联，不然发布到公众号会失败。</span>   
												<br> 
											</div>
											 
											<span class="text-danger set_content_error"></span>
										</div> 
										
										
									</div>
								</div>
							</form> 
						</div>
					</div>
		 		</div>
		 		<!-- 右边设置内容 -->
		 		
		 	</div>
		 	<div class="row" style="height:100px;min-width:952px;max-width:1550px;">  
		 		<div class="text-center">
					<button type="button" class="btn btn-default" id="save_btn">&nbsp;&nbsp;&nbsp;保存与更新&nbsp;&nbsp;&nbsp;</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-success" id="send_to_public">&nbsp;&nbsp;&nbsp;发布到公众号&nbsp;&nbsp;&nbsp;</button>
				 </div>
		 	</div>
		 	
		 	
		  </div>
		 </div>
	</div>	
</div>


<!--选择图文-->
				<div id="picture_file_dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="min-width: 800px;max-width:1200px;">
								<div class="modal-header" style="background:white">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title" style="color:black;">选择素材</h5>
								</div>
 
								<div class="panel-body">
				
									<div class="row">
										<table class="table datatable-basic">
											<thead>
												<tr style="display:none;">
													<th>1</th>
													<th>2</th>
													<th>3</th>
												</tr>
											</thead>
											<tbody>
													<c:forEach items="${articleList}" var="ar"  varStatus="status">     
												     <c:if test="${status.count eq 1 || (status.count-1) % 3 eq 0}">    
												      <tr>    
												     </c:if>    
												       <td>
															<div class="col-md-3" style="min-width:220px;max-width:300px;height:230px;margin-top:12px;"> 
																<div class="thumbnail" style="height:230px;">
																	<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
																		<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&amp;url=${ar.cover_img }" alt="">
																		<div class="caption-overflow"> 
																			<span>
																				<a href="javascript:;" onclick="insertPictureFile('${ar.cover_img}','${ar.media_id }','${ar.title }')" class="btn bg-info btn-rounded btn-icon"><i class="icon-checkmark3 position-left"></i>选择图文</a>
																			</span>
																		</div>
																	</div>
																	<div class="panel-heading" style="height:50px">
																		${ar.title }
																	</div>
																</div>  
															</div>
														</td>    
												      <c:if test="${status.count % 3 eq 0 || status.count eq 3}">    
												      </tr>    
												      </c:if>    
												  </c:forEach> 
											</tbody>
										</table>
										
									</div>
								   
								
								</div>
							</div>
						</div>
					</div>				
<!--选择图文--> 

<!--选择图片-->
				<div id="picture_dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="min-width: 800px;max-width:1200px;">
								<div class="modal-header" style="background:white">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title" style="color:black;">选择素材</h5>
								</div>
 
								<div class="panel-body">
				
									<div class="row">
										
										
										<table class="table datatable-pagination">
										<thead>
											<tr style="display:none;"> 
												<th>1</th>
												<th>2</th>
												<th>3</th>
											</tr>
										</thead>
										<tbody>
												<c:forEach items="${pictureList}" var="pic"  varStatus="status">     
												     <c:if test="${status.count eq 1 || (status.count-1) % 3 eq 0}">    
												      <tr>    
												     </c:if>    
												       <td>
															<div class="col-md-3" style="min-width:220px;max-width:300px;height:230px;margin-top:12px;"> 
																<div class="thumbnail" style="height:230px;">
																	<div class="thumb" style="height:180px;overflow:hidden;-webkit-box-pack:center;display:flex;justify-content:center;-webkit-box-align:center;align-items:center">
																		<img src="http://img01.store.sogou.com/net/a/04/link?appid=100520029&amp;url=${pic.image_url }" alt="">
																		<div class="caption-overflow"> 
																			<span>
																				<a href="javascript:;" onclick="insertPicture('${pic.image_url}','${pic.media_id}')" class="btn bg-info btn-rounded btn-icon"><i class="icon-checkmark3 position-left"></i>选择图片</a>
																			 </span>
																		</div>
																	</div>
																	<div class="panel-heading" style="height:50px">
																		${pic.create_time }
																	</div>
																</div>
															</div>
														</td>
												      <c:if test="${status.count % 3 eq 0 || status.count eq 3}">    
												      </tr>    
												      </c:if>    
												  </c:forEach> 
												  
										</tbody>
									</table>
										
										
									</div>
								   
								
								</div>
							</div>
						</div>
					</div>				
<!--选择图片--> 
<%@include file="../common/footer.jsp" %>
<script>
var ue = UE.getEditor('editor',{  
    toolbars: [  
               [  
				"fullscreen",
				"source",
				"bold",
				"italic",
				"underline",
				"forecolor",
				"backcolor",
				"background",
				"fontfamily",
				"fontsize",
				"indent",
                 "simpleupload",
				"justifyleft",
				//"music",
				"link",
				"horizontal",
				"inserttable"
                 ]  
           ]   
       });
       
</script>
<script>
	var root_menu_list=new Array();
	$.ajax({
	     url: '${pageContext.request.contextPath}/center/weixin/menu/getMenuJson',
	     type: 'POST',
	     data:{},
	     success:function(res){
	    	 var res=eval("("+res+")");
	    	 console.log(res.data);
	    	root_menu_list=res.data;
	     } 
	 })
	 .done(function(res) {
	     // success and do something
		 freshMenu(root_menu_list);
		 initRirght();
	 })
	 .fail(function(res) {
	     // fail and do something s 
	 });
	//var cache_root_menu_list=JSON.parse(localStorage.getItem("menu"));
	//console.log(cache_root_menu_list); 
	//if(cache_root_menu_list!=null&&cache_root_menu_list.length>0){
	//	root_menu_list=cache_root_menu_list; 
	//}
	//freshMenu(root_menu_list);
	
	//获得菜单中的子菜单
	function getChildHtml(childs,parentId){
		var dd_str="";	
	 	for(var j=0;j<childs.length;j++){
	 		if(childs[j].is_select=='1'){
	 			dd_str+=
				'<dd  value="'+j+'">'+
					'<a href="#" class="on"><span>'+childs[j].name+'</span></a>'+
				'</dd>';
	 		}else{
	 			dd_str+=
				'<dd  value="'+j+'">'+
					'<a href="#"><span>'+childs[j].name+'</span></a>'+
				'</dd>';
	 		}
	 		
	 	}
	 	if(childs.length<5){
	 		dd_str+=
	 			'<dd  value="-1">'+
					'<a href="#"><span><i class="icon-plus2"></i></span></a>'+
				'</dd>';
	 	}else{
	 		console.log("二级菜单不能超过5个");
	 	}
	 	if(root_menu_list.length==1){
	 		var dl_str='<dl class="size2">'+dd_str+'</dl>';
	 	}else{
	 		var dl_str='<dl>'+dd_str+'</dl>';
	 	}
	 	
	 	return dl_str; 
	}
	//刷新菜单结构，根据数组结构进行刷新
	function freshMenu(root_menu_list){
		var sizeClass="size1"; 
		if(root_menu_list.length==0){
			sizeClass="size1";
		}else if(root_menu_list.length==1){ 
			sizeClass="size2";
		}else if(root_menu_list.length==2){
			sizeClass="size3";
		}else{
			sizeClass="size3";
		}
		var li_str=""; 
		for(var i=0;i<root_menu_list.length;i++){
			//组装二级菜单	
		 	var dl_str=getChildHtml(root_menu_list[i].childs,i);
		 	
		 	if(root_menu_list[i].is_select=="1"){
		 		//拼装一级菜单
				li_str+='<li class='+sizeClass+' value="'+i+'">'+
		 				'<a href="javascript:;" class="on"><span>'+root_menu_list[i].name+'</span></a>'+dl_str+
		 			'</li>';
		 	}else{
				//拼装一级菜单
				li_str+='<li class='+sizeClass+' value="'+i+'">'+
		 				'<a href="javascript:;" class=""><span>'+root_menu_list[i].name+'</span></a>'+dl_str+
		 			'</li>';
		 	}
		}
		
		if(root_menu_list.length<3){
			if(sizeClass=="size1"){
				li_str+='<li class='+sizeClass+' value="-1">'+
				'<a href="javascript:;" class=""><span><i class="icon-plus2"></i>添加菜单</span></a>'+
				'</li>';
			}else{
				li_str+='<li class='+sizeClass+' value="-1">'+
				'<a href="javascript:;" class=""><span><i class="icon-plus2"></i></span></a>'+
				'</li>';
			}
			
		}else{
			if(root_menu_list.length>3){ 
				console.log("一级菜单最多3个");
			}
		}
		$(".menu_list").children('li').remove(); //移除原来的数据
		$(".menu_list").append(li_str);//渲染菜单
		
		
		listnerMenuLick();
		initRirght();
		
		
	}
	function listnerMenuLick(){
		//监听一级菜单点击
		$(".menu_list").find("li").each(function(i){
			//监听一级菜单被点击事件
			$(this).children("a:first-child").click(function(){
				//把所有一级、二级菜单先不选中
				for(var k=0;k<root_menu_list.length;k++){
					root_menu_list[k].is_select=0;
					//所有子菜单先不选中
					for(var r=0;r<root_menu_list[k].childs.length;r++){
						root_menu_list[k].childs[r].is_select=0;
					}
				}
				if($(this).parent().attr("value")=="-1"){
					console.log("添加一级菜单");   
					//记住该对象一定要新创建，不能作为全局变量
					var menu={name:"菜单名称",childs:[],type:"1",body:{content_type:"1",pic_file:{url:"",media_id:"",title:""},text:{content:""},pic:{url:"",media_id:"",title:""},link:{url:"",title:"",page:""},custome_content:{content:""},mini:{content:""}},is_select:"1"};
					root_menu_list.push(menu);
					freshMenu(root_menu_list);//新增菜单后，需要重新刷新菜单;
				}else{
					console.log("选中一级菜单");
					root_menu_list[$(this).parent().attr("value")].is_select=1;//把当前一级菜单设置为选中
					freshMenu(root_menu_list);//新增菜单后，需要重新刷新菜单;
				}
				initRirght(); 
			});
			
			//监听一级菜单上面的二级菜单被点击
			$(this).find("dl").find("dd").each(function(){
				$(this).children("a:first-child").click(function(){
					for(var k=0;k<root_menu_list.length;k++){
						//所有子菜单先不选中
						for(var r=0;r<root_menu_list[k].childs.length;r++){
							root_menu_list[k].childs[r].is_select=0;
						}
					}
					if($(this).parent().attr("value")=="-1"){
						console.log("添加二级菜单"); 
						var child={name:"菜单名称",childs:[],type:"1",body:{content_type:"1",pic_file:{url:"",media_id:"",title:""},text:{content:""},pic:{url:"",media_id:"",title:""},link:{url:"",title:"",page:""},custome_content:{content:""},mini:{content:""}},is_select:"1"};
						if(root_menu_list[i].childs.length>0){
							root_menu_list[i].childs.push(child);//如果已经存在二级菜单了，追加一个二级菜单
						}else{
							root_menu_list[i].childs=[child];//如果是第一次新增二级菜单，初始化一个默认的二级菜单
						}
						freshMenu(root_menu_list);//新增子菜单后，需要重新刷新菜单;
					}else{
						console.log("选中二级菜单");
						//当点击时，将当期已选中的一级菜单下当期点击的菜单设置为选中
						for(var k=0;k<root_menu_list.length;k++){
							if(root_menu_list[k].is_select==1){
								for(var r=0;r<root_menu_list[k].childs.length;r++){
									if(r==$(this).parent().attr("value")){
										root_menu_list[k].childs[r].is_select=1;
									}
								} 
							}
						}
						freshMenu(root_menu_list);//新增子菜单后，需要重新刷新菜单;
					}
					initRirght(); //刷新右边设置内容
					
				});
			});
			
			
			
		});
	}
	$(function(){
		
		$("input[name=menu_name]").change(function(){
			if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
				if($(this).val().length<1){
					$(".menu_name_error").html("请输入菜单名称");
				}else{
					if(checkName($(this).val())>8){
						$(".menu_name_error").html("字数超过上限");
					}else{
						$(".menu_name_error").html("");
					}
					
				}
				var index=$(".delete_menu").attr("index");//菜单索引
				root_menu_list[index].name=$(this).val();
			}
			if($(".delete_menu").attr("ischild")=='1'){//二级菜单
				if($(this).val().length<1){
					$(".menu_name_error").html("请输入子菜单名称"); 
				}else{
					if(checkName($(this).val())>16){
						$(".menu_name_error").html("字数超过上限");
					}else{
						$(".menu_name_error").html("");
					}
					
				}
				var index=$(".delete_menu").attr("index").split("-");
				root_menu_list[index[0]].childs[index[1]].name=$(this).val();
				
			}
			
			freshMenu(root_menu_list);
			initRirght(); //刷新右边设置内容
		});
		
		
		//图文删除
		$(".picture_file_del").click(function(){
			console.log("删除图文");
			$(".select_picture_file_div_prew").find("img").attr("src","");//把图文清空
			$(".select_picture_file_div_prew").find(".panel-heading").html("");//把标题清空
			$(".select_picture_file_div_prew").hide();//隐藏显示区域
			$(".select_picture_file_div").show();//展示选择图文、上传图文操作
			
			if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
				var index=$(".delete_menu").attr("index");//菜单索引
				root_menu_list[index].body.pic_file.url="";
				root_menu_list[index].body.pic_file.media_id="";
				root_menu_list[index].body.pic_file.title="";
			}
			if($(".delete_menu").attr("ischild")=='1'){//二级菜单
				var index=$(".delete_menu").attr("index").split("-");
				root_menu_list[index[0]].childs[index[1]].body.pic_file.url="";
				root_menu_list[index[0]].childs[index[1]].body.pic_file.media_id="";
				root_menu_list[index[0]].childs[index[1]].body.pic_file.title="";
				
			}
		});
		
		//图片删除
		$(".file_del").click(function(){
			console.log("删除图片"); 
			$(".select_picture_div_prew").find("img").attr("src","");
			$(".select_picture_div_prew").hide();
			$(".select_picture_div").show();
			
			if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
				var index=$(".delete_menu").attr("index");//菜单索引
				root_menu_list[index].body.pic.url="";
				root_menu_list[index].body.pic.media_id="";
				root_menu_list[index].body.pic.title="";
			}
			if($(".delete_menu").attr("ischild")=='1'){//二级菜单
				var index=$(".delete_menu").attr("index").split("-");
				root_menu_list[index[0]].childs[index[1]].body.pic.url="";
				root_menu_list[index[0]].childs[index[1]].body.pic.media_id="";
				root_menu_list[index[0]].childs[index[1]].body.pic.title="";
				
			}
		});
	
		//文本设置
		$(".text-content").change(function(){
		    console.log($(this).val()); 
			//把选中的radio的值赋值给菜单对象
			if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
				var index=$(".delete_menu").attr("index");//菜单索引
				root_menu_list[index].body.content_type="2";
				root_menu_list[index].body.text.content=$(this).val();
			}
			if($(".delete_menu").attr("ischild")=='1'){//二级菜单
				var index=$(".delete_menu").attr("index").split("-");
				root_menu_list[index[0]].childs[index[1]].body.content_type="2";
				root_menu_list[index[0]].childs[index[1]].body.text.content=$(this).val();
				
			}
			freshMenu(root_menu_list);
			initRirght(); //刷新右边设置内容
		});
		 
		$(".select_link_url").change(function(){
		    console.log($(this).val());    
		     
		    if($(this).val()=="index"){//选折的是微页面,需要弹出框让其选择是哪个微页面
		    	$(".show_link_div").hide();
		    	showTableCustom("");
		    }else if($(this).val()=="productGroup"){//选择的是商品组，弹出是哪个商品组
		    	$(".show_link_div").hide();
		    	showTableTag("");    
		    }else if($(this).val()=="detail"){//选择的是商品详情，弹出是哪个商品的详情
		    	$(".show_link_div").hide(); 
		    	showTable("");
		    }else if($(this).val()=="zidingyi"){//选择的是自定义链接
		    	$(".show_link_div").show();
		    	$(".link_info").hide(); 
		    	if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
					var index=$(".delete_menu").attr("index");//菜单索引
					root_menu_list[index].type="2";
					root_menu_list[index].body.link.page="zidingyi";
					root_menu_list[index].body.link.url="";
				}
				if($(".delete_menu").attr("ischild")=='1'){//二级菜单
					var index=$(".delete_menu").attr("index").split("-");
					root_menu_list[index[0]].childs[index[1]].type="2";
					root_menu_list[index[0]].childs[index[1]].body.link.page="zidingyi";
					root_menu_list[index[0]].childs[index[1]].body.link.url="";
					
				} 
		    	$(".link_url").change(function(){
		    		var regex = /^http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- ./?%&=]*)?$/;
		    		if(!regex.test($(this).val())){//不是链接内容
		    			$(".show_link_error").html("自定义外链必须是一个完整的链接地址");
		    		}else{
		    			$(".show_link_error").html("");
		    		} 
		    		if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
						var index=$(".delete_menu").attr("index");//菜单索引
						root_menu_list[index].type="2";
						root_menu_list[index].body.link.page="zidingyi";
						root_menu_list[index].body.link.url=$(this).val();
					}
					if($(".delete_menu").attr("ischild")=='1'){//二级菜单
						var index=$(".delete_menu").attr("index").split("-");
						root_menu_list[index[0]].childs[index[1]].type="2";
						root_menu_list[index[0]].childs[index[1]].body.link.page="zidingyi";
						root_menu_list[index[0]].childs[index[1]].body.link.url=$(this).val();
						
					}
		    	});
		    	
		    }else{
		    	$(".show_link_div").hide(); 
		    	//把选中的radio的值赋值给菜单对象
				if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
					var index=$(".delete_menu").attr("index");//菜单索引
					root_menu_list[index].type="2";
					root_menu_list[index].body.link.page=$(this).val();
					root_menu_list[index].body.link.url=$(this).val();
				}
				if($(".delete_menu").attr("ischild")=='1'){//二级菜单
					var index=$(".delete_menu").attr("index").split("-");
					root_menu_list[index[0]].childs[index[1]].type="2";
					root_menu_list[index[0]].childs[index[1]].body.link.page=$(this).val(); 
					root_menu_list[index[0]].childs[index[1]].body.link.url=$(this).val();
					
				}
		    	
		    }
		    
			
			freshMenu(root_menu_list);
			initRirght(); //刷新右边设置内容
		});
		
		$("input[name=type]").each(function(){//选中菜单内容设置
			$(this).click(function(){
				if($(this).val()=="1"){//显示图文消息，文字跟图片设置隐藏
					$(".file_picture").show();
					$(".my_blog").hide();
					$(".web_link").hide();
					$(".mini_app").hide();
				}else if($(this).val()=="2"){//显示文字，图文消息，图片设置隐藏
					$(".file_picture").hide();
					$(".web_link").show();
					$(".my_blog").hide();
					$(".mini_app").hide(); 
				}else if($(this).val()=="3"){//显示文章
					$(".file_picture").hide();
					$(".web_link").hide(); 
					$(".my_blog").show();
					$(".mini_app").hide(); 
				}else{
					$(".file_picture").hide();
					$(".web_link").hide(); 
					$(".my_blog").hide(); 
					$(".mini_app").show();   
				}
				
	 			//把选中的radio的值赋值给菜单对象
	 			if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
	 				var index=$(".delete_menu").attr("index");//菜单索引
	 				root_menu_list[index].type=$(this).val()+"";
	 			}
	 			if($(".delete_menu").attr("ischild")=='1'){//二级菜单
	 				var index=$(".delete_menu").attr("index").split("-");
	 				root_menu_list[index[0]].childs[index[1]].type=$(this).val()+"";
					
	 			}  
	 			freshMenu(root_menu_list);
				initRirght(); //刷新右边设置内容     
			});
			 
			

			
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
					
				}else if($(this).val()=="2"){//表示文字
					$(".my_file_pic").hide();
					$(".my_text").show();
					$(".my_pic").hide();
				}else{//表示图片
					$(".my_file_pic").hide();
					$(".my_text").hide();
					$(".my_pic").show();
				}
				
				
				if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
					var index=$(".delete_menu").attr("index");//菜单索引
					root_menu_list[index].body.content_type=$(this).val()+"";
				}
				if($(".delete_menu").attr("ischild")=='1'){//二级菜单
					var index=$(".delete_menu").attr("index").split("-");
					root_menu_list[index[0]].childs[index[1]].body.content_type=$(this).val()+"";
					
				}		
				freshMenu(root_menu_list);
				initRirght(); //刷新右边设置内容
			});
			
		});
		
		$("input[name=mini_app_id]").change(function(){
			if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
				var index=$(".delete_menu").attr("index");//菜单索引
				root_menu_list[index].body.mini.content=$(this).val();
			}
			if($(".delete_menu").attr("ischild")=='1'){//二级菜单
				var index=$(".delete_menu").attr("index").split("-");
				root_menu_list[index[0]].childs[index[1]].body.mini.content=$(this).val();
				
			}
			
			freshMenu(root_menu_list);
			initRirght(); //刷新右边设置内容 
		});
	
	});
	function initRirght(){
		//去掉原来的错误
		$(".set_content").removeClass("error");
		$(".set_content_error").html("");
		
		console.log("initRirght()");
		var parent_index=-1;//设置需要显示的一级菜单的索引，-1表示没有选中
		var child_size=0;
		var child_index=-1;//设置需要显示的二级菜单的索引,-1表示没有选中
		for(var i=0;i<root_menu_list.length;i++){
			if(root_menu_list[i].is_select==1){//判断是否有一级菜单被选中
				if(root_menu_list[i].childs.length>0){//判断一级菜单下有
					for(var k=0;k<root_menu_list[i].childs.length;k++){//判断该一级菜单下是否有二级菜单被选中
						if(root_menu_list[i].childs[k].is_select==1){//
							child_index=k;//选中的二级菜单
						}
					}
				}
				child_size=root_menu_list[i].childs.length;//当前选中的一级菜单的子菜单数目
				parent_index=i;
			}
		}
		console.log("当前选中一级菜单索引:"+parent_index+",该菜单下有子菜单:"+child_size+"个,当前选中该一级菜单下的二级菜单索引:"+child_index);
		if(parent_index>-1){//表示选中了一级菜单
			if(child_size==0){//表示一级菜单没有子菜单,展示右边，可以设置内容
				console.log("无子菜单");
				
				$("input[name=menu_name]").val(root_menu_list[parent_index].name);
				if(checkName(root_menu_list[parent_index].name)>8){
					$(".menu_name_error").html("字数超过上限");
				}else{
					$(".menu_name_error").html("");
				}
				$(".menu_label").html("字数不超过4个汉字或8个字母");
				$(".menu_info").html(""); //把提示该子菜单下有xxx个子菜单的提示去掉
				$(".delete_menu").html("删除菜单");
				$(".delete_menu").attr("index",parent_index);//设置要删除的菜单的索
				$(".delete_menu").attr("ischild",0);//0表示一级菜单
				$("input[name=type][value="+root_menu_list[parent_index].type+"]").prop("checked",true); 
				$(".menu_type").show();//展示菜单内容设置
				$(".menu_content").show();//展示发送消息下的图文消息、文字、图片的设置 
				
				
				if(root_menu_list[parent_index].type=="1"){//如果是发送消息设置，还需要判断是图文、文字、图片三种
					$(".file_picture").show();//展示发送消息的设置
					$(".my_blog").hide();//关闭自定义文章设置
					$(".web_link").hide();//关闭跳转链接设置
					$(".mini_app").hide();//关闭小程序设置
					
					//初始化发送消息、图文、图片三种类型的选中
					$(".contentType").find("li").each(function(){
						$(this).attr("class","");
					});
					$(".contentType").find("li").each(function(){
						if($(this).attr("value")==root_menu_list[parent_index].body.content_type){ 
							$(this).attr("class","on");
						}
					});
					
					if(root_menu_list[parent_index].body.content_type=="1"){//表示图文消息
						if(root_menu_list[parent_index].body.pic_file.url!=""){//有图文
							$(".select_picture_file_div_prew").find("img").attr("src",root_menu_list[parent_index].body.pic_file.url);
							$(".select_picture_file_div_prew").find(".panel-heading").html(root_menu_list[parent_index].body.pic_file.title);
							$(".select_picture_file_div_prew").find(".picture_file_del").attr("media_id",root_menu_list[parent_index].body.pic_file.media_id);
							$(".select_picture_file_div_prew").show();
							$(".select_picture_file_div").hide();
						}else{
							$(".select_picture_file_div_prew").hide();
							$(".select_picture_file_div").show();
						}
						
						$(".my_file_pic").show();
						$(".my_text").hide(); 
						$(".my_pic").hide();  
						
						$("#picture_file_dialog").find(".close").click();//如果存在图文弹出框则关闭
						
					}else if(root_menu_list[parent_index].body.content_type=="2"){//表示文字 
						
						$(".text-content").val(root_menu_list[parent_index].body.text.content); 
						$(".my_file_pic").hide();
						$(".my_text").show();
						$(".my_pic").hide();
						
					}else if(root_menu_list[parent_index].body.content_type=="3"){//表示图片
						if(root_menu_list[parent_index].body.pic.url!=""){
							$(".select_picture_div_prew").find("img").attr("src",root_menu_list[parent_index].body.pic.url);
							$(".select_picture_div_prew").find(".file_del").attr("media_id",root_menu_list[parent_index].body.pic.media_id);
							$(".select_picture_div_prew").show();
							$(".select_picture_div").hide();
						}else{
							$(".select_picture_div_prew").hide();
							$(".select_picture_div").show();
						}
						$(".my_file_pic").hide();
						$(".my_text").hide();
						$(".my_pic").show();
						
						$("#picture_dialog").find(".close").click();//如果存在图片弹出框则关闭
						
					}
					
				}else if(root_menu_list[parent_index].type=="2"){
					$(".file_picture").hide();
					$(".my_blog").hide();
					$(".web_link").show();
					$(".mini_app").hide();
			  		 console.log(root_menu_list[parent_index].body.link.page); 
					//菜单存在链接设置过，回显
					if(root_menu_list[parent_index].body.link.page=="zidingyi"){//自定义外链
						$(".show_link_div").show();//显示外链输入框
						$(".link_info").hide(); //隐藏链接名称提示
						$(".link_url").val(root_menu_list[parent_index].body.link.url);//显示输入框中的链接
						$(".select_link_url").selectpicker('val','zidingyi');//下拉框选中自定义
					}else if(root_menu_list[parent_index].body.link.page=="index"){//微页面
						$(".show_link_div").hide();//隐藏输入框
						$(".link_info").show();//显示链接名称
						$(".link_info").html("微页面名称:"+root_menu_list[parent_index].body.link.title);//链接名称内容
						$(".select_link_url").selectpicker('val','index');//选中微页面
					}else if(root_menu_list[parent_index].body.link.page=="productGroup"){//商品组
						$(".show_link_div").hide();//隐藏输入框
						$(".link_info").show();//显示链接名称
						$(".link_info").html("商品组名称:"+root_menu_list[parent_index].body.link.title);//链接名称的内容
						$(".select_link_url").selectpicker('val','productGroup');//选中商品组
					}else if(root_menu_list[parent_index].body.link.page=="detail"){//商品详情
						$(".show_link_div").hide();//隐藏输入框
						$(".link_info").show();//显示链接名称
						$(".link_info").html("商品名称:"+root_menu_list[parent_index].body.link.title);//链接名称内容
						$(".select_link_url").selectpicker('val','detail');//下拉框选中商品详情
					}else{
						if(root_menu_list[parent_index].body.link.page==""){
							$(".select_link_url").selectpicker("val","-1");//不选中下拉框
							$(".link_info").hide();//显示链接名称
							$(".show_link_div").hide();//隐藏输入框
							$(".link_info").html("");
						}else{
							$(".select_link_url").selectpicker("val",root_menu_list[parent_index].body.link.page);
							$(".link_info").hide();//显示链接名称
							$(".show_link_div").hide();//隐藏输入框
							$(".link_info").html("");
						}
					}
				
				}else if(root_menu_list[parent_index].type=="3"){
					$(".file_picture").hide();
					$(".my_blog").show();
					$(".web_link").hide();
					$(".mini_app").hide(); 
			    	ue.setContent(root_menu_list[parent_index].body.custome_content.content);
					
				}else if(root_menu_list[parent_index].type=="4"){
					$(".file_picture").hide();
					$(".my_blog").hide();
					$(".web_link").hide();
					$(".mini_app_id").val(root_menu_list[parent_index].body.mini.content); 
					$(".mini_app").show();
				}else{
					console.log("非法操作");
				}
			}else{
				if(child_index>-1){//选中了二级菜单
					console.log("有"+child_size+"子菜单,并选中了索引为"+child_index+"的菜单");
					
					
					$("input[name=menu_name]").val(root_menu_list[parent_index].childs[child_index].name);//把当前一级菜单的值传递过去
					if(checkName(root_menu_list[parent_index].childs[child_index].name)>16){
						$(".menu_name_error").html("字数超过上限");
					}else{
						$(".menu_name_error").html(""); 
					}
					$(".menu_label").html("字数不超过8个汉字或16个字母"); 
					$(".menu_info").html(""); 
					$(".delete_menu").html("删除子菜单");
					$(".delete_menu").attr("index",parent_index+"-"+child_index);//设置要删除的菜单的索
					$(".delete_menu").attr("ischild",1);//1表示子菜单
					$("input[name=type][value="+root_menu_list[parent_index].childs[child_index].type+"]").prop("checked",true); 
				
					$(".menu_type").show();//展示菜单内容设置
					$(".menu_content").show();//展示发送消息下的图文消息、文字、图片的设置
					
					if(root_menu_list[parent_index].childs[child_index].type==1){
						$(".file_picture").show();//展示发送消息的设置
						$(".my_blog").hide();//关闭自定义文章设置
						$(".web_link").hide();//关闭跳转链接设置
						$(".mini_app").hide();//关闭小程序设置
						 
						//初始化发送消息、图文、图片三种类型的选中
						$(".contentType").find("li").each(function(){
							$(this).attr("class","");
						});
						$(".contentType").find("li").each(function(){
							if($(this).attr("value")==root_menu_list[parent_index].childs[child_index].body.content_type){
								$(this).attr("class","on");
							}
						});
						if(root_menu_list[parent_index].childs[child_index].body.content_type=="1"){//表示图文消息
							if(root_menu_list[parent_index].childs[child_index].body.pic_file.url!=""){//有图文
								$(".select_picture_file_div_prew").find("img").attr("src",root_menu_list[parent_index].childs[child_index].body.pic_file.url);
								$(".select_picture_file_div_prew").find(".panel-heading").html(root_menu_list[parent_index].childs[child_index].body.pic_file.title);
								$(".select_picture_file_div_prew").find(".picture_file_del").attr("media_id",root_menu_list[parent_index].childs[child_index].body.pic_file.media_id);
								$(".select_picture_file_div_prew").show();
								$(".select_picture_file_div").hide();
							}else{
								$(".select_picture_file_div_prew").hide();
								$(".select_picture_file_div").show();
							}
							
							$(".my_file_pic").show();
							$(".my_text").hide(); 
							$(".my_pic").hide();  
							
							$("#picture_file_dialog").find(".close").click();//如果存在图文弹出框则关闭
							
						}else if(root_menu_list[parent_index].childs[child_index].body.content_type=="2"){//表示文字 
							
							$(".text-content").val(root_menu_list[parent_index].childs[child_index].body.text.content); 
							$(".my_file_pic").hide();
							$(".my_text").show();
							$(".my_pic").hide();
							
						}else if(root_menu_list[parent_index].childs[child_index].body.content_type=="3"){//表示图片
							if(root_menu_list[parent_index].childs[child_index].body.pic.url!=""){
								$(".select_picture_div_prew").find("img").attr("src",root_menu_list[parent_index].childs[child_index].body.pic.url);
								$(".select_picture_div_prew").find(".file_del").attr("media_id",root_menu_list[parent_index].childs[child_index].body.pic.media_id);
								$(".select_picture_div_prew").show();
								$(".select_picture_div").hide();
							}else{
								$(".select_picture_div_prew").hide();
								$(".select_picture_div").show();
							}
							$(".my_file_pic").hide();
							$(".my_text").hide();
							$(".my_pic").show();
							
							$("#picture_dialog").find(".close").click();//如果存在图片弹出框则关闭
							
						}
						
					}else if(root_menu_list[parent_index].childs[child_index].type==2){
						$(".file_picture").hide();
						$(".my_blog").hide();
						$(".web_link").show();
						$(".mini_app").hide();
				  		 
						//菜单存在链接设置过，回显
						if(root_menu_list[parent_index].childs[child_index].body.link.page=="zidingyi"){//自定义外链
							$(".show_link_div").show();//显示外链输入框
							$(".link_info").hide(); //隐藏链接名称提示
							$(".link_url").val(root_menu_list[parent_index].childs[child_index].body.link.url);//显示输入框中的链接
							$(".select_link_url").selectpicker('val','zidingyi');//下拉框选中自定义
						}else if(root_menu_list[parent_index].childs[child_index].body.link.page=="index"){//微页面
							$(".show_link_div").hide();//隐藏输入框
							$(".link_info").show();//显示链接名称
							$(".link_info").html("微页面名称:"+root_menu_list[parent_index].childs[child_index].body.link.title);//链接名称内容
							$(".select_link_url").selectpicker('val','index');//选中微页面
						}else if(root_menu_list[parent_index].childs[child_index].body.link.page=="productGroup"){//商品组
							$(".show_link_div").hide();//隐藏输入框
							$(".link_info").show();//显示链接名称
							$(".link_info").html("商品组名称:"+root_menu_list[parent_index].childs[child_index].body.link.title);//链接名称的内容
							$(".select_link_url").selectpicker('val','productGroup');//选中商品组
						}else if(root_menu_list[parent_index].childs[child_index].body.link.page=="detail"){//商品详情
							$(".show_link_div").hide();//隐藏输入框
							$(".link_info").show();//显示链接名称
							$(".link_info").html("商品名称:"+root_menu_list[parent_index].childs[child_index].body.link.title);//链接名称内容
							$(".select_link_url").selectpicker('val','detail');//下拉框选中商品详情
						}else{
							if(root_menu_list[parent_index].childs[child_index].body.link.page==""){
								$(".select_link_url").selectpicker("val","-1");//不选中下拉框
								$(".link_info").hide();//显示链接名称
								$(".show_link_div").hide();//隐藏输入框
								$(".link_info").html("");
							}else{
								$(".select_link_url").selectpicker("val",root_menu_list[parent_index].childs[child_index].body.link.page);
								$(".link_info").hide();//显示链接名称
								$(".show_link_div").hide();//隐藏输入框
								$(".link_info").html("");
							}
						}
					 
					}else if(root_menu_list[parent_index].childs[child_index].type==3){
						$(".file_picture").hide();
						$(".my_blog").show();
						$(".web_link").hide();
						$(".mini_app").hide();
				    	ue.setContent(root_menu_list[parent_index].childs[child_index].body.custome_content.content);
						
					}else if(root_menu_list[parent_index].childs[child_index].type==4){
						$(".file_picture").hide();
						$(".my_blog").hide();
						$(".web_link").hide();
						$(".mini_app_id").val(root_menu_list[parent_index].childs[child_index].body.mini.content); 
						$(".mini_app").show();
					}else{
						console.log("非法操作");
					}
						
				}else{//没有选中二级菜单，提示一级菜单下面有多个子菜单了，此时可以只能修改菜单名称
					console.log("有"+child_size+"子菜单");
					
					$("input[name=menu_name]").val(root_menu_list[parent_index].name);
					$(".menu_info").html("已为“"+root_menu_list[parent_index].name+"”添加了"+child_size+"个子菜单，无法设置其他内容。"); 
					$(".menu_label").html("字数不超过4个汉字或8个字母");
					$(".delete_menu").html("删除菜单");
					$(".delete_menu").attr("index",parent_index);//设置要删除的菜单的索引
					$(".delete_menu").attr("ischild",0);//0表示一级菜单
					$(".menu_type").hide();
					$(".menu_content").hide();
				}
			}
			$(".body_right").show();
		}else{
			$(".body_right").hide(); 
		}
		
		
	}
	
	function deleteMenu(){
		MConfirm('删除菜单后，该菜单下设置的内容将被删除','温馨提示','',function(result) {
			if(result){
				if($(".delete_menu").attr("ischild")=='1'){//删除子菜单
					var parentAndChild=$(".delete_menu").attr("index").split("-");
					for(var i=0;i<root_menu_list[parentAndChild[0]].childs.length;i++){
						if(i==parentAndChild[1]){
							root_menu_list[parentAndChild[0]].childs.splice(i,1);
							freshMenu(root_menu_list);//删除了菜单，重新渲染菜单结构 
							initRirght(); //刷新右边设置内容
							break;
						}
						
					}
					
				}else{
					root_menu_list.splice($(".delete_menu").attr("index"),1);
					freshMenu(root_menu_list);//删除了菜单，重新渲染菜单结构
					initRirght(); //刷新右边设置内容
				}
			}
		});
	
		
	}
	
	function insertPictureFile(url,media_id,title){
		
		if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
			var index=$(".delete_menu").attr("index");//菜单索引
			root_menu_list[index].body.pic_file.url=url;
			root_menu_list[index].body.pic_file.media_id=media_id;
			root_menu_list[index].body.pic_file.title=title;
			root_menu_list[index].body.content_type="1";
		}
		if($(".delete_menu").attr("ischild")=='1'){//二级菜单
			var index=$(".delete_menu").attr("index").split("-");
			root_menu_list[index[0]].childs[index[1]].body.pic_file.url=url;
			root_menu_list[index[0]].childs[index[1]].body.pic_file.media_id=media_id;
			root_menu_list[index[0]].childs[index[1]].body.pic_file.title=title;
			root_menu_list[index[0]].childs[index[1]].body.content_type="1";
				
		}
		freshMenu(root_menu_list);
		initRirght(); //刷新右边设置内容 
		
	}
	function insertPicture(url,media_id){
		
		if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
			var index=$(".delete_menu").attr("index");//菜单索引
			root_menu_list[index].body.pic.url=url;
			root_menu_list[index].body.pic.media_id=media_id;
			root_menu_list[index].body.content_type="3";
		}
		if($(".delete_menu").attr("ischild")=='1'){//二级菜单
			var index=$(".delete_menu").attr("index").split("-");
			root_menu_list[index[0]].childs[index[1]].body.pic.url=url;
			root_menu_list[index[0]].childs[index[1]].body.pic.media_id=media_id;
			root_menu_list[index[0]].childs[index[1]].body.content_type="3";
				
		}
		freshMenu(root_menu_list);
		initRirght(); //刷新右边设置内容
	
	}
	
</script>
<script>

			   ue.addListener("contentChange",function(){
              	 console.log('内容改变:'+ue.getContent()); 
              	 if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
					var index=$(".delete_menu").attr("index");//菜单索引
					root_menu_list[index].type="3";
					root_menu_list[index].body.custome_content.content=ue.getContent();
				 }
				 if($(".delete_menu").attr("ischild")=='1'){//二级菜单
					var index=$(".delete_menu").attr("index").split("-");
					root_menu_list[index[0]].childs[index[1]].type="3";
					root_menu_list[index[0]].childs[index[1]].body.custome_content.content=ue.getContent();
					
				 }	
            });
			   
				
			$.extend( $.fn.dataTable.defaults, {
				        autoWidth: true, 
				        iDisplayLength:3, 
				        aaSorting: [[0, "desc"]],   
				        language: {
				            search: '',
				            lengthMenu: '',
				            sEmptyTable: "无数据",
				            sTableId:"datatable-basic7", 
				            sInfoEmpty: "",
			                sInfoFiltered: "",
			                sInfo: "总共 _TOTAL_ 条",
			                sZeroRecords: "没有匹配到查询",
				            paginate: { 'first': '第一页', 'last': '尾页', 'next': '上一页', 'previous': '下一页' } 
				        }
				    }); 
			$('.datatable-basic').DataTable(); 
			$('.datatable-pagination').DataTable({
				      pagingType: "simple",
				      iDisplayLength:3, 
				      aaSorting: [[0, "desc"]],
				      language: {
				          search: '',
				          lengthMenu: '',
				          sEmptyTable: "无数据",
				          sTableId:"datatable-basic7", 
				          sInfoEmpty: "",
			              sInfoFiltered: "", 
			              sInfo: "总共 _TOTAL_ 条",
			              sZeroRecords: "没有匹配到查询",
				          paginate: { 'first': '第一页', 'last': '尾页', 'next': '上一页', 'previous': '下一页' } 
				      }
			});
			
			$("#send_to_public").click(function(){
				FullScreenShow("正在生成你的公众号菜单"); 
			 	 
				 $.ajax({
				     url: '${pageContext.request.contextPath}/center/weixin/menu/sendMenuToWeixinPublic',
				     type: 'POST',
				     data:{menu:JSON.stringify(root_menu_list)},
				     success:function(res){
				    	console.log(res);
				    	
				     } 
				 })
				 .done(function(res) {
				     // success and do something
				      FullScreenHide();
				      res=eval("("+res+")");
				      new PNotify({title: '提示操作',text: res.message,addclass: 'bg-info'}); 
				 })
				 .fail(function(res) {
				     // fail and do something
				 });
			});
			
			$("#save_btn").click(function(){
				 //每次保存时都加入缓存
				// localStorage.setItem("menu",JSON.stringify(root_menu_list));
				 
				 var flag=true;
				 var p_index=-1;
				 var c_index=-1;
				 var message;
				 for(var i=0;i<root_menu_list.length;i++){
				 	var menu=root_menu_list[i];
				 	
				 	if(menu.childs.length>0){//判断子菜单
				 		for(var j=0;j<root_menu_list[i].childs.length;j++){
							
							var child=root_menu_list[i].childs[j];
							if(child.name.length<1){
								$(".menu_name_error").html("请输入菜单名称");
								flag=false;
								p_index=i;
								c_index=j; 
								break;
							}else if(checkName(child.name)>16){
									$(".menu_name_error").html("字数超过上限");
									flag=false;
									p_index=i;
									c_index=j; 
									break;
								
							}else{
								$(".menu_name_error").html("");
								
								if(child.type=="1"){//表示发送消息
									if(child.body.content_type=="1"){
										if(child.body.pic_file.url==""){
											message="请设置当前菜单内容";
											flag=false;
											p_index=i;
											c_index=j; 
											break;
										}
									}
									if(child.body.content_type=="2"){
										if(child.body.text.content==""){
											message="文字必须为1到600个字";
											flag=false;
											p_index=i;
											c_index=j; 
											break;
										}else{
											if(child.body.text.content.length>600){
												message="文字必须为1到600个字";
												flag=false;
												p_index=i;
												c_index=j; 
												break;
											}
										}
									}
									if(child.body.content_type=="3"){
										if(child.body.pic.url==""){
											message="请设置当前菜单内容";
											flag=false;
											p_index=i;
											c_index=j; 
											break;
										}
									}
								}else if(child.type=="2"){
									if(child.body.link.url==""){
										message="请设置跳转链接";
										flag=false;
										p_index=i;
										c_index=j; 
										break;
									}
								}else if(child.type=="3"){
									if(child.body.custome_content.content==""){
										message="文章内容不能为空";
										flag=false;
										p_index=i;
										c_index=j; 
										break;
									}else{
										if(child.body.custome_content.content.length>3000){
											message="文章内容不能超过3000个字符";
											flag=false;
											p_index=i;
											c_index=j; 
											break;
										}
									}
								}else if(child.type=="4"){
									if(child.body.mini.content==""){
										message="请设置要绑定的小程序AppId";
										flag=false;
										p_index=i;
										c_index=j; 
										break;
									}
									
								}
							}
						}
				 	}else{
				 		
				 		if(menu.name.length<1){
							$(".menu_name_error").html("请输入菜单名称");
							flag=false;
							p_index=i;
							break;
						}else if(checkName(menu.name)>8){
							$(".menu_name_error").html("字数超过上限");
							flag=false;
							p_index=i;
							break;
						
					    }else{
							$(".menu_name_error").html("");
							if(menu.type=="1"){//表示发送消息
								if(menu.body.content_type=="1"){
									if(menu.body.pic_file.url==""){
										message="请设置当前菜单内容";
										flag=false;
										p_index=i;
										break;
									}
								}
								if(menu.body.content_type=="2"){
									if(menu.body.text.content==""){
										message="文字必须为1到600个字";
										flag=false;
										p_index=i;
										break; 
									}else{
										if(menu.body.text.content.length>600){
											message="文字必须为1到600个字";
											flag=false; 
											p_index=i;
											break;
										}
									}
								}
								if(menu.body.content_type=="3"){
									if(menu.body.pic.url==""){
										message="请设置当前菜单内容";
										flag=false;
										p_index=i;
										break;
									}
								}
							}else if(menu.type=="2"){
								if(menu.body.link.url==""){
									message="请设置跳转链接";
									flag=false;
									p_index=i;
									break;
								}
							}else if(menu.type=="3"){
								if(menu.body.custome_content.content==""){
									message="文章内容不能为空";
									flag=false;
									p_index=i;
									break;
								}else{
									if(menu.body.custome_content.content.length>3000){
										message="文章内容不能超过3000个字符";
										flag=false;
										p_index=i;
										break;
									}
								}
							}else if(menu.type=="4"){
								if(child.body.mini.content==""){
									message="请设置要绑定的小程序AppId";
									flag=false;
									p_index=i;
									c_index=j; 
									break;
								}
							}
						}
				 	}
				 	
					
				 }
				 if(flag==false){
				 	console.log(p_index+"="+c_index);
				 	if(c_index>-1){
				 		for(var t=0;t<root_menu_list.length;t++){
	 						root_menu_list[t].is_select=0; //关闭所有一级菜单选中
	 						for(var k=0;k<root_menu_list[t].childs.length;k++){
	 							root_menu_list[t].childs[k].is_select=0;//关闭所有二级菜单选中
	 						}
	 						
	 					}
				 		root_menu_list[p_index].is_select=1; //选中一级菜单
				 		
				 		$(".menu_list").find("li").each(function(i,obj){
				 			
							$(this).find("dl").find("dd").each(function(j,ot){
				 				if($(this).attr("value")==c_index){
				 					
				 					root_menu_list[i].childs[c_index].is_select=1;
				 					$(ot).children("a:first-child").click();  
									$(".set_content_error").html(message); 
									$(".set_content").addClass("error");
				 				}
				 			});  
				 		}); 
				 	}else{ 
				 		if(p_index>-1){
				 			for(var t=0;t<root_menu_list.length;t++){
		 						root_menu_list[t].is_select=0; //关闭所有一级菜单选中
		 					} 
				 			root_menu_list[p_index].is_select=1; //选中一级菜单
				 			$(".menu_list").find("li").each(function(i){
								if($(this).attr("value")==p_index){
									$(this).children("a:first-child").click(); 
									$(".set_content_error").html(message); 
									$(".set_content").addClass("error"); 
								} 
							});
				 		}
				 		
				 	}
				 	
					
				}else{
					console.log("菜单信息完整");
					FullScreenShow("正在保存菜单结构，请耐心等待."); 
					console.log(root_menu_list); 
					 $.ajax({
					     url: '${pageContext.request.contextPath}/center/weixin/menu/createMenu',
					     type: 'POST',
					     data:{menu:JSON.stringify(root_menu_list)},
					     success:function(res){
					    	 var res=eval("("+res+")");
					    	 console.log(res.data);
					    	root_menu_list=res.data;
					    	 
					    	freshMenu(root_menu_list);
							initRirght(); //刷新右边设置内容
					    	
					    	
					     } 
					 })
					 .done(function(res) {
					     // success and do something
					      FullScreenHide();
					      
					      new PNotify({title: '提示操作',text: '更新成功',addclass: 'bg-info'});
					 })
					 .fail(function(res) {
					     // fail and do something
						  FullScreenHide();
					 }); 
					
				}
				
				
			});
</script> 
<script>
	function checkName(menu_name){
		menu_name=String(menu_name);
		var length=menu_name.length;
		var hanzi=(menu_name.match(/[^\x00-\xff]/g) ||"").length;
		var num=length-hanzi;
		//算整个字节数(微信端一个汉字占用3个字节，一级菜单总字节数不超过16个)
		var str=hanzi*2+num;
		return str;
	} 
</script>
<%@include file="weixinMenuLink.jsp"%> 