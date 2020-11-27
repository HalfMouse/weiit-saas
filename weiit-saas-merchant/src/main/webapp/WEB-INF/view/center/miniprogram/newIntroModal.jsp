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
                            <div class="panel-body">
                                <div class="profile">
                                    <form class="form-horizontal" id="infoForm" action="${pageContext.request.contextPath}/center/miniprogram/introSave" method="post"  enctype="multipart/form-data">
                                        <fieldset class="content-group">
                                            <div class="form-group">
                                                <label class="control-label col-md-1">引导页名称<span class="text-danger">*</span></label>
                                                <div class="col-md-2">
                                                    <input type="text" class="form-control validate[required]" value=""  name="intro_page_desc" data-errormessage-value-missing=“引导页名称不能为空" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-1">图片上传<span class="text-danger">*</span></label>
                                                <div class="col-lg-10">
                                                    <input type="file" name="file_logo" class="bootstrap-uploader" id="file_logo">
                                                    <br>
                                                    <span style="color: gray">建议尺寸：120 * 120 像素。</span>
                                                </div>
                                            </div>
                                            <div class="text-center">
                                                &nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" id="save_btn" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
                                            </div>
                                        </fieldset>

                                    </form>
                                </div>

                            </div>
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



<!-- /main content -->
<%@include file="../common/footer.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.pagewalkthrough.js"></script>

