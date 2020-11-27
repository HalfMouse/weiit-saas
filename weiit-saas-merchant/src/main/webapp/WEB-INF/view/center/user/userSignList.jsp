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
								<li><a href="userCardList"><i class="icon-vcard"></i>会员卡管理</a></li>
								<li class="active"><a href="userSignList"><i class="icon-lan2"></i>标签组管理</a></li>
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
					<div class="page-header-content">
						<div class="page-title" style="height:70px;padding-top:20px;">
							<h4>
								<i class="icon-arrow-left52 position-left"></i> <span
									class="text-semibold"> 标签组管理 </span>
							</h4>
						</div>
						<div class="heading-elements">
							<a href="javascript:;" onclick="add()" class="btn bg-blue"  data-toggle="modal" data-target="#dialog"><i class="icon-diff-added"></i> 新增标签组</a>
						</div>
					</div>
					
			
				</div>
				<!-- /page header -->
			 
				<!-- Content area -->
				<div class="content">
					<!-- Bordered striped table -->
					<div class="panel panel-flat">
			
						<div class="panel-body">
							<form class="form-horizontal" name="searchform" id="searchform" action="" method="post">
								
								<br> <br>
								<div class="table-responsive">
									<table id="data-table"
										class="table">
										<thead>
											<tr>
												<th><input type="checkbox" class="styled" name="allCheck" onclick="allCheckClick(this)" value="0" /></th>
												<th>标签名</th>
												<th>会员数</th> 
												<th>自动打标签条件</th>
												<th>创建时间</th>
												<th>修改时间</th>
												<th width="80">操作</th>
											</tr>
										</thead>
										<c:forEach items="${pageInfo.list}" var="sign">
											<tr>
												<td><input type="checkbox" class="styled" name="ids" value="${sign.validate_id }|${sign.validate_id_token}"></td>
												<td>${sign.sign_name }</td>
												<td>${sign.user_count }</td> 
												<td>
													<span class="text-muted">
													<c:if test="${sign.total_price_count>0.00 }">
														会员累积交易额达到￥${sign.total_price_count}，自动打标签<br>
													</c:if>
													<c:if test="${sign.order_count>0 }">
														会员累积订单笔数达到${sign.order_count}笔，自动打标签<br>
													</c:if>
													<c:if test="${sign.integral_count>0 }">
														会员累积积分数达到${sign.integral_count}，自动打标签<br>
													</c:if>
													<c:if test="${sign.total_price_count=='0.00' and sign.order_count=='0' and sign.integral_count=='0'}">
														未设置
													</c:if>
													</span>
												</td>  
												<td> 
													<fmt:formatDate value="${sign.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/>
												</td>
												<td>
													<fmt:formatDate value="${sign.update_time}" pattern="yyyy-MM-dd hh:mm:ss"/>
												</td>
												<td>
													
													<a href="javascript:;" onclick="edit('${sign.validate_id}','${sign.validate_id_token}')" title="编辑" class="btn bg-teal m-r-5 m-b-5" style="height: 22px;padding-top: 0px;"  data-toggle="modal" data-target="#dialog"><i class="icon-pencil7 position-left"></i>编辑</a>
													&nbsp;&nbsp;
													<a href="javascript:;" onclick="WIremove('${sign.validate_id}','${sign.sign_name }','${sign.validate_id_token}')" title="删除" class="btn bg-grey m-r-5 m-b-5" style="height: 22px; padding-top: 0px;"><i class="icon-trash-alt position-left"></i>删除</a>
												</td>
											</tr>
										</c:forEach> 
									</table>
			
								</div>
								
							</form>
						</div>
					</div> 
					<!-- /bordered striped table -->
			 
					<div id="dialog" class="modal fade" style="display:none; padding-right: 17px;padding-top: 100px;">
						<div class="modal-dialog modal-lg" style="padding-left:10%;">
							<div class="modal-content" style="width: 560px;">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">新增标签组</h5>
								</div>

								<form action="${pageContext.request.contextPath}/center/user/userSignSaveOrEdit" id="infoForm" class="form-horizontal" method="post">
									<div class="modal-body">
										<div class="form-group">
										 	<label class="control-label col-md-3 text-right"> <span  class="text-danger">*</span>标签组名称 </label>
											<div class="col-md-5">
												<input type="text" class="form-control validate[required]" name="sign_name"  id="sign_name" placeholder="请输入标签组名称" data-errormessage-value-missing="标签组名称不能为空" />
											</div>
										</div>
										<legend class="text-bold">自动升级条件</legend>
										
										<div class="form-group">
											<label class="control-label col-md-3 text-right">交易笔数满 </label>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text" name="order_count" id="order_count" class="form-control validate[required,custom[integer]]" placeholder="" value="0"  data-errormessage-value-missing="交易笔数限定不能为空" >
													<div class="input-group-addon">笔</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 text-right">或 消费金额满 </label>
											<div class="col-md-6">
												<div class="input-group">
													<input type="text" name="total_price_count"  id="total_price_count" class="form-control validate[required,custom[integer]]" placeholder="" value="0"  data-errormessage-value-missing="消费金额限定不能为空">
													<div class="input-group-addon">元</div>
												</div>
											</div>
										</div>  
										<div class="form-group">
											<label class="control-label col-md-3 text-right">或 累计积分满 </label>
											<div class="col-md-6">
												<div class="input-group"> 
													<input type="text" name="integral_count" id="integral_count" class="form-control validate[required,custom[integer]]" placeholder="" value="0"  data-errormessage-value-missing="累计积分限定不能为空">
													<div class="input-group-addon">积分</div>
												</div>
											</div>
										</div>
										<div class="alert alert-primary no-border">
											<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">关闭</span></button>
											<span class="text-semibold">
												会员标签组，即指可以创建不同的标签组，然后对会员进行分组管理<br><br>
												<span class="text-warning">自动升级条件</span>，设置了自动升级条件，当会员满足条件后会自动分配到该标签组下管理。0表示不设置</span><br>
											
										</div> 
									</div>

									<div class="modal-footer" style="text-align: center;">
										<input type="hidden" name="validate_id" class="validate_id" value=""/>
										<input type="hidden" name="validate_id_token" class="validate_id_token" value=""/>
										<button type="submit" class="btn btn-sm btn-primary">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					
				</div>
				<!-- /content area -->
			</div>
			<!-- /main content -->
			
			<%@include file="../common/footer.jsp"%>
			
			<script>
			$(document).ready(function() {
			  
			    /*默认监听表单onbulr验证*/
				$('#infoForm').validationEngine("attach",{ 
					promptPosition: 'bottomRight', 
					addPromptClass: 'blackPopup formError-small',
					scroll: true,
					showOneMessage: true
				});
			});
			
			function add(){
				$("#dialog").find(".modal-title").html("新增标签组");
				$("#sign_name").val("");
				$("#order_count").val("0");
				$("#total_price_count").val("0");
				$("#integral_count").val("0");
				$("#validate_id").val("0");
				$("#validate_id_token").val("0");
				
			}
			
			function edit(validate_id,validate_id_token){
				$("#dialog").find(".modal-title").html("编辑标签组");
				$.ajax({
				    url:'${pageContext.request.contextPath}/center/user/userSignView?validate_id='+validate_id+'&validate_id_token='+validate_id_token,
				    type:'GET', 
				    data:null,
				    dataType:'json',
				    success:function(result){
				        var result=result.data;
				        $("input[name='validate_id']").attr("value",validate_id);
				        $("input[name='validate_id_token']").attr("value",validate_id_token);
				        $("input[name='order_count']").attr("value",result.order_count);
				        $("input[name='total_price_count']").attr("value",result.total_price_count);
				        $("input[name='integral_count']").attr("value",result.integral_count);
				    },
				    error:function(xhr,textStatus){
				        console.log('错误');
				    }
				});
			}
			function WIremove(id,name,validate_id_token){
				MConfirm('确认要删除标签组  <label style="color: red;">'+name+'</label> 吗？','','',function(result) {
					if(result){
						window.location="${pageContext.request.contextPath}/center/user/userSignRemove?validate_id="+id+"&validate_id_token="+validate_id_token;
					}
				});
			} 
			</script>
						
