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
	action="${pageContext.request.contextPath}/center/shop/productShop/productModal?radioType=${queryParam.radioType}" method="post" >						
<!-- Main content -->
<div class="content-wrapper col-sm-12" style="padding:0px;margin:0px;">
 
	<!-- Content area -->
	<div class="content"  style="padding:0px;margin:0px;">
		<!-- Bordered striped table -->
		<div class="panel panel-flat"> 
			<div class="panel-body" >
				<div class="col-md-5">
					<div class="input-group">
						<div id="vertical" style="width:300px;height:300px;">
                            <img src="${imageDomain}${product.product_img}?${i100}" id="midimg" style="width:300px;height:300px;">
                        </div>
						<div id="imageMenu" style="margin-left:0px;padding-left:0px;padding-top:3px;">
                            <ul>
                            <c:forEach items="${product.imagesList}" var="info" varStatus="ind">
                            	<li ${ind.count eq 1?"id='onlickImg'":""} onclick="imgclick(this,'${imageDomain}${info}')" ><img src="${imageDomain}${info}?${i100}" width="60px" height="60px"></li>
							</c:forEach>              
                             </ul>
                        </div>
						 
					</div>
				</div>
				<div class="col-md-6">
					<div class="input-group">
						<h5>${product.product_name}</h5>
					</div>
				    <div class="form-group" style="margin-bottom:10px;">
				     	<label class="control-label col-md-2 text-right" style="padding:0px;margin:0px;">市场价：</label>
				     	<div class="col-md-10" id="shopsmarket">
				        	￥${product.smarket_price}
				      	</div>
				    </div> 
				    <div class="form-group" style="margin-bottom:10px;">
				     	<label class="control-label col-md-2 text-right" style="padding:0px;margin:0px;">销售价：</label>
				     	<div class="col-md-10">
				        	<span class="text-danger" id="shopsale">￥${product.sale_price}</span>
				      	</div>
				    </div> 
				    <c:if test="${product.spec_config eq 1}">
				    <div class="form-group" style="margin-bottom:10px;">
				     	<label class="control-label col-md-2 text-right" style="padding:0px;margin:0px;">规格：</label>
				     	<div class="col-md-10" style="padding-left:0px;">
				    		<c:forEach items="${product.guigeList}" var="info33" varStatus="ind">  
									<c:set var="skuCount" value="0"></c:set>
									<c:forEach items="${attrList}" var="info" >
										<c:if test="${info33 == info.key_id && info.type eq 1  && empty info.parent_id }">
										
												<div class="form-group col-sm-12  m-b-0"
													id="divitems_${info.key_id}" style="margin-bottom:0px;" >
													<label class="col-sm-12 control-label p-0 p-t-5">
													  <span class="text-warning">${info.key_name}</span>
													</label>
													<div class="col-sm-12">
														<table style="height: 40px; border: 0px;">
															<tr>
																<td id="guivalDev_${info.key_id}">
																	<c:forEach items="${attrList}" var="info22" varStatus="ind22">
																		<c:if test="${info22.parent_id==info.key_id }"> 
																			<c:forEach items="${product.idslist}" var="info44"> 
																    		<c:if test="${info44==info22.key_id }">
																    			 <a href="javascript:;" id="${info22.key_id}" class="ids${ind.count} btn btn-default" onclick="guigeClick(this,${ind.count})">${info22.key_name }</a>
																				 <c:set var="skuCount" value="${skuCount+1}"></c:set> 
																    		</c:if>
																    		</c:forEach>
								                                    	</c:if>
																	</c:forEach>
																</td>
															</tr>
														</table>
													</div>
													<hr class="col-sm-12 m-0 p-0" style="padding:0px;margin:0px;">
												</div>
											</c:if>					    			 
										</c:forEach>
								</c:forEach> 
				    	</div>
				    </div>
				    </c:if>
				    <div class="form-group" style="margin-bottom:10px;">
				     	<label class="control-label col-md-2 text-right" style="padding:0px;margin:0px;">库存：</label>
				     	<div class="col-md-10" id="idstock">
				        	${product.stock}
				      	</div>
				    </div>
				    <div class="form-group" style="margin-bottom:10px;">
				     	<label class="control-label col-md-2 text-right" style="padding:0px;margin:0px;">分类：</label>
				     	<div class="col-md-10">
				        	${product.firstCateName}
							<c:if test="${!empty product.secondCateName}">
                       		&gt;${product.secondCateName}
                    			</c:if>
							<c:if test="${!empty product.thirdCateName}">
                       		&gt;${product.thirdCateName}
                   			</c:if>
				      	</div>
				    </div>
				    <div class="form-group" style="margin-bottom:10px;">
				     	<label class="control-label col-md-2 text-right" style="padding:0px;margin:0px;">商品ID：</label>
				     	<div class="col-md-10">
				        	${product.product_id}
				      	</div>
				    </div>
				</div>
				
				<div class="col-md-12">
					<div class="col-md-6">
						<div class="input-group">
							<h5>商品介绍</h5>
							<c:forEach items="${product.mitems}" var="info" varStatus="ind" >
								${info}<br/>
							</c:forEach>
						</div>
						<div class="input-group">
							 ${product.editorValue}
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
var custom=new Array(); 
var smarket=new Array();
var sale=new Array();
var stock=new Array();

$(document).ready(function() { 
	<c:forEach items="${product.skulist}" var="info" varStatus="ind">
		custom[${ind.count-1}]='${info.spec_custom}'; 
		smarket[${ind.count-1}]='${info.smarket_price}'; 
		sale[${ind.count-1}]='${info.sale_price}'; 
		stock[${ind.count-1}]='${info.stock}'; 
	</c:forEach>
	
	var idStr="";
	<c:forEach items="${product.guigeList}" var="info" varStatus="ind"> 
		$(".ids${ind.count}").each(function(index){
			if(index==0){
				$(this).addClass("bg-primary");  
				if(idStr==""){
					idStr=$(this).attr("id");
				}else{
					idStr=idStr+";"+$(this).attr("id");
				}
			}
		});
	</c:forEach>
	if(idStr!=""){
		for ( var m = 0; m < custom.length; m++) {
			if(idStr==custom[m]){ 
				$("#idsmarket").html("￥"+smarket[m]);
				$("#shopsale").html("￥"+sale[m]);
				$("#shopsmarket").html("￥"+smarket[m]);
				$("#idstock").html(stock[m]);
				break;
			}
		}
	}
});

function imgclick(obj,img,id){
	$("#midimg").attr("src",img);
	$("#onlickImg").attr("id","");
	$(obj).attr("id","onlickImg");
}

function guigeClick(obj,num,id){ 
	$(".ids"+num).removeClass("bg-primary");
	$(obj).addClass("bg-primary");  
	
	var idStr="";
	$(".bg-primary").each(function(){
		if(idStr==""){
			idStr=$(this).attr("id");
		}else{
			idStr=idStr+";"+$(this).attr("id");
		}
	});
	for ( var m = 0; m < custom.length; m++) {
		if(idStr==custom[m]){ 
			$("#idsmarket").html("￥"+smarket[m]);
			$("#shopsale").html("￥"+sale[m]);
			$("#shopsmarket").html("￥"+smarket[m]);
			$("#idstock").html(stock[m]);
			break;
		}
	}
	
}
</script>
 