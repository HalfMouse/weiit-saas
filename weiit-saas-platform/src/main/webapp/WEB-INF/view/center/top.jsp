<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="weiyun" uri="http://shiro.apache.org/tags"%>
<!-- Main navbar -->
<div class="navbar navbar-inverse" style="position:fixed; top:0; left: 0; width: 100%" >
	<div class="navbar-header">
		<a class="navbar-brand" href="index.html"><img
			src="${pageContext.request.contextPath}/resource/images/logo_light.png"
			alt=""></a>

		<ul class="nav navbar-nav pull-right visible-xs-block">
			<li><a data-toggle="collapse" data-target="#navbar-mobile"><i
					class="icon-tree5"></i></a></li>
			<li><a class="sidebar-mobile-main-toggle"><i
					class="icon-paragraph-justify3"></i></a></li>
		</ul>
	</div>

	<div class="navbar-collapse collapse" id="navbar-mobile">
		<ul class="nav navbar-nav">
			<li><a class="sidebar-control sidebar-main-toggle hidden-xs" onclick="onleft()">
					<i class="icon-paragraph-justify3"></i>
			</a></li>
				<!--<c:forEach items="${sessionScope.menuList }" var="menu">
					<weiyun:hasRole name="${menu.resource_sign }">
					<c:forEach items="${menu.children }" var="child">
					 <weiyun:hasRole name="${child.resource_sign }">
					 	<li id="li${child.resource_id }" class="li-show" style="display: none">
							<a href="${pageContext.request.contextPath}${child.rest_url}" target="rightIframe" class="sidebar-control">
								<i class="${child.css_icon }"></i>
								${child.resource_name }
							</a>
						</li>
					 </weiyun:hasRole>
					</c:forEach>
					</weiyun:hasRole>
				</c:forEach>
				
				<li class="dropdown mega-menu mega-menu-wide">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" id="frequentResource"><i class="icon-cog3"></i> 常用功能 </a>
					<div class="dropdown-menu dropdown-content">
						
						<div class="dropdown-content-body">
							<form action="${pageContext.request.contextPath}/center/system/frequent/saveFrequentResource" method="post">
							<div class="row">
								<c:forEach items="${sessionScope.menuList }" var="menu">
									<weiyun:hasRole name="${menu.resource_sign }">
									<div class="col-md-3">
										<span class="menu-heading underlined">${menu.resource_name}</span>
										<ul class="dropdown-menu" style="display: block; position: static; width: 100%; margin-top: 0; float: none;">
											<c:forEach items="${menu.children }" var="child">
											<weiyun:hasRole name="${child.resource_sign }">
											<li class="checkbox checkbox-right"><label><input type="checkbox" name="resource_id"  class="styled" value="${child.resource_id }">${child.resource_name} </label></li>												
											</weiyun:hasRole>
											</c:forEach>
										</ul>
									</div>
									</weiyun:hasRole>
								</c:forEach>
							</div>
							<div class="row">
							<br><br>
								<div class="text-center">
									<button class="btn bg-info" type="button" onclick="submitForm()">保存</button>
									<button class="btn bg-grey" type="button" onclick="closeForm()">取消</button>
								</div>
							</div>
							</form>
						</div>
					</div>
					
				</li>-->
		</ul>

		<ul class="nav navbar-nav navbar-right">
			
			<li class="dropdown dropdown-user">
				<a class="dropdown-toggle"
					data-toggle="dropdown"> <img
						src="${pageContext.request.contextPath}/resource/images/placeholder.jpg"
						alt=""> <span>${sessionScope[sessionUserKey].manager_name } </span> <i class="caret"></i>
				</a>

				<ul class="dropdown-menu dropdown-menu-right">
					<!-- 
					<c:forEach items="${sessionScope.userIndexList }" var="userIndex" varStatus="i">
						<weiyun:hasAnyRoles name="${userIndex.resource_sign }">
						 <li><a href="${pageContext.request.contextPath}${userIndex.rest_url}" ${userIndex.resource_sign=='logout'?"":"target='rightIframe'" }><i class="${userIndex.css_icon}"></i>${userIndex.resource_name }</a></li> 
						</weiyun:hasAnyRoles>
						<c:if test="${i.count%3==0}">
							<li class="divider"></li>
						</c:if>
					</c:forEach> -->
					 <c:if test="${sessionScope.role_sign=='USER'}">
					<li><a> 
					账户余额<br>
					<span class="text-success" style="font-size:20px;font-weight:bold;"><fmt:formatNumber type="number" value="${sessionScope.last_balance }" pattern="0.00" maxFractionDigits="2"/>  </span>
					<span class="badge badge-warning pull-right">服务商</span>
					</a></li> 
					<li class="divider"></li>
					<li><a href="${pageContext.request.contextPath}/center/manager/balanceLog" target="rightIframe"><i class="icon-stats-bars2"></i>收支明细</a></li>
					</c:if>
					<li><a href="${pageContext.request.contextPath}/center/manager/updatePasswordUI" target='rightIframe' ><i class="icon-key"></i>修改密码</a></li>
					<li><a href="${pageContext.request.contextPath}/center/manager/logout" ><i class="icon-switch2"></i>退出</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>
<!-- /main navbar -->
<script>
var leii=0;
function onleft(){
	if(leii==0){
		leii=1;
		$("#left").css("width","50px");
		$("#right").css("padding-left","50px");
	}else{ 
		leii=0;
		$("#left").css("width","200px");
		$("#right").css("padding-left","200px");
	}
}

$(function(){
	//加载数据
	$.ajax({
	    url:'${pageContext.request.contextPath}/center/system/frequent/getFrequentResource',
	    type:'GET', 
	    data:null,
	    dataType:'json',
	    success:function(result){
	        //var result=result.data;
	        for ( var int = 0; int < result.length; int++) {
	        	$("input[name='resource_id'][value='"+result[int].resource_id+"']").click();
	        	$("#li"+result[int].resource_id).show();
			}
	       // chanageChecked();
	       
	    },
	    error:function(xhr,textStatus){
	        console.log('错误');
	    }
	});
	
	$("input[name='resource_id']").each(function(){
		$(this).on("click",chanageChecked);
	}); 
	
});

function chanageChecked(){
	var i=0;
	$("input[name='resource_id']").each(function(){
		if($(this).parent().attr("class")=='checked'){
			i++;
		}
	});
	if(i>=5){
		$("input[name='resource_id']").each(function(){
			if($(this).parent().attr("class")!='checked'){
				$(this).attr("disabled","disabled");
				$(this).parent().parent().addClass("disabled");
				$(this).parent().parent().parent().parent().addClass("disabled");
			}
		});
	}else{
		$("input[name='resource_id']").each(function(){
			if($(this).parent().attr("class")!='checked'){
				$(this).removeAttr("disabled","disabled");
				$(this).parent().parent().removeClass("disabled");
				$(this).parent().parent().parent().parent().removeClass("disabled");
			}
		});
	}	
}
	
function submitForm(){
	var resource_id=new Array();
	var i=0;
	$("input[name='resource_id']").each(function(){
		if($(this).parent().attr("class")=='checked'){
			resource_id[i]=($(this).val());
			i++;
		}
	});
	
	//alert(resource_id);
	$.ajax({
	    url:'${pageContext.request.contextPath}/center/system/frequent/saveFrequentResource',
	    type:'GET', 
	    data:{"resource_id":resource_id},
	    dataType:'json',
	    success:function(result){
	        //var result=result.data;
	    	if(result.status=='success'){
	    		 new PNotify({title: '提示操作',text: '保存成功',addclass: 'bg-info'});
	    		 $("#frequentResource").parent().removeClass("open");
	    		 $(".li-show").hide();
	    		 $("input[name='resource_id']").each(function(){
    				if($(this).parent().attr("class")=='checked'){
    					$("#li"+$(this).val()).show();
    				}
    			});
	    		 
	    	}
	    },
	    error:function(xhr,textStatus){
	        console.log('错误');
	    }
	});
}
function closeForm(){
	$("#frequentResource").parent().removeClass("open");
}


</script>