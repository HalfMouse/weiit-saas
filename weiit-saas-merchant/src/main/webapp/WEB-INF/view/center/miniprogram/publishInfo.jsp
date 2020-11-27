<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@include file="../common/header.jsp" %>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=Ot8m2eR2tQI4lg1lUxtjGnwuFwFIn2US"></script>
<style>
    .anchorBL {
        display: none;
    }
</style>
<!-- Secondary sidebar -->
<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
    <div class="sidebar-content">
        <!-- Sub navigation -->
        <div class="sidebar-category">
            <div class="category-content no-padding">
                <ul class="navigation navigation-alt navigation-accordion">
                    <li><a href="${pageContext.request.contextPath}/center/miniprogram/miniPublicInfo"><i
                            class="icon-gear"></i>小程序设置</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/center/miniprogram/publishInfo"><i
                            class="icon-store"></i>小程序管理</a></li>
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
                    <li class="active"><a href="publishInfo" style="border-left:0px;border-top:0px;"><i
                            class="icon-home8 position-left"></i>小程序发布</a></li>
                </ul>
                <!-- /tabs -->

                <div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">

                    <div class="panel-body">
                        <div class="profile">
                            <fieldset class="content-group">
                                <div class="form-group">
                                    <div class="col-md-3" style="margin-left: 1rem; ">
														<span class="text-bold text-muted">
														    <br>授权状态:
													        <span class="text-success text-bold"><i
                                                                    class="icon-shield-check"></i>已认证</span>
                                                            <br><br>
                                                            APPID:${sessionScope.miniPublicInfo.authorizer_app_id}<br><br>
															授权时间:<fmt:formatDate value="${sessionScope.miniPublicInfo.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/><br><br>
															公司主体:${sessionScope.miniPublicInfo.principal_name}<br><br>
														</span>
                                    </div>
                                </div>
                            </fieldset>


                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <!-- Hover rows -->
                                        <div class="panel panel-flat">
                                            <div class="panel-heading">
                                                <h2 class="panel-title">发布小程序</h2>
                                                <form class="steps-basic wizard clearfix" action="#" role="application"
                                                      id="steps-uid-0">
                                                    <div class="steps clearfix">
                                                        <ul role="tablist">
                                                            <li role="tab" class="first current" aria-disabled="false"
                                                                aria-selected="true"><a id="steps-uid-0-t-0"
                                                                                        href="#"
                                                                                        aria-controls="steps-uid-0-p-0"><span
                                                                    class="current-info audible">current step: </span><span
                                                                    class="number">1</span> 发布小程序</a>
                                                            </li>
                                                                <li role="tab" ${currentAuthInfo.status eq 1?"class='error'":"class='current'"} aria-disabled="true" aria-selected="true"><a
                                                                        id="steps-uid-0-t-1" href="#"
                                                                        aria-controls="steps-uid-0-p-1">
                                                                    <span class="current-info audible">current step: </span>
                                                                    <span
                                                                            class="number">2</span>
                                                                    <c:if test="${currentAuthInfo.status eq 0}">审核通过</c:if>
                                                                    <c:if test="${currentAuthInfo.status eq 1}"><span class="text-danger">审核失败</span></c:if>
                                                                    <c:if test="${currentAuthInfo.status eq 2}">审核中</c:if>
                                                                </a></li>
                                                            <li role="tab" class='<c:if test="${currentAuthInfo.status ne 0}">disable</c:if> <c:if test="${currentAuthInfo.status eq 0}">current</c:if>' aria-disabled="true"><a
                                                                    id="steps-uid-0-t-2" href="#steps-uid-0-h-2"
                                                                    aria-controls="steps-uid-0-p-2"><span
                                                                    class="number">3</span>正式上线</a></li>

                                                        </ul>
                                                    </div>
                                                </form>

                                                <a class="heading-elements-toggle"><i class="icon-menu"></i></a><a
                                                    class="heading-elements-toggle"><i class="icon-menu"></i></a></div>

                                            <div class="table-responsive">
                                                <table class="table table-lg text-nowrap">
                                                    <tbody>
                                                    <tr style="height: 230px" >
                                                        <td class="col-md-5">
                                                            <div class="col-md-2" style="margin-left: 6rem;">
                                                                <div class="content-group">
                                                                    <h6 class="text-semibold no-margin">版本号</h6>
                                                                    <h3 class="text-bold text-size-small text-success">${currentAuthInfo.version_no}</h3>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div class="content-group">
                                                                    <h6 class="text-semibold no-margin">提交时间 &nbsp;&nbsp;&nbsp; <span
                                                                            class="text-muted text-size-small text-center"><fmt:formatDate value="${currentAuthInfo.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                                                    </h6>
                                                                    <br>
                                                                    <h6 class="no-margin">状态  &nbsp;&nbsp;&nbsp;
                                                                        <c:if test="${currentAuthInfo.status ne 0}">
                                                                        <span class="text-success"><i class="icon-shield-check"></i>审核中</span>
                                                                        </c:if>
                                                                        <c:if test="${currentAuthInfo.status eq 0}">
                                                                         <span class="text-success"><i class="icon-shield-check"></i>已经上线</span>
                                                                        </c:if>
                                                                    </h6>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="text-left col-md-1">
                                                            <a href="javascript:;" class="btn bg-success-300" onclick="hoverShowDiv(this)"><i class="icon-mobile position-left"></i><span class="text-suuccess">获取体验二维码</span></a>&nbsp;
                                                        </td>
                                                        <td class="text-left col-md-6">
                                                            <div style="border:1px solide #aaccff;display:none;" id="divTestQrCode">
                                                                <span class="text-success">请用微信扫一扫!</span><br/>
                                                                <img id="miniQrcode" style="width: 180px" src=""/>
                                                            </div>

                                                        </td>
                                                        <%--<td class="text-right col-md-5">--%>
                                                            <%--<c:if test="${currentAuthInfo.status ne 0}"><a href="#" class="btn bg-success-300 disable"><i class="icon-statistics position-left"></i>审核中</a></c:if>--%>
                                                            <%--<c:if test="${currentAuthInfo.status eq 0}"><a href="#" class="btn bg-success-300 disable"><i class="icon-statistics position-left"></i>运营中</a></c:if>--%>
                                                        <%--</td>--%>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>


                                        </div>
                                        <!-- /hover rows -->
                                    </div>
                                    <div class="col-md-12">


                                        <!-- Hover rows -->
                                        <div class="panel panel-flat">
                                            <div class="panel-heading">
                                                <h5 class="panel-title">小程序体验用户 <a href="#user-modal-add" data-toggle="modal" class="bg-blue btn-rounded  btn-xs">新增</a>
                                                </h5>

                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-hover table-responsive">
                                                    <thead>
                                                    <tr>
                                                        <th>微信号</th>
                                                        <th>添加时间</th>
                                                        <th>操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach items="${testUserList }" var="user"
                                                               varStatus="status">
                                                        <tr>
                                                            <td>${user.wechat_id }</td>
                                                            <td><fmt:formatDate value="${user.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                            <td>
                                                                <a href="javascript:;" onclick="WIremove(${user.validate_id},'${user.validate_id_token}','${user.nick_name}','${user.wechat_id}')" class=" btn-danger btn-xs m-r-5" >删除</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /hover rows -->
                                    </div>

                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <!-- /form validation -->
            </div>
        </div>


    </div>
    <!-- /content area -->

</div>

<div class="modal fade" id="user-modal-add" role="dialog">
    <div class="modal-dialog" style="width: 500px;height: 220px">
        <div class="modal-content" style="height: 200px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">添加体验用户</h4>
            </div>
            <div class="modal-body">
                <div class="alert  m-b-0">
                    <form class="form-horizontal" method="post">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">微信号</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="wechat_id"
                                           name="wechat_id" placeholder="请输入微信号">
                                </div>
                                <br><br>
                              <%--  <label class="col-sm-3 control-label">昵称</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="nick_name"
                                           name="nick_name" placeholder="请输入备注昵称">
                                </div>--%>
                                <div class="col-sm-10" style="margin-top: 15px">
                                    <label class="col-sm-5 control-label"></label>
                                    <a class="btn-success btn-sm" id="addButton"
                                            onclick="addTestUser()">添加
                                    </a>
                                </div>

                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- /main content -->
<%@include file="../common/footer.jsp" %>



<script>

    function WIremove(id,token,name,wechat_id){
        MConfirm('确定要删除<label style="color: red;">'+name+'</label> 吗？','','',function(result) {
            if(result){
                window.location="${pageContext.request.contextPath}/center/miniprogram/delTestUser?validate_id="+id+"&validate_id_token="+token+"&wechat_id="+wechat_id;
            }
        });
    }

    function addTestUser() {
        $("#addButton").attr("disabled", true);
        var wechat_id = $("#wechat_id").val();
        if ($.trim(wechat_id) == "") {
            $("#addButton").removeAttr("disabled");
            MAlert('请输入微信号！');
            return;
        }

      /*  var  nick_name= $("#nick_name").val();
        if ($.trim(nick_name) == "") {
            $("#addButton").removeAttr("disabled");
            MAlert('请输入昵称！');
            return;
        }*/
        var url = "${pageContext.request.contextPath}/center/miniprogram/addTestUser?wechat_id=" + wechat_id;

        window.location=url;
        $("#valButton").removeAttr("disabled");
    }

    function hoverShowDiv(obj) {
        var miniQrcode = $("#miniQrcode").attr("src");
        console.log("miniCode"+miniQrcode);
        if (miniQrcode ==""){
            $.get("${pageContext.request.contextPath}/center/miniprogram/getQrcode", function (res) {
                console.log("res"+res);
                $("#miniQrcode").attr("src",res);

            });
        }
        $("#divTestQrCode").show();
    }

</script>


