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
						<li><a href="${pageContext.request.contextPath}/center/service/list" style="border-left:0px;border-top:0px;">收费服务项目</a></li>
						<li><a href="${pageContext.request.contextPath}/center/service/orderTimeConfig">订购时长配置</a></li>
						<li class="active"><a href="${pageContext.request.contextPath}/center/service/versionList">版本收费配置</a></li>
					</ul> 
					<!-- /tabs -->
							
					<!-- 表单验证开始 -->
					<div class="panel panel-flat" style="margin-top:-20px;border-top:0px;">
						<div class="panel-body">
							<div style="float:left;">
								<a href="${pageContext.request.contextPath}/center/service/versionAdd" class="btn bg-blue">新增版本收费</a>
							</div> 	
						</div>
						<form class="form-horizontal"  name="searchform" id="searchform" action="${pageContext.request.contextPath}/center/service/versionList" method="post" >	
							<div class="table-responsive">
								<table  id="data-table"  class="table">
									<thead>
										<tr > 
											<th class="text-center">版本编号</th> 
											<th class="text-center">版本名称</th> 
											<th class="text-center">版本原价</th>
											<th class="text-center">官方价格</th>
											<th class="text-center">渠道价格</th>
											<th class="text-center">版本服务列表</th>
											<th class="text-center">版本描述</th>
											<th class="text-center">操作人</th>
											<th class="text-center">状态</th>
											<th width="80" class="text-center">操作</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${pageInfo.list}" var="info">
					                    <tr>
					                        <td class="text-center">${info.version_num}</td>
					                        <td class="text-center">${info.version_name}</td>
					                        <td class="text-center">${info.smarket_price}</td>
					                        <td class="text-center">${info.sale_price}</td>
					                        <th class="text-center">${info.supply_price }</th>
					                        <th class="text-center">
					                        	<c:forEach items="${info.versionServiceList }" var="ser">
					                        		${ser.service_name }[${ser.service_num }]<br>
					                        	</c:forEach>
					                        	<a  class="btn btn-warning m-r-5 m-b-5" style="height: 22px; padding-top: 0px;" onclick="editService('${info.version_num}')" data-toggle="modal" data-target="#versionService">编辑服务</a>
					                        </th>
					                        <td class="text-center">${info.version_desc}</td>
					                        <td class="text-center">${info.update_manager_name}</td>
					                        <td class="text-center">
					                           	<c:if test="${info.state ==0}">
					                           		<a href="javascript:;" title="点击停用" class="btn btn-success m-r-5 m-b-5"
														style="height: 22px; padding-top: 0px;"
														onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.version_name}',-1)">启用</a>
					                           	</c:if>
					                           	<c:if test="${info.state==-1}">
													<a href="javascript:;" title="点击启用" class="btn btn-warning m-r-5 m-b-5"
														style="height: 22px; padding-top: 0px;"
														onclick="mUpdate(${info.validate_id},'${info.validate_id_token}','${info.version_name}',0)">停用</a>
												</c:if>
					                        </td>
					                        <td class="text-center"> 
												<ul class="icons-list">
													<li><a href="${pageContext.request.contextPath}/center/service/editVersion?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}" title="编辑" >
														<i class="icon-pencil7"></i></a></li> 
												</ul>
											</td>
					                    </tr>
					                </c:forEach>
									</tbody>
								</table>
								<div id="pager" class="panel-body"></div>
							</div>
						 </form>
					</div>
					<!-- /form validation -->
					
					<div id="versionService" class="modal fade">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="width: 400px;">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">授权服务</h5>
								</div>

								<form action="${pageContext.request.contextPath}/center/service/addVersionService" id="infoForm" class="form-horizontal" method="post">
									<div class="modal-body">
										<div class="form-group">
											<div class="col-sm-10">
												<c:forEach items="${serviceList }" var="ser">
												<input type="checkbox" name="service_num" class="validate[required,minCheckbox[2]]" value="${ser.service_num }"/>${ser.service_name }[${ser.service_num }] 
												&nbsp;&nbsp;
												</c:forEach>
												
											</div>
										</div>
									</div>

									<div class="modal-footer" style="text-align: center;">
										<input type="hidden" name="version_num" id="version_num" value=""/>
										<button type="button" id="save_btn" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
									</div>
								</form>
							</div>
						</div>
					</div>		
				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			<%@include file="../common/footer.jsp" %>
<script> 
 $(function(){
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
	 
 }); 
function mUpdate(id,validate_id_token,name,state){
	var title="";
	if(state=="-1"){
		title='确定要停用该版本 <label style="color: red;">'+name+'</label> 吗？';
	}
	if(state=="0"){
		title='确定要启用该版本 <label style="color: red;">'+name+'</label> 吗？';
	}
	MConfirm(title,'','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/service/versionState?state="+state+"&validate_id="+id+"&validate_id_token="+validate_id_token;
		}
	});
}

function editService(version_num){
	$("#version_num").val(version_num);
}

</script>
			
