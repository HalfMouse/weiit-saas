<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<style type="text/css">
ul{
    margin-left:0px;
    padding-left:0px;
    display:inline;
    white-space: nowrap;
}
ul li{
    padding: 0px;
    display: inline-block;
    background:pink;
    white-space:nowrap;
    cursor: pointer;
}
ul li :hover{
    border:2px red solid;
}

#onlickImg{
    border:2px red solid;
}
</style>
<form class="form-horizontal"  name="searchform" id="searchform"
      action="" method="post" >
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">

    <!-- Content area -->
    <div class="content"  style="padding:0px;margin:0px;">
        <!-- Bordered striped table -->
        <div class="panel panel-flat">
            <div class="panel-body" >
                <div class="col-md-12">
                    <div class="input-group">
                        <h3 style="font-size: 28px; color: #000000">${articleInfo.title}</h3>
                    </div>
                    <div class="input-group">
                        <span style="color: #7c7f83">${articleInfo.create_time}</span>
                    </div>
                </div>
                <br><br><br><br><br><br><br>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="input-group">
                            ${articleInfo.main_body}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /bordered striped table -->
    </div>
    <!-- /content area -->
</div>
<!-- /main content -->
</form>
<%@include file="../common/footer.jsp" %>
<script>

</script>
