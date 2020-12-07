<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
<link href="${pageContext.request.contextPath}/resource/css/minified/components.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" charset="utf-8" src="/resource/js/neditor/neditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/resource/js/neditor/neditor.all.min.js"></script>

<!-- Secondary sidebar -->


<!-- Main content -->
<div class="page-header">
    <div class="page-header-content">
        <div class="page-title" style="height:70px;padding-top:20px;">
            <h4>
                <i class="icon-arrow-left52 position-left"></i>
                <span class="text-semibold"> 编辑信息通知 </span>
            </h4>
        </div>
    </div>
</div>
<!-- Content building -->
<div class="content">
    <!-- Bordered striped table -->
    <div class="panel panel-flat">

        <div class="panel-body">
            <form class="form-horizontal" action="${pageContext.request.contextPath}/center/notify/save" name="infoform" id="infoform"  method="POST" enctype="multipart/form-data" >

                <div id="wizard " class="bwizard clearfix">
                    <div class="well">
                        <div class="wizard-step-1 bwizard-activated" id=" step1 ">
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font color="red">*</font>通知类型</label>
                                <div class="col-md-3">
                                    <select name="business_type_id"  class="select" >
                                         <option value="${infoMap.id}">${infoMap.business_types}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>手机号码
                                </label>
                                <div class="col-sm-4">
                                    <textarea rows="5" cols="10"class="form-control validate[required]" name="notify_phone" id="notify_phone"
                                              data-errormessage-value-missing="手机号码不能为空" placeholder="多个手机号码以逗号隔开">${infoMap.notify_phone}</textarea>
                                </div>
                            </div>

                            <input type="hidden" value="${infoMap.id}"  name="notifyId" id="notifyId">

                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>备注
                                </label>
                                <div class="col-sm-4">
                                    <textarea rows="5" cols="10"class="form-control" name="remark" id="remark" >${infoMap.remark}</textarea>
                                </div>
                            </div>
                            <div id="wizard" class="bwizard clearfix">
                                <ul class="pager bwizard-buttons">
                                    <li class="next" id="buttonli" role="button" aria-disabled="false"><button type="button" id="save_btn"  class="btn btn-primary">保存<i class="icon-arrow-right14 position-right"></i></button></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- /bordered striped table -->
</div>
<!-- /content building -->
</div>
<!-- /main content -->

<%@include file="../common/footer.jsp"%>
<script>
    $(document).ready(function() {

        $('#infoform').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
    });

    //表单提交
    $("#save_btn").click(function(){
        $("#infoform").submit();
    });



</script>
