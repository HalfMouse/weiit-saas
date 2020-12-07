<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<style>
.yang-class {
    max-width: 1488px;
    min-width: 940px;
    height: 40px;
    overflow: hidden;
    position: relative
}

.yang-class ul {
    float: left;
    padding-left: 40px;
    max-width: 1480px;
    min-width: 960px;
    padding-right: 160px;
    margin-bottom: 10px
}

.yang-class ul li {
    float: left;
    height: 30px;
    margin-left: 26px;
    position: relative;
    z-index: 1
}

.yang-class ul li.on a {
    color: #10c55b
}

.yang-class ul li span {
    width: 100%;
    height: 40px;
    display: block;
    position: absolute;
    z-index: 10;
    top: 0;
    left: 0;
    cursor: pointer
}

.yang-check i {
    background: url(http://pic.qiantucdn.com/yang/img/icon25.png) 1px -110px
}

.yang-class ul li a {
    font-size: 14px;
    line-height: 38px
}

.yang-class ul li i {
    width: 16px;
    height: 16px;
    display: block;
    float: left;
    border: 1px solid #d3d3d3;
    margin-top: 11px;
    margin-right: 5px
}

.yang-class ul li:hover a {
    color: #10c55b
}

.yang-class ul li:hover i {
    border: 1px solid #10c55b
}

.yang-class strong {
    font-weight: 700;
    display: block;
    height: 25px;
    font-size: 14px;
    position: absolute;
    left: 10px;
    top: 9px
}

ol,ul {
    list-style: none
}
a {
    color: #666;
    text-decoration: none;
    cursor: pointer
}

</style>
        <!-- Main content -->
<div class="content-wrapper">
<!-- Content building -->
    <div class="content">
        <!-- Content area -->
        <div class="content">
            <ul class="nav  nav-tabs">
                <li><a href="${pageContext.request.contextPath}/center/articleCate/list" style="border-left:0px;border-top:0px;">微信公共图文分类</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/center/article/list">微信公共图文</a></li>
            </ul>
            <!-- Navbar navigation -->
            <div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
                <div class="panel-heading">
                    <div class="alert alert-primary no-border">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
                        <span class="text-semibold">
                            微信公共图文，指的是官方团队可以上传优质的图文，供商户使用。</span><br>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row search-option-buttons">
                        <div class="col-sm-12">
                            <ul class="list-inline no-margin-bottom">
                                <li><a href="${pageContext.request.contextPath}/center/article/add" class="btn bg-blue">新增图文</a></li>
                            </ul>
                        </div>
                    </div>
                    <br>
                    <div class="yang-class">
                        <strong>分类：</strong>
                        <ul id="industry_key" data-id="1">
                            <li class="fl ${(empty formMap.media_cate_id)?'on':''}"><a href="${pageContext.request.contextPath}/center/article/list">全部</a></li>
                            <c:forEach items="${sortList}" var="info">
                                <li class="fl ${(info.id eq formMap.media_cate_id)?'on':''}"><a href="${pageContext.request.contextPath}/center/article/list?media_cate_id=${info.id}">${info.cate_name}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="row">
                        <c:forEach items="${pageInfo.list}" var="info">
                            <div class="col-md-3" style="width:350px;height:255px;">
                                <div class="thumbnail" style="height:255px;">
                                    <div class="thumb" style="height:182px;">
                                        <img src="${imageDomain }${info.cover_img }" alt="" style="width:320px;height:180px;">
                                        <div class="caption-overflow">
                                            <span>
                                                <a href="javascript:;" class="btn bg-orange  btn-icon" data-popup="lightbox" target="_blank" onclick="detail('${info.id}')"><i class="icon-zoomin3 position-left"></i>预览</a>
                                                <a href="javascript:;" onclick="edit('${info.id}')" class="btn bg-danger btn-rounded btn-icon"><i class="icon-pen6 position-left"></i>编辑</a>
                                                <a href="javascript:;" class="btn btn-primary btn-icon" data-popup="lightbox" target="_blank" onclick="WIremove('${info.id}')"><i class="icon-trash-alt"></i>删除</a>
                                             </span>
                                        </div>
                                    </div>
                                    <div class="panel-heading" style="height:70px">
                                        图文标题:${info.title }
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <form class="form-horizontal" name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/article/list?media_cate_id=${formMap.media_cate_id}" method="post">
                        <div id="pager" class="panel-body"></div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<!-- /content building -->
</div>



<%@include file="../common/footer.jsp"%>
<script>

    $(document).ready(function() {
        $("#pager").pager({
            pagenumber: ${pageInfo.pageNum},
            pagecount: ${pageInfo.pages},
            pagesize: ${pageInfo.pageSize} ,
            pagerecordSize: ${pageInfo.total},
            buttonClickCallback: searchSubmit });

        $('#infoForm').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
    });

    //表单提交
    $("#buttonsave").click(function(){
        $("#infoForm").submit();
    });


    function detail(id){
        commonDialogModal("图文详情","${pageContext.request.contextPath}/center/article/selectArticleDateil?articleId="+id+"&t="+new Date().getTime(),900,800,'','');
    }

    function edit(id){
        window.location="${pageContext.request.contextPath}/center/article/edit?articleId="+id;
    }

    function WIremove(id){
        window.location="${pageContext.request.contextPath}/center/article/remove?articleId="+id;
    }


</script>