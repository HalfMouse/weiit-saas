<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<%--<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=Ot8m2eR2tQI4lg1lUxtjGnwuFwFIn2US"></script>--%>
<link href="${pageContext.request.contextPath}/resource/css/jquery.pagewalkthrough.css" rel="stylesheet" type="text/css">
<style>
    .anchorBL{display:none;}
</style>
<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li class="active"><a href="${pageContext.request.contextPath}/center/miniprogram/miniPublicInfo"><i class="icon-store"></i>小程序设置</a></li>
                    <li class="step_manage"><a href="${pageContext.request.contextPath}/center/miniprogram/publishInfo"><i class="icon-store"></i>小程序管理</a></li>
                </ul>
            </div>
        </div>
        <!-- /sub navigation -->
    </div>
</div>
<!--  /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">

    <!-- Content area -->
    <div class="content">

        <div class="row">
            <div class="col-md-12">
                <!-- Tabs -->
                <ul class="nav  nav-tabs">
                    <li class="active"><a href="miniPublicInfo" style="border-left:0px;border-top:0px;"><i class="icon-home8 position-left"></i>小程序授权</a></li>
                    <li><a class="step_pay" href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-vcard position-left"></i>支付配置</a></li>
                    <li><a class="step_template" href="${pageContext.request.contextPath}/center/weixin/templateMessage/miniMessageList"><i class="icon-vcard position-left"></i>模板消息</a></li>
                    <li><a class="" href="${pageContext.request.contextPath}/center/miniprogram/introPage"><i class="icon-vcard position-left"></i>引导页</a></li>
                </ul>
                <!-- /tabs -->

                <!-- 表单验证开始 -->
                <div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">

                    <div class="panel-body">

                        <div class="alert alert-primary no-border">
                            <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
                            <span class="text-semibold"> 将您的小程序授权给平台，系统会自动帮您生成对应的小程序，无需任何复杂操作，直接拥有属于您自己的微信小程序。</span><br>
                            <br>注意：已授权后<span class="text-danger">更新授权</span>
                            <span class="text-semibold">仅限更改原小程序权限，不能重新授权新的小程序，否则会导致之前的小程序也不能正常使用！！！。</span>
                        </div>
						
                        <form class="form-horizontal" method="post" >
                            <fieldset class="content-group">

                                <div class="form-group">
                                    <label class="col-md-2 text-right">是否已授权:</label>
                                    <div class="col-md-3">
                                        <c:if test="${sessionScope.miniPublicInfo!=null }"><span class="text-success text-bold">已授权</span></c:if>
                                        <c:if test="${sessionScope.miniPublicInfo==null }"><span class="text-danger text-bold">未授权</span></c:if>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 text-right">小程序名称:</label>
                                    <div class="col-md-3">
                                        <span class="">${sessionScope.miniPublicInfo.nick_name}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 text-right">小程序原始ID:</label>
                                    <div class="col-md-3">
                                        <span class="">${sessionScope.miniPublicInfo.user_name}</span>
                                    </div> 
                                </div>
                                <div class="form-group">
									<label class="col-md-2 text-right">小程序头像:</label>
									<div class="col-md-3">
										<c:if test="${sessionScope.miniPublicInfo!=null and sessionScope.miniPublicInfo.head_img!=null and sessionScope.miniPublicInfo.head_img!=''}">
											<img src="${sessionScope.miniPublicInfo.head_img }" width="140" height="140"/>
										</c:if>
									</div> 
								</div>
                                <div class="form-group">
                                    <label class="col-md-2 text-right">描述:</label>
                                    <div class="col-md-3">
                                        <span class="">${sessionScope.miniPublicInfo.signature}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 text-right"></label>
                                    <div class="col-md-3 ">
                                        <a href="${pageContext.request.contextPath}/center/miniprogram/go_auth" class="btn border-slate text-slate-800 btn-flat step_auth" >
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <c:if test="${sessionScope.miniPublicInfo==null }"><span class="text-success text-bold">一键授权</span></c:if>
                                            <c:if test="${sessionScope.miniPublicInfo!=null }"><span class="text-danger text-bold">更新授权</span></c:if>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 text-right"></label>
                                    <div class="col-md-3">
                                        <span class="text-success text-bold">${info}</span>
                                        <span class="text-danger text-bold">${error}</span>
                                    </div>
                                </div>
                            </fieldset>

                        </form>

                    </div>
                </div>
                <!-- /form validation -->
            </div>
        </div>


    </div>
    <!-- /content area -->

</div>

<div id="walkthrough-content" style="display: none">
    <div id="walkthrough-1"><span><h1><img src="${pageContext.request.contextPath}/resource/images/intro/robot_top.png"></span>
        <span >hello 又见面呢 ，跟着小蜗学习小程序吧</span></h1>
    </div>
    <div id="walkthrough-2">
        <span >一键授权，点击之后扫一扫，小程序管理员选择要授权的小程序。</span>
    </div>

    <div id="walkthrough-3">
        <span >授权成功之后，可以立即体验小程序</span>
    </div>

    <div id="walkthrough-4">
        <span >配置开启小程序支付信息，您的店铺就可以支持微信下单啦！</span>
    </div>

    <div id="walkthrough-5">
        <span >模板消息自动配置，配置完成后用户就可以接受不同的场景消息,更多精彩体验等着你哦！</span>
    </div>
</div>

<!-- /main content -->
<%@include file="../common/footer.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.pagewalkthrough.js"></script>
<script>
    $(function() {
        // Set up tour
        if(${sessionScope.page_miniPublicInfo ==null}){
            $('body').pagewalkthrough({
                name: 'miniIntro',
                steps: [
                    { popup: {content: '#walkthrough-1',type: 'modal'}
                    },
                    {wrapper: 'a.step_auth',popup: {content: '#walkthrough-2',type: 'tooltip',position: 'bottom'}
                    },
                    {wrapper: 'li.step_manage',popup: {content: '#walkthrough-3',type: 'tooltip',position: 'right'}
                    },
                    {wrapper: 'a.step_pay',popup: {content: '#walkthrough-4',type: 'tooltip',position: 'bottom'}
                    },
                    {wrapper: 'a.step_template',popup: {content: '#walkthrough-5',type: 'tooltip',position: 'right'}
                    }
                ]
            });
            // Show the tour
            $('body').pagewalkthrough('show');
        }
    });
</script>

