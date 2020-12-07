<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<style type="text/css">
.tree {
    width:100%;
    background-color:#fbfbfb;
    -webkit-border-radius:4px;
    -moz-border-radius:4px;
    border-radius:4px;
    -webkit-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
    -moz-box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05);
    box-shadow:inset 0 1px 1px rgba(0, 0, 0, 0.05)
}
.tree li {
    list-style-type:none;
    margin:0;
    border-top:1px solid #e3e3e3;
}
.tree li::before, .tree li::after {
    content:'';
    position:absolute;
    right:auto
}

.tree li span {
    -moz-border-radius:5px;
    -webkit-border-radius:5px;
    border-radius:5px;
    display:inline-block;
    padding:3px 8px;
    text-decoration:none
}
.tree li.parent_li>span {
    cursor:pointer
}
.tree>ul>li::before, .tree>ul>li::after {
    border:0
}
.tree li:last-child::before {
    height:30px
}
.tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span {
    background:#eee;
    color:#000
}
 .cateButton{
     -moz-border-radius:5px;
    -webkit-border-radius:5px;
    border-radius:5px;
    display:inline-block;
    float:right;
    text-decoration:none;
}
</style>

<%@include file="../common/header.jsp" %>
  		
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title" style="height:70px;padding-top:20px;">
				<h4>
					<i class="icon-arrow-left52 position-left"></i> <span
						class="text-semibold"> 商品分类 </span>
				</h4>
			</div>
		</div>
	</div>

	<!-- Content building -->
	<div class="content">
		<!-- Bordered striped table -->
		<div class="panel panel-flat">
	 
			<div class="panel-body" style="padding:10px;margin:10px;">
 				
				  <div class="tab-content p-b-0 m-b-0">
				      <div class="tab-pane fade active in" id="default-tab-1">
				      	<div class="row">
				        	<div class="col-sm-12">
				         	 <div class="tree well col-sm-12">
				          		<ul class="col-sm-12">
				             		<a href="javascript:;" class="btn bg-blue" onclick="addCate(-1)"><i class="icon-diff-added"></i> 新增一级分类</a>
				             		<br><br>
				             		<li style="min-height:40px;font-size:14px;"> 
				             			<span class="text-info text-bold"> 一级分类</span>
				            			<span style="width:25%">&nbsp;</span>
				             			<span class="text-info text-bold"> 二级分类</span>
				              			<span style="width:20%">&nbsp;</span>
				              			<span class="text-info text-bold"> 三级分类</span>
				              			<span >&nbsp;</span>
				              			<span style="width:95px;text-align:right;float:right;padding-right:30px;" class="text-info text-bold"> 操作</span>
				             		</li>
						        	<c:forEach items="${productMyCateList }" var="info">
						        	<li id="first${info.cate_id }">
						        		 <span class="text-muted"><i class="icon-minus-circle2"></i><img alt="" src="${imageDomain }/${info.cate_icon_img}" width="20px;" height="20px;"> ${info.cate_name }</span>
						        		 <div class="cateButton">
						        		 	<a href="javascript:;" title="新增二级分类" class="expand-node text-orange" onclick="addCate(${info.cate_id})"><i class="icon-add"></i>新增二级分类</a>&nbsp;
						        		 	<a href="javascript:;" title="编辑" class="m-r-5 text-orange" onclick="toEdit(${info.cate_id},'${info.validate_id_token }')"><i class="icon-pencil7"></i>编辑</a>&nbsp;
						        		 	<a href="javascript:;" title="删除" class="m-r-5 text-orange" onclick="mdelete(${info.cate_id},'${info.cate_name}','${info.validate_id_token }');"><i class="icon-trash"></i>删除</a>
						        		 </div>
					            		 <c:if test="${info.secondList != null}">
						            	 	 <ul>
							            	 <c:forEach items="${info.secondList }" var="second">
							            	 	<li id="second${second.cate_id }">
							            	 		<span style="width:29%">&nbsp;</span> 
							            	 		<span  class="text-muted"><i class="icon-minus-circle2"></i><img alt="" src="${imageDomain }/${second.cate_icon_img }" width="20px;" height="20px;"> ${second.cate_name }</span>
							            	 		<div class="cateButton">
							            	 			<a href="javascript:;" title="新增三级分类"  class="expand-node text-info" onclick="addCate(${second.cate_id})"><i class="icon-add"></i>新增三级分类</a>&nbsp;
							            	 			<a href="javascript:;" title="编辑"  class="m-r-5 text-info" onclick="toEdit(${second.cate_id},'${second.validate_id_token }')"><i class="icon-pencil7"></i>编辑</a>&nbsp;
							            	 			<a href="javascript:;" title="删除" class="m-r-5 text-info" onclick="mdelete(${second.cate_id},'${second.cate_name}','${second.validate_id_token }');"><i class="icon-trash"></i>删除</a>
							            	 		</div>
							            	        <c:if test="${second.thirdList != null}">
							            	        <ul>
									            	<c:forEach items="${second.thirdList }" var="third">
									            	 	<li id="third${third.cate_id }">
									            	 		<span style="width:54%">&nbsp;</span>
									            	 		<span  class="text-muted"><img alt="" src="${imageDomain }/${third.cate_icon_img }" width="20px;" height="20px;"> ${third.cate_name }</span>
									            	 		<div class="cateButton">
									            	 			<a href="javascript:;" title="编辑"  class="m-r-5 text-info" onclick="toEdit(${third.cate_id},'${third.validate_id_token }')"><i class="icon-pencil7"></i>编辑</a>&nbsp;
									            	 			<a href="javascript:;" title="删除" class="m-r-5 text-info" onclick="mdelete(${third.cate_id},'${third.cate_name}','${third.validate_id_token }');"><i class="icon-trash"></i>删除</a>
									            	 		</div>				            	        
									            	 	</li>
									            	</c:forEach>
									            	</ul>
							            	        </c:if>
							            	       
							            	 	 </li>
							            	 </c:forEach>
							            	 </ul>
						            	  </c:if>
						        	</li>
						        	</c:forEach>
						    	</ul>
							</div>
				        </div>
				      </div>
				      </div>
				    </div>
			</div>

		</div>
		<!-- /bordered striped table -->
	</div>
	<!-- /content building -->
</div>
<!-- /main content -->

<!-- begin modal-alert -->
<div class="modal fade" id="cate-modal-alert">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="modal-title">新增分类</h4>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" name="infoform" id="infoform"
					action="${pageContext.request.contextPath}/center/productCate/save"
					method="POST" enctype="multipart/form-data">
					<input type="hidden" name="parent_id" id="parent_id">
					<input type="hidden" name="validate_id" id="validate_id" value=""/>
					<input type="hidden" name="validate_id_token" id="validate_id_token" value=""/>
					<div class="form-group">
						<label class="col-sm-2 control-label"> <font color="red">*</font>分类名称
						</label>
						<div class="col-sm-4">
							<input type="text" class="form-control validate[required]" name="cate_name"
								id="cate_name" value="" data-errormessage-value-missing="分类名称不能为空">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">
								<font color="red">* </font>分类小图标
						</label>
						<div class="col-sm-6">
							<input type="file" class="bootstrap-uploader" name="smallFile" id="smallFile" value="" /> 
							<br> <span style="color: gray">建议尺寸：100 x 100 像素。</span> 
							<input type="hidden" name="cate_icon_img" id="cate_icon_img" value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"> <font color="red">*</font>排序
						</label>
						<div class="col-sm-3">
							<input type="text" class="form-control validate[required,custom[integer]]" name="sort_num"
								id="sort_num" value="0" data-errormessage-value-missing="排序不能为空" data-errormessage-custom-error="必须是整数">
						</div>
					</div>
					<div class="form-group">
				     	<label class="col-sm-2 control-label "> <font color="red">*</font>状态</label>
				     	<div class="col-sm-4">
				     		<label class="radio-inline"> 
				     			<input type="radio" class="styled" name="is_show" id="is_show1"
									checked="checked" value="0">
									显示
							</label>
							<label class="radio-inline">
								<input type="radio" class="styled" name="is_show" id="is_show0" value="-1">
									不显示
							</label>
				     	</div>
			      	</div> 
					<div class="form-group">
						<label class="col-md-3 control-label"></label>
						<div class="col-md-9">
							<button type="button" onclick="saveButton(this,'数据提交中，请稍后！')" class="btn btn-sm btn-success">保存</button>&nbsp;&nbsp;&nbsp;&nbsp; 
							<a href="#" id="qua1" data-toggle="tab"	class="btn btn-sm btn-default" data-dismiss="modal">取消</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!--  end modal-alert -->
</div>

<%@include file="../common/footer.jsp"%>
<script>
$(document).ready(function() {
	$('#infoform').validationEngine({ 
		promptPosition: 'bottomRight', 
		addPromptClass: 'formError-white',
		scroll: true,
		showOneMessage: true
	});
	
	openSource("#smallFile");
	
	$(function () {
	    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
	    $('.tree li.parent_li > span').on('click', function (e) {
	        var children = $(this).parent('li.parent_li').find(' > ul > li');
	        var img = $(this).attr('title', 'Expand this branch').find(' > i').attr("class");
	        if(img !='fa fa-folder-open'){
	        	if (children.is(":visible")) {
		            children.hide('fast');
		            $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-circle2').removeClass('icon-minus-circle2');
		        } else {
		            children.show('fast');
		            $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-circle2').removeClass('icon-plus-circle2');
		        }
	        }
	        else{
	        	if (children.is(":visible")) {
		            children.hide('fast');
		           
		        } else {
		            children.show('fast');				          
		        }
	        }
	        e.stopPropagation();
	    });
	});
	
});


function toEdit(cate_id,validate_id_token){
	$("#modal-title").html("编辑分类");
	$.ajax({
	    url:"${pageContext.request.contextPath}/center/productCate/view?validate_id="+cate_id+"&validate_id_token="+validate_id_token,
	    type:'GET', 
	    data:null,
	    dataType:'json',
	    success:function(result){	
      	 	   var jsonMap = result.data;
      	 	   $("#infoform").validate().resetForm();
      	 	   
		       $("#validate_id").val(jsonMap.validate_id);	 
		       $("#validate_id_token").val(jsonMap.validate_id_token);
		       $("#cate_name").val(jsonMap.cate_name);	
		       $("#sort_num").val(jsonMap.sort_num);	 
		       $("#parent_id").val(jsonMap.parent_id);  
	    	   $("#cate_icon_img").val(jsonMap.cate_icon_img);
		       $("input[name=is_show][value=" + jsonMap.is_show + "]").prop("checked", true); 
		       $("input[name=is_show][value=" + jsonMap.is_show + "]").trigger('click');


		     	initPicture("${imageDomain}/",jsonMap.cate_icon_img+"_100x100","#smallFile","100","100");
		    	
	    	   $("#cate-modal-alert").modal("show");
       	  },
       	  error:function(xhr,textStatus){
     	        console.log('错误');
     	    }
	});
}

function addCate(parent_id){
	$("input[name=is_show][value=0]").prop("checked", true);
    $("input[name=is_show][value=0]").trigger('click');
	$("#infoform").validate().resetForm();
	$("#modal-title").html("新增分类");
	$("#parent_id").attr("value",parent_id);
	document.infoform.reset();
	$("#validate_id").val("");	 
    $("#validate_id_token").val(""); 
    $("#smallFile").val(""); 
    $("#cate_icon_img").val("");
    $("#cate-modal-alert").modal("show");
}

function mdelete(cate_id,name,validate_id_token){	
	MConfirm('确定要删除分类 <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
		if(result){
			window.location="${pageContext.request.contextPath}/center/productCate/remove?validate_id="+cate_id+"&validate_id_token="+validate_id_token;	
		}
	}); 
}
 

</script>