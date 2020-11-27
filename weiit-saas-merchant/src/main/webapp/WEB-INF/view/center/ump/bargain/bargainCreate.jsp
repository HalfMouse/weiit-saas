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
                    <li class="active"><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i class="icon-wrench2"></i>常规营销</a>
                    </li>
                  <%--  <li class="active"><a href="${pageContext.request.contextPath}/center/ump/scene"><i
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
                    <span class="text-semibold"> 砍价活动 </span>
                </h4>
            </div>
        </div>
    </div>
    <!-- Content area -->
    <div class="content">

        <form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
              action="${pageContext.request.contextPath}/center/ump/bargain/save" method="post">
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
                                        <h5>砍价活动信息</h5>
                                    </legend>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>活动名称:</label>
                                        <div class="col-lg-3">
                                            <div class="input-group">
                                                <input type="text" class="form-control validate[required,maxSize[12]]"
                                                       name="bargain_name" id="bargain_name"
                                                       value="${infoMap.bargain_name }"
                                                       data-errormessage-value-missing="请输入活动名称" placeholder="最多支持12个字"
                                                       data-errormessage-range-overflow="最多支持12个字">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right" ><font color="red">
                                            * </font>选择商品:</label>
                                        <div class="col-md-2" style="width: 260px;height: 240px">
                                            <div class="dropzone2" id="single_product_div" style="min-height:150px;">
                                                <div class="dz-preview2" style="width:100%;min-height:223px;margin:0">
                                                    <div class="dz-details" style="width:100%;min-height:185px;">
                                                        <img src="${imageDomain }${infoMap.product_img}"
                                                             style="width:100%;min-height:199px;"/>
                                                    </div>
                                                    <a onclick="showTable('')" class="dz-remove btn btn-warning btn-xs"
                                                       data-toggle="modal" data-target="#select_modal"><i
                                                            class="fa fa-plus"></i>+挑选商品</a>
                                                </div>
                                                <input type="hidden" name="product_id" value="${infoMap.product_id }"/>
                                                <input type="hidden" name="item_id" value="${infoMap.item_id }"/>
                                                <div class='validation-error-label' id="product_id_error"
                                                     style="display:none;">请选择商品
                                                </div>
                                                <div class='validation-error-label' id="item_id_error"
                                                     style="display:none;">请选择商品规格
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="fixed_div">
                                        <label class="col-md-2 control-label text-bold text-right"><font color="red">
                                            * </font>活动时间</label>
                                        <div class="col-md-5">
                                            <div class="col-sm-12 input-group">
                                                <input type="text" class="form-control validate[required]" name="start_time" id="start_time"  value="${infoMap.start_time }" data-errormessage-value-missing="选择固定范围设置时必须设置开始时间">
                                                <span class="input-group-addon">--</span>
                                                <input type="text" class="form-control validate[required]" name="end_time" id="end_time" value="${infoMap.end_time }"  data-errormessage-value-missing="选择固定范围设置时必须设置到期时间">


                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="dateDiv" style="display: none;">
                                        <label class="col-md-2 control-label text-right"> </label>
                                        <div class="col-md-7">
                                            <font color="red" id="dateMsg"></font>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>原价:</label>
                                        <div class="col-md-7">
                                            <div class="col-sm-3 input-group">
                                                <input type="text"
                                                       id="salePrice"
                                                       class="form-control validate[required,custom[number]]]"
                                                       name="max_price" id="max_price" value="${infoMap.max_price}"
                                                       readonly/>
                                                <span class="input-group-addon">元</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>选择规格:</label>
                                        <div class="col-md-7">
                                            <div class="col-sm-3 input-group">
                                                <input type="text"
                                                       class="form-control validate[required]] skuName"
                                                       value="${infoMap.skuName}"
                                                       readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>底价:</label>
                                        <div class="col-md-7">
                                            <div class="col-sm-3 input-group">
                                                <input type="text"
                                                       class="form-control validate[required,custom[number],max[${infoMap.max_price}]]"
                                                       name="min_price" id="min_price" value="${infoMap.min_price}"
                                                       data-errormessage-value-missing="请输入底价"
                                                       data-errormessage-range-overflow="底价不能高于原价${infoMap.max_price}"
                                                       data-errormessage-custom-error="必须是金额类型"/>
                                                <span class="input-group-addon">元</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font color="red">
                                            * </font>砍价额度:</label>
                                        <div class="col-md-6 input-group" id="random_div"
                                             style="padding:10px;margin:-10px;word-break:keep-all;">
                                            <span class="input-group-addon">面值</span>
                                            <input type="text" class="form-control validate[required,custom[number]]"
                                                   id="random_min_price"
                                                   name="cut_price_min" id="cut_price_min"
                                                   value="${infoMap.cut_price_min }"
                                                   data-errormessage-value-missing="请设置最小面值"
                                                   data-errormessage-custom-error="必须是金额类型">
                                            <span class="input-group-addon">--</span>
                                            <input type="text"
                                                   class="form-control validate[required,custom[number],funcCall[comparisonPrice]]"
                                                   id="random_max_price"
                                                   name="cut_price_max" id="cut_price_max"
                                                   value="${infoMap.cut_price_max }"
                                                   data-errormessage-value-missing="请设置最大面值"
                                                   data-errormessage-custom-error="必须是金额类型">
                                            <span class="input-group-addon">元</span>
                                            <span style="font-size: 13px;font-color:red;font-weight: normal;line-height: 1;color: rgb(51, 51, 51);text-align: center;float: left;padding: 7px 12px;">每次砍掉的价格在此范围内随机</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-2 text-bold text-right"><font
                                                color="red"> * </font>砍价有效期:</label>
                                        <div class="col-md-2">
                                            <div class="col-sm-8 input-group" >
                                                <input type="text"
                                                       class="form-control validate[required,custom[number],min[1],max[24]]"
                                                       name="bargain_hour"
                                                       value="${infoMap.bargain_hour}"
                                                       data-errormessage-value-missing="请输入砍价有效期"
                                                       data-errormessage-range-overflow="有效期1-24小时"
                                                       data-errormessage-custom-error="必须是数字类型"/>
                                                <span class="input-group-addon">小时</span>
                                            </div>
                                        </div>
                                    </div>

                                </fieldset>
                            </div>

                            <div class="text-right">
                                <button type="button" id="buttonsave" onclick="saveButton(this,'数据保存中，请稍后。。。')" class="btn btn-primary">
                                    创建砍价活动<i class="icon-arrow-right14 position-right"></i></button>
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


        <div id="sku_modal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h5 class="modal-title">选择规格</h5>
                    </div>

                    <div class="modal-body">
                        <table id="sku-table" class="table sku_sort_table table-hover">
                            <thead>
                            <tr>
                                <th class="col-lg-4">规格</th>
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
    $(document).ready(function () {

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



        //计算
        $(".bootstrap-touchspin-down").click(function () {
            jisuan();
        });

        $(".bootstrap-touchspin-up").click(function () {
            jisuan();
        });

        $("#discount").blur(function () {
            jisuan();
        });

        $("#discount_price").blur(function () {
            var max_price = $("input[name='max_price']").val();

            var discount = discount_price * 10.0 / smarket_price;
            $("#discount").val(discount.toFixed(2));
        });



        //商品搜索点击
        $("#product_search").click(function () {
            var product_name = $("input[name='product_name']").val();
            showTable(product_name);
        });


        //默认监听表单onbulr验证
        $('#infoForm').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });



        //表单提交
        $("#buttonsave").click(function () {
            console.log("buttonsave click");
            if ($("input[name='product_id']").val() == "") {
                $("#product_id_error").show();
            } else {
                $("#product_id_error").hide();
            }

            if ($("input[name='itei_id']").val() == "") {
                $("#item_id_error").show();
            } else {
                $("#item_id_error").hide();
            }
        });
    });
</script>
<script>
    function showTable(product_name) {

        $('.product_sort_table').DataTable({
            ajax: '${pageContext.request.contextPath}/center/ump/bargain/productList.json?product_name=' + product_name,
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


    function showSku(product_id) {
        console.log("showSku"+product_id);
        $('.sku_sort_table').DataTable({
            ajax: '${pageContext.request.contextPath}/center/ump/bargain/skuList.json?product_id=' + product_id,
            columns: [
                {data: "specDesc"},
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
//        var img = $(".able_product_" + id).parent().parent().find("img").attr("src");
        //拼接到商品插件中
//        $("#single_product_div").find(".dz-details").find("img").attr("src", img);
        //拼接到控件中，方便表单提交时跟着提交
        //关闭弹出框
        $(".close").click();

        $("#sku_modal").modal('show');
        showSku(id);

    }


    function selectItem(id) {
        var price = $(".able_item_" + id).attr("price");
        var stock = $(".able_item_" + id).attr("stock");
        var product_id = $(".able_item_" + id).attr("product_id");
        var specDescs = $(".able_item_" + id).attr("specDesc");


        var img = $(".able_item_" + id).attr("product_img");

        $("#single_product_div").find(".dz-details").find("img").attr("src", img);


        $("input[name='product_id']").val(product_id);
        $("#product_id_error").hide();

        $("input[name='max_price']").val(price);

        $("input[name='stock']").val(stock);
        $("input[name='item_id']").val(id);
        $(".skuName").val(specDescs);

        $("#min_price").removeAttr("class");
        $("#min_price").attr("class","form-control validate[required,custom[number],max["+price+"]]");
        $("#min_price").removeAttr("data-errormessage-range-overflow");
        $("#min_price").attr("data-errormessage-range-overflow","底价不能高于原价"+price);

        console.log($("input[name='item_id']").val());
        $("#item_id_error").hide();

        //关闭弹出框
        $(".close").click();

    }

    function comparisonPrice(field, rules, i, options) {
        rules.push('required');
        var min_price = $("#random_min_price").val();
        var max_price = $("#random_max_price").val();
        var salePrice = $("#salePrice").val();
        min_price=min_price-0;
        max_price=max_price-0;
        if (max_price>salePrice){
            return "不能大于原价";
        }
        if (max_price < min_price) {
            return "面板值有误";
        }
    }

    function jisuan() {
        var smarket_price = $("input[name='smarket_price']").val();
        var discount = $("#discount").val();
        var discount_price = (smarket_price * discount) / 10.0;
        $("#discount_price").val(discount_price.toFixed(2));
    }
</script>
						
