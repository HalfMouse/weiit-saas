<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@include file="../../common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
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
                    <li><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a>
                    </li>
                    <%--<li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i
                            class="icon-diamond"></i>场景营销</a></li>--%>
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
                    <i class="icon-arrow-left52 position-left"></i>
                    <span class="text-semibold"> 拼团活动 </span>
                </h4>
            </div>
        </div>
    </div>
    <!-- Content area -->
    <div class="content">

        <form class="form-horizontal " id="infoForm" name="infoForm"
              action="${pageContext.request.contextPath}/center/ump/groupon/save" method="post">
            <input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
            <input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
            <div class="row">
                <div class="col-md-12">
                    <!-- 表单验证开始 -->
                    <div class="panel panel-flat">

                        <div class="panel-body">

                            <div class="info">
                                <fieldset class="content-group">
                                    <legend class="text-bold">
                                        <h5>拼团活动信息</h5>
                                    </legend>

                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>活动商品:</label>
                                        <div class="col-md-2">
                                            <div class="dropzone2" id="single_product_div" style="min-height:150px;">
                                                <div class="dz-preview2" style="width:100%;min-height:140px;margin:0">
                                                    <div class="dz-details" style="width:100%;min-height:110px;">
                                                        <img src="${imageDomain }${infoMap.product_img}"
                                                             style="width:100%;min-height:108px;"/>
                                                    </div>
                                                    <c:if test="${empty infoMap.validate_id}">
                                                        <a onclick="showTable('')"
                                                           class="dz-remove btn btn-warning btn-xs"
                                                           data-toggle="modal" data-target="#select_modal"><i
                                                                class="fa fa-plus"></i>+挑选商品</a>
                                                    </c:if>
                                                </div>
                                                <input type="hidden" name="product_id" value="${infoMap.product_id }"/>
                                                <div class='validation-error-label' id="product_id_error"
                                                     style="display:none;">请选择商品
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>活动名称:</label>
                                        <div class="col-lg-3">
                                            <div class="input-group">
                                                <input type="text" class="form-control validate[required,maxSize[12]]"
                                                       name="groupon_name" id="groupon_name"
                                                       value="${infoMap.groupon_name}"
                                                       data-errormessage-value-missing="请输入活动名称" placeholder="最多支持12个字"
                                                       data-errormessage-range-overflow="最多支持12个字">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="fixed_div">
                                        <label class="col-md-2 control-label text-bold text-right"><font color="red">
                                            * </font>活动生效时间</label>
                                        <div class="col-md-5">
                                            <div class="col-sm-6 input-group">
                                                <input type="text" class="form-control validate[required]"
                                                       name="start_time" id="start_time" value="${infoMap.start_time }"
                                                       <c:if test="${!empty infoMap.start_time }">readonly</c:if>
                                                       data-errormessage-value-missing="选择固定范围设置时必须设置开始时间">
                                                <span class="input-group-addon">--</span>
                                                <input type="text" class="form-control validate[required]"
                                                       name="end_time" id="end_time" value="${infoMap.end_time }"
                                                       data-errormessage-value-missing="选择固定范围设置时必须设置到期时间">


                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font
                                                color="red"> * </font>拼团有效期:</label>
                                        <div class="col-md-2">
                                            <div class="col-sm-9 input-group">
                                                <input type="text"
                                                       class="form-control validate[required,custom[number],min[1],max[24]]"
                                                       name="expire_time"
                                                       value="${infoMap.expire_time}"
                                                       data-errormessage-value-missing="请输入拼团有效期"
                                                       data-errormessage-range-overflow="有效期1-24小时"
                                                       data-errormessage-custom-error="必须是数字类型"/>
                                                <span class="input-group-addon">小时</span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group" id="dateDiv" style="display: none;">
                                        <label class="col-md-1 control-label text-right"> </label>
                                        <div class="col-md-5">
                                            <font color="red" id="dateMsg"></font>
                                        </div>
                                    </div>
                                    <div class="form-group" id="salePrice"
                                        <c:if test="${!empty itemList}">style="display: none"</c:if>>
                                        <label class="control-label col-md-2 text-bold text-right"><font
                                                color="red"> * </font>销售价格:</label>
                                        <div class="col-md-2">
                                            <div class="col-sm-9 input-group" >
                                                <c:if test="${empty itemList}">
                                                    <input type="text"
                                                           class="form-control"
                                                           name="sale_price" id="sale_price"
                                                           value="${infoMap.sale_price}" readonly>
                                                    <span class="input-group-addon">元</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="pintuanjia"
                                        <c:if test="${!empty itemList}">style="display: none"</c:if>>
                                        <label class="control-label col-md-2 text-bold text-right"><font
                                                color="red"> * </font>拼团价格:</label>
                                        <div class="col-md-2">
                                            <div class="col-sm-9 input-group" id="grouponPrice">
                                                <c:if test="${empty itemList}">
                                                    <input type="text"
                                                           class="form-control validate[required,custom[number],min[0.01],max[${infoMap.sale_price}]]"
                                                           name="groupon_price" id="groupon_price"
                                                           value="${infoMap.groupon_price}"
                                                           data-errormessage-value-missing="请输入拼团价格"
                                                           data-errormessage-range-overflow="拼团价不能高于销售价${infoMap.sale_price}"
                                                           data-errormessage-custom-error="必须是金额类型"/>
                                                    <span class="input-group-addon">元</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>参团人数:</label>
                                        <div class="col-md-2">
                                            <div class="col-sm-9 input-group">
                                                <input type="text"
                                                       class="form-control validate[required,custom[integer],min[2],max[10]]"
                                                       name="groupon_number" id="groupon_number"
                                                       placeholder="建议开团人数2-7人 提高成团率"
                                                       value="${infoMap.groupon_number}"
                                                       data-errormessage-value-missing="请输入参团人数"
                                                       data-errormessage-range-underflow="建议开团人数2-10人"
                                                       data-errormessage-range-overflow="建议开团人数2-10人"
                                                       data-errormessage-custom-error="必须是整数类型"/>
                                                <span class="input-group-addon">人</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label text-bold text-right">
                                            <font color="red"> * </font>虚拟成团
                                        </label>
                                        <div class="col-md-4">
                                            <label class="radio-inline">
                                                <input type="radio" name="virtual_groupon" value="0" class="styled"
                                                       <c:if test="${infoMap.virtual_groupon eq 0 or empty infoMap.virtual_groupon }">checked="checked"</c:if> >
                                                关闭
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="virtual_groupon" value="1" class="styled"
                                                       <c:if test="${infoMap.max_limit !=null and infoMap.virtual_groupon>0 }">checked="checked"</c:if>>
                                                开启
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-2 control-label text-bold text-right">
                                            <font color="red"> * </font>每人限购
                                        </label>
                                        <div class="col-md-4">
                                            <label class="radio-inline">
                                                <input type="radio" name="maxLimitType" value="1" class="styled"
                                                       <c:if test="${infoMap.max_limit eq 0 or empty infoMap.max_limit }">checked="checked"</c:if> >
                                                不限
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="maxLimitType" value="2" class="styled"
                                                       <c:if test="${infoMap.max_limit !=null and infoMap.max_limit>0 }">checked="checked"</c:if>>
                                                限制
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group <c:if test="${infoMap.max_limit eq 0 or empty infoMap.max_limit}">hide</c:if>"
                                         id="maxLimit_div">

                                        <label class="col-md-2 control-label"></label>
                                        <div class="col-md-4">
                                            <div class="col-sm-6 input-group">
                                                <input type="text"
                                                       class="form-control validate[required,custom[integer]]"
                                                       name="max_limit" id="max_limit" value="${infoMap.max_limit }"
                                                       data-errormessage-value-missing="选择限购时限购数必须设置"
                                                       data-errormessage-custom-error="必须是整数"/>
                                                <span class="input-group-addon">个/件</span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group" id="youhui"
                                         <c:if test="${empty itemList}">style="display: none"</c:if>>
                                        <label class="col-md-2 control-label text-bold text-right">
                                            <font color="red"> * </font> 优惠配置
                                        </label>
                                        <div class="col-md-4">
                                            <table id="testTable" class="table table-striped table-bordered ">
                                                <tbody>
                                                <c:if test="${!empty itemList}">
                                                <tr class="tr_0">
                                                    <c:forEach items="${specList}" var="item" varStatus="index">
                                                        <td class="cl1">${item.key_name}</td>
                                                    </c:forEach>
                                                    <td class="cl1">销售价</td>
                                                    <td class="cl1">拼团价</td>
                                                </tr>

                                                <c:forEach items="${itemList}" var="item" varStatus="status">
                                                <tr>
                                                    <c:forEach items="${item.specDesc}" var="spec"
                                                               varStatus="ind">
                                                        <td class="cl1">${spec.key_name}</td>
                                                    </c:forEach>
                                                    <td><input name="salePrice${status.index}"
                                                               style="border:0px;background-color:transparent;"
                                                               value="${item.sale_price}"></td>
                                                    <td class="cl1"><input type="hidden"
                                                                           name="itemId${status.index}"
                                                                           value="${item.item_id}:${item.spec_custom}"><input
                                                            type="number"
                                                            class="form-control input-sm validate[required,custom[number],min[0.01],max[${item.sale_price}]]"
                                                            name="grouponPrice${status.index}"
                                                            value="${item.groupon_price}" style="width:80px"
                                                            data-errormessage-value-missing="拼团价不能为空"
                                                            data-errormessage-range-underflow="拼团价不低于0.01元"
                                                            data-errormessage-custom-error="必须是金额类型"
                                                            data-errormessage-range-overflow="拼团价不能高于销售价"></td>
                                                </tr>
                                                </c:forEach>

                                                <input type="hidden" name="itemCount"
                                                       value="${fn:length(itemList)}">
                                                </c:if>
                                            </table>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>

                            <div class="text-right">
                                <button type="button" id="buttonsave" onclick="saveButton(this,'数据保存中，请稍后。。。')"
                                        class="btn btn-primary">
                                    创建拼团活动<i class="icon-arrow-right14 position-right"></i></button>
                                <button type="button" class="btn btn-default" onclick="javascript:history.back(-1)">返回
                                    <i class="icon-reload-alt position-right"></i></button>
                            </div>
                        </div>
                    </div>
                    <!-- /form validation -->
                </div>
            </div>
        </form>


        <!-- select product modal -->
        <div id="select_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h5 class="modal-title">选择商品</h5>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">商品标题</span>
                                <input type="text" class="form-control" name="product_name" value=""
                                       placeholder="支持模糊匹配">
                            </div>
                        </div>

                        &nbsp;&nbsp;
                        <button class="btn bg-blue" type="button" id="product_search">搜索</button>
                        <table id="data-table" class="table product_sort_table table-hover">
                            <thead>
                            <tr>
                                <th class="col-lg-4">商品</th>
                                <th class="col-lg-2">价格</th>
                                <th class="col-lg-2">库存</th>
                                <th class="col-lg-2">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                </div>
            </div>
        </div>
        <!-- /select product modal -->

    </div>
    <!-- /content area -->

</div>

<!-- /main content -->

<%@include file="../../common/footer.jsp" %>
<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
<script>
    var rowNum = 2;
    $(document).ready(function () {

        $('#config-demo').daterangepicker({
            "timePicker": true,
            "timePicker24Hour": true,
            "linkedCalendars": false,
            "autoUpdateInput": false,
            "locale": {
                format: 'YYYY-MM-DD',
                separator: ' ~ ',
                applyLabel: "应用",
                cancelLabel: "取消",
                resetLabel: "重置",
            }
        }, function (start, end, label) {
            beginTimeStore = start;
            endTimeStore = end;
            console.log(this.startDate.format(this.locale.format));
            console.log(this.endDate.format(this.locale.format));
            if (!this.startDate) {
                this.element.val('');
            } else {
                this.element.val(this.startDate.format(this.locale.format) + this.locale.separator + this.endDate.format(this.locale.format));
            }
        });


        //日期控件加载
        $("#start_time").datetimepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            defaultDate: "${infoMap.start_time}"

        });
        $("#end_time").datetimepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            defaultDate: "${infoMap.end_time}"
        });
        $("#start_time").on("dp.change",
            function (e) {
                $("#end_time").data("DateTimePicker").minDate(e.date)
            });
        $("#end_time").on("dp.change",
            function (e) {
                $("#start_time").data("DateTimePicker").maxDate(e.date)
            });


        $("#stock").TouchSpin({
            min: 1,
            postfix: '个/件'
        });
        //商品搜索点击
        $("#product_search").click(function () {
            var product_name = $("input[name='product_name']").val();
            showTable(product_name);
        });
        /*默认监听表单onbulr验证*/

        $('#infoForm').validationEngine("attach", {
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
        //表单提交
        $("#buttonsave").click(function () {
            $("#buttonsave").attr("disabled", true);
            if ($("input[name='product_id']").val() == "") {
                $("#product_id_error").show();
            } else {
                $("#product_id_error").hide();
            }
            if (!$('#infoForm').validationEngine("validate")) {
                $("#buttonsave").removeAttr("disabled");
                return false;
            } else {
                FullScreenShow("数据提交中，请稍后！");
                $("#infoForm").submit();
            }
        });


        $("input[name=maxLimitType]").click(function (e) {
            if ($(this).val() == '1') {
                $("#maxLimit_div").addClass("hide");
            } else {
                $("#maxLimit_div").removeClass("hide");
            }
        });
    });


    function showTable(product_name) {

        $('.product_sort_table').DataTable({
            ajax: '${pageContext.request.contextPath}/center/ump/groupon/productList.json?product_name=' + product_name,
            columns: [
                {data: "product_name"},
                {data: "sale_price"},
                {data: "stock"},
                {data: "option"}
            ],
            bDestroy: !0,
            bLengthChange: !1,
            bFilter: !1,
            bAutoWidth: !1,
            iDisplayLength: 5,
            oLanguage: {
                oAria: {
                    sSortAscending: ": 升序排序",
                    sSortDescending: ": 降序排序"
                },
                oPaginate: {
                    sFirst: "首页",
                    sLast: "末页",
                    sNext: "下一页",
                    sPrevious: "上一页"
                },
                sEmptyTable: "没有商品数据",
                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
                sInfoEmpty: "当前 0 - 0 条  共  0 条",
                sInfoFiltered: "(filtered from _MAX_ total entries)",
                sInfoPostFix: "",
                sDecimal: "",
                sThousands: ",",
                sLengthMenu: "显示 _MENU_ 条",
                sLoadingRecords: "加载中...",
                sProcessing: "进行中...",
                sSearch: "Search:",
                sSearchPlaceholder: "",
                sUrl: "",
                sZeroRecords: "没有商品数据"
            }
        });
    }


    function selectProduct(id) {
//        console.log(id);
        var img = $(".able_product_" + id).parent().parent().find("img").attr("src");
        //拼接到商品插件中
        $("#single_product_div").find(".dz-details").find("img").attr("src", img);
        //拼接到控件中，方便表单提交时跟着提交
        $("input[name='product_id']").val(id);
        //关闭弹出框
        $(".close").click();
        $("#product_id_error").hide();

        //如果是多规格商品 还需配置每个商品的拼团价
        $.get("${pageContext.request.contextPath}/center/product/getProductById", {product_id: id}, function (res) {
//            console.log(typeof(res) + 'sss')
//            console.log(res)
            if (res.spec_config == 1) {
                $("#youhui").show();
                $("#pintuanjia").hide();
                $("#salePrice").hide();

                $("#testTable").empty();
                var html = '<tbody><tr class="tr_0">';
                $.each(res.specList, function (i, item) {
                    html += '<td class="cl1">' + item.key_name + '</td>';
                })
                html += '<td class="cl1">销售价</td><td class="cl1">拼团价</td></tr>';

                $.each(res.itemList, function (i, item) {
                    html += '<tr>'
                    $.each(item.specDesc, function (i, spec) {
                        html += '<td class="cl1">' + spec.key_name + '</td>';
                    })
                    html += '<td><input  name="salePrice' + i + '" style="border:0px;background-color:transparent;" value="' + item.sale_price + '"></td><td class="cl1"><input type="hidden" name="itemId' + i + '" value="' + item.item_id + ":" + item.spec_custom + '"><input type="number" class="form-control input-sm validate[required,custom[number],min[0.01],max[' + item.sale_price + ']]" name="grouponPrice' + i + '"  style="width:80px" data-errormessage-value-missing="拼团价不能为空"  data-errormessage-range-overflow="拼团价不能高于销售价"  data-errormessage-range-underflow="拼团价不低于0.01元" data-errormessage-custom-error="必须是金额类型"></td></tr>';

                })
                html += '<input type="hidden" name="itemCount" value="' + res.itemList.length + '">';
                $("#testTable").append(html);


            } else {
                $("#pintuanjia").show();
                $("#salePrice").show();
                $("#youhui").hide();
                $("#testTable").empty();

                $("#grouponPrice").empty();
                $("#sale_price").val(res.sale_price);
                htmlPrice = '<input type="hidden" name="item_id" value="' + res.item_id + '"> <input type="hidden" name="spec_custom" value="' + res.spec_custom + '"> <input type="text" class="form-control validate[required,custom[number],min[0.01],max[' + res.product.sale_price + ']]" name="groupon_price" id="groupon_price" data-errormessage-value-missing="请输入拼团价格" data-errormessage-range-overflow="拼团价不能高于销售价' + res.product.sale_price + '" data-errormessage-custom-error="必须是金额类型"/><span class="input-group-addon">元</span>';

                $("#grouponPrice").append(htmlPrice);
            }

        });


    }



</script>
						
