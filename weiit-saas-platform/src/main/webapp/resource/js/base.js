//js获取项目根路径
function getRootPath(){  
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp  
    var curWwwPath=window.document.location.href;  
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp  
    var pathName=window.document.location.pathname;  
    var pos=curWwwPath.indexOf(pathName);  
    //获取主机地址，如： http://localhost:8083  
    var localhostPaht=curWwwPath.substring(0,pos);  
    //获取带"/"的项目名，如：/uimcardprj  
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);  
    return(localhostPaht+projectName);  
}  
//查询按钮 公用
function searchSubmit(obj){
	if( obj<1 || isNaN(obj) ){
		$("#page").val(1);
	}else{
		$("#page").val(obj);
	}
	$("#searchform").submit();
}

function searchButton(obj){
	if( obj<1 || isNaN(obj) ){
		$("#pageNo").val(1);
	}else{
		$("#pageNo").val(obj);
	}
	$.post( $("#searchform").attr("action") ,  $("#searchform").serialize(),
   		function (date, textStatus){ 
   	 	  try{
   	 		 $('#loadListDiv').html(date);
    	  }catch(oException){
        	  alert("查询失败:" + oException.message);
    	  }finally{
    		   
    	  }
	});
}

var loadingTime = null;
var loadingCount = 0; 
//显示全屏Loading图
function FullScreenShow(msg) {
    if (msg == undefined) {
        msg = "数据加载中, 请稍等...";
    }
    if ($("#div_loadingImg").length == 0) {
        $("body").append("<div id='div_loadingImg'></div>");
    }
    if (loadingCount < 1) {
    	loadingTime = setTimeout(function () {
            $("#div_loadingImg").append("<div id='loadingPage_bg' class='loadingPage_bg1'></div><div id='loadingPage'>" + msg + "</div>");
            $("#loadingPage_bg").height($("body").height()).width("100%");
        }, 100);
    }
    loadingCount += 1;
}

//隐藏全屏Loading图
function FullScreenHide () {
    loadingCount -= 1;
    if (loadingCount <= 0) {
        clearTimeout(loadingTime);
        $("#div_loadingImg").empty();
        $("#div_loadingImg").remove();
        loadingCount = 0;
    }
}

//重置按钮  公用
function resetButton(obj){
	$(obj)[0].form.reset();
}

//保存按钮--验证parsley  公用
function saveButton(obj,msg){
	$(obj).attr("disabled","disabled");
	var form = obj.form;
	//if(!$(form).validate().form()){
	if(!$(form).validationEngine("validate")){
		$(obj).removeAttr("disabled");
		return false;
	}
	if (msg != undefined && msg != "" ) {
    	FullScreenShow(msg);
    }
	form.submit();
}
 
//全选复选框
function  allCheckClick(obj) {
	//$(obj).attr("checked"); 1.10.2.min.js高版本用prop.低版本可以用attr
	var idsCheck = $("#data-table input[name='ids']");
	if ($(obj).prop("checked") && $(obj).attr("checked")==undefined) {	
		idsCheck.each(function(i){
			if(!$(this).prop("checked")){
				$(this).attr("checked", true);
				$(this).trigger('click'); 
			}
	    });
		if($(obj).attr("name")=="allCheck"){
			//选择table列里面的checkbox与全选checkbox
			$("input[name='selectAll']").each(function(){
				$(this).attr("checked", true);
				$(this).parent().addClass("checked");
			});
		}else{
			//选择table列里面的checkbox与全选checkbox
			$("input[name='allCheck']").each(function(){
				$(this).attr("checked", true);
				$(this).parent().addClass("checked");
			});
		}
	}else {
		idsCheck.each(function(i){
			$(this).attr("checked", false);
			$(this).parent().removeClass();
	    });  
		//选择table列里面的checkbox与全选checkbox
		$("input[name='selectAll']").each(function(){
			$(this).attr("checked", false);
			$(this).parent().removeClass();
		});
		$("input[name='allCheck']").each(function(){
			$(this).attr("checked", false);
			$(this).parent().removeClass();
		});
	}
	
} 


//公用导出时候调用exportCSV 时调用
function commonExportList(formId,exportClassName,exportMethodName,exporTexcelName,exportTitles,exportFields,fileType){
	//将原来搜索条件的表单内容复制过来
	$("#fileExportForm").html($("#"+formId).html());
	
	$("#fileExportForm").append("<input type='hidden' name='exportClassName' value='"+exportClassName+"'/>");
	$("#fileExportForm").append("<input type='hidden' name='exportMethodName' value='"+exportMethodName+"'/>");
	$("#fileExportForm").append("<input type='hidden' name='exportExcelName' value='"+exporTexcelName+"'/>");
	$("#fileExportForm").append("<input type='hidden' name='exportTitles' value='"+exportTitles+"'/>");
	$("#fileExportForm").append("<input type='hidden' name='exportFields' value='"+exportFields+"'/>");
	$("#fileExportForm").append("<input type='hidden' name='fileType' value='"+fileType+"'/>");
	var url=basePath+"/center/publics/excel/export";
	$("#fileExportForm").attr('action',url);
	$("#fileExportForm").attr('target',"_blank");  
	$("#fileExportForm").submit();
} 
 
//  谈出框 Alert
function MAlert(message,title,width,callback){
	$("#mymodal-dialog").remove();
	var  array = [];
	array.push('<div class="modal fade in" role="dialog" id="mymodal-dialog" aria-hidden="false" style="display:none; padding-right: 17px;padding-top: 100px;">');
	array.push('<div class="modal-dialog">'); //点谈出框外面不隐藏 <div class="modal-backdrop fade in" style="height: 100%;"></div><div class="modal-dialog">
	if(width!=undefined && width!=""){
		array.push('<div class="modal-content" style="width: '+width+'px;"> ');
	}else{
		array.push('<div class="modal-content" style="width: 400px;">');
	}
	array.push('<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>');
	if(title!=undefined && title!=""){
		array.push('<h5 class="modal-title" id="modalTitle">'+title+'</h5>');
	}else{
		array.push('<h5 class="modal-title" id="modalTitle">操作提示</h5>');
	}
	array.push('</div><div class="modal-body" id="modalBody">'+message+'</div>');
	array.push('<div class="modal-footer" style="text-align: center;"><a href="javascript:;" id="alert_modal_ok"  class="btn btn-sm btn-primary" >确定</a></div> ');
	array.push('</div></div></div>');
	$("BODY").append(array.join(" "));
	$("#mymodal-dialog").modal('show');
 
	$("#alert_modal_ok").click( function() {
		$("#mymodal-dialog").modal('hide');
		if( callback ) callback(true);
	});
	$("#alert_modal_ok").focus().keypress( function(e) { 
		if( e.keyCode == 13 || e.keyCode == 32 ) $("#alert_modal_ok").trigger('click');
	});
}
//谈出框 Confirm
function MConfirm(message,title,width,callback){
	$("#mymodal-dialog").remove();
	var  array = [];
	array.push('<div class="modal fade in" id="mymodal-dialog" aria-hidden="false" style="display:none; padding-right: 17px;padding-top: 100px;">');
	array.push('<div class="modal-dialog">');  
	if(width!=undefined && width!=""){
		array.push('<div class="modal-content" style="width: '+width+'px;"> ');
	}else{
		array.push('<div class="modal-content" style="width: 400px;">');
	}
	array.push('<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>');
	if(title!=undefined && title!=""){
		array.push('<h5 class="modal-title" id="modalTitle">'+title+'</h5>');
	}else{
		array.push('<h5 class="modal-title" id="modalTitle">操作提示</h5>');
	}
	array.push('</div><div class="modal-body" id="modalBody">'+message+'</div>');
	array.push('<div class="modal-footer" style="text-align: center;">');
	array.push('<a href="javascript:;"  id="confirm_modal_ok"  class="btn btn-sm btn-primary" >确定</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	array.push('<a href="javascript:;"  class="btn btn-sm btn-default" data-dismiss="modal" aria-hidden="true" >取消</a></div>');
	array.push('</div></div></div>');	
	$("BODY").append(array.join(" "));
	$("#mymodal-dialog").modal('show');

	$("#confirm_modal_ok").click( function() {
		$("#mymodal-dialog").modal('hide');
		if( callback ) callback(true);
	}); 
	$("#confirm_modal_ok").focus();
	$("#confirm_modal_ok").keypress( function(e) { 
		if( e.keyCode == 13 ) $("#confirm_modal_ok").trigger('click');
	});
}
//公共删除方法，支持get获取post两种方式提交进行删除
function Mremove(method,url,message){
	if(!message){
		message="你将要删除这条数据. 确认删除吗?";
	}
	if(method=='get'){
		MConfirm(message,'','',function(result) {
			if(result){
				window.location=url;
			}
		});
	}else{
		MConfirm(message,'','',function(result) {
			if(result){
				$("#removeForm").attr("action",url);
				$("#removeForm").submit();
			}
		});
	}
	
}
function Mget(url){
	window.location.href=url;
}
//公共批量删除方法，必须要求post方式提交
function MremoveBath(checkboxId,url,message){
	if(!message){
		message="你将要删除这条数据. 确认删除吗?";
	}
	var html="";
	$(checkboxId).each(function(){
		 if($(this).prop("checked")){
			 var valueStr=$(this).val().split("|");
			 html+="<input type='hidden' name='validate_id' value='"+valueStr[0]+"' />";
			 html+="<input type='hidden' name='validate_id_token' value='"+valueStr[1]+"' />";
		 }
	});
	if(html==""){
		MAlert('请至少选择一条数据进行操作！');
		return;
	}
	$("#removeForm").html(html);
	$("#removeForm").attr("action",url);
	MConfirm(message,'','',function(result) {
		if(result){
			 $("#removeForm").submit();
		}
	});
	
	
}
function commonDialogModal( title,url,width,height,index,type,callback ){ 
	if(index == undefined ){
		index="";
	} 
	$("#commonDialogModal"+index).remove();
	var  array = [];
	array.push('<div class="modal fade in" id="commonDialogModal'+index+'" role="dialog" aria-hidden="false" style="display:none;text-align:center;">');
	if(width!=undefined && width!=""){
		array.push('<div class="modal-dialog" style="text-align:left;width: '+width+'px;">');
	}else{
		array.push('<div class="modal-dialog" style="text-align:left;width: 600px;">');
	}
	array.push('<div class="modal-content" >');
	array.push('<div class="modal-header" style="height: 43px;padding-top:5px;margin-top:0px;" > ');
	array.push('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>');
	array.push('<h4 class="modal-title text-bold" id="dialogModalTitle'+index+'">'+title+'</h4>');
	array.push('</div>');
	array.push('<div class="modal-body" style="padding:0px;margin:0px;" id="dialogModalBody'+index+'">');
	array.push('<iframe id="dialogModalFrame" name="dialogModalFrame'+index+'" src="'+url+'" frameborder="0" scrolling="auto"  border="0" width="'+(width-3)+'" height="'+height+'" > '); 
	array.push('</iframe>'); 
	array.push('</div>');  
	if(type!=undefined && type!=""){
		array.push('<div class="modal-footer " style="padding-top:5px;" style="height: 45px; " >');
		array.push('<a href="javascript:;"   id="commonDialogModalOk'+index+'"  class="btn btn-sm bg-blue" >确定</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
		array.push('<a href="javascript:;"  class="btn btn-sm btn-default" data-dismiss="modal" aria-hidden="true" >取消</a>');
		array.push('</div>');
	}
	array.push('</div></div></div> ');	
	$("BODY").append(array.join(" "));
 
	$("#commonDialogModal"+index).modal('show');
	 
	if(type!=undefined && type!=""){
		$("#commonDialogModalOk"+index).click( function() { 
			$("#commonDialogModal"+index).modal('hide');
			if( callback ) callback(true);
		}); 
	}
} 
 

function loading(id){
	var html = '<div id="querytip" class="qrytip2" >loading....</div>';
	$(id).html(html);
} 
//图片素材调起方法
function openSource(id){
	//图片素材地址
	var url=getRootPath()+"/center/file/picture/source";
	$(id).parent().parent().parent().find(".fileinput-source").click(function(){
		//记录当前弹出框的ID
		$(".cacheOpenSourceId").attr("value",id);
		commonDialogModal("图片空间",url,900,500,'');
	});
}
//图片素材弹出框点击图片插入方法
function insert(domain,imgUrl){
	var cacheOpenSourceId=window.parent.$(".cacheOpenSourceId").val();
	var img='<div class="file-preview-frame" id="preview-"+'+cacheOpenSourceId+'>'+
	            '<img src="'+domain+imgUrl+'"  class="file-preview-image" title="'+imgUrl+'" alt="'+imgUrl+'" style="width:200px;height:198px;">'+
	        '</div>';
	window.parent.$(cacheOpenSourceId).parent().parent().parent().parent().removeClass("file-input-new");
	window.parent.$(cacheOpenSourceId).parent().parent().parent().parent().find(".file-preview-thumbnails").html(img);
	//隐藏素材的地址内容
	window.parent.$(cacheOpenSourceId).parent().parent().parent().parent().next().attr("value",imgUrl);
	window.parent.$("#commonDialogModal .close").click();
	 
 }
function initPicture(domain,imgUrl,id,width,height){
	var img='<div class="text-center" id="preview-"+'+id+'>'+
	   			'<img src="'+domain+imgUrl+'"  class="" title="'+imgUrl+'" alt="'+imgUrl+'" width="'+width+'px" height="'+height+'px" style="width:'+width+'px;height:'+height+'px;">'+
	   		 '</div>';
	$(id).parent().parent().parent().parent().removeClass("file-input-new");
	$(id).parent().parent().parent().parent().find(".file-preview-thumbnails").html(img);
	//隐藏素材的地址内容
	$(id).parent().parent().parent().parent().next().attr("value",imgUrl);
}

//商品弹出框调用方法
function openProduct(id){
	var url=getRootPath()+"/center/publics/publics/productGridList";
	//判断是否已经存在选中商品，如果存在，每次打开弹出框时把以有商品参数缓存起来,方便弹出框中页面可以获取到缓存的商品id，以便能选中复选框
	
	if($(".dropzone2").length>0){
		$("#cacheOpenProductId").attr("value",id);
	}
	commonDialogModal("商品列表",url,900,500,id,'1',function(result){ 
		if(result){
			//临时保存选中的所有的商品的id的字符串
			var productIds="";
			//选中的商品自动生成的div
			var product_list_div ="<div class='dropzone2'>";
			
			//获取弹出框中的所有的复选框
			//var idsCheck = $("input[name='ids']" , window.frames["dialogModalFrame"+id].document) ;
			var selects = $(".col-md-3.selected" , window.frames["dialogModalFrame"+id].document) ;
			selects.each(function(i){
				var product_id=$(this).find(".info").val();
				var product_name=$(this).find(".info").attr("product_name");
				var product_img=$(this).find(".info").attr("product_img");
				console.log(product_id+product_name+product_img);
				productIds=productIds+product_id+",";
				//拼接选中商品
				var product_div=
					 '<div class="dz-preview2" product_id='+product_id+'>'+ 
					   '<div class="dz-details">'+ 
					    '<img src="'+product_img+'" />'+ 
					   '</div>'+ 
					   '<a class="dz-remove" href="javascript:undefined;" data_id="'+product_id+'">删除</a>'+
					 '</div>';
				    product_list_div=product_list_div+product_div;
			});
			
			productIds=productIds.substring(0,productIds.length-1);//移除最后一个,
			product_list_div=product_list_div+"</div><input type='hidden' name='"+id+"Values' id='"+id+"Values' value='"+productIds+"'/>";
			console.log(product_list_div);
			//判断页面是否已经存在要拼接的div，如果已经存在清除重新拼接
			$("#"+id).parent().find("#"+id+"Values").remove();
			$("#"+id).parent().find(".dropzone2").remove();
			$("#"+id).after(product_list_div);
			//判断已经拼接好的商品列表是否有删除，每次删除都要刷新隐藏的商品id值
			$("#"+id).parent().find(".dropzone2").find(".dz-remove").each(function(){
				$(this).click(function(){
					var newIds="";
					var preIds=$("#"+id).parent().find("#"+id+"Values").val().split(",");
					for(var k=0;k<preIds.length;k++){
						if($(this).attr("data_id")!=preIds[k]){
							newIds=newIds+preIds[k]+",";
						}
					}
					newIds=newIds.substring(0,newIds.length-1);//移除最后一个,得到移除后的剩余的商品的id
					//将商品列表中的id的值隐藏到商品列表下面
					var preIds=$("#"+id).parent().find("#"+id+"Values").attr("value",newIds);
					//删除当前要删除的商品
					$(this).parent().remove();
					//判断如果是最后一个，整体商品列表的div全部移除
					if($("#"+id).parent().find(".dropzone2").find(".dz-remove").length<1){
						$("#"+id).parent().find(".dropzone2").remove();
					}
				});
			});
		} 
	});
}

$(function (){
	
	//进页面加载显示与隐藏
	$(".styled").each(function(){
		if(sessionStorage.getItem($(this).val())=='0'){
			if(!$(this).prop("checked")){
				$(this).click();
			}
		}else if(sessionStorage.getItem($(this).val())=='-1'){
			if($(this).prop("checked")){
				$(this).click();
			}
		}
		var checked=$(this).prop("checked");
		var classValue=$(this).val();
		$("table th").each(function(i){
			if($(this).attr("class")==classValue){
				$("table tr").each(function(){
					$(this).children().each(function(j){
						if(i==j){
							if(checked){
								$(this).show();
							}else{
								$(this).hide();
							}
						}
					});
				});
			}
			
		});
	});
	
	//点击复选框隐藏与显示
	$(".styled").each(function(){
		$(this).click(function(){
			var checked=$(this).prop("checked");
			var classValue=$(this).val();
			$("table th").each(function(i){
				if($(this).attr("class")==classValue){
					$("table tr").each(function(){
						$(this).children().each(function(j){
							if(i==j){
								if(checked){
									$(this).show();
									sessionStorage.setItem(classValue,"0");
								}else{
									$(this).hide();
									sessionStorage.setItem(classValue,"-1");
								}
							}
						});
					});
				}
			});
		});
	});
});