<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
<link href="${pageContext.request.contextPath}/resource/css/minified/components.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/neditor/neditor.all.min.js"></script>

<!-- Secondary sidebar -->


<!-- Main content -->
<div class="page-header">
    <div class="page-header-content">
        <div class="page-title" style="height:70px;padding-top:20px;">
            <h4>
                <i class="icon-arrow-left52 position-left"></i>
                <span class="text-semibold"> 发布图文 </span>
            </h4>
        </div>
    </div>
</div>
<!-- Content building -->
<div class="content">
    <!-- Bordered striped table -->
    <div class="panel panel-flat">
        <div class="panel-body">
            <form class="form-horizontal" action="${pageContext.request.contextPath}/center/article/save" name="bwizard_Form" id="bwizard_Form"  method="POST" enctype="multipart/form-data" >
                <div id="wizard " class="bwizard clearfix">
                    <div class="well">
                        <div class="wizard-step-1 bwizard-activated" id=" step1 ">
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font color="red">*</font>选择分类</label>
                                <div class="col-md-2">
                                    <select name="media_cate_id"  class="select" >
                                        <c:forEach items="${sortList}" var="info" varStatus="ind">
                                            <c:choose>
                                                <c:when test="${articleInfo.media_cate_id==info.id}">
                                                    <option value="${info.id}" selected = “selected”>${info.cate_name}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${info.id}">${info.cate_name}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>作者
                                </label>
                                <div class="col-md-2">
                                    <input type="text" class="form-control validate[required]" name="author" id="author"
                                           value="${articleInfo.author}"  placeholder="作者">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>图文标题
                                </label>
                                <div class="col-md-5">
                                    <input type="text" class="form-control validate[required]" name="title" id="title"
                                           value="${articleInfo.title}"
                                           data-errormessage-value-missing="图文标题不能为空" placeholder="图文标题">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>原文链接
                                </label>
                                <div class="col-md-5">
                                    <input type="text" class="form-control validate[required]" name="original_link" id="original_link"
                                           value="${articleInfo.original_link}" placeholder="原文链接">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10">
                                    <font color="red">*</font>是否原文链接:
                                </label>
                                <div class="col-md-4">
                                    <label class="radio-inline">
                                        <input type="radio" id="state1"
                                               name="is_original_link" ${articleInfo.state ne -1?"checked":""} value="0"
                                               class="styled">
                                        是
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" id="state2" name="is_original_link"
                                               value="-1" ${articleInfo.state eq -1?"checked":""} class="styled">
                                        否
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>摘要
                                </label>
                                <div class="col-sm-4">
                                    <textarea rows="5" cols="10"class="form-control validate[required]" name="model" id="model" >${articleInfo.model}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"><span class="text-danger">*</span>选择封面</label>
                                <div class="col-md-6">
                                    <input type="file" name="file1" class="bootstrap-uploader" id="file1">
                                    <input type="hidden" name="cover_img" id="cover_img" class="hiddenClass" value="${articleInfo.cover_img }"/>
                                    <br>
                                    <span style="color: gray">只支持本地上传,图库暂时不开放.</span>
                                </div>
                            </div>
                            <div class="form-group" id="fixed_div">
                                <label class="col-sm-1 control-label p-t-10">
                                    <font color="red">*</font>有效时间</label>
                                <div class="col-md-5">
                                    <div class="col-sm-12 input-group">
                                        <input type="text" class="form-control validate[required]" name="start_time" id="start_time"  value="${articleInfo.start_time }" data-errormessage-value-missing="选择固定范围设置时必须设置开始时间">
                                        <span class="input-group-addon">--</span>
                                        <input type="text" class="form-control validate[required]" name="end_time" id="end_time" value="${articleInfo.end_time }"  data-errormessage-value-missing="选择固定范围设置时必须设置到期时间">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10"> <font
                                        color="red">*</font>正文
                                </label>
                                <div class="col-sm-8">
                                    <script id="editor" type="text/plain" style="width:100%;height:300px;"></script>
                                </div>
                            </div>
                            <input type="hidden" value="${articleInfo.id}"  name="articleId" id="articleId">
                            <div class="form-group">
                                <label class="col-sm-1 control-label p-t-10">
                                    <font color="red">*</font>状态:
                                </label>
                                <div class="col-md-4">
                                    <label class="radio-inline">
                                        <input type="radio" id="state3"
                                               name="state" ${articleInfo.state ne -1?"checked":""} value="0"
                                               class="styled">
                                        启用
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" id="state4" name="state"
                                               value="-1" ${articleInfo.state eq -1?"checked":""} class="styled">
                                        禁用
                                    </label>
                                </div>
                            </div>
                            <div id="wizard" class="bwizard clearfix">
                                <ul class="pager bwizard-buttons">
                                    <li class="next" id="buttonli" role="button" aria-disabled="false"><button type="button" id="save_btn"  class="btn btn-primary">发布图文<i class="icon-arrow-right14 position-right"></i></button></li>
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
            ue.setContent('${articleInfo.editorValue}');
        });

        $('#bwizard_Form').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });

        openSource("#file1");
        <c:if test="${!empty articleInfo.cover_img}">
        initPicture("${imageDomain }","${articleInfo.cover_img}","#file1","300","200");
        </c:if>

        //日期控件加载
        $("#start_time").datetimepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            defaultDate: "${articleInfo.start_time}"
        });
        $("#end_time").datetimepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            defaultDate: "${articleInfo.end_time}"
        });
        $("#start_time").on("dp.change",
            function (e) {
                $("#end_time").data("DateTimePicker").minDate(e.date)
            });
        $("#end_time").on("dp.change",
            function (e) {
                $("#start_time").data("DateTimePicker").maxDate(e.date)
            });

    });


    //表单提交
    $("#save_btn").click(function(){
        $("#bwizard_Form").submit();
    });

</script>