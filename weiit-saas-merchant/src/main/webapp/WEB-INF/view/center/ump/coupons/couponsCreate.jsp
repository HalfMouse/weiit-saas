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
                    <li class="active"><a href="${pageContext.request.contextPath}/center/ump/dashboard"><i
                            class="icon-wrench2"></i>常规营销</a></li>
                  <%--  <li><a href="${pageContext.request.contextPath}/center/ump/scene"><i
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

    <!-- Content area -->
    <div class="content">

        <div class="panel-content">
            <div class="main-content-area">
                <div class="row">
                    <div style="width:340px;float:left;">
                        <div class="widget white" style="width:320px;background:#fafafa;">
                            <div class="widget-titlebar">
                                <h5 class="text-white text-center" style="margin-top:7px;">优惠券</h5>
                            </div>
                            <div class="widget-content">
                                <div class="sortable-style">
                                    <ul class="sortable list">
                                        <li>
                                            <div style="background:#FE3650;color:white;border-radius:6px;padding:20px">
                                                <div class="card-info" style="width:100%;">
                                                    <div class="card-header" style="">
					                                             		<span class="text-bold text-white title">
																		<c:choose>
                                                                            <c:when test="${coupon eq null }">优惠券标题</c:when>
                                                                            <c:otherwise>${coupon.coupon_name }</c:otherwise>
                                                                        </c:choose>
																		</span>
                                                        <div class="card_qr_code" style="float:right;">
                                                            分享
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="card-name" style="padding:20px 0">
                                                    <h2 class="text-bold text-white desc"
                                                        style="margin:0;line-height:1">
                                                        <c:choose>
                                                            <c:when test="${coupon eq null }">￥50.00元</c:when>
                                                            <c:otherwise>
                                                                <c:if test="${coupon.type==1 }">￥${coupon.coupon_price }元</c:if>
                                                                <c:if test="${coupon.type==2 }">${coupon.coupon_discount }折</c:if>
                                                                <c:if test="${coupon.type==3 }">￥${coupon.random_min_price }-${coupon.random_max_price }元</c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </h2><br>
                                                    <h7 class="text-white condition" style="margin:0;line-height:1;">
                                                        <c:choose>
                                                            <c:when test="${coupon eq null }">订单满 xx 元 (不含运费)</c:when>
                                                            <c:otherwise>订单满 ${coupon.condition_price }元 (不含运费)</c:otherwise>
                                                        </c:choose>
                                                    </h7>
                                                </div>
                                                <div class="card-limit" style="margin-left:-5px;width:340px;">
                                                    有效期：<br><span class="text-white time" style="font-size:11px;">
				                                             		<c:choose>
                                                                        <c:when test="${coupon eq null }">20xx : 00 : 00 - 20xx : 00 : 00</c:when>
                                                                        <c:otherwise>
                                                                            <c:if test="${coupon.use_type==1 }">${coupon.start_time }-${coupon.end_time }</c:if>
                                                                            <c:if test="${coupon.use_type==2 }">领到券第${coupon.from_day }日开始${coupon.to_day }日内有效</c:if>
                                                                        </c:otherwise>
                                                                    </c:choose>
				                                             		</span>
                                                </div>
                                            </div>
                                        </li>

                                        <li style="background:white;">
                                            <legend class="text-bold"><h6>使用说明</h6></legend>
                                            <div class="row">
                                                <div class="col-md-12 use_desc">
                                                    <c:choose>
                                                        <c:when test="${coupon eq null }">暂无使用说明...</c:when>
                                                        <c:otherwise>${coupon.coupon_desc }</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </li>
                                        <li></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <form class="form-horizontal" id="infoForm" name="infoForm"
                          action="${pageContext.request.contextPath}/center/ump/coupons/save" method="post">
                        <input type="hidden" name="validate_id" id="validate_id" value="${coupon.validate_id }"/>
                        <input type="hidden" name="validate_id_token" id="validate_id_token"
                               value="${coupon.validate_id_token }"/>
                        <div style="margin-left:350px;width:680px;">
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- 表单验证开始 -->
                                    <div class="panel panel-flat">
                                        <div class="panel-body">

                                            <fieldset class="content-group">
                                                <legend class="text-bold">优惠券基本信息</legend>
                                            </fieldset>
                                            <fieldset class="content-group">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2 text-right"> <span
                                                            class="text-danger">*</span>优惠券名称 </label>
                                                    <div class="col-md-5">
                                                        <input type="text"
                                                               class="form-control validate[required,maxSize[12]]"
                                                               name="coupon_name" value="${coupon.coupon_name }"
                                                               placeholder="最多支持12个字"
                                                               data-errormessage-value-missing="优惠券不能为空"
                                                               data-errormessage-range-overflow="最多支持12个字">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right">
                                                        <font color="red"> * </font>发放总量
                                                    </label>
                                                    <div class="col-md-3">
                                                        <div class="input-group">
                                                            <input type="text" name="number"
                                                                   class="form-control validate[required,custom[integer]]"
                                                                   placeholder="" value="${coupon.number }"
                                                                   data-errormessage-value-missing="选输入发放总量"
                                                                   data-errormessage-custom-error="必须是整数">
                                                            <div class="input-group-addon">张</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right">
                                                        <font color="red"> * </font>优惠形式
                                                    </label>
                                                    <div class="col-md-8">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="type" class="styled" value="1"
                                                                   <c:if test="${coupon eq null or coupon.type==1 }">checked="checked"</c:if> >
                                                            指定金额
                                                        </label>

                                                        <label class="radio-inline">
                                                            <input type="radio" name="type" class="styled" value="2"
                                                                   <c:if test="${coupon!=null and coupon.type==2 }">checked="checked"</c:if>>
                                                            打折
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="type" class="styled" value="3"
                                                                   <c:if test="${coupon!=null and coupon.type==3 }">checked="checked"</c:if>>
                                                            指定金额(随机)
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label"></label>
                                                    <div class="col-md-5">
                                                        <div class="col-sm-12 input-group <c:if test="${coupon.type==2 or coupon.type==3 }">hide</c:if>"
                                                             id="price_div">
                                                            <input type="text" class="form-control validate[required]"
                                                                   name="coupon_price" id="coupon_price"
                                                                   value="${coupon.coupon_price }"
                                                                   data-errormessage-value-missing="选择指定金额时必须输入面值"/>
                                                        </div>
                                                        <div class="col-sm-12 input-group <c:if test="${coupon eq null or coupon.type==1 or coupon.type==3 }">hide</c:if>"
                                                             id="discount_div">
                                                            <input type="text" class="form-control validate[required]"
                                                                   name="coupon_discount" id="coupon_discount"
                                                                   value="${coupon.coupon_discount }"
                                                                   data-errormessage-value-missing="选择打折时必须输入折扣"/>
                                                        </div>
                                                        <div class="col-sm-12 input-group <c:if test="${coupon eq null or coupon.type==1 or coupon.type==2 }">hide</c:if>"
                                                             id="random_div">
                                                            <span class="input-group-addon">面值</span>
                                                            <input type="text"
                                                                   class="form-control validate[required,custom[number]]"
                                                                   id="random_min_price" name="random_min_price"
                                                                   value="${coupon.random_min_price }"
                                                                   data-errormessage-value-missing="选择指定金额随机时需要设置最小面值"
                                                                   data-errormessage-custom-error="必须是金额类型">
                                                            <span class="input-group-addon">--</span>
                                                            <input type="text"
                                                                   class="form-control validate[required,custom[number],funcCall[comparisonPrice]]"
                                                                   id="random_max_price" name="random_max_price"
                                                                   value="${coupon.random_max_price }"
                                                                   data-errormessage-value-missing="选择指定金额随机时需要设置最大面值"
                                                                   data-errormessage-custom-error="必须是金额类型">
                                                            <span class="input-group-addon">元</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right">
                                                        <font color="red"> * </font>生效条件
                                                    </label>
                                                    <div class="col-md-5">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="is_condition" value="-1"
                                                                   class="styled"
                                                                   <c:if test="${coupon eq null or coupon.is_condition==-1 }">checked="checked"</c:if> >
                                                            无条件
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="is_condition" value="1"
                                                                   class="styled"
                                                                   <c:if test="${coupon!=null and coupon.is_condition==1 }">checked="checked"</c:if>>
                                                            满减条件
                                                        </label>
                                                    </div>
                                                </div>

                                                <div class="form-group <c:if test="${coupon eq null or coupon.is_condition==-1 }">hide</c:if>"
                                                     id="conditionPrice_div">
                                                    <label class="col-md-2 control-label"></label>
                                                    <div class="col-md-5">
                                                        <div class="col-sm-12 input-group">
                                                            <span class="input-group-addon">满</span>
                                                            <input type="text"
                                                                   class="form-control validate[required,custom[number]]"
                                                                   name="condition_price" id="condition_price"
                                                                   value="${coupon.condition_price }"
                                                                   data-errormessage-value-missing="选择满减条件时必须输入满减条件"
                                                                   data-errormessage-custom-error="必须是金额类型"/>
                                                            <span class="input-group-addon">元(不含运费)</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right">
                                                        <font color="red"> * </font>使用有效期
                                                    </label>
                                                    <div class="col-md-5">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="use_type" value="1" class="styled"
                                                                   <c:if test="${coupon eq null or coupon.use_type==1 }">checked="checked"</c:if> >
                                                            固定范围
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="use_type" value="2" class="styled"
                                                                   <c:if test="${coupon!=null and coupon.use_type==2 }">checked="checked"</c:if>>
                                                            指定时间
                                                        </label>

                                                    </div>
                                                </div>
                                                <div class="form-group <c:if test="${coupon!=null and coupon.use_type==2 }">hide</c:if>"
                                                     id="fixed_div">
                                                    <label class="col-md-2 control-label"></label>
                                                    <div class="col-md-8">
                                                        <div class="col-sm-12 input-group">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">固定范围</span>
                                                                <input type="text"
                                                                       class="form-control validate[required]"
                                                                       name="start_time" id="start_time" value=""
                                                                       value="${coupon.start_time }"
                                                                       data-errormessage-value-missing="选择固定范围设置时必须设置开始时间">
                                                                <span class="input-group-addon">--</span>
                                                                <input type="text"
                                                                       class="form-control validate[required]"
                                                                       name="end_time" id="end_time" value=""
                                                                       value="${coupon.end_time }"
                                                                       data-errormessage-value-missing="选择固定范围设置时必须设置到期时间">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group <c:if test="${coupon eq null or coupon.use_type==1 }">hide</c:if>"
                                                     id="range_div">
                                                    <label class="col-md-2 control-label"></label>
                                                    <div class="col-md-6">
                                                        <div class="col-sm-12 input-group">
                                                            <span class="input-group-addon">领取后</span>
                                                            <input type="text"
                                                                   class="form-control validate[required,custom[integer]]"
                                                                   name="from_day" id="from_day"
                                                                   value="${coupon.from_day }"
                                                                   data-errormessage-value-missing="选择指定时间访问时需要设置领取后几天生效"
                                                                   data-errormessage-custom-error="必须是整数"/>
                                                            <span class="input-group-addon">天</span>
                                                            <span class="input-group-addon">生效</span>
                                                            <input type="text"
                                                                   class="form-control validate[required,custom[integer]]"
                                                                   name="to_day" id="to_day" value="${coupon.to_day }"
                                                                   data-errormessage-value-missing="选择指定时间访问时需要设置领取后生效几天"
                                                                   data-errormessage-custom-error="必须是整数"/>
                                                            <span class="input-group-addon">天</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right">
                                                        <font color="red"> * </font>每人领取
                                                    </label>
                                                    <div class="col-md-4">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="maxLimitType" value="1"
                                                                   class="styled"
                                                                   <c:if test="${coupon eq null or coupon.max_limit==0 }">checked="checked"</c:if>>
                                                            不限
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="maxLimitType" value="2"
                                                                   class="styled"
                                                                   <c:if test="${coupon!=null and coupon.max_limit>0 }">checked="checked"</c:if>>
                                                            限制
                                                        </label>
                                                    </div>
                                                </div>

                                                <div class="form-group <c:if test="${coupon eq null or coupon.max_limit==null }">hide</c:if>"
                                                     id="maxLimit_div">
                                                    <label class="col-md-2 control-label"></label>
                                                    <div class="col-md-5">
                                                        <div class="col-sm-6 input-group">
                                                            <input type="text"
                                                                   class="form-control validate[required,custom[integer]]"
                                                                   name="max_limit" id="max_limit"
                                                                   value="${coupon.max_limit }" value="0"
                                                                   data-errormessage-value-missing="请输入每人领取的张数"
                                                                   data-errormessage-custom-error="必须是整数"/>
                                                            <span class="input-group-addon">张</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right"><font color="red">
                                                        * </font>使用须知</label>
                                                    <div class="col-md-10" style="padding-left:0px;">
                                                        <div class="col-md-9">
                                                            <textarea rows="7" class="form-control" cols="100"
                                                                      id="coupon_desc" name="coupon_desc"
                                                                      placeholder="填写活动的使用说明详细，支持换行。">${coupon.coupon_desc}</textarea>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-2 control-label text-right">
                                                        <font color="red"> * </font>可使用商品
                                                    </label>
                                                    <div class="col-md-4">
                                                        <label class="radio-inline">
                                                            <input type="radio" name="product_range_type" value="1"
                                                                   class="styled"
                                                                   <c:if test="${coupon eq null or coupon.product_ids==null }">checked="checked"</c:if>>
                                                            全店商品
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="product_range_type" value="2"
                                                                   class="styled"
                                                                   <c:if test="${coupon!=null and coupon.product_ids!=null }">checked="checked"</c:if>>
                                                            指定商品
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="form-group <c:if test="${coupon eq null or coupon.product_ids==null }">hide</c:if>"
                                                     id="product_div">
                                                    <label class="col-md-2 control-label ">选择商品：</label>
                                                    <div class="col-sm-8">
                                                        <a href="javascript:;" class="btn btn-warning btn-xs"
                                                           id="selectProduct"><i class="fa fa-plus"></i>+挑选商品</a>
                                                        <div class="dropzone2">
                                                            <c:forEach items="${coupon.couponProductList }" var="pro">
                                                                <div class="dz-preview2"
                                                                     product_id="${pro.product_id }">
                                                                    <div class="dz-details">
                                                                        <img src="${imageDomain }${pro.product_img }"/>
                                                                    </div>
                                                                    <a class="dz-remove" href="javascript:undefined;"
                                                                       data_id="${pro.product_id }">删除</a>
                                                                </div>
                                                            </c:forEach>
                                                            <input type='hidden' name='selectProductValues'
                                                                   id='selectProductValues'
                                                                   value='${coupon.product_ids }'/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>

                                        </div>
                                    </div>
                                    <!-- /form validation -->


                                </div>
                            </div>

                        </div>

                        <div class="form-group "
                             style="width:100%; margin:0 auto; overflow:hidden; position: fixed; bottom:0;">
                            <ul class="nav nav-pills col-sm-12  alert-danger" style="margin:0px;padding:0px;">
                                <li class="col-sm-12" style="padding-top:10px;padding-bottom:10px;margin-left:30%">
                                    <button type="button" class="btn btn-primary" id="save_btn">保存<i
                                            class="icon-checkmark3 position-right"></i></button>
                                    &nbsp;&nbsp;
                                    <button type="button" class="btn btn-default" onclick="javascript:history.back(-1)">
                                        返回 <i class="icon-reload-alt position-right"></i></button>
                                </li>
                            </ul>
                        </div>
                    </form>
                </div>

            </div>
        </div><!-- Panel Content -->


    </div>
    <!-- /content area -->

</div>

<!-- /main content -->

<%@include file="../../common/footer.jsp" %>
<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
<script>
    $(document).ready(function () {

        //优惠形式控件加载
        $("#coupon_price").TouchSpin({
            min: 0,
            step: 0.01,
            decimals: 2,
            prefix: '面值'
        });
        $("#coupon_discount").TouchSpin({
            min: 0,
            max: 10,
            step: 1,
            postfix: '折'
        });
        //日期控件加载
        $("#start_time").datetimepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            defaultDate: "${coupon.start_time}"
        });
        $("#end_time").datetimepicker({
            format: "YYYY/MM/DD HH:mm:ss",
            defaultDate: "${coupon.end_time}"
        });
        $("#start_time").on("dp.change",
            function (e) {
                $("#end_time").data("DateTimePicker").minDate(e.date);
                //改变右边有效日期变动
                $(".card-limit .time").html($(this).val() + "-20xx : 00 : 00");
            });
        $("#end_time").on("dp.change",
            function (e) {
                $("#start_time").data("DateTimePicker").maxDate(e.date);
                //改变右边有效日期变动
                $(".card-limit .time").html($("input[name=start_time]").val() + "-" + $(this).val());
            });

        //减价与打折切换
        $("input[name=type]").click(function (e) {
            if ($(this).val() == '1') {
                $("#discount_div").addClass("hide");
                $("#random_div").addClass("hide");
                $("#price_div").removeClass("hide");
            } else if ($(this).val() == '2') {
                $("#price_div").addClass("hide");
                $("#random_div").addClass("hide");
                $("#discount_div").removeClass("hide");
            } else {
                $("#price_div").addClass("hide");
                $("#discount_div").addClass("hide");
                $("#random_div").removeClass("hide");
            }
        });

        //生效条件切换
        $("input[name=is_condition]").click(function (e) {
            if ($(this).val() == '-1') {
                $("#conditionPrice_div").addClass("hide");
            } else {
                $("#conditionPrice_div").removeClass("hide");
            }
        });

        //使用有效期切换
        $("input[name=use_type]").click(function (e) {
            if ($(this).val() == '1') {
                $("#fixed_div").removeClass("hide");
                $("#range_div").addClass("hide");
            } else {
                $("#range_div").removeClass("hide");
                $("#fixed_div").addClass("hide");
            }
        });

        //领取设置
        $("input[name=maxLimitType]").click(function (e) {
            if ($(this).val() == '1') {
                $("#maxLimit_div").addClass("hide");
            } else {
                $("#maxLimit_div").removeClass("hide");
            }
        });

        //可使用商品切换
        $("input[name=product_range_type]").click(function (e) {
            if ($(this).val() == '1') {
                $("#product_div").addClass("hide");
            } else {
                $("#product_div").removeClass("hide");
            }
        });
        //商品弹出框
        $("#selectProduct").click(function () {
            openProduct("selectProduct");
        });

        /*默认监听表单onbulr验证*/
        $('#infoForm').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });
        //表单提交
        $("#save_btn").click(function () {
            $("#save_btn").attr("disabled", true);
            if (!$('#infoForm').validationEngine("validate")) {
                $("#save_btn").removeAttr("disabled");
                return false;
            } else {
                FullScreenShow("数据提交中，请稍后！");
                $("#infoForm").submit();
            }

        });

        //右边动态效果控制 开始
        $("input[name=coupon_name]").blur(function () {
            $(".card-header .title").html($(this).val());
        });
        $("input[name=coupon_price]").change(function () {
            $(".card-name .desc").html("￥" + $(this).val() + "元");
        });
        $("input[name=coupon_discount]").change(function () {
            $(".card-name .desc").html($(this).val() + "折");
        });
        $("input[name=random_min_price]").change(function () {
            $(".card-name .desc").html("￥" + $(this).val() + "~");
        });
        $("input[name=random_max_price]").change(function () {
            $(".card-name .desc").html("￥" + $("input[name=random_min_price]").val() + "~" + $(this).val() + "元");
        });
        $("input[name=condition_price]").change(function () {
            $(".card-name .condition").html("订单满" + $(this).val() + "元 (不含运费)");
        });
        $("input[name=from_day]").change(function () {
            $(".card-limit .time").html("领到券第" + $(this).val() + "日开始x天内有效");
        });
        $("input[name=to_day]").change(function () {
            $(".card-limit .time").html("领到券第" + $("input[name=from_day]").val() + "日开始" + $(this).val() + "天内有效");
        });
        $("#coupon_desc").change(function () {
            $(".use_desc").html($(this).val());
        });
        //右边动态效果控制 结束
    });

    //自定义拓展比较 面值设置最大价格要大于最小价格
    function comparisonPrice() {
        var min_price = $("#random_min_price").val();
        var max_price = $("#random_max_price").val();
        min_price=min_price-0;
        max_price=max_price-0;
        if (max_price < min_price) {
            return "面值范围输入有误";
        }
    }
</script>
			
