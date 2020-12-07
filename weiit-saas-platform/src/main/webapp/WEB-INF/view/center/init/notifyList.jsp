<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>


<!-- Main content -->
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title" style="height:70px;padding-top:20px;">
                <h4>
                    <i class="icon-arrow-left52 position-left"></i>
                    <span class="text-semibold"> 短信通知列表 </span>
                </h4>
            </div>
        </div>
    </div>
    <!-- /page header -->

    <!-- Content area -->
    <div class="content">
        <!-- Bordered striped table -->
        <div class="panel panel-flat">

            <div class="panel-body">
                <form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
                    <div class="table-responsive">
                        <table id="data-table"
                               class="table">
                            <thead>
                            <tr>
                                <th>编号</th>
                                <th>通知类型</th>
                                <th>通知手机号</th>
                                <th>备注说明</th>
                                <th width="150">操作</th>
                            </tr>
                            </thead>
                            <c:forEach items="${pageInfo.list}" var="info">
                            <tr>
                                <td>${info.id}</td>
                                <td>${info.business_types}</td>
                                <td>${info.notify_phone}</td>
                                <td>${info.remark}</td>
                                <td>
                                    <a href="javascript:;" title="编辑" onclick="WIedit('${info.id}')" >编辑</a>
                                </td>
                            </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <div id="pager" class="panel-body"></div>
                </form>
            </div>
        </div>
        <!-- /bordered striped table -->

    </div>
    <!-- /content area -->
</div>
<!-- /main content -->

<%@include file="../common/footer.jsp"%>
<script>
    $(document).ready(function() {
        $("#pager").pager({
            pagenumber: ${pageInfo.pageNum},
            pagecount: ${pageInfo.pages},
            pagesize: ${pageInfo.pageSize} ,
            pagerecordSize: ${pageInfo.total},
            buttonClickCallback: searchSubmit });
    });

    function WIADD(){
        window.location="${pageContext.request.contextPath}/center/information/add";
    }

    function WIedit(id){
        window.location="${pageContext.request.contextPath}/center/notify/edit?id="+id;
    }


</script>

