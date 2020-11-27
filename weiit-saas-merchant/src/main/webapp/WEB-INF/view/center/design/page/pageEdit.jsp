<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/minified/main.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/shopTemplate/user.css">

 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/ueditor.all.min.js"></script>
 <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
 <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
 <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resource/js/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>					

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>店铺装修</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li class="active"><a href="${pageContext.request.contextPath}/center/design/page/pageList"><i class="icon-html5"></i>微页面</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/bottomMenu"><i class="icon-cube4"></i>底部菜单</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				<!-- Page header -->
				<div class="page-header" >
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold">${title}</span>
							</h4>
						</div> 
					</div>  
				</div>
				<!-- /page header -->
			
				<form class="form-horizontal " method="POST"  name="infoForm" id="infoForm"
					action="${pageContext.request.contextPath}/center/design/page/pageSave" enctype="multipart/form-data" >												
					<input type="hidden" name="validate_id" id="validate_id" value="${infoMap.validate_id}"/>
					<input type="hidden" name="validate_id_token" id="validate_id_token" value="${infoMap.validate_id_token}"/>
				<!-- Content area -->
				<div class="content" style="padding-top:0px;margin-top:0px;">
						
					<div class="panel-content">
			          <div class="main-content-area">
			               <div class="row">
			                    <div style="width:340px;float:left;">
			                         <div class="widget white" style="width:320px;background:#fafafa;padding-top:0px;margin-top:0px;">
			                        	  <div class="widget-titlebar">
			                         	 	<h5 class="text-white text-center" style="margin-top:7px;" id="nameH5" >${(empty infoMap.name)?"会员中心":infoMap.name}</h5>
			                              </div>
			                              <div class="widget-content">
			                                   <div class="">
			                                   		<ul class="sortable list" id="labelH5">
			                                   		</ul>
			                                   </div>
			                              </div>
			                              <div class="custom_content" > 
			                              	<h5 class="text-default  text-center" style="margin-top:7px;">自定义添加</h5>
			                              	<div class="row" style="padding:0px;margin:0px;">
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(1)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">店招</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(2)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">图片广告</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(3)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">图标导航</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(4)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">搜索框</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(5)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">商品列表</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(6)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">商品分组</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(7)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">文本导航</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(8)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">标题</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(9)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">富文本</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(10)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">语音</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(11)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">视频</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(12)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">公告</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(13)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">客服电话</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(14)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">辅助空白</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(15)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">辅助线</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(16)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">优惠券</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(17)" style="ackground:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">拼团</span>
			                              			</div>
			                              		</div>
			                              		<div class="col-md-3" style="margin-bottom:20px;">
			                              			<div onclick="labelClick(18)" style="background:white;width:56px;height:30px;display:table-cell;border:1px solid #d1d1d1;text-align:center;cursor:pointer;padding-top:5px;">
			                              				<span class="text-primary">秒杀</span>
			                              			</div>
			                              		</div>
			                              	</div>
			                              </div>
			                         </div>
			                    </div>
			                    <div style="margin-left:350px;">
			                         <div class="row">
										<div class="col-md-12" data-role="listview" id="divH5">
											<!-- 表单验证开始 -->
											<div class="panel panel-flat" style="padding-bottom:0px;margin-bottom:0px;">
												<div class="panel-body" style="padding:0px;margin: 0px;">
													<fieldset class="content-group">
														<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>页面基础设置</h4></legend>
														<div class="form-group">
															<label class="control-label col-md-2 text-right">页面标题：</label>
															<div class="col-md-5">
																<input type="text"  name="custom_name" id="custom_name" class="form-control" required="required" value="${infoMap.custom_name}">
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-2 text-right">页面描述：</label>
															<div class="col-md-5">
																<input type="text"  name="custom_desc" id="custom_desc" class="form-control" required="required" value="${infoMap.custom_desc}">
															</div>
														</div>
														<div class="form-group">
															<label class="control-label col-md-2 text-right">卡片封面:</label>
															<div class="col-md-6 "> 
																背景色<input type="text" name="bgcolor" class="form-control colorpicker-show-input" data-preferred-format="hex" value="${(empty infoMap.bgcolor)?'#f75d1c':infoMap.bgcolor}">
															</div>
														</div>	
													</fieldset>
												</div>
											</div>
											<!-- /form validation -->
 
											
										</div>
									 </div>

			                    </div>
			               		</div>
			               </div>
			               
			          </div>
			     	</div><!-- Panel Content -->
					<div class="form-group " style="width:100%; margin:0 auto; overflow:hidden; position: fixed; bottom:0;">
						<ul class="nav nav-pills col-sm-12  alert-danger" style="margin:0px;padding:0px;">
							<li class="col-sm-12" style="padding-top:10px;padding-bottom:10px;margin-left:30%">
								<button type="button" class="btn btn-primary" onclick="saveButton(this,'数据保存中，请稍后。。。')">保存<i class="icon-checkmark3 position-right"></i></button>
								<button type="button" class="btn btn-default" onclick="document.location.reload()">重置 <i class="icon-reload-alt position-right"></i></button>				
							</li>
						</ul>
					</div> 	 
				 
				
				</form>
			
				
			</div>
			<!-- /main content -->
			<%@include file="custom.jsp"%>
			<%@include file="../../common/footer.jsp"%>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/app.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/divsort/common.js"></script>
			<script>
			var ue = UE.getEditor('editor');
			$(document).ready(function() { 
				colorReady(); 
				
				openSource("#filedianzhao");
				initPicture("${imageDomain }","${infoMap.user_img}","#filedianzhao",320,160);
				
				<c:forEach items="${targetList}" var="info" varStatus="ind" >
					var param= new Array();
						param[0]='${info.target_id}';
						param[1]='${info.target_set1}';
						param[2]='${info.target_set2}';
						param[3]='${info.target_set3}';
						param[4]='${info.target_set4}';
						param[5]='${info.target_set5}';
						param[6]='${info.target_set6}';
						param[7]='${info.target_set7}';
						param[8]='${info.target_set8}';
						param[9]='${info.target_set9}';
						param[10]='${info.target_set10}';
						param[11]='${info.target_set11}';
						param[12]='${info.target_set12}';
						param[13]='${info.target_set13}';
						param[14]='${info.target_set14}';
						param[15]='${info.target_set15}';
						param[20]='${info.parent_id}';
						param[21]='${info.target_text}';
					if("${info.parent_id}"=="-1"){
						labelClick('${info.target_type}',param); 
					}else{
						paramSet('${info.target_type}',param); 
					}
	    		</c:forEach>
			});
			
			function colorReady(){
				$(".colorpicker-show-input").spectrum({
			    	showInput: true,
			    	cancelText: "取消",
			        chooseText: "确定",
			        change: function(c) { 
			        }
			    });
			}
			
			var customNum=0;
			function customClick(num){
				$("div[id^='custonDiv']").removeClass("show");
				$("div[id='custonDiv"+num+"']").addClass("show");
			}
			
			function labelClick(num,obj){
				customNum++;
				var labelH5="";
				var randomNum = (new Date()).valueOf();
				if(num==1){
					labelH5='<li style="background:white;padding:0px;margin:0px;"  onclick="customClick(\'1_'+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\'1_'+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>'
			    		 		+'<img src="${pageContext.request.contextPath}/resource/images/custom/dianzhao.png" >'
			    		 		+'<input type="hidden"  name="targetType1" id="targetType1" class="form-control" value="1">'
                		 		+'</li>';
				}else if(num==2){
					labelH5='<li style="background:white;padding:0px;margin:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>'			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/banner.png" >'
			    		 		+'<input type="hidden"  name="targetType2" id="targetType2" class="form-control" value="2">'
    		 					+'</li>';
				}else if(num==3){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>'
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/tubiao.png" >'
			    		 		+'<input type="hidden"  name="targetType3" id="targetType3" class="form-control" value="3">'
					 			+'</li>';
				}else if(num==4){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/sousuo.png" >'
			    		 		+'<input type="hidden"  name="targetType4" id="targetType4" class="form-control" value="4">'
					 			+'</li>';
				}else if(num==5){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/shangpin.png" >'
			    		 		+'<input type="hidden"  name="targetType5" id="targetType5" class="form-control" value="5">'
					 			+'</li>';
				}else if(num==6){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/shangpinfenzu.png" >'
			    		 		+'<input type="hidden"  name="targetType6" id="targetType6" class="form-control" value="6">'
					 			+'</li>';
				}else if(num==7){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/biaotidaohang.png" >'
			    		 		+'<input type="hidden"  name="targetType7" id="targetType7" class="form-control" value="7">'
					 			+'</li>';
				}else if(num==8){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/biaoti.png" >'
			    		 		+'<input type="hidden"  name="targetType8" id="targetType8" class="form-control" value="8">'
					 			+'</li>';
				}else if(num==9){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/fuwenben.png" >'
			    		 		+'<input type="hidden"  name="targetType9" id="targetType9" class="form-control" value="9">'
					 			+'</li>';
				}else if(num==10){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/yuyin.png" >'
			    		 		+'<input type="hidden"  name="targetType10" id="targetType10" class="form-control" value="10">'
					 			+'</li>';
				}else if(num==11){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/shipin.png" >'
			    		 		+'<input type="hidden"  name="targetType11" id="targetType11" class="form-control" value="11">'
					 			+'</li>';
				}else if(num==12){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/gonggao.png" >'
			    		 		+'<input type="hidden"  name="targetType12" id="targetType12" class="form-control" value="12">'
					 			+'</li>';
				}else if(num==13){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/kefu.png" >'
			    		 		+'<input type="hidden"  name="targetType13" id="targetType13" class="form-control" value="13">'
					 			+'</li>';
				}else if(num==14){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/kongbai.png" >'
			    		 		+'<input type="hidden"  name="targetType14" id="targetType14" class="form-control" value="14">'
					 			+'</li>';
				}else if(num==15){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/fengexian.png" >'
			    		 		+'<input type="hidden"  name="targetType15" id="targetType15" class="form-control" value="15">'
					 			+'</li>';
				}else if(num==16){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
					+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
					+'<img src="${pageContext.request.contextPath}/resource/images/custom/youhuiquan.png" >'
    		 		+'<input type="hidden"  name="targetType16" id="targetType16" class="form-control" value="17">'
		 			+'</li>';
				}else if(num==17){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/pingtuan.png" >'
			    		 		+'<input type="hidden"  name="targetType17" id="targetType17" class="form-control" value="19">'
					 			+'</li>';
				}else if(num==18){
					labelH5='<li style="background:white;padding:0px;"  onclick="customClick(\''+num+"_"+customNum+'\')">'
								+'<div style="margin-top:-20px;"><img name="delete'+randomNum+'" onclick="onclickDelete(this,\''+num+"_"+customNum+'\')" id="adelete" src="${pageContext.request.contextPath}/resource/images/delete.png" '
			    		 		+'style="position: relative; top: 20px; right: -300px; cursor: pointer;"></div>' 			
								+'<img src="${pageContext.request.contextPath}/resource/images/custom/miaosha.png" >'
			    		 		+'<input type="hidden"  name="targetType18" id="targetType18" class="form-control" value="16">'
					 			+'</li>';
				}
				$("#labelH5").append(labelH5);
 
				//复制 .clone(true)
				var divcust=$("#custonDiv"+num).attr('id','custonDiv'+num+"_"+customNum);
// 				var divH5 = $('<div id="custonDiv'+num+"_"+customNum+'" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;"></div>');
// 					divH5.append($(divcust));
				$("#divH5").append(divcust);
				  
				$("div[id^='custonDiv']").removeClass("show");
				$("div[id='custonDiv"+num+"_"+customNum+"']").addClass("show");
				
				if(obj !=undefined){
					if(num==1){
						$("#custonDiv"+num+"_"+customNum+" input[name=dianzhao1][value="+obj[1]+"]").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=dianzhao1][value="+obj[1]+"]").trigger('click');
						$("#custonDiv"+num+"_"+customNum+" #dianzhao2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" #dianzhao3").val(obj[3]);
						colorReady();
						initPicture("${imageDomain }", obj[3] ,"#filedianzhao",320,160);
					}else if(num==2){
						$("#custonDiv"+num+"_"+customNum+" input[name=tupian1][value="+obj[1]+"]").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=tupian1][value="+obj[1]+"]").trigger('click'); 
					}else if(num==3){
						$("#custonDiv"+num+"_"+customNum+" input[name=tubiao1][value="+obj[1]+"]").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=tubiao1][value="+obj[1]+"]").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=tubiao2][value="+obj[2]+"]").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=tubiao2][value="+obj[2]+"]").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #tubiao3").val(obj[3]);
					}else if(num==4){
						$("#custonDiv"+num+"_"+customNum+" input[name=sousuo1][value="+obj[1]+"]").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=sousuo1][value="+obj[1]+"]").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=sousuo2]").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" input[name=sousuo3]").val(obj[3]);
						colorReady();
					}else if(num==5){
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin1][value='"+obj[1]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin1][value='"+obj[1]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #shangpin2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin3][value='"+obj[3]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin3][value='"+obj[3]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin4][value='"+obj[4]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin4][value='"+obj[4]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin5][value='"+obj[5]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin5][value='"+obj[5]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin6][value='"+obj[6]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin6][value='"+obj[6]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin7][value='"+obj[7]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin7][value='"+obj[7]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin8][value='"+obj[8]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin8][value='"+obj[8]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin9][value='"+obj[9]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin9][value='"+obj[9]+"']").trigger('click');
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin10][value='"+obj[10]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=shangpin10][value='"+obj[10]+"']").trigger('click'); 
					}else if(num==6){
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz1][value='"+obj[1]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz1][value='"+obj[1]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #spfz2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz3][value='"+obj[3]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz3][value='"+obj[3]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz4][value='"+obj[4]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz4][value='"+obj[4]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz5][value='"+obj[5]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz5][value='"+obj[5]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz6][value='"+obj[6]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz6][value='"+obj[6]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz7][value='"+obj[7]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz7][value='"+obj[7]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz8][value='"+obj[8]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz8][value='"+obj[8]+"']").trigger('click');
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz9][value='"+obj[9]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz9][value='"+obj[9]+"']").trigger('click'); 
						 
						$("#custonDiv"+num+"_"+customNum+" #spfz2").trigger('change');
					}else if(num==7){
						$("#custonDiv"+num+"_"+customNum+" #wbdaohang1").val(obj[1]);
						$("#custonDiv"+num+"_"+customNum+" #wbdaohang2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" #wbdaohang3").val(obj[3]);
						$("#custonDiv"+num+"_"+customNum+" #wbdaohang4").val(obj[4]);
						$("#custonDiv"+num+"_"+customNum+" #wbdaohang5").val(obj[5]);
						 
						$("#custonDiv"+num+"_"+customNum+" #wbdaohang3").trigger('change');
						initPicture("${imageDomain }", obj[5] ,"#filewbdaohang1",100,100);
					}else if(num==8){
						$("#custonDiv"+num+"_"+customNum+" #biaoti1").val(obj[1]);
						$("#custonDiv"+num+"_"+customNum+" #biaoti2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" #biaoti3").val(obj[3]);
						$("#custonDiv"+num+"_"+customNum+" #biaoti4").val(obj[4]);
						$("#custonDiv"+num+"_"+customNum+" #biaoti5").val(obj[5]);
						$("#custonDiv"+num+"_"+customNum+" #biaoti6").val(obj[6]);
						$("#custonDiv"+num+"_"+customNum+" #biaoti5").trigger('change'); 
					}else if(num==9){
						ue.addListener("ready", function () {
							ue.setHeight(300);
					    	// editor准备好之后才可以使用 
							ue.setContent(obj[21]);
						});
					}else if(num==10){
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz4][value='"+obj[4]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz4][value='"+obj[4]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz5][value='"+obj[5]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=spfz5][value='"+obj[5]+"']").trigger('click'); 
						
						$("#custonDiv"+num+"_"+customNum+" #yuyin1").val(obj[1]);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin2][value='"+obj[2]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin2][value='"+obj[2]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #yuyin3").val(obj[3]);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin4][value='"+obj[4]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin4][value='"+obj[4]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #yuyin5").val(obj[5]);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin6][value='"+obj[6]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin6][value='"+obj[6]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin7][value='"+obj[7]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=yuyin7][value='"+obj[7]+"']").trigger('click'); 
						 
						initPicture("${imageDomain }", obj[5] ,"#fileyuyin1",100,100);
					}else if(num==11){
						$("#custonDiv"+num+"_"+customNum+" #shipin1").html(obj[21]);
					}else if(num==12){
						$("#custonDiv"+num+"_"+customNum+" #gonggao1").val(obj[1]);
						$("#custonDiv"+num+"_"+customNum+" #gonggao2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" #gonggao3").val(obj[3]);
						$("#custonDiv"+num+"_"+customNum+" #gonggao4").val(obj[4]);
						colorReady();
						$("#custonDiv"+num+"_"+customNum+" #gonggao2").trigger('change'); 
					}else if(num==13){
						$("#custonDiv"+num+"_"+customNum+" #kefu1").val(obj[1]);
						$("#custonDiv"+num+"_"+customNum+" #kefu2").val(obj[2]);
					}else if(num==14){
						$("#custonDiv"+num+"_"+customNum+" #kongbai1").val(obj[1]); 
					}else if(num==15){
						$("#custonDiv"+num+"_"+customNum+" input[name=fuzuxian1][value='"+obj[1]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=fuzuxian1][value='"+obj[1]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #fuzuxian2").val(obj[2]);
						colorReady();
					}else if(num==17){
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan1][value='"+obj[1]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan1][value='"+obj[1]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #pintuan2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan3][value='"+obj[3]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan3][value='"+obj[3]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan4][value='"+obj[4]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan4][value='"+obj[4]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan5][value='"+obj[5]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan5][value='"+obj[5]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan6][value='"+obj[6]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan6][value='"+obj[6]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan7][value='"+obj[7]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan7][value='"+obj[7]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan8][value='"+obj[8]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan8][value='"+obj[8]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan9][value='"+obj[9]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan9][value='"+obj[9]+"']").trigger('click');
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan10][value='"+obj[10]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=pintuan10][value='"+obj[10]+"']").trigger('click'); 
					}else if(num==18){
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha1][value='"+obj[1]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha1][value='"+obj[1]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" #miaosha2").val(obj[2]);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha3][value='"+obj[3]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha3][value='"+obj[3]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha4][value='"+obj[4]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha4][value='"+obj[4]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha5][value='"+obj[5]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha5][value='"+obj[5]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha6][value='"+obj[6]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha6][value='"+obj[6]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha7][value='"+obj[7]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha7][value='"+obj[7]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha8][value='"+obj[8]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha8][value='"+obj[8]+"']").trigger('click'); 
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha9][value='"+obj[9]+"']").attr("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha9][value='"+obj[9]+"']").trigger('click');
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha10][value='"+obj[10]+"']").prop("checked",true);
						$("#custonDiv"+num+"_"+customNum+" input[name=miaosha10][value='"+obj[10]+"']").trigger('click'); 
					}
				}
			}
			
			function paramSet(num,obj){
				if(num==2){
					$("#custonDiv"+num+"_"+customNum+" #tupianimg1").val(obj[1]);
					$("#custonDiv"+num+"_"+customNum+" #tupianname1").val(obj[2]); 
					$("#custonDiv"+num+"_"+customNum+" #tupianurltype1").val(obj[3]); 
					$("#custonDiv"+num+"_"+customNum+" #tupianurl1").val(obj[4]); 
					$("#custonDiv"+num+"_"+customNum+" #tupianurltype1").selectpicker('render');
					$("#custonDiv"+num+"_"+customNum+" #tupianurltype1").selectpicker('refresh');
					$("#custonDiv"+num+"_"+customNum+" #tupianurltype1").trigger('change');  
					initPicture("${imageDomain }", obj[1] ,"#filetupian1",50,50);
				}else if(num==3){
					$("#custonDiv"+num+"_"+customNum+" #tubiaoimg1").val(obj[1]);
					$("#custonDiv"+num+"_"+customNum+" #tubiaoname1").val(obj[2]); 
					$("#custonDiv"+num+"_"+customNum+" #tubiaonamecolor1").val(obj[3]); 
					$("#custonDiv"+num+"_"+customNum+" #tubiaourltype1").val(obj[4]);  
					$("#custonDiv"+num+"_"+customNum+" #tubiaourl1").val(obj[5]);  
					$("#custonDiv"+num+"_"+customNum+" #tubiaocolor1").val(obj[6]); 
					$("#custonDiv"+num+"_"+customNum+" #tubiaourltype1").selectpicker('render');
					$("#custonDiv"+num+"_"+customNum+" #tubiaourltype1").selectpicker('refresh');
					$("#custonDiv"+num+"_"+customNum+" #tubiaourltype1").trigger('change'); 
					colorReady();
					initPicture("${imageDomain }", obj[1] ,"#filetubiao1",50,50);
				}else if(num==16){
					$("#custonDiv"+num+"_"+customNum+" #youhuiquan1").val(obj[1]);
				}
			}
			
			function onclickDelete(obj,name){
				  $(obj).parents("li").remove();
				  $("#custonDiv"+name).remove();
			 }
			 
			function addTupian(num){
			    $("#tupianTable").find("tbody").append($("#tupianTr"));
			}
			function delRowTupian(nowTr){
				$(nowTr).parent().parent().remove();
			} 

	 
			</script>
						
