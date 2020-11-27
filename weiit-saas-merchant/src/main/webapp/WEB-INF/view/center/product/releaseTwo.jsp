<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@include file="../common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">

<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-content">
                <a href="${pageContext.request.contextPath}/center/product/releaseOne"
                   class="btn bg-orange btn-rounded btn-block btn-xs">发布商品</a>
            </div>
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li ${(empty productSession.saleOld or productSession.saleOld eq 1)?"class='active'":""} ><a
                            href="${pageContext.request.contextPath}/center/product/onSaleList"><i
                            class="icon-price-tag3"></i>出售中的商品</a></li>
                    <li ${(productSession.saleOld eq 2)?"class='active'":""}><a
                            href="${pageContext.request.contextPath}/center/product/soldOutList"><i
                            class="icon-flag3"></i>库存紧张商品</a></li>
                    <li ${(productSession.saleOld eq 3)?"class='active'":""}><a
                            href="${pageContext.request.contextPath}/center/product/forSaleList"><i
                            class="icon-make-group"></i>仓库中的商品</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/productTag/list"><i
                            class="icon-price-tags"></i> 商品标签</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/productGroup/list"><i
                            class="icon-paragraph-justify2"></i> 商品分组</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/productImport/list"><i
                            class="icon-import"></i> 商品导入</a></li>
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
                    <span class="text-semibold">发布商品</span>
                </h4>
            </div>
        </div>
    </div>

    <!-- Content building -->
    <div class="content">
        <!-- Bordered striped table -->
        <div class="panel panel-flat">

            <div class="panel-body">
                <ul class="nav nav-pills col-sm-12  alert-primary">
                    <li class="col-sm-3 text-center">
                        <a href="javascript:;" onclick="firstStep();"> 1.选择商品品类
                            <i class="icon-arrow-right15 position-right"></i>
                            <i class="icon-arrow-right15 position-right"></i></a></li>
                    <li class="active col-sm-3 text-center">
                        <a href="javascript:;"> 2.编辑基本信息
                            <i class="icon-arrow-right15 position-right"></i>
                            <i class="icon-arrow-right15 position-right"></i></a></li>
                    <li class="col-sm-3 text-center">
                        <a href="javascript:;" onclick="thirdStep();"> 3.编辑商品详情
                            <i class=" icon-check position-right"></i></a></li>
                </ul>

                <form class="form-horizontal" action="" name="bwizard_Form" id="bwizard_Form" method="POST"
                      enctype="multipart/form-data">
                    <input type="hidden" name="rowCount" id="rowCount" value="0">
                    <input type="hidden" name="specAttributeIds" id="specAttributeIds"
                           value="${productSession.specAttributeIds}">
                    <input type="hidden" name="specAttributeValIds" id="specAttributeValIds"
                           value="${productSession.specAttributeValIds}">
                    <div id="wizard" class="bwizard clearfix">
                        <div class="well">
                            <div class="wizard-step-1 bwizard-activated" id="step1">

                                <div class="form-group">
                                    <label class="col-sm-1 control-label"><font
                                            color="red">*</font>商品分类</label>
                                    <div class="col-sm-5 control-label">
                                        ${productSession.firstCateName}
                                        <c:if test="${!empty productSession.secondCateName}">
                                            &gt;${productSession.secondCateName}
                                        </c:if>
                                        <c:if test="${!empty productSession.thirdCateName}">
                                            &gt;${productSession.thirdCateName}
                                        </c:if>
                                        &nbsp; <a href="javascript:" onclick="firstStep()">修改</a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label"> 商品属性 </label>
                                    <div class="col-sm-11 control-label">
                                        <div id="attrDiv"
                                             class="col-sm-12 p-t-10 m-b-5 ${(attrList ne null and fn:length(attrList) gt 0)?'show':'hide' }"
                                             style="background-color: #f9f9f9;padding-top:5px;margin-bottom:5px;">
                                            <c:if test="${attrList ne null and fn:length(attrList) gt 0}">
                                                <c:forEach items="${attrList}" var="attr">
                                                    <c:if test="${attr.type eq 0 && empty attr.parent_id}">
                                                        <div class="form-group col-sm-6  m-b-0"
                                                             style="margin-bottom:0px;"
                                                             id="divitems_${attr.key_id}">
                                                            <label class="col-sm-3 control-label  p-0 p-t-5">
                                                                    ${attr.key_name}</label>
                                                            <div class="col-sm-6">
                                                                <select name="mitems" id="mitems_${attr.key_id}"
                                                                        class="select-search"
                                                                        data-size="5">
                                                                    <option value="">请选择</option>
                                                                    <c:forEach items="${attrList}" var="attrTwo">
                                                                        <c:if test="${attrTwo.parent_id==attr.key_id }">
                                                                            <option value="${attr.key_id }:${attr.key_name}:${attrTwo.key_name }">
                                                                                    ${attrTwo.key_name}</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <label class=" p-t-5"> <a href="#attr-modal-alert"
                                                                                      data-toggle="modal"
                                                                                      title="编辑"
                                                                                      onclick="showProdAttrVal(${attr.key_id},'${attr.key_name}',1)">
                                                                <i class="icon-pencil7"></i>
                                                            </a> <a
                                                                    onclick="deleteAttr(${attr.key_id});" title="删除">
                                                                <i class="icon-trash"></i>
                                                            </a>
                                                            </label>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                        <p id="moreProp">
                                            <a href="javascript:" onclick="showAdd('moreProp','addProp')">
                                                <i class="fa fa-plus"></i>添加属性
                                            </a>
                                        </p>
                                        <div id="addProp" class="hide">
                                            <div class=" col-sm-3 p-l-0">
                                                <input type="text" class="form-control" id="addProp-name"
                                                       placeholder="请输入属性名称">
                                            </div>
                                            <div class=" col-sm-3 p-l-0">
                                                <input type="text" class="form-control" id="addProp-value"
                                                       placeholder="请输入属性值">
                                            </div>
                                            <button type="button" class="btn btn-info btn-sm" id="propButton"info
                                                    onclick="addProp()">添加
                                            </button>
                                            <button type="button" class="btn btn-default btn-sm"
                                                    onclick="showAdd('addProp','moreProp')">取消
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label p-t-10"> <font
                                            color="red">*</font>商品标题
                                    </label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control validate[required,maxSize[30]]" name="product_name"
                                               id="product_name"
                                               value="${productSession.product_name}"
                                               data-errormessage-value-missing="商品标题不能为空" placeholder="商品标题">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-1 control-label">商品分组</label>
                                    <div class="col-sm-6">
                                        <select name="tag_id_str" id="tag_id_str" multiple="multiple" class="select"
                                                placeholder="选择分组">
                                            <c:forEach items="${tagList}" var="group">
                                                <option value="${group.group_id}">${group.group_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label p-t-10"><font
                                            color="red"> * </font>首图</label>
                                    <div class="col-sm-9 control-label">
                                        <div style="width: 600px; height: auto;" id="filediv">
                                            <!-- 												<input  type="file" name="mfile" class="bootstrap-uploader" multiple="multiple" id="Button1"> -->
                                            <input id="Button1" class="btn btn-warning btn-xs" type="button"
                                                   value="选择图片"/>
                                            <span style="color: gray"> &nbsp;建议尺寸：600*600 像素。</span>
                                            <div class="dropzone2" style="height:140px;" id="filedivUl">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group"
                                     <c:if test='${productSession.activity.isJoinActivity eq true}'>title="${productSession.activity.activityInfo}" </c:if>>
                                    <label class="col-md-1 control-label">商品规格</label>

                                    <div class="col-sm-11">
                                        <label class="radio-inline"> <input type="radio"
                                                                            class="styled" name="spec_config"
                                                                            id="spec_config0"
                                                                            checked="checked"
                                        ${productSession.spec_config!=1?"checked":""} value="0"
                                                                            onclick="allowGuige('0')"
                                                                            <c:if test="${productSession.activity.isJoinActivity eq true}">disabled</c:if>>
                                            统一规格
                                        </label>
                                        <label class="radio-inline"> <input type="radio"
                                                   class="styled" name="spec_config"
                                                   id="spec_config1"
                                                   ${productSession.spec_config==1?"checked":""} value="1"
                                                   onclick="allowGuige('1')"
                                                   <c:if test="${productSession.activity.isJoinActivity eq true}">disabled</c:if>>
                                        多规格
                                    </label>
                                        <c:set var="skuCount" value="0"></c:set>
                                        <div id="guigeDiv22"
                                             class="col-sm-12 p-t-10 m-b-5 ${(attrList ne null and fn:length(attrList) gt 0)?'show':'hide' }"
                                             style="background-color: #f9f9f9;">
                                            <div id="guigeDiv33" class="col-sm-12  m-0 p-0 "
                                                 style="padding:0px;margin:0px;">
                                                <c:if test="${attrList ne null and fn:length(attrList) gt 0}">
                                                    <c:forEach items="${attrList}" var="info" varStatus="ind">
                                                        <c:if test="${info.type eq 1  && empty info.parent_id }">
                                                            <div class="form-group col-sm-12  m-b-0"
                                                                 id="divitems_${info.key_id}"
                                                                 style="margin-bottom:0px;">
                                                                <label class="col-sm-12 control-label  p-0 p-t-5">
                                                                        ${info.key_name} &nbsp;
                                                                    <a
                                                                            href="#attr-modal-alert"
                                                                            <c:if test="${productSession.activity.isJoinActivity eq true}">style="display:none"</c:if>
                                                                            data-toggle="modal" title="编辑"
                                                                            onclick="showProdAttrVal(${info.key_id},'${info.key_name}',2,${skuCount})"
                                                                    >
                                                                        编辑
                                                                    </a>
                                                                    &nbsp;&nbsp;
                                                                    <a href="javascript:;"
                                                                            <c:if test="${productSession.activity.isJoinActivity eq true}">style="display:none"</c:if>
                                                                            onclick="deleteAttr(${info.key_id},1);"
                                                                            title="删除"
                                                                        ${productSession.activity.isJoinActivity}
                                                                    >
                                                                        删除
                                                                    </a>
                                                                </label>
                                                                <div class="col-sm-12">
                                                                    <table style="height: 40px; border: 0px;">
                                                                        <tr>
                                                                            <td id="guivalDev_${info.key_id}">
                                                                                <c:forEach items="${attrList}"
                                                                                           var="attr">
                                                                                    <c:if test="${attr.parent_id==info.key_id }">
                                                                                        <input type="checkbox"
                                                                                               <c:if test='${productSession.activity.isJoinActivity eq true}'>disabled</c:if>
                                                                                               name="mattvalids${attr.key_id}"
                                                                                               class="ids${skuCount}"
                                                                                               hideAttrId="${info.key_id}"
                                                                                               onclick="onclickIds(${attr.key_id},this)"
                                                                                               alt="${info.key_name}"
                                                                                               value="${attr.key_id}"
                                                                                               title="${attr.key_name}"/>${attr.key_name }
                                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                    </c:if>
                                                                                </c:forEach></td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <c:set var="skuCount" value="${skuCount+1}"></c:set>
                                                                <hr class="col-sm-12 m-0 p-0"
                                                                    style="padding:0px;margin:0px;">
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </div>
                                            <label class="col-sm-12 control-label p-t-10">
                                                <p id="moreGuige">
                                                    <a ${productSession.activity.isJoinActivity eq true?'disabled':''}
                                                            href="javascript:"
                                                            onclick="showAdd('moreGuige','addGuige')"><i
                                                            class="fa fa-plus"></i>添加规格
                                                    </a>
                                                </p>
                                            </label>
                                            <div id="addGuige" class="hide">
                                                <div class=" col-sm-3 p-l-0">
                                                    <input type="text" class="form-control" id="guige-name"
                                                           placeholder="请输入规格名称">
                                                </div>
                                                <div class=" col-sm-7 p-l-0">
                                                    <div class=" col-sm-5 p-l-0">
                                                        <input type="text" class="form-control" id="guige-value"
                                                               placeholder="请输入规格值">
                                                    </div>
                                                    <a type="button" class="btn btn-success btn-sm"
                                                            id="guigebutton" onclick="addGuige()">添加
                                                    </a>
                                                    <a type="button" class="btn btn-default btn-sm"
                                                            onclick="showAdd('addGuige','moreGuige')">取消
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <br/>
                                    </div>


                                </div>

                                <div id="guigeDiv">
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label p-t-10"> <font
                                                color="red">*</font>市场价
                                        </label>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control validate[required,custom[number]]"
                                                   name="smarket_price" id="smarket_price"
                                                   value="${(empty productSession.smarket_price)?'0':productSession.smarket_price}"
                                                   data-errormessage-value-missing="市场价不能为空"
                                                   data-errormessage-custom-error="必须是金额类型">
                                        </div>
                                        <label style="padding-top:10px;">不知市场价可填0，默认0</label>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-1 control-label p-t-10">
                                            <font
                                                    color="red">*</font>销售价
                                        </label>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control validate[required,custom[number]]"
                                                   name="sale_price" id="sale_price"
                                                   value="${productSession.sale_price}"
                                                   data-errormessage-value-missing="销售价不能为空"
                                                   data-errormessage-custom-error="必须是金额类型">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label p-t-10"> <font
                                                color="red">*</font>库存
                                        </label>
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control validate[required,custom[integer]]"
                                                   name="stock"
                                                   id="stock" value="${productSession.stock}"
                                                   data-errormessage-value-missing="库存不能为空"
                                                   data-errormessage-custom-error="必须是整数">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-1 control-label p-t-10">商品编号</label>
                                        <div class="col-sm-2">
                                            <input type="hidden" class="form-control" name="item_id"
                                                   value="${productSession.item_id}">
                                            <input type="text" class="form-control" name="item_num"
                                                   id="item_num" value="${productSession.item_num}"
                                                   placeholder="商品编号">
                                        </div>
                                    </div>
                                </div>

                                <div id="guigeDivMM">
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label p-t-10">价格/<br/>库存
                                        </label>
                                        <div class="col-sm-11  p-r-0 " id="guigeDivNN">
                                            <table id="testTable" class="table table-striped table-bordered ">
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-1 control-label">运费设置</label>
                                    <div class="col-md-8">
                                        <label class="radio-inline"> <input type="radio"
                                                                            class="styled" name="express_config"
                                                                            id="expressConfig0"
                                                                            checked="checked" onclick="tips(-1);"
                                        ${productSession.express_config==-1?"checked":""} value="-1">
                                            统一邮费
                                        </label>
                                        <label class="radio-inline"> <input type="radio"
                                                                            class="styled" name="express_config"
                                                                            id="expressConfig1"
                                        ${productSession.express_config==0?"checked":""} value="0"
                                                                            onclick="tips(0);">运费模板
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group" id="expressMoneyDiv" style="display: none;">
                                    <label class="col-md-1 control-label">
                                        <font color="red">*</font>统一邮费</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control validate[required,custom[number]]"
                                               name="express_money" id="express_money"
                                               value="${(empty productSession.express_money)?'0':productSession.express_money}"
                                               data-errormessage-value-missing="邮费不能为空"
                                               data-errormessage-custom-error="必须是金额类型">
                                    </div>
                                </div>
                                <div class="form-group" id="expressDiv" style="display: none;">
                                    <label class="col-md-1 control-label">
                                        <font color="red">*</font>选择模板</label>
                                    <div class="col-sm-3">
                                        <select name="express_template_id" id="express_template_id"
                                                class="select-search" data-size="5">
                                            <option value="0">请选择</option>
                                            <c:forEach items="${shipList}" var="info22" varStatus="ind22">
                                                <c:if test="${info22.parent_id==info.key_id }">
                                                    <option value="${info22.shipping_id}"
                                                            mconfig="${info22.shipping_config}">${info22.shipping_name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" id="expressDiv11" style="display: none;">
                                    <label class="col-md-1 control-label">
                                        <font color="red">*</font><span id="spanX">商品重量</span></label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control validate[required,custom[number]]"
                                               name="weight" id="weight"
                                               value="<c:if test="${empty productSession.weight}">0</c:if><c:if test="${!empty productSession.weight}">${productSession.weight}</c:if>"
                                               data-errormessage-value-missing="商品重量不能为空"
                                               data-errormessage-custom-error="必须是数字类型">
                                    </div>
                                </div>
                                <div class="form-group" id="expressDiv22" style="display: none;">
                                    <label class="col-md-1 control-label">
                                        <font color="red">*</font>商品体积</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control validate[required,custom[number]]"
                                               name="msize" id="msize"
                                               value="<c:if test="${empty productSession.msize}">0</c:if><c:if test="${!empty productSession.msize}">${productSession.msize}</c:if>"
                                               data-errormessage-value-missing="商品重量不能为空"
                                               data-errormessage-custom-error="必须是数字类型">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label">是否上架</label>
                                    <div class="col-sm-4">
                                        <label class="radio-inline"> <input type="radio"
                                                                            class="styled" name="is_on_sale"
                                                                            id="isOnSale0"
                                                                            checked="checked"
                                        ${productSession.is_on_sale==0?"checked":""} value="0">
                                            是
                                        </label> <label class="radio-inline"> <input type="radio"
                                                                                     class="styled" name="is_on_sale"
                                                                                     id="isOnSale1"
                                    ${productSession.is_on_sale==-1?"checked":""} value="-1">
                                        否
                                    </label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label p-t-10">每人限购</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control validate[required,custom[integer]]"
                                               name="purchase"
                                               placeholder="0 表示不限购"
                                               id="purchase"
                                               value="<c:if test="${empty productSession.purchase}">0</c:if><c:if test="${!empty productSession.purchase}">${productSession.purchase}</c:if>"
                                               data-errormessage-value-missing="限购数不能为空"
                                               data-errormessage-custom-error="必须是整数">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-1 control-label p-t-10">基础销量</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control validate[required,custom[integer]]"
                                               name="sale_count"
                                               id="sale_count"
                                               value="<c:if test="${empty productSession.sale_count}">0</c:if><c:if test="${!empty productSession.sale_count}">${productSession.sale_count}</c:if>"
                                               data-errormessage-value-missing="基础销量不能为空"
                                               data-errormessage-custom-error="必须是整数">
                                    </div>
                                </div>

                            </div>
                        </div>
                        <ul class="pager bwizard-buttons">
                            <li class="previous" role="button" aria-disabled="false">
                                <a href="javascript:;" onclick="firstStep()">← 上一步</a></li>
                            <li class="next" role="button" aria-disabled="false">
                                <a href="javascript:;" onclick="thirdStep()">下一步 →</a></li>
                        </ul>
                    </div>
                </form>
            </div>

        </div>
        <!-- /bordered striped table -->
    </div>
    <!-- /content building -->
</div>
<!-- /main content -->


<!-- begin attr-modal-alert -->
<div class="modal fade" id="attr-modal-alert" role="dialog">
    <div class="modal-dialog" style="width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">值设置</h4>
            </div>
            <div class="modal-body">
                <div class="alert  m-b-0">
                    <form class="form-horizontal" name="addAttrValForm" method="post" id="addAttrValForm" action="">
                        <input type="hidden" id="attributeId" name="attributeId" value=""/>
                        <input type="hidden" id="type" name="type" value=""/>
                        <input type="hidden" id="attributeNameHide" name="attributeNameHide" value=""/>
                        <input type="hidden" id="attriFlag" name="attriFlag" value=""/>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" id="attributeNameHtml"></label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" id="attributeValueName"
                                           name="attributeValueName" placeholder="请输入值">
                                </div>
                                <button type="button" class="btn btn-success btn-sm" id="valButton"
                                        onclick="addProdAttrVal()">添加
                                </button>
                                <a href="javascript:;" class="btn btn-sm btn-default" data-dismiss="modal">取消</a>
                            </div>
                        </div>
                        <br>
                        <table id="levelTable" class="table table-striped table-bordered  table-condensed ">
                            <thead>
                            <tr>
                                <th>值</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end attr-modal-alert -->

<%@include file="../common/footer.jsp" %>
<script>

    var cate_id =${productSession.cate_id};
    var skuNum = 0;
    var uploadNum = 0;

    $(document).ready(function () {
        skuNum =${skuCount};

        $("#smarket_price").TouchSpin({
            min: 0,
            max: 99999999,
            step: 0.01,
            decimals: 2,
            postfix: '元'
        });
        $("#sale_price").TouchSpin({
            min: 0,
            max: 99999999,
            step: 0.01,
            decimals: 2,
            postfix: '元'
        });
        $("#stock").TouchSpin({
            min: 0,
            max: 99999999,
            postfix: '个/件'
        });
        $("#purchase").TouchSpin({
            min: 0,
            max: 99999999,
            postfix: '个/件'
        });
        $("#sale_count").TouchSpin({
            min: 0,
            max: 99999999,
            postfix: '个/件'
        });
        $("#weight").TouchSpin({
            min: 0,
            max: 99999999,
            step: 1,
            decimals: 2,
            postfix: 'g'
        });
        $("#msize").TouchSpin({
            min: 0,
            max: 99999999,
            step: 1,
            decimals: 2,
            postfix: 'cm3'
        });
        $("#express_money").TouchSpin({
            min: 0,
            max: 99999999,
            step: 0.01,
            decimals: 2,
        });

        tips($("input[name='express_config']:checked").val());
        allowGuige($("input[name='spec_config']:checked").val());

        if ('1' == '${productSession.spec_config}') {
            if ('${productSession.rowCount}' > 0 && '${productSession.idslist}' != "") {
                <c:forEach items="${productSession.idslist}" var="info">
                $("input[name='mattvalids${info}']").attr("checked", true);
                </c:forEach>

                onclickIds();
                $("#rowCount").val('${productSession.rowCount}');

                <c:forEach items="${productSession.skulist}" var="info" varStatus="ind" >
                $("input[name='smarketPricelist${ind.count-1}']").val('${info.smarket_price}');
                $("input[name='salePricelist${ind.count-1}']").val('${info.sale_price}');
                $("input[name='stocklist${ind.count-1}']").val('${info.stock}');
                $("input[name='itemNumlist${ind.count-1}']").val('${info.item_num}');
                $("input[name='itemId${ind.count-1}']").val('${info.item_id}');
                </c:forEach>

            }
        }

        if ('${productSession.tag_id_str}' != "") {
            if ("${productSession.tag_id_count}" == "1") {
                $("#tag_id_str").val('${productSession.tag_id_str}');
            } else if ("${productSession.tag_id_count}" == "2") {
                var select = document.getElementById("tag_id_str");
                <c:forEach items="${productSession.tag_id_str}" var="info" varStatus="ind" >
                $("#tag_id_str option[value='${info}']").attr("selected", true);
                </c:forEach>
            }
            $("#tag_id_str").trigger('change');
        }

        if ('${productSession.mitems}' != "") {
            if ("${productSession.mitemsCount}" == "1") {
                $("select[name='mitems']").val('${productSession.mitems}');
                $(".select-search").trigger('change');
            } else if ("${productSession.mitemsCount}" == "2") {
                <c:forEach items="${productSession.mitems}" var="info" varStatus="ind" >
                var mitem = "${info}";
                var strs = mitem.split(":");
                $('#mitems_' + strs[0]).val(mitem);
                $('#mitems_' + strs[0]).selectpicker('render');
                $('#mitems_' + strs[0]).selectpicker('refresh');
                $('#mitems_' + strs[0]).trigger('change');
                </c:forEach>
                $(".select-search").trigger('change');
            }
        }

        if ('${productSession.imagesList}' != "") {
            var randomNum = (new Date()).valueOf();
            <c:forEach items="${productSession.imagesList}" var="info" varStatus="ind" >
            imageOperation("input" + randomNum + "${ind.count}", "${imageDomain}${info}");
            imageUpdateHide("imagesList", "input" + randomNum + "${ind.count}", "${info}");
            </c:forEach>
        }

        $("#express_template_id").change(function () {
            var mconfig = $("#express_template_id").find("option:selected").attr("mconfig");
            if (mconfig == undefined) {
                $("#expressDiv11").hide();
                $("#expressDiv22").hide();
            } else if (mconfig == 0) {
                $("#expressDiv11").show();
                $("#expressDiv22").hide();
            } else if (mconfig == 1) {
                $("#expressDiv11").hide();
                $("#expressDiv22").hide();
            } else if (mconfig == 2) {
                $("#expressDiv11").hide();
                $("#expressDiv22").show();
            }
        });

        $("#express_template_id").val("${productSession.express_template_id}");
        $("#express_template_id").selectpicker('refresh');
        $("#express_template_id").trigger('change');

        $("#Button1").click(function () {
            if (uploadNum >= 5) {
                MAlert("首图最多只能上传5张图片！");
                return;
            }
            var input = document.createElement("input");
            var randomNum = (new Date()).valueOf();
            input.type = "file";
            $(input).attr("name", "input" + randomNum);
            $(input).attr("id", input.name);
            $(input).css("display", "none");

            input.onchange = function () {
                $("#filediv").append(input);
                imageOperation(this.name, "");

                var $file = $(this);
                var fileObj = $file[0];
                var windowURL = window.URL || window.webkitURL;
                var dataURL;
                var $img = $("#" + this.name + "img");
                if (fileObj && fileObj.files && fileObj.files[0]) {
                    dataURL = windowURL.createObjectURL(fileObj.files[0]);
                    $img.attr('src', dataURL);
                } else {
                    dataURL = $file.val();
                    var imgObj = document.getElementById(this.name);
                    imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                    imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
                }
            };
            $(input).trigger('click');
        });

        /*默认监听表单onbulr验证*/
        $('#bwizard_Form').validationEngine({
            promptPosition: 'bottomRight',
            addPromptClass: 'formError-white',
            scroll: true,
            showOneMessage: true
        });

    });

    function imageOperation(name, value) {
        var imageStr =
            '<div class="dz-preview2"  >' +
            '<div class="dz-details">' +
            '<img name="' + name + 'img" id="' + name + 'img" src="' + value + '" />' +
            '</div>' +
            '<button class="btn btn-default btn-sm" style="padding:0px;margin:0px;width: 65px; height: 30px;" onclick="onclickDelete(this,\'' + name + '\');" >删除</button>' +
            '</div>';
        $("#filedivUl").append(imageStr);
        uploadNum = uploadNum + 1;
    }

    function imageUpdateHide(name, id, value) {
        var imageStr = '<input type="text" name="' + name + '" id="' + id + '" value="' + value + '" style="display: none;">';
        $("#filediv").append(imageStr);
    }

    function onclickDelete(obj, name) {
        $(obj).parent().remove();
        $("#" + name).remove();
        uploadNum = uploadNum - 1;
    }

    function allowGuige(value) {
        if (value == '0') {
            $("#guigeDiv").attr("class", "show");
            $("#guigeDivMM").attr("class", "hide");
            $("#guigeDiv22").attr("class", "col-sm-12 p-t-10 m-b-5  hide");
        } else {
            $("#guigeDiv").attr("class", "hide");
            $("#guigeDivMM").attr("class", "show");
            $("#guigeDiv22").attr("class", "col-sm-12 p-t-10 m-b-5  show");
        }

    }

    function showAdd(firstName, secondName) {
        $("#" + firstName).attr("class", "hide");
        $("#" + secondName).attr("class", "show");
    }

    function addProp() {
        $("#propButton").attr("disabled", true);
        var name = $("#addProp-name").val();
        var value = $("#addProp-value").val();
        if (name == "" || value == "") {
            MAlert("属性名称和值不能为空!");
            $("#propButton").removeAttr("disabled");
            return;
        }
        var url = "${pageContext.request.contextPath}/center/product/attrSave?type=0&attributeName=" + encodeURI(encodeURI(name)) + "&attributeValueName=" + encodeURI(encodeURI(value)) + "&cate_id=" + cate_id;
        $.post(url, null,
            function (result) {
                try {
                    var date = eval("(" + result + ")");
                    if (date.code == '0') {
                        var jsonMap = date.data;
                        // MAlert('添加成功！','','',function(result) {
                        showAdd('addProp', 'moreProp');
                        $("#addProp-name").val("");
                        $("#addProp-value").val("");

                        var divstr = '<div class="form-group col-sm-6  m-b-0" style="margin-bottom:0px;" id="divitems_' + jsonMap.key_id + '">'
                            + '<label class="col-sm-3 control-label  p-0 p-t-5">'
                            + name
                            + '  </label><div class="col-sm-6"> '
                            + '     <select name="mitems" id="mitems_' + jsonMap.key_id + '" class="select-search" data-size="5" >'
                            + '        <option value="" >请选择</option>'
                            + '        <option value="' + jsonMap.key_id + ":" + name + ':' + value + '" selected="selected">' + value + '</option>'
                            + '      </select>'
                            + '  </div>'
                            + '	<label class=" p-t-5">'
                            + '		<a href="#attr-modal-alert"  data-toggle="modal"  class="btn btn-default btn-icon btn-circle btn-sm" '
                            + '   			title="编辑" onclick="showProdAttrVal(' + jsonMap.key_id + ',\'' + name + '\',1)"  >'
                            + '  		<i class="icon-pencil7"></i></a>'
                            + ' 		<a class="btn btn-default btn-icon btn-circle btn-sm" onclick="deleteAttr(' + jsonMap.key_id + ');" title="删除">'
                            + '     		<i class="icon-trash"></i>'
                            + ' 		</a>'
                            + ' 	</label>'
                            + '</div>';

                        $("#attrDiv").append(divstr);
                        $("#attrDiv").addClass("show");
                        $('#mitems_' + jsonMap.key_id).selectpicker('render');
                        $('#mitems_' + jsonMap.key_id).selectpicker('refresh');
                        $('#mitems_' + jsonMap.key_id).trigger('change');
                        //  });
                    } else {
                        MAlert(date.message);
                    }
                } catch (oException) {
                    alert("和服务器交互失败:" + oException.message);
                } finally {
                    $("#propButton").removeAttr("disabled");
                }
            });
        $("#propButton").removeAttr("disabled");
    }

    function addGuige() {
        $("#guigebutton").attr("disabled", true);
        var name = $("#guige-name").val();
        var value = $("#guige-value").val();
        if (name == "" || value == "") {
            MAlert("规格名称和值不能为空!");
            $("#guigebutton").removeAttr("disabled");
            return;
        }
        var url = "${pageContext.request.contextPath}/center/product/attrSave?type=1&attributeName=" + encodeURI(encodeURI(name)) + "&attributeValueName=" + encodeURI(encodeURI(value)) + "&cate_id=" + cate_id;
        $.post(url, null,
            function (result) {
                try {
                    var date = eval("(" + result + ")");
                    if (date.code == '0') {
                        var jsonMap = date.data;
                        showAdd('addGuige', 'moreGuige');
                        $("#guige-name").val("");
                        $("#guige-value").val("");


                        var divstr = '<div class="form-group col-sm-12  m-b-0" style="margin-bottom:0px;" id="divitems_' + jsonMap.key_id + '">'
                            +'<label class="col-sm-12 control-label  p-0 p-t-5">'
                            + name
                            +' 	&nbsp;<a href="#attr-modal-alert"  data-toggle="modal" '
                            +'  		title="编辑" onclick="showProdAttrVal('+jsonMap.key_id+',\''+name+'\',2,'+skuNum+')"  >'
                            +' 		编辑</a>&nbsp;&nbsp; '
                            +' 	<a href="javascript:;"  onclick="deleteAttr('+jsonMap.key_id+',1);" title="删除">删除</a> '
                            +'  </label><div class="col-sm-12"><table style="height: 40px;border: 0px;"><tr><td  id="guivalDev_'+jsonMap.key_id+'"> '
                            + '      </td></tr></table> '
                            + '  </div> <hr class="col-sm-12 m-0 p-0" style="padding:0px;margin:0px;"> </div> ';

                        $("#guigeDiv33").append(divstr);

                        refreshRow = skuNum;
                        $("#attributeNameHide").val(name);
                        $("#attriFlag").val("2");
                        refreshSeledtProdAttrVal(jsonMap.key_id);
                        skuNum++;
                        //});
                    } else {
                        MAlert(date.message);
                    }
                } catch (oException) {
                    alert("和服务器交互失败:" + oException.message);
                } finally {
                    $("#guigebutton").removeAttr("disabled");
                }
            });
        $("#guigebutton").removeAttr("disabled");
    }

    var refreshRow = 0;
    function refreshSeledtProdAttrVal(attributeId) {
        var attvalId = $("#mitems_" + attributeId).val();
        var url = "${pageContext.request.contextPath}/center/product/attrValList?parent_id=" + attributeId;
        $.post(url, null,
            function (result) {
                try {
                    var date = eval("(" + result + ")");
                    if (date.code == '0') {
                        var attrValList = date.data;
                        if ($("#attriFlag").val() == 1) {
                            var op = "<option value='' >请选择</option>";
                            for (var i = 0; i < attrValList.length; i++) {
                                op += '  <option value="' + attributeId + ':' + $("#attributeNameHide").val() + ':' + attrValList[i].key_name + '">' + attrValList[i].key_name + '</option> ';
                            }
                            $("#mitems_" + attributeId).html(op);
                            $("#mitems_" + attributeId).val(attvalId);
                            $('#mitems_' + attributeId).selectpicker('render');
                            $('#mitems_' + attributeId).selectpicker('refresh');
                        } else {
                            var op = "";
                            for (var i = 0; i < attrValList.length; i++) {
                                op += ' <input type="checkbox"  name="mattvalids' + attrValList[i].key_id + '" class="ids' + refreshRow + '"  '
                                    + '   onclick="onclickIds()"  alt="' + $("#attributeNameHide").val() + '" hideAttrId="' + attributeId + '"  '
                                    + ' 	title="' + attrValList[i].key_name + '"    value="' + attrValList[i].key_id + '" /> '
                                    + attrValList[i].key_name + ' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '
                            }
                            $("#guivalDev_" + attributeId).html(op);
                            onclickIds();
                        }
                    } else {
                        MAlert(date.message);
                    }
                } catch (oException) {
                    alert("和服务器交互失败:" + oException.message);
                }
            });
    }

    function showProdAttrVal(attributeId, attributeName, flag, row11) {
        refreshRow = row11;
        $("#attributeId").val(attributeId);
        $("#attributeNameHide").val(attributeName);
        var tt = "名称：" + attributeName;
        ;
        if (flag == 1) {
            tt = "属性名称：" + attributeName;
            $("#type").val("0");
        }
        if (flag == 2) {
            tt = "规格名称：" + attributeName;
            $("#type").val("1");
        }
        $("#attributeNameHtml").html(tt);
        $("#attriFlag").val(flag);
        var url = "${pageContext.request.contextPath}/center/product/attrValList?parent_id=" + attributeId;
        $.post(url, null,
            function (result) {
                try {
                    var date = eval("(" + result + ")");
                    if (date.code == '0') {
                        var attrValList = date.data;
                        var tr = "";
                        for (var i = 0; i < attrValList.length; i++) {
                            tr += "<tr class='odd gradeA'><td> " + attrValList[i].key_name + "</td>"
                                + '<td><input type="button" class="btn btn-xs btn-danger" onclick="deleteAttrVal(this,' + attrValList[i].key_id + ');" value="删除"></input></td></tr>';
                        }
                        $("#levelTable").find("tbody").html(tr);
                    } else {
                        MAlert(date.message);
                    }
                } catch (oException) {
                    alert("和服务器交互失败:" + oException.message);
                }
            });
    }


    /*添加属性*/
    function addProdAttrVal() {
        $("#valButton").attr("disabled", true);
        var value = $("#attributeValueName").val();
        if ($.trim(value) == "") {
            $("#valButton").removeAttr("disabled");
            MAlert('请输入值再添加！');
            return;
        }
        var url = "${pageContext.request.contextPath}/center/product/attrValSave?cate_id=" + cate_id;
        ;
        $.post(url, $("#addAttrValForm").serialize(),
            function (result) {
                try {
                    var date = eval("(" + result + ")");
                    if (date.code == '0') {
                        var jsonMap = date.data;
                        // MAlert('添加成功！','','',function(result) {
                        $("#attributeValueName").val("");

                        var tr = "<tr><td> " + jsonMap.key_name + "</td>"
                            + '<td><input type="button" class="btn btn-xs btn-danger" onclick="deleteAttrVal(this,' + jsonMap.key_id + ');" value="删除"></input></td></tr>';

                        $("#levelTable").find("tbody").append(tr);

                        refreshSeledtProdAttrVal($("#attributeId").val());
                        //  });
                    } else {
                        MAlert(date.message);
                    }
                } catch (oException) {
                    alert("和服务器交互失败:" + oException.message);
                } finally {
                    $("#valButton").removeAttr("disabled");
                }
            });
        $("#valButton").removeAttr("disabled");
    }

    function deleteAttr(attributeId, fa) {
        MConfirm('删除不可恢复，确认要删除吗？', '', '', function (result) {
            if (result) {
                var url = "${pageContext.request.contextPath}/center/product/removeAttr?key_id=" + attributeId;
                $.post(url, null,
                    function (result) {
                        try {
                            var date = eval("(" + result + ")");
                            if (date.code == '0') {
                                //MAlert('删除成功！');
                                $('#divitems_' + attributeId).remove();
                                if (1 == fa) {
                                    onclickIds();
                                }
                            } else {
                                MAlert(date.message);
                            }
                        } catch (oException) {
                            alert("和服务器交互失败:" + oException.message);
                        }
                    });

            }
        });

    }

    function deleteAttrVal(nowTr, attributeValueId) {
        MConfirm('删除不可恢复，确认要删除吗？', '', '', function (result) {
            if (result) {
                var url = "${pageContext.request.contextPath}/center/product/removeAttrVal?key_id=" + attributeValueId;
                $.post(url, null,
                    function (result) {
                        try {
                            var date = eval("(" + result + ")");
                            if (date.code == '0') {
                                //MAlert('删除成功！');
                                $(nowTr).parent().parent().remove();
                                refreshSeledtProdAttrVal($("#attributeId").val());
                                if (refreshRow != undefined) {
                                    onclickIds();
                                }
                            } else {
                                MAlert(date.message);
                            }
                        } catch (oException) {
                            alert("和服务器交互失败:" + oException.message);
                        }
                    });
            }
        });
    }

    function firstStep() {
        if ($("input[name='spec_config']:checked").val() == "0") {
            $("#specAttributeIds").val("");
            $("#specAttributeValIds").val("");
        }
        $('#bwizard_Form').attr('action', '${pageContext.request.contextPath}/center/product/releaseOne?oneflag=1');

        //移除表单验证
        $('#bwizard_Form').validationEngine('detach');

        $("#bwizard_Form").submit();
    }

    var hideromove = "";
    function thirdStep() {
        var radio = $("input[name='spec_config']:checked").val();
        if (radio == '1') {
            hideromove = $("#guigeDiv").html();
            $("#guigeDiv").html("");
            if (rowCount == 0) {
                MAlert('多规格请至少选择一个商品规格！');
                $("#guigeDiv").html(hideromove);
                return false;
            }
        } else {
            hideromove = $("#testTable tbody").html();
            $("#testTable tbody").html("");
        }
        if (!$("#bwizard_Form").validationEngine("validate")) {
            if (radio == '1') {
                $("#guigeDiv").html(hideromove);
            } else {
                $("#testTable tbody").html(hideromove);
            }
            return false;
        }
        if ($("input[name='spec_config']:checked").val() == "0") {
            $("#specAttributeIds").val("");
            $("#specAttributeValIds").val("");
        }

        tips($("input[name='express_config']:checked").val());

        var express_config = $("input[name='express_config']:checked").val();
        if (express_config == -1) {
            $("#weight").val("0");
            $("#msize").val("0");
        } else {
            var mconfig = $("#express_template_id").find("option:selected").attr("mconfig");
            if (mconfig == undefined) {
                MAlert("请选择运费模板！");
                return false;
            } else if (mconfig == 0) {
                $("#msize").val("0");
            } else if (mconfig == 1) {
                $("#weight").val("0");
                $("#msize").val("0");
            } else if (mconfig == 2) {
                $("#weight").val("0");
            }
        }
        $('#bwizard_Form').attr('action', '${pageContext.request.contextPath}/center/product/releaseThree?oneflag=1');
        $("#bwizard_Form").submit();
    }

    //http://xiaowei-qi-epro-com-cn.iteye.com/blog/1976677
    var rowCount = 0;
    var oldCount = 0;
    var oldItemKey = new Array();
    var oldItemVal = new Array();
    function onclickIds(index, obj) {

        rowCount = 0;
        var arr = new Array();
        var arrtitle = new Array();
        var titcol = 0;
        var attidsStr = "";
        var attidsValStr = "";
        for (var i = 0; i < skuNum; i++) {
            var num = 1;
            var fa = 0;
            var arr11 = new Array();
            var valStr = "";
            var idsCheck = $("input.ids" + i);
            idsCheck.each(function (a) {
                if ($(this).prop("checked")) {
                    if (fa == 0) {
                        fa++;
                        if (attidsStr == "") {
                            attidsStr = $(this).attr("hideAttrId");
                        } else {
                            attidsStr = attidsStr + ";" + $(this).attr("hideAttrId");
                        }
                    } else {
                        num++;
                    }

                    if (valStr == "") {
                        valStr = $(this).val();
                    } else {
                        valStr = valStr + "|" + $(this).val();
                    }

                    arrtitle[titcol] = $(this).attr("alt");
                    arr11[num - 1] = $(this).val();
                }
            });
            if (arr11.length > 0) {
                arr[titcol] = arr11;
                titcol++;
            }
            if (valStr != "") {
                if (attidsValStr == "") {
                    attidsValStr = valStr;
                } else {
                    attidsValStr = attidsValStr + ";" + valStr;
                }
            }
        }

        if (oldCount != 0) {
            for (var i = 0; i < oldCount; i++) {
                var valKey = $("input[name='attValArrlist" + i + "']").val();
                var oldItemValAttr = new Array();
                oldItemValAttr[0] = $("input[name='smarketPricelist" + i + "']").val();
                oldItemValAttr[1] = $("input[name='salePricelist" + i + "']").val();
                oldItemValAttr[2] = $("input[name='stocklist" + i + "']").val();
                oldItemValAttr[3] = $("input[name='itemNumlist" + i + "']").val();
                oldItemValAttr[4] = $("input[name='itemId" + i + "']").val();

                var valflag = false;
                var oldLength = oldItemKey.length;
                for (var m = 0; m < oldLength; m++) {
                    if (valKey == oldItemKey[m]) {
                        oldItemKey[m] = valKey;
                        oldItemVal[m] = oldItemValAttr;
                        valflag == true;
                        break;
                    }
                }
                if (valflag == false) {
                    oldItemKey[oldLength] = valKey;
                    oldItemVal[oldLength] = oldItemValAttr;
                }
            }
        }
        addGuigeRow(arrtitle, arr);
        $("#rowCount").val(rowCount);
        $("#specAttributeIds").val(attidsStr);
        $("#specAttributeValIds").val(attidsValStr);

        if (oldCount != 0) {
            for (var i = 0; i < rowCount; i++) {
                var valKey = $("input[name='attValArrlist" + i + "']").val();
                for (var m = 0; m < oldItemKey.length; m++) {
                    if (valKey == oldItemKey[m]) {
                        var oldItemValAttr = oldItemVal[m];
                        $("input[name='smarketPricelist" + i + "']").val(oldItemValAttr[0]);
                        $("input[name='salePricelist" + i + "']").val(oldItemValAttr[1]);
                        $("input[name='stocklist" + i + "']").val(oldItemValAttr[2]);
                        $("input[name='itemNumlist" + i + "']").val(oldItemValAttr[3]);
                        $("input[name='itemId" + i + "']").val(oldItemValAttr[4]);
                        break;
                    }
                }
            }
        }
        oldCount = rowCount;
    }

    function addGuigeRow(arrtitle, arr) {
        if (arr.length == 0) {
            $("#testTable tbody").html("");
            return "";
        }
        $("#guigeDivMM").attr("class", "show");

        var tableHtml = '<tr class="tr_' + rowCount + '">';

        for (var i = 0; i < arrtitle.length; i++) {
            tableHtml = tableHtml + '<td class="cl1">' + arrtitle[i] + '</td>';
        }
        tableHtml = tableHtml
            + '<td class="cl1">市场价</td>'
            + '<td class="cl1">销售价</td>'
            + '<td class="cl1">库存</td>'
            + '<td class="cl1">商品编号</td>';

        var arr11 = arr[0];
        for (var i = 0; i < arr11.length; i++) {
            var val = arr11[i];
            var tr = '<tr><td class="cl1">' + ($("input[name=mattvalids" + val + "]").attr("title")) + '</td>';
            if (arr.length > 1) {
                tr = addGuigeRow22(tr, arr, 1, val);
            } else {
                tr = tr + '<td class="cl1"><input type="hidden" name="itemId' + rowCount + '"><input type="hidden" class="form-control input-sm" name="attValArrlist' + rowCount + '" id="attValArrlist' + rowCount + '" value="' + val + '" >'
                    + '<input type="number" class="form-control input-sm validate[required,custom[number]]" name="smarketPricelist' + rowCount + '" id="smarketPricelist' + rowCount + '" '
                    + ' style="width:80px" data-errormessage-value-missing="市场价不能为空" data-errormessage-custom-error="必须是金额类型" ></td>'
                    + '<td class="cl1"><input type="number" class="form-control input-sm validate[required,custom[number]]" name="salePricelist' + rowCount + '" id="salePricelist' + rowCount + '" '
                    + ' style="width:80px" data-errormessage-value-missing="销售价不能为空" data-errormessage-custom-error="必须是金额类型"></td>'
                    + '<td class="cl1"><input type="number" class="form-control input-sm validate[required,custom[integer]]" name="stocklist' + rowCount + '" id="stocklist' + rowCount + '" '
                    + ' style="width:80px" data-errormessage-value-missing="库存不能为空" data-errormessage-custom-error="必须是整数"></td>'
                    + '<td class="cl1"><input type="text" class="form-control input-sm" name="itemNumlist' + rowCount + '" id="itemNumlist' + rowCount + '" '
                    + ' style="width:120px"  ></td>';
                rowCount++;
            }
            tableHtml = tableHtml + tr;
        }
        $("#testTable tbody").html(tableHtml);
    }

    function addGuigeRow22(tr, arr, m, vids) {
        var html = "";
        var arr11 = arr[m];
        for (var i = 0; i < arr11.length; i++) {
            var val = arr11[i];
            var td = tr + '<td class="cl1">' + ($("input[name=mattvalids" + val + "]").attr("title")) + '</td>';
            val = vids + ";" + val;
            if (arr.length > (m + 1)) {
                td = addGuigeRow22(td, arr, m + 1, val);
            } else {
                td = td + '<td class="cl1"><input type="hidden" name="itemId' + rowCount + '"> <input type="hidden" class="form-control input-sm" name="attValArrlist' + rowCount + '" id="attValArrlist' + rowCount + '" value="' + val + '" >'
                    + '<input type="number" class="form-control input-sm validate[required,custom[number]]" name="smarketPricelist' + rowCount + '" id="smarketPricelist' + rowCount + '" '
                    + ' style="width:80px" data-errormessage-value-missing="市场价不能为空" data-errormessage-custom-error="必须是金额类型" ></td>'
                    + '<td class="cl1"><input type="number" class="form-control input-sm validate[required,custom[number]]" name="salePricelist' + rowCount + '" id="salePricelist' + rowCount + '" '
                    + ' style="width:80px" data-errormessage-value-missing="销售价不能为空" data-errormessage-custom-error="必须是金额类型"></td>'
                    + '<td class="cl1"><input type="number" class="form-control input-sm validate[required,custom[integer]]" name="stocklist' + rowCount + '" id="stocklist' + rowCount + '" '
                    + ' style="width:80px" data-errormessage-value-missing="库存不能为空" data-errormessage-custom-error="必须是整数"></td>'
                    + '<td class="cl1"><input type="text" class="form-control input-sm" name="itemNumlist' + rowCount + '" id="itemNumlist' + rowCount + '" '
                    + ' style="width:120px"  ></td>';
                rowCount++;
            }
            html = html + td;
        }
        return html;
    }

    function tips(type) {
        if (type == 0) {
            $("#expressDiv").show();
            $("#expressMoneyDiv").hide();
        } else {
            $("#expressMoneyDiv").show();

            $("#express_template_id").val("");
            $("#express_template_id").selectpicker('refresh');
            $("#express_template_id").trigger('change');

            $("#expressDiv").hide();
            $("#expressDiv11").hide();
            $("#expressDiv22").hide();
        }
    }

</script>