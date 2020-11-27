<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../../common/header.jsp" %>

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
								<li><a href="${pageContext.request.contextPath}/center/design/page/feature"><i class="icon-html5"></i>微页面</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/globalStyle"><i class="icon-color-sampler"></i>全店风格</a></li>
								<li><a href="${pageContext.request.contextPath}/center/design/page/navigation"><i class="icon-menu9"></i>店铺导航</a></li>
							</ul>
						</div>
					</div>
					<!-- /sub navigation -->
					
				</div>
			</div>	
			<!--  /Secondary sidebar -->
			
			<!-- Main content -->
			<div class="content-wrapper">
				
			
				
			</div>
			<!-- /main content -->
			
			<%@include file="../../common/footer.jsp"%>
			
			<script>
			$(document).ready(function() {
			    $("#pager").pager({
			        pagenumber: ${pageInfo.pageNum}, 
			        pagecount: ${pageInfo.pages},
			        pagesize: ${pageInfo.pageSize} ,
			        pagerecordSize: ${pageInfo.total},
			        buttonClickCallback: searchSubmit });
			});
			 
			function mUpdate(id,token,name,status){
				var title="";
				if(status=="-1"){
					title='确定要禁用账户<label style="color: red;">'+name+'</label> 吗？';
				}
				if(status=="0"){
					title='确定要启用账户<label style="color: red;">'+name+'</label> 吗？';
				}
				MConfirm(title,'','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/users/user/status?is_disabled="+status+"&validate_id="+id+"&validate_id_token="+token;
					}
				});
			}
			 
			 //批量禁用，启用
			function BatchWIremove(is_disabled){
				var title="";
				if(is_disabled==-1){
					title='确定要批量禁用选择账户吗,禁用后用户无法登录？';
				}
				if(is_disabled==0){
					title='确定要批量启用选择账户吗？';
				}
				MremoveBath("input[name='ids']","${pageContext.request.contextPath}/center/users/user/statusBatch?is_disabled="+is_disabled,title);
			}
			 
			//excel导出
			function exportExcel(fileType){
				var exportClassName="com.weiit.web.admin.user.service.UserService";
				var	exportMethodName="selectList";
				var	exportExcelName="会员列表";
				var	exportTitles="用户账号,用户密码,用户名,用户积分,用户余额,用户手机,地区";
				var	exportFields="user_account,user_password,user_name,integral,balance,user_phone,region";	
				commonExportList("searchform",exportClassName,exportMethodName,exportExcelName,exportTitles,exportFields,fileType);
			}
			</script>
						
