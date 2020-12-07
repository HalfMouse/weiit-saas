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
                <span class="text-semibold"> 新增服务协议 </span>
            </h4>
        </div>
    </div>
</div>
<!-- Content building -->
<div class="content">
    <!-- Bordered striped table -->
    <div class="panel panel-flat">

        <div class="panel-body">
            <form class="form-horizontal" action="${pageContext.request.contextPath}/center/agreement/insert" name="infoform" id="infoform"  method="POST" enctype="multipart/form-data" >

                <div id="wizard " class="bwizard clearfix">
                    <div class="well">
                        <div class="wizard-step-1 bwizard-activated" id=" step1 ">
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>协议标题
                                </label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control validate[required]" data-prompt-position="topRight" name="protocol_title" id="protocol_title"
                                           value="${infoMap.protocol_title}"
                                           data-errormessage-value-missing="协议标题不能为空" placeholder="协议标题">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>协议内容
                                </label>
                                <div class="col-sm-8">
                                    <script id="editor" type="text/plain" style="width:100%;height:300px;" ></script>
                                </div>
                            </div>
                            <input type="hidden" value="${infoMap.id}"  name="agreementId" id="agreementId">
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
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    $(document).ready(function() {
        //UE.getEditor('editor').setContent("ddd");
        ue.addListener("ready", function () {
            // editor准备好之后才可以使用
            ue.setContent('${infoMap.protocol_content}');
        });

        $('#infoform').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });

        //表单提交
        $("#save_btn").click(function(){$("#infoform").submit();})




    });


</script>

