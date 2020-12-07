<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>
<!-- Main content -->
			<div class="content-wrapper">
				 
				 <!-- Page header -->
				<div class="page-header">
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> 
								<span class="text-semibold"> 模板管理</span>
							</h4>
						</div>
						<div class="heading-elements"> 
							<ul class="breadcrumb-elements"> 
								<li><button type="button"class="btn btn-info btn-xlg" onclick="WIAdd()" style="border-radius:0;"><i class="icon-add position-left"></i>创建新模板</button></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /page header -->
				
				<!-- Content area -->
				<div class="content">
					<!-- Tabs -->
					<ul class="nav nav-lg nav-tabs nav-tabs-bottom search-results-tabs">
						<li ${empty queryParam.template_cate_id?'class="active"':''}><a href="${pageContext.request.contextPath}/center/template/templateList"><i class="icon-display4 position-left"></i> 所有模板</a></li>
						<c:forEach items="${cateList }" var="cate">
							<li ${queryParam.template_cate_id eq cate.cate_id?'class="active"':''}><a href="${pageContext.request.contextPath}/center/template/templateList?template_cate_id=${cate.cate_id}">${cate.cate_name }</a></li>
						</c:forEach>
					</ul>
					<!-- /tabs -->
					
					<!-- Search results -->
					<div class="content-group">
					
					<form class="form-horizontal"  name="searchform" id="searchform" 
							action="${pageContext.request.contextPath}/center/template/templateList" method="post" >
						<div class="search-results-list content-group">
							<div class="row">
								<c:forEach items="${pageInfo.list}" var="template">
									<div class="col-md-3" style="width:260px;height:550px;">
										<div class="thumbnail">
											<div style="overflow:hidden;text-align: center;"> 
												<h6 class="text-bold">${template.template_name}</h6>
											</div>
											<div class="thumb">
												<img src="${imageDomain }${template.template_img}" alt="" >
												<div class="caption-overflow">
													<span>
<%-- 														<a href="http://m.winwinabc.com/webshop/index.html#/?shop_id=${template.template_id }" class="btn bg-info btn-rounded btn-icon" target="_blank"><i class="icon-zoomin3"></i>预览</a> --%>
														<a href="javascript:;"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="WIEdit('${template.validate_id}','${template.validate_id_token }')" ><i class="icon-link"></i>编辑</a>
														<a href="javascript:;" onclick="WIremove('${template.validate_id}','${template.validate_id_token }','${template.template_name}')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt"></i>删除</a>
													 </span>
												</div>
											</div>
											<div class="caption" style="overflow:hidden;text-align: center;">
													<c:if test="${template.state ==0}">
						                           		<a href="javascript:;" title="点击下架" class="btn btn-success m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${template.validate_id},'${template.validate_id_token}','${template.template_name}',-1)">上架中</a>
						                           	</c:if>
						                           	<c:if test="${template.state==-1}">
														<a href="javascript:;" title="点击上架" class="btn btn-warning m-r-5 m-b-5"
															style="height: 22px; padding-top: 0px;"
															onclick="mUpdate(${template.validate_id},'${template.validate_id_token}','${template.template_name}',0)">已下架</a>
													</c:if>
												</h6>
											</div>
										</div>
									</div>
								</c:forEach>
							 </div>
							 <br><br><br><br><br><br><br>
							 <div id="pager" class="panel-body">												
							 </div>
	                    </div>
						</form>
					</div>
					<!-- /search results -->
					
					
					
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
				
				function WIAdd(){
					window.location="${pageContext.request.contextPath}/center/template/templateCreate";
				}
				
				function WIEdit(validate_id,validate_id_token){
					window.location="${pageContext.request.contextPath}/center/template/templateCreate?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
				}
				
				function WIremove(validate_id,validate_id_token,name){
					var url="${pageContext.request.contextPath}/center/template/templateRemove?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
					Mremove("get",url,'确定要删除模板 <label style="color:red;">'+name+'</label> 吗？');
				}
				
				function mUpdate(id,validate_id_token,name,state){
					var title="";
					if(state=="-1"){
						title='确定要下架模板 <label style="color: red;">'+name+'</label> 吗？';
					}
					if(state=="0"){
						title='确定要上架模板 <label style="color: red;">'+name+'</label> 吗？';
					}
					MConfirm(title,'','',function(result) {
						if(result){
							window.location="${pageContext.request.contextPath}/center/template/templateState?state="+state+"&validate_id="+id+"&validate_id_token="+validate_id_token;
						}
					});
				}
			</script>
