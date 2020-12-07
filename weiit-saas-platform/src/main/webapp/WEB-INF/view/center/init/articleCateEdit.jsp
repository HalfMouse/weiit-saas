<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>


<!-- Main content -->
<div class="content-wrapper">
    <!-- Content building -->
    <div class="content">
        <!-- Content area -->
        <div class="content">
            <ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
                <li class="active"><a class="position-left" style="border-bottom-color:transparent;">微信公共图文分类</a></li>
            </ul>
            <!-- Navbar navigation -->
            <div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
                <div class="panel-body">
                    <form class="form-horizontal" action="${pageContext.request.contextPath}/center/articleCate/save" name="infoform" id="infoform"  method="POST"  >
                        <div class="form-group">
                            <label class="col-sm-1 control-label p-t-10"> <font  color="red">*</font>图文分类名称 </label>
                            <div class="col-sm-3">
                                <input type="text" name="cate_name" id="cate_name" value="${infoMap.cate_name}" class="form-control validate[required]" data-errormessage-value-missing="图文分类名称不能为空">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label p-t-10"> <font  color="red">*</font>序号 </label>
                            <div class="col-sm-3">
                                <input type="text" name="sort_num" id="sort_num" value="${infoMap.sort_num}" class="form-control validate[required]" data-errormessage-value-missing="序号不能为空">
                            </div>
                        </div>
                        <input type="hidden" value="${infoMap.id}"  name="cate_id" id="cate_id">
                        <div class="form-group">
                            <label class="col-sm-1 control-label p-t-10"></label>
                            <div class="col-sm-8">
                                <button type="button" id="save_btn"  class="btn btn-primary">保存<i class="icon-arrow-right14 position-right"></i></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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