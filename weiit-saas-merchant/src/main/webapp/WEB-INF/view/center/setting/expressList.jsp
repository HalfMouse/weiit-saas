<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@include file="../common/header.jsp" %>

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li><a href="${pageContext.request.contextPath}/center/setting/shopInfo"><i class="icon-store"></i>店铺设置</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/center/setting/protocol"><i
                            class="icon-file-text2"></i>服务协议</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/setting/payment"><i
                            class="icon-credit-card"></i>支付/交易</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/center/setting/expressList"><i
                            class="icon-truck"></i>物流配送</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/account/password"><i class="icon-key"></i>
                        修改密码</a></li>
                </ul>
            </div>
        </div>
        <!-- /sub navigation -->

    </div>
</div>
<!-- /Secondary sidebar -->

<!-- Main content -->
<div class="content-wrapper">

    <!-- Content area -->
    <div class="content">

        <div class="row">
            <div class="col-md-12">
                <!-- Tabs -->
                <ul class="nav  nav-tabs">
                    <li class="active"><a href="expressList" style="border-left:0px;border-top:0px;"><i
                            class="icon-truck position-left"></i>物流公司管理</a></li>
                    <li><a href="shippingList"><i class="icon-clipboard3 position-left"></i>运费模板设置</a></li>
                </ul>
                <!-- /tabs -->

                <!-- 表单验证开始 -->
                <div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">

                    <div class="panel-body">


                        <h6 class="content-group text-semibold">
                            <span class="text-bold">常用快递</span>
                            <small class="display-block">订单发货选择物流支持时，会弹出常用快递物流。</small>
                        </h6>

                        <div class="row" id="myExpress">
                            <c:forEach items="${myExpressList }" var="my">
                                <%--<div class="col-lg-2 col-md-6 myExpress_${my.express_id }">--%>
                                <%--<div class="panel panel-body"  style="width:200px;height:150px;">--%>
                                <%--<img src="${imageDomain }${my.express_logo}" >--%>
                                <%--<br>--%>
                                <%--<p>${my.express_name }--%>
                                <%--<button type="button" onclick="WIremove('${my.express_id}','${my.express_name }')" title="删除" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">删除</span></button>--%>
                                <%--</p>--%>
                                <%--</div>--%>
                                <%--</div>--%>


                                <div class="col-md-3 myExpress_${my.express_id }" style="width:260px;height:135px;">
                                    <div class="thumbnail" style="height:125px;">
                                        <div class="thumb" style="height:72px;">
                                            <img src="${imageDomain }${my.express_logo}">
                                            <div class="caption-overflow">
													<span>
														<a href="javascript:;"
                                                           onclick="WIremove('${my.express_id}','${my.express_name }')"
                                                           class="btn bg-danger btn-rounded btn-icon"><i
                                                                class="icon-trash-alt"></i>删除</a>
													 </span>
                                            </div>
                                        </div>
                                        <div class="panel-heading" style="height:25px">
                                                ${my.express_name}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>

                        <div class="alert alert-primary no-border">
                            <button type="button" class="close" data-dismiss="alert"><span>&times;</span><span
                                    class="sr-only">关闭</span></button>
                            <span class="text-semibold">如商家需要更多的物流支持,可以从下面进行选择，以下物流公司都是可以支持的物流.</span>
                        </div>
                        <h6 class="content-group text-semibold">
                            <span class="text-bold">更多快递</span>
                            <small class="display-block">我们已经对接了200多家物流公司的数据接口</small>
                        </h6>

                        <div class="row" id="allExpress">
                            <c:forEach items="${allExpressList }" var="ali">
                                <%--<div class="col-lg-2 col-md-6 allExpress_${ali.express_id }">--%>
                                <%--<div class="panel panel-body" style="width:200px;height:150px;">--%>
                                <%--<img src="${imageDomain }${ali.express_logo}">--%>
                                <%--<br>--%>
                                <%--<p>${ali.express_name }--%>
                                <%--<a href="javascript:expressAdd('${ali.express_id }');" title="添加"--%>
                                <%--class="btn bg-blue m-r-5 m-b-5" style="height: 22px;padding-top: 0px;">添加为常用</a>--%>
                                <%--</p>--%>
                                <%--</div>--%>
                                <%--</div>--%>
                                <div class="col-md-3 allExpress_${ali.express_id }" style="width:260px;height:135px;">
                                    <div class="thumbnail" style="height:125px;">
                                        <div class="thumb" style="height:72px;">
                                            <img src="${imageDomain }${ali.express_logo}">
                                            <div class="caption-overflow">
													<span>
														<a href="javascript:;"
                                                           onclick="expressAdd('${ali.express_id}')"
                                                           class="btn bg-info btn-rounded btn-icon"><i
                                                                class="icon-edit"></i>设为常用</a>
													 </span>
                                            </div>
                                        </div>
                                        <div class="panel-heading" style="height:25px">
                                                ${ali.express_name}
                                        </div>
                                    </div>
                                </div>


                            </c:forEach>
                        </div>


                    </div>

                </div>
            </div>
        </div>


    </div>
    <!-- /content area -->

</div>

<!-- /main content -->
<%@include file="../common/footer.jsp" %>
<script>
    $(document).ready(function () {

    });

    function WIremove(id, name) {
        MConfirm('确定要删除快递公司<label style="color: red;">' + name + '</label> 吗？删除后,发货时将不能选择该快递进行发货.', '', '', function (result) {
            if (result) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/center/setting/expressRemove',
                    type: 'POST',
                    data: {'express_id': id},
                    dataType: 'json',
                    success: function (result) {
                        //移除自己
                        $("#myExpress").find(".myExpress_" + id).remove();

                        var div = '<div class="col-md-3 allExpress_' + result.data.express_id + '" style="width:260px;height:135px;">' +
                            '<div class="thumbnail" style="height:125px;"> <div class="thumb" style="height:72px;">' +
                            '<img src="${imageDomain }' + result.data.express_logo + '">' +
                            '<div class="caption-overflow"> <span> <a href="javascript:;"' +
                            'onclick="expressAdd(' + result.data.express_id + ')"' +
                            'class="btn bg-info btn-rounded btn-icon"><i class="icon-edit"></i>设为常用</a> </span> </div> </div> <div class="panel-heading" style="height:25px">' + result.data.express_name + '</div> </div> </div>';
                        $("#allExpress").append(div);

                    },
                    error: function (xhr, textStatus) {
                        console.log('错误');
                    }
                });
            }
        });
    }

    function expressAdd(express_id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/center/setting/expressAdd',
            type: 'POST',
            data: {'express_id': express_id},
            dataType: 'json',
            success: function (result) {
                console.log(result);
                if (result.code == 0) {
                    //添加到常用快递模块去
                    var div = '<div class="col-md-3 myExpress_' + result.data.express_id + '" style="width:260px;height:135px;">' +
                        '<div class="thumbnail" style="height:125px;"> <div class="thumb" style="height:72px;">' +
                        '<img src="${imageDomain }' + result.data.express_logo + '">' +
                        '<div class="caption-overflow"> <span> <a href="javascript:;"' +
                        "onclick='WIremove(\"" + result.data.express_id + "\",\"" + result.data.express_name + "\")'" +
                        'class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt"></i>删除</a> </span> </div> </div> <div class="panel-heading" style="height:25px">' + result.data.express_name + '</div> </div> </div>';
                    $("#myExpress").append(div);
                    //移除自己
                    $("#allExpress").find(".allExpress_" + express_id).remove();
                }
            },
            error: function (xhr, textStatus) {
                console.log('错误');
            }
        });
    }
</script>
			
