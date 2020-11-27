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
<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-title">
                <span>店铺装修</span>
            </div>
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li class="active"><a href="${pageContext.request.contextPath}/center/design/page/pageList"><i
                            class="icon-html5"></i>微页面</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i
                            class="icon-color-sampler"></i>全店风格</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i
                            class="icon-cube4"></i>底部菜单</a></li>
                    <li ><a href="${pageContext.request.contextPath}/center/design/page/navEdit"><i
                            class="icon-cube3"></i>底部导航</a></li>
                </ul>
            </div>
        </div>
        <!-- /sub navigation -->
    </div>
</div>
<!-- /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title" style="height:70px;padding-top:20px;">
                <h4>
                    <i class="icon-arrow-left52 position-left"></i> <span
                        class="text-semibold">微页面 </span>
                </h4>
            </div>
        </div>
    </div>
    <!-- /page header -->

    <!-- Content area -->
    <div class="content">

        <div class="row">
        <div class="col-md-12">
            <div class="panel panel-flat">
                <div class="panel-heading">
                    <div class="panel-title">
                        <a onclick="WIModal()"
                           class="btn bg-blue btn-rounded  btn-xs">新增微页面</a>
                    </div>
                    <li class="media date-step content-divider">
                        <span>已有微页面</span>
                    </li>
                </div>
                <form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
                    <div class="panel-body">
                        <c:forEach items="${pageInfo.list}" var="info">
                            <div class="col-md-3" style="width:260px;height:420px;">
                                <div class="thumbnail">
                                    <div class="thumb template-image-content">
                                        <img src="${imageDomain}${info.page_cover}">
                                        <c:if test="${info.is_default eq 1}"> <span class="badge bg-danger-400 media-badge">  &nbsp;&nbsp;店铺主页</span></c:if>
                                        <c:if test="${info.is_default eq 2}"> <span class="badge bg-danger-400 media-badge">  &nbsp;&nbsp;特惠页</span></c:if>
                                        <div class="caption-overflow">
                                            <span>
                                                <a href="${pageContext.request.contextPath}/center/design/pageCreate?style=edit&templateId=${info.validate_id}" class="btn bg-info btn-rounded btn-icon" data-popup="lightbox"><i class="icon-pencil5"></i>编辑</a>
                                                <c:if test="${info.is_default eq 0}">
                                                    <a href="javascript:;"  class="btn bg-blue-600 btn-rounded btn-icon" onclick="WIsetdefault('${info.validate_id}','${info.validate_id_token}')"> <i class="icon-link"></i>设为主页</a>
                                                    <a href="javascript:;" class="btn bg-danger btn-rounded btn-icon" onclick="WIremove('${info.page_name}','${info.validate_id}','${info.validate_id_token}')"><i class="icon-trash-alt"></i>删除</a>
                                                </c:if>
                                             </span>
                                        </div>
                                    </div>
                                    <div class="panel-heading" style="height:75px">
                                        <span class="text-grey-400">${info.page_name}</span><br/>
                                        <span class="text-blue-300">访问次数 ${info.page_view}</span><br/>
                                        <span class="text-purple-600"><fmt:formatDate value="${info.update_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
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


    </div>
    <!-- /content area -->

</div>

<!-- /main content -->
<%@include file="../../common/footer.jsp" %>
<script>
    $(document).ready(function () {
        $("#pager").pager({
            pagenumber: ${pageInfo.pageNum},
            pagecount: ${pageInfo.pages},
            pagesize: ${pageInfo.pageSize},
            pagerecordSize: ${pageInfo.total},
            buttonClickCallback: searchSubmit
        });
    });

    function WIremove(name, validate_id, validate_id_token) {
        MConfirm('确定要删除微页面 <label style="color: red;">' + name + '</label> 吗？', '', '', function (result) {
            if (result) {
                window.location = "${pageContext.request.contextPath}/center/design/page/pageRemove?validate_id=" + validate_id + "&validate_id_token=" + validate_id_token;
            }
        });
    }

    function WIsetdefault(validate_id, validate_id_token) {
                window.location = "${pageContext.request.contextPath}/center/design/page/pageDefault?validate_id=" + validate_id + "&validate_id_token=" + validate_id_token;
    }

   function WIModal() {
        commonDialogModal("选择页面模板","${pageContext.request.contextPath}/center/design/page/newPageModal",1120,680);
    }



</script>
			
