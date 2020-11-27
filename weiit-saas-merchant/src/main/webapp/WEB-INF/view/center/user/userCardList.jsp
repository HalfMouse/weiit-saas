<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/header.jsp" %>

			<!-- Secondary sidebar -->
			<div class="sidebar sidebar-secondary sidebar-default" style="width:180px">
				<div class="sidebar-content">
					<!-- Sub navigation -->
					<div class="sidebar-category">
						<div class="category-title">
							<span>客户管理</span>
						</div>
						<div class="category-content no-padding">
							<ul class="navigation navigation-alt navigation-accordion">
								<li><a href="userList"><i class="icon-users"></i>会员管理</a></li>
								<li class="active"><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
								<li><a href="userCashList"><i class="icon-cash"></i>会员提现</a></li>
								<li><a href="userSet"><i class="icon-gear"></i>会员设置</a></li>
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
				<div class="page-header">

					<!-- Header content -->
					<div class="page-header-content">
						<div class="page-title">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 会员卡管理 </span>
							</h4>
						</div>

						<div class="heading-elements">
							<a href="javascript:;" onclick="Mget('${pageContext.request.contextPath}/center/user/userCardCreate')" class="btn bg-blue btn-labeled heading-btn"><b><i class="icon-diff-added"></i></b> 创建卡片</a>
						</div>
					</div>
					<!-- /header content -->
				</div>
				<!-- /page header -->

				<!-- Content area -->
				<div class="content">
						
					
						<!-- Search results -->
						<div class="content-group">
	
							<div class="search-results-list content-group">
								<!-- Tasks grid -->
								<div class="text-center content-group text-muted content-divider">
									<span class="pt-10 pb-10">我的会员卡</span>
								</div>
								<!--/Tasks grid  --> 
								<div class="row">
								<c:forEach items="${cardList}" var="info">
									<div class="col-md-3" style="min-width:250px;max-width:320px;">
										<div class="thumbnail">
											<div class="thumb" >
												<div style="<c:if test="${info.card_bg_type==0 }">background:${info.card_bg_color };</c:if><c:if test="${info.card_bg_type==1 }">background:url(${info.card_img });</c:if>color:white;border-radius:6px;padding:20px" id="card-info-div">
				                                     <div class="card-info" style="width:100%;">
					                                        <div class="card-header" style="">
					                                           <img src="${imageDomain}/${shopInfo.shop_logo }" class="img-circle" width="30px" height="30px" style="width:30px;">
					                                            <span class="text-bold text-white">
																     ${shopInfo.shop_name }
																</span>
																<div class="card_qr_code" style="float:right;">
						                                             <img src="${pageContext.request.contextPath}/resource/images/shopTemplate/qc_code.png" class="img-circle" width="30px" height="30px"/>
						                                        </div>
					                                        </div> 
					                                             	
				                                       </div>
				                                       <div class="card-name" style="padding:20px 0">
				                                            <h2 class="text-bold text-white title" style="margin:0;line-height:1">${info.card_name }</h2>
				                                       </div>
				                                       <div class="card-limit">
				                                          <span class="text-bold text-white time_prew">
				                                             	<c:choose>
					                                             	<c:when test="${info eq null }">有效期:无期限</c:when>
					                                             	<c:otherwise>
					                                             		<c:if test="${info.limit_type==1 }">有效期:无期限</c:if>
					                                             		<c:if test="${info.limit_type==2 }">有效期:<fmt:formatDate value="${info.start_time }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${info.end_time }" pattern="yyyy-MM-dd"/></c:if>
					                                             	</c:otherwise>
				                                             	</c:choose>
					                                      </span>
				                                        </div>
												</div>
												<!-- <img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510750116708&di=2a92c61f9ae4b6e5ca491af24ae89faa&imgtype=0&src=http%3A%2F%2Ffile1.youboy.com%2Fe%2F2015%2F3%2F25%2F17%2F262087s.jpg" alt=""> -->
												<div class="caption-overflow">
													<span>
														<a href="${pageContext.request.contextPath}/center/user/userCardEdit?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}"   class="btn bg-blue-600 btn-rounded btn-icon" onclick="" ><i class="icon-link"></i>编辑</a>
														<a href="javascript:;" onclick="WIRemove('${info.validate_id}','${info.validate_id_token }','${info.card_name}')"  class="btn bg-danger btn-rounded btn-icon"><i class="icon-trash-alt"></i>删除</a>
													 </span>
												</div>
											</div>
	
											<div class="caption" style="height:96px;">
												<!-- <h6 class="text-bold"><a href="#" class="text-default">${info.card_name }</a></h6> -->
												<a href="${pageContext.request.contextPath}/center/user/userCardUser?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}"><i class="icon-user position-left"></i>查看会员</a>&nbsp;&nbsp;
												<a href="${pageContext.request.contextPath}/center/user/userCardGive?validate_id=${info.validate_id}&validate_id_token=${info.validate_id_token}"><i class="icon-credit-card position-left"></i>发卡</a>
												<br><br>
												<span class="text-muted">持卡享受：
													<c:if test="${info.is_free_shippiing eq 0}">包邮;</c:if>
													<c:if test="${info.discount gt 0}">会员折扣${info.discount}折;</c:if>
													<c:if test="${info.give_integral gt 0}">赠送${info.give_integral}积分</c:if>
												</span>
											</div>
										</div>
									</div>
								</c:forEach>
								 
								</div>
								
		                    </div>
	
						</div>
						<!-- /search results -->

				</div>
				<!-- /content area -->
				
			</div>
			
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			
<script> 
function WIRemove(validate_id,validate_id_token,card_name){ 
	var url="${pageContext.request.contextPath}/center/user/userCardRemove?validate_id="+validate_id+"&validate_id_token="+validate_id_token;
	Mremove("get",url,'确定要删除会员卡 <label style="color: red;">'+card_name+'</label> 吗？');
}
</script>
						
