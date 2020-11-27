<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <!-- Secondary sidebar -->
    <div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
        <div class="sidebar-content">
            <!-- Sub navigation -->
            <div class="sidebar-category">
                <div class="category-title">
                    <span>营销服务</span>
                </div>
                <div class="category-content no-padding">
                    <ul class="navigation navigation-alt navigation-accordion">
                        <li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a></li>
                    </ul>
                </div>
            </div>
            <!-- /sub navigation -->

        </div>
    </div>
</div>
<!--  /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title" style="height:70px;padding-top:20px;">
                <h4>
                    <i class="icon-arrow-left52 position-left"></i>
                    <span class="text-semibold">积分商城 </span>
                </h4>
            </div>
        </div>
    </div>
    <!-- Content area -->
    <div class="content">

        <ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
            <li><a href="${pageContext.request.contextPath}/center/ump/integral/list"><i class="icon-home8 position-left"></i>积分商品</a></li>
            <li><a href="${pageContext.request.contextPath}/center/ump/integral/orderList"><i class="icon-vcard position-left"></i>积分订单</a></li>
            <li  class="active"><a href="${pageContext.request.contextPath}/center/ump/integral/config"><i class="icon-vcard position-left"></i>积分配置</a></li>
        </ul>
        <div class="row">
            <div class="col-md-12">
                <!-- 表单验证开始 -->
                <div class="panel panel-flat">

                    <div class="panel-body">
                        <div class="profile">
                            <form class="form-horizontal" id="infoFrom" name="infoFrom" action="${pageContext.request.contextPath}/center/ump/integral/configSave" method="post" >
                                <fieldset class="content-group">
                                    <legend class="text-bold"><h4>积分场景赠送设置</h4></legend>

                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold">完善个人信息:</label>
                                        <div class="col-md-2 text-bold"><input type="hidden" value="${queryParam.PERSONAL_ID}" name="PERSONAL_ID">
                                            <label class="radio-inline"> <input type="radio" class="styled" name="PERSONAL" ${(queryParam.PERSONAL ne 0)?"checked":""} value="-1"> 关闭</label>
                                            <label class="radio-inline"> <input type="radio" class="styled" name="PERSONAL" ${(queryParam.PERSONAL eq 0)?"checked":""} value="0"> 开启</label>
                                        </div>
                                        <div class="input-group col-md-1">
                                            <input type="text" name="PERSONAL_ITEM" class="form-control validate[required,custom[integer],min[0]]" value="${queryParam.PERSONAL_ITEM}"
                                                   data-errormessage-value-missing="积分不能为空" data-errormessage-custom-error="必须是正整数">
                                            <div class="input-group-addon">积分</div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold">购物赠送:</label>
                                        <div class="col-md-2 text-bold"><input type="hidden" value="${queryParam.GOSHOP_ID}" name="GOSHOP_ID">
                                            <label class="radio-inline"> <input type="radio" class="styled" name="GOSHOP" ${(queryParam.GOSHOP ne 0)?"checked":""} value="-1"> 关闭</label>
                                            <label class="radio-inline"> <input type="radio" class="styled" name="GOSHOP" ${(queryParam.GOSHOP eq 0)?"checked":""} value="0"> 开启</label>
                                        </div>
                                        <div class="input-group col-md-1">
                                            <input type="text" name="GOSHOP_ITEM" class="form-control validate[required,custom[integer],min[0]]" value="${queryParam.GOSHOP_ITEM}"
                                                   data-errormessage-value-missing="积分不能为空" data-errormessage-custom-error="必须是正整数">
                                            <div class="input-group-addon">积分</div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold">分享店铺:</label>
                                        <div class="col-md-2 text-bold"><input type="hidden" value="${queryParam.SHARE_ID}" name="SHARE_ID">
                                            <label class="radio-inline"> <input type="radio" class="styled" name="SHARE" ${(queryParam.SHARE ne 0)?"checked":""} value="-1"> 关闭</label>
                                            <label class="radio-inline"> <input type="radio" class="styled" name="SHARE" ${(queryParam.SHARE eq 0)?"checked":""} value="0"> 开启</label>
                                        </div>
                                        <div class="input-group col-md-1">
                                            <input type="text" name="SHARE_ITEM" class="form-control validate[required,custom[integer],min[0]]" value="${queryParam.SHARE_ITEM}"
                                                   data-errormessage-value-missing="积分不能为空" data-errormessage-custom-error="必须是正整数">
                                            <div class="input-group-addon">积分</div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold">绑定粉丝:</label>
                                        <div class="col-md-2 text-bold"><input type="hidden" value="${queryParam.BIND_ID}" name="BIND_ID">
                                            <label class="radio-inline"> <input type="radio" class="styled" name="BIND" ${(queryParam.BIND ne 0)?"checked":""} value="-1"> 关闭</label>
                                            <label class="radio-inline"> <input type="radio" class="styled" name="BIND" ${(queryParam.BIND eq 0)?"checked":""} value="0"> 开启</label>
                                        </div>
                                        <div class="input-group col-md-1">
                                            <input type="text" name="BIND_ITEM" class="form-control validate[required,custom[integer],min[0]]" value="${queryParam.BIND_ITEM}"
                                                   data-errormessage-value-missing="积分不能为空" data-errormessage-custom-error="必须是正整数">
                                            <div class="input-group-addon">积分</div>
                                        </div>
                                    </div>
                                </fieldset>
                                <div class="text-center">
                                    <button type="button" onclick="window.location.reload()" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="submit" class="btn btn-primary">更新<i class="icon-arrow-right14 position-right"></i></button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
                <!-- /form validation -->
            </div>
        </div>


    </div>
    <!-- /content area -->

</div>

<!-- /main content -->

<%@include file="../../common/footer.jsp"%>

<script>
    $(document).ready(function() {
        $('#infoFrom').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
    });
</script>