<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@include file="../../common/header.jsp" %>
<style>
    .template-image-content {
        padding: 5px;
        position: relative;
        width: 234px;
        height: 321px;
        overflow: hidden;
    }
</style>
<!-- Main content -->
<div class="content-wrapper col-xs-12" style="padding:0px;margin:0px;">
    <!-- Content area -->
    <div class="content" style="padding:0px;margin:0px;">
        <!-- Bordered striped table -->
        <div class="panel panel-flat">
            <div class="panel-body">
                <div class="tabbable">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#basic-tab0" data-toggle="tab" aria-expanded="false">全部模板</a></li>
                        <c:forEach items="${sessionScope.templatePageList}" var="template">
                            ${template}
                            <li class=""><a href="#basic-tab${template.cate_id}" data-toggle="tab"
                                            aria-expanded="true">${template.cate_name}</a></li>
                        </c:forEach>

                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" id="basic-tab0">
                            <c:forEach items="${sessionScope.pageList}" var="page">
                                <div class="col-md-3" style="width:260px;height:420px;">
                                    <div class="thumbnail">
                                        <div class="thumb template-image-content">
                                            <img src="${imageDomain}${page.template_img}">

                                            <div class="caption-overflow">
                                            <span>
                                                <a href="${pageContext.request.contextPath}/center/design/pageCreate?style=create&templateId=${page.template_id}" target="rightIframe" class="btn bg-info btn-rounded btn-icon"
                                                   data-popup="lightbox"><i class="icon-pencil5"></i>立即应用</a>
                                             </span>
                                            </div>
                                        </div>
                                        <div class="panel-heading" style="height:50px">
                                            <span class="badge bg-danger-400 media-badge">&nbsp;&nbsp;免费使用</span><br/>
                                            <span class="text-blue-300">${page.template_name} </span><br/>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <c:forEach items="${sessionScope.templatePageList}" var="template">
                            <div class="tab-pane " id="basic-tab${template.cate_id}">
                                <c:forEach items="${sessionScope.pageList}" var="page">
                                    <c:if test="${template.cate_id eq page.template_cate_id}">
                                        <div class="col-md-3  xxx"  style="width:260px;height:420px;">
                                            <div class="thumbnail">
                                                <div class="thumb template-image-content">
                                                    <img src="${imageDomain}${page.template_img}">

                                                    <div class="caption-overflow">
                                            <span>
                                                <a href="${pageContext.request.contextPath}/center/design/pageCreate?style=create&templateId=${page.template_id}" target="rightIframe" class="btn bg-info btn-rounded btn-icon"
                                                   data-popup="lightbox"><i class="icon-pencil5"></i>立即应用</a>
                                             </span>
                                                    </div>
                                                </div>
                                                <div class="panel-heading" style="height:50px">
                                                    <span class="badge bg-danger-400 media-badge">&nbsp;&nbsp;免费使用</span><br/>
                                                    <span class="text-blue-300">${page.template_name} </span><br/>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </div>
        <!-- /bordered striped table -->
    </div>
    <!-- /content area -->
</div>
<!-- /main content -->
<%@include file="../../common/footer.jsp" %>
<script>
</script>