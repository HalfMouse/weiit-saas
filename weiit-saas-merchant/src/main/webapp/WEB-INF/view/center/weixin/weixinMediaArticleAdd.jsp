<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<meta name="referrer" content="never">
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
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
	width: 232px;
	height: 223px;
	color: white;
	border-top-right-radius: 6px;
	border-top-left-radius: 6px;
}

.con_content {
	font-size: 13px;
	width: 210px;
	line-height: 30px;
	min-height: 22px;
	/*word-break: break-all; 
				word-wrap:break-word; */
	margin-left: 6px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif;
}

.whole {
	line-height: 30px;
	font-size: 13px;
	margin-left: 5px;
	border-top: 1px solid #E4E8EB;
}

.whole .More {
	float: right;
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
			
			   <!-- 手机模型开始 -->
			   <div style="width:340px;float:left;">
			       <img src="${pageContext.request.contextPath}/resource/images/phone.png" style="width: 290px;height: 588px;">   
			       <div class="Exhibition">
						<div class="con">
							<img class="con_img" src="${imageDomain}/wstore_saas/2018-08-14/8334ffe9-14e0-4031-ac46-66907671fa28.png">
							<p class="con_content">2018世界杯，真伪球迷</p>
							<div class="whole">
								<span class="read">阅读全部</span>
								<span class="More">>&nbsp;&nbsp;</span>
							</div>
						</div>
					</div>               
			   </div>
			   <!-- 手机模型结束 -->
			   
			   <!-- 右边设置开始 -->
			   <div style="margin-left:350px;">
			   
			   	<div class="panel panel-flat">
				  <div class="panel-body">
				  
					<form class="form-horizontal" method="POST" name="infoForm" id="infoForm" action="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/saveOrEdit" enctype="multipart/form-data" >
						<fieldset class="content-group">
							<legend class="text-bold">新增图文</legend>
							<div class="form-group">
								<label class="control-label col-md-1 text-right">标题：<span class="text-danger">*</span></label>
								<div class="col-md-5">
									<input type="text" name="title" class="form-control validate[required]"  placeholder="请输入标题" value="${article.title }" >
								</div>
							</div>	
							<div class="form-group">
								<label class="control-label col-md-1 text-right">作者：<span class="text-danger">*</span></label>
								<div class="col-md-5">
									<input type="text" name="author" class="form-control validate[required]"  placeholder="请输入作者" value="${article.author }" >
								</div>
							</div>	
							<div class="form-group">
								<label class="control-label col-md-1 text-right">封面：<span class="text-danger">*</span></label>
								<div class="col-md-5">
									<input type="file" name="file_cover_img" id="file_cover_img" class="bootstrap-uploader">
									<input type="hidden" name="cover_img" value="${article.cover_img }"/>
									<br>
									<span style="color: gray">只支持本地上传,图库暂时不开放.</span>
								</div>
							</div>	
							<div class="form-group">
								<label class="control-label col-md-1 text-right">摘要：<span class="text-danger">*</span></label>
								<div class="col-md-5">
									<input type="text" name="model" class="form-control validate[required]"  placeholder="请输入摘要" value="${article.model }" >
								</div>
							</div>	
							<div class="form-group">
								<label class="control-label col-md-1 text-right">正文</label>
								<div class="col-md-10">
									<script id="editor" type="text/plain" style="width:100%;height:300px;"></script> 
								</div>
							</div>	
						<%--	<div class="form-group">
								<label class="control-label col-md-1 text-right"> </label>
								<div class="col-md-4">
									<input type="checkbox" name="is_open_comment" value="1" class="styled" <c:if test="${not empty article and article.is_open_comment=='1'}">checked</c:if>> 留言
									<br>
									<div id="commpent_div" style=" <c:if test="${empty article or article.is_open_comment=='0' }">display:none;</c:if>"> 
                                    <label class="radio-inline">
                                       <input type="radio" name="is_only_fans_comment" value="0" class="styled" <c:if test="${article eq null or article.is_only_fans_comment=='0'}">checked</c:if> > 所有人可留言
                                    </label>   
                                     <label class="radio-inline">
                                       <input type="radio" name="is_only_fans_comment" value="1" class="styled" <c:if test="${not empty article and article.is_only_fans_comment=='1'}">checked</c:if>>仅关注后可留言
                                    </label>
                                    </div>
                                </div>
							</div>	  --%>
							<div class="form-group">
								<label class="control-label col-md-1 text-right"></label>
								<div class="col-md-8">
									<input type="hidden" name="validate_id" value="${article.validate_id }"/>
									<input type="hidden" name="cover_media_id" value="${article.cover_media_id }"/>
									<input type="hidden" name="media_id" value="${article.media_id }"/>
									<input type="hidden" name="validate_id_token" value="${article.validate_id_token }"/>
									<button type="button" id="save_btn" class="btn btn-primary">&nbsp;&nbsp;保&nbsp;存&nbsp;&nbsp;</button>
								</div>
							</div>	
						</fieldset>
					</form>
					
					
				 </div>
				</div>
				
			   </div>
			   <!-- 右边设置结束 -->	
			</div>
		</div>
		<!-- /navbar navigation -->
	</div>
			
</div>

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
				"justifyleft",
				"simpleupload",
		        "insertimage",
				"link",
				"horizontal",
				"inserttable"
                 ]  
           ]  
       });
       
$(document).ready(function() {
   		
	 //UE.getEditor('editor').setContent("ddd"); 
	 ue.addListener("ready", function () {
	    	// editor准备好之后才可以使用
	    ue.setContent('${article.main_body}');
	 }); 
	   
	 <c:if test="${article!=null }">
	initPicture("","${article.cover_img}","#file_cover_img",300,150);
	</c:if>
	 
    $('.bootstrap-uploader').fileinput({
        browseLabel: '本地上传',
        browseClass: 'btn bg-grey',
        removeLabel: '取消',
        uploadLabel: '',
        browseIcon: '<i class="icon-image2"></i>',
        uploadIcon: '<i class="icon-image2"></i> ',
        removeClass: 'btn btn-danger btn-icon',
        uploadClass: 'btn bg-grey btn-icon',
        removeIcon: '<i class="icon-trash"></i> ',
        layoutTemplates: {
            caption: '<div tabindex="-1" class="form-control file-caption {class}">'+ '</div>'
        },
        msgLoading: "加载...",
        maxFileSize: 1024, // 文件限制大小KB
        msgSizeTooLarge: '文件大小不能超过1M',
        msgInvalidFileExtension: '无效的文件类型，不支持此文件格式上传.',
        allowedFileExtensions: ["jpg", "gif", "png"],
        msgProgress: "加载完成",
        msgSelected: "",
        initialCaption: "主图"
    }).on('change', function(event, data, previewId, index) {
        console.log('File uploaded params',data);
      
    }); 

	$("input[name='is_open_comment']").click(function(){
		if($(this).prop("checked")){
			$("#commpent_div").show();
		}else{
			$("#commpent_div").hide();
		}
	});
	 /*默认监听表单onbulr验证*/
		$('#infoForm').validationEngine("attach",{ 
			promptPosition: 'bottomRight', 
			addPromptClass: 'blackPopup formError-small',
			scroll: true,
			showOneMessage: true
		}); 
		
		//表单提交
		$("#save_btn").click(function(){
			
			$("#save_btn").attr("disabled", true);
			if(!$('#infoForm').validationEngine("validate")){
				$("#save_btn").removeAttr("disabled");
				return false;
			}else{
				if($("#cover_img").val()==""){
					MAlert("请上传封面");
					$("#save_btn").removeAttr("disabled"); 
					return false;
				}
				FullScreenShow("正在创建图文，请稍后！");
				$("#infoForm").submit(); 
				
			}
			
		});
});


</script>