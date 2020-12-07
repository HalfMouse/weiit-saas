<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
	<!-- Page header -->
	<div class="page-header">
		<div class="breadcrumb-line">
			<ul class="breadcrumb">
				<li><a href="#"><i class="icon-home2 position-left"></i>系统管理</a></li>
				<li><a href="#">角色管理</a></li>
				<li class="active">角色权限编辑</li>
			</ul>
			<ul class="breadcrumb" style="float:right;margin-right:30px;">
				<li><a href="javascript:history.back(-1)"><i class="icon-arrow-left16 position-left"></i>返回</a></li>
			</ul>
		</div>
	</div>
	
	<!-- Content area -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
		 	<div class="panel-heading" >
				<h5 class="panel-title text-default text-bold" style="color:white;">角色权限编辑</h5>
			</div>
			
			<form class="form-horizontal form-validate-jquery" id="infoForm" name="infoForm"
			 		action="${pageContext.request.contextPath}/center/system/role/saveAuthorize" method="post" >
				<input type="hidden" name="validate_id" id="validate_id" value="" />
				<input type="hidden" name="validate_id_token" id="validate_id_token" value="" />	 
			<div class="panel-body">
				<div class="table-responsive">
					<table  id="data-table"  class="table table-striped table-hover table-bordered  nowrap dataTable">
						<thead>
							<tr > 
								<th>资源名称</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${menuList}" var="menu">
							    <tr>
							    	<td style="word-break:keep-all;"  >
							    		<label class="checkbox-inline" style="padding-left:15px;">
							    			<input type="checkbox" name="resources" class="parCheck${menu.resource_id}" onclick="onclickPar(this)" value="${menu.resource_id }">${menu.resource_name}
							    		</label>
							    	</td>
							    	<td>
							    	
							    	</td>
			                    </tr>
		                	<c:forEach items="${menu.children}" var="child">
		                		<tr>
						    		<td style="word-break:keep-all" >
							    		<label class="checkbox-inline" style="padding-left:45px;">
							    			<input type="checkbox" name="resources" class="childCheck${menu.resource_id}" onclick="onclickPar(this,${menu.resource_id})" value="${child.resource_id }">${child.resource_name}
							    		</label>
							    	</td>
							    	<td>
							    	<c:forEach items="${child.childrenButton}" var="button">
			                        	<label class="checkbox-inline" style="padding-left:15px;">
					                      	<input type="checkbox" name="resources" class="ids${child.resource_id}" onclick="onClickButton(this,${child.resource_id},${menu.resource_id})" value="${button.resource_id }">${button.resource_name}&nbsp;&nbsp;&nbsp;
					                   	</label>
					                </c:forEach>
							    	</td>
						    	</tr>
						    </c:forEach>
						    </c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="text-center" style="padding-top: 10px;">
					<button type="button" onclick="saveButton(this,'数据提交中，请稍后！')" class="btn btn-primary">保存<i class="icon-checkmark3 position-right"></i></button>
					&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)" id="qua1" class="btn btn-default" >返回<i class="icon-undo2 position-right"></i></a>	
				</div>
			
			</div>
			</form>
		</div> 
		<!-- /bordered striped table -->
	</div>
	<!-- /content area -->
</div>
<!-- /main content -->
<%@include file="../common/footer.jsp" %>
<script>
 
$(document).ready(function() {
	$("#validate_id").val("${queryParam.validate_id}");
	$("#validate_id_token").val("${queryParam.validate_id_token}");
	
	<c:forEach items="${resourcesList}" var="infoMap">
       	$("input[name=resources][value=${infoMap.resource_id}]").attr("checked",true);
	</c:forEach>
	
});
 
function onclickPar(obj,parId){
	//复选框选中 则下级复选框选中
	if(parId==null){
		$(".childCheck"+$(obj).val()).prop("checked",$(obj).prop("checked"));
		$(".childCheck"+$(obj).val()).each(function(){
			if(!$(this).prop("checked")){
				$(".ids"+$(this).val()).prop("checked",$(this).prop("checked"));
			}
		});
	}else{
		var parCheckFlag=false;
		$("."+$(obj).prop("class")).each(function(){
			if($(this).prop("checked")){
				parCheckFlag=true;
			}
		});
		$(".parCheck"+parId).prop("checked",parCheckFlag);
		if(!$(obj).prop("checked")){
			$(".ids"+$(obj).val()).prop("checked",$(obj).prop("checked"));
		}
	}
	
}
 


function onClickButton(obj,parId,twoParId){
	//按钮选中状态判断上级是否菜单的状态
	var parCheckFlag=false;
	$("."+$(obj).prop("class")).each(function(){
		if($(this).prop("checked")){
			parCheckFlag=true;
		}
	});
	//按钮被选中才将上级所有菜单选中，按钮取消选中不取消上级菜单的选中
	if(parCheckFlag){
		$(".childCheck"+twoParId).each(function(){
			if($(this).val()==parId){
				$(this).prop("checked",parCheckFlag);
				onclickPar($(this),twoParId);
			}
		});
	}
}
</script>