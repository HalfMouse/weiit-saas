<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../common/header.jsp" %>
<link href="${pageContext.request.contextPath}/resource/css/jquery.pagewalkthrough.css" rel="stylesheet" type="text/css">
<%--<meta name="referrer" content="never">--%>
<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li class="active"><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"><i
                            class="icon-gear"></i>基本设置</a></li>
                    <li><a class="step_imageText" href="${pageContext.request.contextPath}/center/weixin/weixinMediaArticle/list"><i
                            class="icon-images3"></i>图文管理</a></li>
                    <li><a class="step_msg" href="${pageContext.request.contextPath}/center/weixin/batchSending/list"><i
                            class="icon-users4"></i>消息群发</a></li>
                    <li><a class="step_menu" href="${pageContext.request.contextPath}/center/weixin/menu/weixinMenu"><i
                            class="icon-mobile"></i>自定义菜单</a></li>
                </ul>
            </div>
        </div>
        <!-- /sub navigation -->

    </div>
</div>
<!-- /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">
    <!-- Content area -->
    <div class="content">
        <ul class="nav  nav-tabs">
            <li class="active"><a href="${pageContext.request.contextPath}/center/weixin/public/publicInfo"
                                  style="border-left:0px;border-top:0px;"><i class="icon-qrcode position-left"></i>公众号授权</a>
            </li>
            <li><a class="step_pay" href="${pageContext.request.contextPath}/center/setting/payment"><i
                    class="fa fa-wechat position-left"></i>微信支付</a></li>
            <li><a class="step_template" href="${pageContext.request.contextPath}/center/weixin/templateMessage/list"><i
                    class="icon-bubble-lines4 position-left"></i>模板消息</a></li>
            <li><a class="step_reply" href="${pageContext.request.contextPath}/center/weixin/weixinReply/list"><i
                    class="icon-file-text2 position-left"></i>自动回复</a></li>
        </ul>
        <!-- Navbar navigation -->
        <!-- 表单验证开始 -->
        <div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
            <div class="panel-body">
                <div class="alert alert-primary no-border">
                    <button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">关闭</span>
                    </button>
                    <span class="text-semibold">
										绑定公众号，微信公众号的管理者可以点击下面“授权”按钮进行授权，授权后公众号才可以做营销活动与推送。<br><br>
										公众号必须是</span>
                    <span class="text-warning">已经认证</span>
                    <span class="text-semibold">才可以授权成功，如公众号类型有变化，建议重新授权，重新授权原来的数据不受影响。</span>
                </div>
                <form class="form-horizontal" method="post">
                    <fieldset class="content-group">

                        <div class="form-group">
                            <label class="col-md-2 text-right">是否已授权:</label>
                            <div class="col-md-3">
                                <c:if test="${sessionScope.publicInfo!=null }"><span
                                        class="text-success text-bold">已授权</span></c:if>
                                <c:if test="${sessionScope.publicInfo==null }"><span
                                        class="text-danger text-bold">未授权</span></c:if>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right">公众号名称:</label>
                            <div class="col-md-3">
                                ${sessionScope.publicInfo.nick_name }
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right">公众号原始ID:</label>
                            <div class="col-md-3">
                                ${sessionScope.publicInfo.user_name }
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 text-right">公众号头像:</label>
                            <div class="col-md-3">
                                <c:if test="${sessionScope.publicInfo!=null and sessionScope.publicInfo.head_img!=null and sessionScope.publicInfo.head_img!='' }">
                                    <img src="${sessionScope.publicInfo.head_img }" width="140" height="140"/>
                                </c:if>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right">描述:</label>
                            <div class="col-md-3">
                                <span class="">${sessionScope.publicInfo.signature}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right"></label>
                            <div class="col-md-3 ">
                                <a href="${pageContext.request.contextPath}/center/weixin/public/go_auth"
                                   class="btn border-slate text-slate-800 btn-flat step_auth">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <c:if test="${sessionScope.publicInfo==null }">公众号授权</c:if>
                                    <c:if test="${sessionScope.publicInfo!=null }">更新授权</c:if>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right"></label>
                            <div class="col-md-3">
                                <span class="text-success text-bold">${info }</span>
                                <span class="text-danger text-bold">${error }</span>
                            </div>
                        </div>
                    </fieldset>

                </form>
            </div>
        </div>
        <!-- /form validation -->

        <!-- /content area -->
    </div>
    <div id="walkthrough-content" style="display: none">
        <div id="walkthrough-1">

            <h1><span><img src="${pageContext.request.contextPath}/resource/images/intro/robot_top.png"></span><span class="text-bold">hi,跟着小蜗一起熟悉公众号操作</span></h1>
        </div>

        <div id="walkthrough-2">
            <span >一键授权，点击之后扫一扫，公众号管理员选择要授权的公众号。</span>
        </div>

        <div id="walkthrough-3">
            <span >配置公众号支付信息，您的店铺就可以支持微信下单啦！</span>
        </div>

        <div id="walkthrough-4">
            <span >模板消息自动配置，配置完成后您的客户就可以接收不同的场景消息</span>
        </div>

        <div id="walkthrough-5">
            <span >这里可以设置关键词、收到消息、关注等回复，让公众号的粉丝们体验到关爱</span>
        </div>
        <div id="walkthrough-6">
            <span >这里是图文管理，如果平时你想你的粉丝呢，就发篇文章给他们吧</span>
        </div>
        <div id="walkthrough-7">
            <span >建好图文之后就可以选择要推送的粉丝，发送消息呢</span>
        </div>
        <div id="walkthrough-8">
            <span >这里可以管理公众号的菜单，是不是想给公众号不一样的感受，那就从这里开始吧！</span>
        </div>
    </div>
    <!-- /main content -->
    <%@include file="../common/footer.jsp" %>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resource/js/jquery.pagewalkthrough.js?v=1"></script>
    <script>
        $(document).ready(function () {
            $('#infoForm').validationEngine({
                promptPosition: 'bottomRight',
                addPromptClass: 'formError-white',
                scroll: true,
                showOneMessage: true
            });


            if (${sessionScope.page_publicInfo ==null}) {
                $('body').pagewalkthrough({
                    name: 'public',
                    steps: [
                        {
                            popup: {content: '#walkthrough-1', type: 'modal'}
                        },
                        {
                            wrapper: 'a.step_auth',
                            popup: {content: '#walkthrough-2', type: 'tooltip', position: 'bottom'}
                        },
                        {
                            wrapper: 'a.step_pay',
                            popup: {content: '#walkthrough-3', type: 'tooltip', position: 'bottom'}
                        },
                        {
                            wrapper: 'a.step_template',
                            popup: {content: '#walkthrough-4', type: 'tooltip', position: 'bottom'}
                        },
                        {
                            wrapper: 'a.step_reply',
                            popup: {content: '#walkthrough-5', type: 'tooltip', position: 'bottom'}
                        },
                        {
                            wrapper: 'a.step_imageText',
                            popup: {content: '#walkthrough-6', type: 'tooltip', position: 'right'}
                        },
                        {
                            wrapper: 'a.step_msg',
                            popup: {content: '#walkthrough-7', type: 'tooltip', position: 'right'}
                        },
                        {
                            wrapper: 'a.step_menu',
                            popup: {content: '#walkthrough-8', type: 'tooltip', position: 'right'}
                        }
                    ]

                });
                // Show the tour
                $('body').pagewalkthrough('show');
            }
        });


    </script>