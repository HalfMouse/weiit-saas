<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="weiyun" uri="http://shiro.apache.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>资源管理</title>

	<link href="${pageContext.request.contextPath}/resource/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resource/css/minified/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resource/css/minified/core.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resource/css/minified/components.min.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/resource/css/minified/colors.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/libraries/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/loaders/blockui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/core/libraries/jquery-1.3.2.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/plugins/grid/treeGrid.js"></script>
	
	
	
</head>

<body>
	<div class="page-container">
		<div class="page-content">
			<div class="content-wrapper">
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 系统管理 </span>
							</h4>
						</div>
					</div>
					<div class="breadcrumb-line">
						<ul class="breadcrumb">
							<li><a href="index.html"><i
									class="icon-home2 position-left"></i> 系统管理</a></li>
							<li class="active">资源管理</li>
						</ul>
						<ul class="breadcrumb-elements">
							<weiyun:hasPermission name="resource:insert">
							<li><button type="button"class="btn btn-info" style="border-radius:0;" onclick='WIADD()' data-toggle='modal'  data-target='#edit_modal'><i class="icon-add position-left"></i>创建资源</button></li>
							</weiyun:hasPermission>
							
						</ul>
					</div>
				</div>
				
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
							<div id="div1"></div>
					</div>
					<!-- /bordered striped table -->
					
				</div>
				

				<!-- Edit modal -->
				<div id="edit_modal" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">编辑资源</h5>
							</div>
	
							<div class="modal-body">
								<form class="form-horizontal form-validate-jquery" action="${pageContext.request.contextPath}/center/system/resource/save" method="post">
										<fieldset class="content-group">
											<div class="form-group">
												<label class="control-label col-md-2">资源类型</label>
												<div class="col-md-6">
													<select class="form-control" name="type" id="type" onchange="chanageType(this.value)">
													<option value="1">左侧菜单</option>
													<option value="2">个人信息菜单</option>
													<option value="3">页面按钮</option>
													</select>
												</div>
											</div>
											<!--弧形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2">菜单名称 </label>
												<div class="col-md-9">
													<input type="text" class="form-control input-rounded" name="resource_name" required="required" >
												</div>
											</div>
											<!-- /弧形输入框 -->
											
											<!--长方形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2">菜单URL</label>
												<div class="col-md-9">
													<input type="text" class="form-control input-roundless" name="rest_url" >
												</div>
											</div>
											<!-- /长方形输入框 -->
											
											<!--长方形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2">菜单图标</label>
												<div class="col-md-9">
													<input type="text" class="form-control input-roundless" name="css_icon" required="required">
												</div>
											</div>
											<!-- /长方形输入框 -->
											<!--长方形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2">是否隐藏</label>
												<div class="col-md-9">
													<label class="radio-inline">
														<input type="radio"  name="is_show" value="0" class="styled" required="required" checked >
														显示
													</label>

													<label class="radio-inline">
														<input type="radio"  name="is_show" value="-1" class="styled">
														隐藏
													</label>
												</div>
											</div>
											<!-- /长方形输入框 -->
											<!--长方形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2">上级资源</label>
												<div class="col-md-6">
													<select class="form-control" name="parent_id" id="parent_id">
													<option value="-1">——顶级目录——</option>
													<option value="1">目录</option>
													</select>
												</div>
											</div>
											<!-- /长方形输入框 -->
											<!--长方形输入框-->
											<div class="form-group">
												<label class="control-label col-md-2">资源签名</label>
												<div class="col-md-6">
													<input type="text" class="form-control input-roundless" name="resource_sign" name="3" required="required" >
												</div>
											</div>
											<!-- <div class="form-group">
												<label class="control-label col-md-2">业务支持</label>
												<div class="col-md-9">
													<input type="checkbox" value="${child.resourceSign }:insert">新增&nbsp;&nbsp;
													<input type="checkbox" value="${child.resourceSign }:insert">编辑&nbsp;&nbsp;
													<input type="checkbox" value="${child.resourceSign }:insert">删除&nbsp;&nbsp;
													<input type="checkbox" value="${child.resourceSign }:insert">导出&nbsp;&nbsp;
												</div>
											</div>
											 -->
											<!-- /长方形输入框 -->
										</fieldset>

										<div class="text-right">
											<input type="hidden" name="validate_id" value=""/>
											<input type="hidden" name="validate_id_token" value=""/>
											<button type="reset" class="btn btn-default" id="reset">重置 <i class="icon-reload-alt position-right"></i></button>
											<button type="submit" class="btn btn-primary">提交 <i class="icon-arrow-right14 position-right"></i></button>
										</div>
									</form>
							</div>
							
						</div>
					</div>
				</div>
				<!-- Edit modal -->
			</div>
<!-- /edit modal -->
				<!-- Remove modal -->
				<form action="" method="post" id="removeForm">
				<div id="remove_modal" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h5 class="modal-title">确认信息</h5>
							</div>
				
							<div class="modal-body">你将要删除这条数据. 确认删除吗?</div>
				
							<div class="modal-footer">
								<button type="button" id="removeFormRemove" class="btn btn-primary" >确定删除</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							</div>
							
						</div>
					</div>
				</div>
				</form>
				<!-- /remove modal -->
			</div>
		</div>
	<script language="javascript">
		$("#removeFormRemove").click(function(){
			$("#removeForm").submit();
		});
	
		$.ajax({
		    url:'${pageContext.request.contextPath}/center/system/resource/list',
		    type:'POST', 
		    data:null,
		    dataType:'json',
		    success:function(result){
		    	console.log(result.data);
		        loadResource(result.data);
		    },
		    error:function(xhr,textStatus){
		        console.log('加载resource列表错误');
		    }
		})
		
		var loadResource=function(result){
			var config = {
	    		id: "tableGrid",
	    		width: "100%",
	    		renderTo: "div1",
	    		headerAlign: "left",
	    		headerHeight: "30",
	    		dataAlign: "left",
	    		indentation: "20",
	    		folderOpenIcon: "icon-plus-circle2",
	    		folderCloseIcon: "icon-minus-circle2",
	    		defaultLeafIcon: "images/defaultLeaf.gif",
	    		hoverRowBackground: "false",
	    		folderColumnIndex: "0",
	    		itemClick: "itemClickEvent",
	    		columns:[
	    			{headerText: "资源名称", dataField: "resource_name", headerAlign: "center",dataAlign: "left", width: "100"},
	    			{headerText: "资源类型", dataField: "type", headerAlign: "center",dataAlign: "left", width: "100",handler: "typeOption"},
	    			{headerText: "URL地址", dataField: "rest_url", dataAlign: "center",dataAlign: "center", width: "100"},
	    			{headerText: "权限", dataField: "resource_sign", dataAlign: "center", dataAlign: "center",width: "100"},
	    			{headerText: "操作", headerAlign: "option", dataAlign: "center", width: "50", handler: "Option"}
	    		],
	    		data:result
	    	};

	    	var treeGrid = new TreeGrid(config);
	    	treeGrid.show();
		}						
		/*
		单击数据行后触发该事件
		id：行的id
		index：行的索引。
		data：json格式的行数据对象。
		*/
		function itemClickEvent(id, index, data){
			$("#currentRow").val(id + ", " + index + ", " + TreeGrid.json2str(data));
		}

		function Option(row, col){
			var option="<ul class='icons-list'>";
			    option=option+"<weiyun:hasPermission name='resource:edit'><li><a href='#' onclick='WIedit("+row.validate_id+",\""+row.validate_id_token+"\")' data-toggle='modal'  data-target='#edit_modal'><i class='icon-pencil7'></i></a></li></weiyun:hasPermission>";
			    option=option+"<li><a href='#' onclick='WIremove("+row.validate_id+",\""+row.validate_id_token+"\")' data-toggle='modal'  data-target='#remove_modal'><i class='icon-trash'></i></a></li>";
			    option=option+"</ul>";
		    return option;
		}
		function typeOption(row,col){
			if(row.type==1){
				return "左侧菜单";
			}
			if(row.type==2){
				return "个人信息菜单";
			}
			if(row.type==3){
				return "按钮";
			}
		}
		
		function WIADD(){
			$("#edit_modal").find(".modal-title").html("新增资源管理");
			$("input[name='validate_id']").attr("value","");
			$("input[name='validate_id_token']").attr("value","");
	        $("input[name='resource_name']").attr("value","");
	        $("input[name='rest_url']").attr("value","parent");
	        $("input[name='css_icon']").attr("value","");
	        $("select[name='type']").val(1);
	        $("input[name='resource_sign']").attr("value","");
	        $("input[name='is_show']").each(function(){//是否显示
	        	if($(this).val()==0){
	        		$(this).attr("checked",true);
	        	}else{
	        		$(this).attr("checked",false);
	        	}
	        });
			//查询select菜单目录
	        $.ajax({
			    url:'${pageContext.request.contextPath}/center/system/resource/list',
			    type:'POST', 
			    data:null,
			    dataType:'json',
			    success:function(result){
			    	//console.log(result.data);
			    	var optionStr="<option value='-1'>——顶级目录——</option>";
			    	for(var i=0;i<result.data.length;i++){
			    		console.log(result.data[i]);
			    		optionStr+="<option value='"+result.data[i].resource_id+"'>"+result.data[i].resource_name+"</option>";
			    		var child=result.data[i];
			    		if(child.children.length>0){
			    			for(var j=0;j<child.children.length;j++){
			    				optionStr+="<option value='"+child.children[j].resource_id+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+child.children[j].resource_name+"</option>";
			    				for(var k=0;k<child.children[j].children.length;k++){
			    					var chil=child.children[j].children[k];
			    					optionStr+="<option value='"+chil.resource_id+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+chil.resource_name+"</option>";
			    					
			    				}
			    				
			    			}
			    		}
			    	}
			    	$("#parent_id").html(optionStr);
			    },
			    error:function(xhr,textStatus){
			        console.log('加载resource列表错误');
			    }
			});
		}
		function WIedit(validate_id,validate_id_token){
			$("#edit_modal").find(".modal-title").html("编辑资源管理");
			$.ajax({
			    url:'${pageContext.request.contextPath}/center/system/resource/view?validate_id='+validate_id+"&validate_id_token="+validate_id_token,
			    type:'GET', 
			    data:null,
			    dataType:'json',
			    success:function(result){
			        var result=result.data;
			        $("input[name='validate_id']").attr("value",validate_id);
					$("input[name='validate_id_token']").attr("value",validate_id_token);
			        $("input[name='resource_name']").attr("value",result.resource_name);
			        $("input[name='rest_url']").attr("value",result.rest_url);
			        $("input[name='css_icon']").attr("value",result.css_icon);
			        $("select[name='type']").val(result.type);
			        $("input[name='resource_sign']").attr("value",result.resource_sign);
			        $("input[name='is_show']").each(function(){//是否显示
			        	if($(this).val()==result.is_show){
			        		$(this).attr("checked",true);
			        	}else{
			        		$(this).attr("checked",false);
			        	}
			        });
			        
			        //查询select菜单目录
			        $.ajax({
					    url:'${pageContext.request.contextPath}/center/system/resource/list',
					    type:'POST', 
					    data:null,
					    dataType:'json',
					    success:function(chilsResult){
					    	//console.log(result.data);
					    	var optionStr="<option value='-1'>——顶级目录——</option>";
					    	for(var i=0;i<chilsResult.data.length;i++){
					    		console.log(chilsResult.data[i]);
					    		if(result.parent_id==chilsResult.data[i].resource_id){
					    			optionStr+="<option value='"+chilsResult.data[i].resource_id+"' selected>"+chilsResult.data[i].resource_name+"</option>";
					    		}else{
					    			optionStr+="<option value='"+chilsResult.data[i].resource_id+"'>"+chilsResult.data[i].resource_name+"</option>";
					    		}
					    		var child=chilsResult.data[i];
					    		if(child.children.length>0){
					    			for(var j=0;j<child.children.length;j++){
					    				if(result.parent_id==child.children[j].resource_id){
					    					optionStr+="<option value='"+child.children[j].resource_id+"' selected>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+child.children[j].resource_name+"</option>";
					    				}else{
					    					optionStr+="<option value='"+child.children[j].resource_id+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+child.children[j].resource_name+"</option>";
					    				}
					    				for(var k=0;k<child.children[j].children.length;k++){
					    					var chil=child.children[j].children[k];
					    					if(result.parent_id==chil.resource_id){
					    						optionStr+="<option value='"+chil.resource_id+"' selected>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+chil.resource_name+"</option>";
					    					}else{
					    						optionStr+="<option value='"+chil.resource_id+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+chil.resource_name+"</option>";
					    					}
					    					
					    				}
					    				
					    			}
					    		}
					    	}
					    	$("#parent_id").html(optionStr);
					    },
					    error:function(xhr,textStatus){
					        console.log('加载resource列表错误');
					    }
					});
			        
			    },
			    error:function(xhr,textStatus){
			        console.log('错误');
			    }
			});
		}
		function WIremove(validate_id,validate_id_token){
			var url="${pageContext.request.contextPath}/center/system/resource/remove?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
			$("#removeForm").attr("action",url);
		}
		
		function chanageType(type){
			if(type==1){
				$("input[name='rest_url']").prop("value","parent");
			}else if(type==3){
				$("input[name='rest_url']").prop("value","button");
			}
		}
	</script>
</body>
</html>
 