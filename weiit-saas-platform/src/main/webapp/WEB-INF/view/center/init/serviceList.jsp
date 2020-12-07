<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
 
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 收费服务项目 </span>
							</h4>
						</div>
					</div>  
				</div>
				<!-- /page header -->
				
				<!-- Content area -->
				<div class="content"> 
				 
					<!-- Tabs -->
					<ul class="nav  nav-tabs"> 
						<li class="active"><a href="${pageContext.request.contextPath}/center/service/list" style="border-left:0px;border-top:0px;">收费服务项目</a></li>
						<li><a href="${pageContext.request.contextPath}/center/service/orderTimeConfig">订购时长配置</a></li>
						<li><a href="${pageContext.request.contextPath}/center/service/versionList">版本收费配置</a></li>
					</ul> 
					<!-- /tabs -->
							
					<!-- 表单验证开始 -->
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<div style="float:left;">
								<a href="${pageContext.request.contextPath}/center/service/add" class="btn bg-blue">新增服务项目</a>
							</div> 	
						</div>
						<form class="form-horizontal"  name="searchform" id="searchform" 
							action="${pageContext.request.contextPath}/center/service/list" method="post" >	
							<div class="table-responsive">
								<table  id="data-table"  class="table">
									<thead>
										<tr > 
											<th>服务项目编号</th> 
											<th>服务项目名称</th> 
											<th>服务项目原价</th>
											<th>服务项目当前价</th>
											<th>服务类型</th>
											<th>操作人</th>
											<th>状态</th>
											<th>排序编号</th>
											<th width="80">操作</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${pageInfo.list}" var="info">
					                    <tr>
					                        <td>${info.service_num}</td>
					                        <td>${info.service_name}</td>
					                        <td>${info.service_smarket_price}</td>
					                        <td>${info.service_price}</td>
					                        <td>
					                        <span class="text-danger">
					                        	<c:if test="${info.type==1 }">常规营销</c:if>
					                        </span>
					                        <span class="text-blue">
					                        	<c:if test="${info.type==2 }">场景营销</c:if>
					                        </span>
					                        </td>
					                        <td>${info.update_manager_name}</td>
					                        <td>
					                           	<c:if test="${info.state ==0}">
					                           		<a href="javascript:;" title="点击停用" class="btn btn-success m-r-5 m-b-5"
														style="height: 22px; padding-top: 0px;"
														onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.service_num}',-1)">启用</a>
					                           	</c:if>
					                           	<c:if test="${info.state==-1}">
													<a href="javascript:;" title="点击启用" class="btn btn-warning m-r-5 m-b-5"
														style="height: 22px; padding-top: 0px;"
														onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.service_num}',0)">停用</a>
												</c:if>
												<a href="${pageContext.request.contextPath}/center/service/editSortNum?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" title="点击置顶" class="btn btn-success m-r-5 m-b-5" style="height: 22px; padding-top: 0px;">置顶</a>
					                        </td>
					                        <td>${info.sort_num }</td>
					                        <td>
												<ul class="icons-list">
													<li><a href="${pageContext.request.contextPath}/center/service/edit?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" title="编辑" ><i class="icon-pencil7"></i></a></li> 
												</ul>
											</td>
					                    </tr>
					                </c:forEach>
									</tbody>
								</table>
							</div>
							<div id="pager" class="panel-body"></div>
						 </form>
					</div>
					<!-- /form validation -->
							
				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
<script> 
$(document).ready(function() {
    $("#pager").pager({
        pagenumber: ${pageInfo.pageNum}, 
        pagecount: ${pageInfo.pages},
        pagesize: ${pageInfo.pageSize} ,
        pagerecordSize: ${pageInfo.total},
        buttonClickCallback: searchSubmit });
});
  
function mUpdate(id,validate_id_token,name,state){
	var title="";
	if(state=="-1"){
		title='确定要停用服务项目 <label style="color: red;">'+name+'</label> 吗？';
	}
	if(state=="0"){
		title='确定要启用服务项目 <label style="color: red;">'+name+'</label> 吗？';
	}
	MConfirm(title,'','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/service/state?state="+state+"&validate_id="+id+"&validate_id_token="+validate_id_token;
		}
	});
}

</script>
			
