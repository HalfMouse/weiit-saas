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
                    <li><a href="miniPublicInfo" style="border-left:0px;border-top:0px;"><i class="icon-home8 position-left"></i>小程序授权</a></li>
                    <li><a class="step_pay" href="${pageContext.request.contextPath}/center/setting/payment"><i class="icon-vcard position-left"></i>支付配置</a></li>
                    <li><a class="step_template" href="${pageContext.request.contextPath}/center/weixin/templateMessage/miniMessageList"><i class="icon-vcard position-left"></i>模板消息</a></li>
                    <li><a class="active" href="${pageContext.request.contextPath}/center/miniprogram/introPage"><i class="icon-vcard position-left"></i>引导页</a></li>
                </ul>
                <!-- /tabs -->

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-flat">
                            <div class="panel-heading">
                                <div class="panel-title">
                                    <a href="${pageContext.request.contextPath}/center/miniprogram/newIntroModal"
                                       class="btn bg-blue btn-rounded  btn-xs">新增引导页</a>
                                </div>
                                <li class="media date-step content-divider">
                                    <span>已有引导页</span>
                                </li>
                            </div>
                            <form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
                                <div class="panel-body">
                                    <c:forEach items="${pageInfo.list}" var="info">
                                        <div class="col-md-3" style="width:260px;height:420px;">
                                            <div class="thumbnail">
                                                <div class="thumb template-image-content">
                                                    <img src="${imageDomain}${info.intro_page_url}">
                                                    <c:if test="${info.is_use eq 1}"> <span class="badge bg-danger-400 media-badge">  &nbsp;&nbsp;引导页</span></c:if>
                                                    <div class="caption-overflow">
                                            <span>
                                            <c:if test="${info.is_use eq 0}">
                                                    <a href="javascript:;"  class="btn bg-blue-600 btn-rounded btn-icon" onclick="WIsetdefault('${info.validate_id}','${info.validate_id_token}')"> <i class="icon-link"></i>设为引导页</a>
                                                    <a href="javascript:;" class="btn bg-danger btn-rounded btn-icon" onclick="WIremove('${info.page_name}','${info.validate_id}','${info.validate_id_token}')"><i class="icon-trash-alt"></i>删除</a>
                                            </c:if>
                                             </span>
                                                    </div>
                                                </div>
                                                <div class="panel-heading" style="height:75px">
                                                    <span class="text-grey-400">${info.intro_page_desc}</span><br/>
                                                    <span class="text-purple-600"><fmt:formatDate value="${info.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div id="pager" class="panel-body">

                                </div>
                            </form>
                        </div>
                        <!-- /form validation -->
                    </div>
                </div>
                <!-- /form validation -->
            </div>
        </div>


    </div>


    <!-- /content area -->

</div>

<div id="walkthrough-content" style="display: none">
    <div id="walkthrough-1"><span><h1><img src="${pageContext.request.contextPath}/resource/images/intro/robot_top.png"></h1></span>
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

    function WIremove(name, validate_id, validate_id_token) {
        MConfirm('确定要删除引导页面吗？', '', '', function (result) {
            if (result) {
                window.location = "${pageContext.request.contextPath}/center/miniprogram/introRemove?validate_id=" + validate_id + "&validate_id_token=" + validate_id_token;
            }
        });
    }

    function WIsetdefault(validate_id, validate_id_token) {
        window.location = "${pageContext.request.contextPath}/center/miniprogram/introDefault?validate_id=" + validate_id + "&validate_id_token=" + validate_id_token;
    }

    function WIModal() {
        commonDialogModal("新增引导页","${pageContext.request.contextPath}/center/miniprogram/newIntroModal",1120,680,'1','1','/center/miniprogram/introPage');
    }
</script>

