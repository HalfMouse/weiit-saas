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
                   <%-- <li><a href="${pageContext.request.contextPath}/center/ump/scene"><i
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

        <div class="row">
            <div class="col-md-12">
                <!-- 表单验证开始 -->
                <div class="panel panel-flat">

                    <div class="panel-body">

                        <div class="auto">
                            <form class="form-horizontal form-validate-jquery">
                                <fieldset class="content-group">
                                    <legend class="text-bold">
                                        <h5>优惠券扫码领取</h5>
                                        <span class="text-muted">说明：想要给您的客户派送优惠券，您可通过发送链接或二维码的方式给客户领取优惠券.</span>
                                    </legend>
                                    <c:if test="${!empty sessionScope.couponMpQrcode}">
                                        <div class="form-group">
                                            <label class="control-label col-md-1 text-bold">领取链接:</label>
                                            <div class="col-lg-3">
                                                <div class="input-group">
                                                    <input type="text" name="input_group" class="form-control" readonly
                                                           value="${sessionScope.couponMpQrCodeUrl}"
                                                           placeholder="">
                                                    <div class="input-group-addon clipboard">复制</div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="form-group ">
                                        <c:if test="${!empty sessionScope.couponMpQrcode}">
                                            <label class="control-label col-md-1 text-bold">公众号领取二维码:</label>
                                            <div class="col-md-3 text-bold">
                                                <img src="${sessionScope.couponMpQrcode}"/>
                                            </div>
                                        </c:if>

                                        <c:if test="${!empty sessionScope.couponMaQrcode}">
                                            <label class="control-label col-md-1 text-bold">小程序领取二维码:</label>
                                            <div class="col-md-3 text-bold">
                                                <img style="width: 168px;" src="${sessionScope.couponMaQrcode}"/>
                                            </div>
                                        </c:if>

                                    </div>
                                </fieldset>
                            </form>
                        </div>

                        <form class="form-horizontal" name="searchform" id="searchform"
                              action="${pageContext.request.contextPath}/center/ump/coupons/couponsGive" method="post">
                            <input type="hidden" name="validate_id" id="validate_id" value="${queryParam.validate_id}"/>
                            <input type="hidden" name="validate_id_token" id="validate_id_token"
                                   value="${queryParam.validate_id_token}"/>
                            <div class="give">
                                <legend class="text-bold">
                                    <h5>优惠券手工派送</h5>
                                    <span class="text-muted">说明：除上面自动领取优惠券外，您还可以给您的客户以手工方式派送优惠券.</span>
                                </legend>
                                <div style="margin-left: -10px;">
                                    <div class="col-md-3">
                                        <div class="input-group">
                                            <span class="input-group-addon">会员昵称</span> <input type="text"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               name="user_name"
                                                                                               value="${queryParam.user_name}">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="input-group">
                                            <span class="input-group-addon">会员账号</span> <input type="text"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               name="user_account"
                                                                                               value="${queryParam.user_account}">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="input-group">
                                            <span class="input-group-addon">手机</span> <input type="text"
                                                                                             class="form-control"
                                                                                             placeholder=""
                                                                                             name="user_phone"
                                                                                             value="${queryParam.user_phone}">
                                        </div>
                                    </div>
                                </div>
                                &nbsp;&nbsp;
                                <button class="btn bg-blue" type="submit">搜索</button>
                                <br> <br>
                                <div class="table-responsive">
                                    <table id="data-table"
                                           class="table">
                                        <thead>
                                        <tr>
                                            <th><input type="checkbox" class="styled" name="allCheck"
                                                       onclick="allCheckClick(this)" value="0"/></th>
                                            <th class="user_column_user_account">会员/昵称</th>
                                            <th class="user_column_user_name">会员账号</th>
                                            <th class="user_column_user_phone">手机</th>
                                            <th class="user_column_user_create_time">注册时间</th>
                                            <th class="user_column_user_disabled">是否拥有</th>
                                            <th width="80">操作</th>
                                        </tr>
                                        </thead>
                                        <c:forEach items="${pageInfo.list}" var="user">
                                            <tr>
                                                <td><input type="checkbox" class="styled" name="ids"
                                                           value="${user.user_id}"></td>
                                                <td><img src="${user.user_img}" width="40"
                                                         height="40"/>&nbsp;&nbsp;${user.user_name }</td>
                                                <td>${user.user_account }</td>
                                                <td>${user.user_phone }</td>
                                                <td><fmt:formatDate value="${user.create_time}"
                                                                    pattern="yyyy-MM-dd hh:mm:ss"/></td>
                                                <td>
                                                    <c:if test="${user.give_count>0 }"><span
                                                            class="text-blue">已拥有</span></c:if>
                                                    <c:if test="${user.give_count==null }"><span
                                                            class="text-muted">无</span></c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${user.give_count>0 }"><a href="javascript:;" title="派发"
                                                                                          onclick="sendCoupon('${user.user_id}','${user.user_name}')"
                                                                                          class="btn bg-orange m-r-5 m-b-5"
                                                                                          style="height: 22px; padding-top: 0px;">继续派送</a></c:if>
                                                    <c:if test="${user.give_count==null }"><a href="javascript:;"
                                                                                              title="派发"
                                                                                              onclick="sendCoupon('${user.user_id}','${user.user_name}')"
                                                                                              class="btn bg-success m-r-5 m-b-5"
                                                                                              style="height: 22px; padding-top: 0px;">派给他/她</a></c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>

                                </div>
                                <c:if test="${fn:length(pageInfo.list)>=10}">
                                    <div id="pager" class="panel-body">
                                        <div style="margin-left: -20px; margin-bottom: 20px;">
                                            <label class="btn btn-default">
                                                <input type="checkbox" class="styled" name="selectAll"
                                                       onclick="allCheckClick(this)" value="1"/>&nbsp;全选/不选
                                            </label>&nbsp;&nbsp;&nbsp;
                                            <button type="button" onclick="BatchCoupon()" class="btn btn-default"
                                                    data-toggle="modal" data-target="#remove_batch_modal">
                                                批量派送
                                            </button>
                                            &nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-default" onclick="allCoupon()"><i
                                                    class="icon-paperplane"></i> 全部派发
                                            </button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </form>

                    </div>
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

    function allCoupon(id, name) {
        MConfirm('确定要给查询全部用户派送吗？', '', '', function (result) {
            if (result) {
                var url = "${pageContext.request.contextPath}/center/ump/coupons/couponsGiveSave?type=2";
                $('#searchform').attr("action", url);
                $('#searchform').submit();
            }
        });
    }
    function BatchCoupon() {
        var idStr = "";
        var idsCheck = $("#data-table input[name='ids']");
        idsCheck.each(function (i) {
            if ($(this).prop("checked")) {
                if (idStr == "") {
                    idStr = $(this).val();
                } else {
                    idStr = idStr + "," + $(this).val();
                }
            }
        });
        if (idStr == "") {
            MAlert('请至少选择一个用户进行派送！');
            return;
        }
        MConfirm('确认对选择用户批量派送优惠券吗？', '', '', function (result) {
            if (result) {
                window.location = "${pageContext.request.contextPath}/center/ump/coupons/couponsGiveSave?type=1&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&userIds=" + idStr;
            }
        });
    }

    function sendCoupon(userId, userName) {
        MConfirm('确定要给用户<label style="color: red;">' + userName + '</label> 派送优惠券吗？', '', '', function (result) {
            if (result) {
                window.location = "${pageContext.request.contextPath}/center/ump/coupons/couponsGiveSave?type=0&validate_id=${queryParam.validate_id}&validate_id_token=${queryParam.validate_id_token}&user_id=" + userId;
            }
        });
    }

</script>