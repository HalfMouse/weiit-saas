<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
					<!-- select product modal -->
					<div id="select_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择商品</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">商品标题</span>
												<input type="text" class="form-control"  name="product_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="product_search">搜索</button>
										<table id="data-table" class="table product_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">商品</th>
													<th class="col-lg-2">价格</th>
													<th class="col-lg-2">库存</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					<!-- select product modal -->
					<div id="custom_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择微页面</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">页面名称</span>
												<input type="text" class="form-control"  name="custom_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="custom_search">搜索</button>
										<table id="data-table2" class="table custom_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">标题</th>
													<th class="col-lg-4">创建时间</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					<!-- select product modal -->
					<div id="tag_modal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h5 class="modal-title">选择商品分组</h5>
								</div>
	
								<div class="modal-body">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-addon">分组名称</span>
												<input type="text" class="form-control"  name="tag_name" value="" placeholder="支持模糊匹配">
											</div>
										</div>
										
										&nbsp;&nbsp;
										<button class="btn bg-blue" type="button" id="tag_search">搜索</button>
										<table id="data-table3" class="table tag_sort_table table-hover">
											<thead>
												<tr >
													<th class="col-lg-4">分组名称</th>
													<th class="col-lg-4">创建时间</th>
													<th class="col-lg-2">操作</th>
												</tr>
											</thead>
										</table>
								</div>
								
							</div>
						</div>
					</div>
					<!-- /select product modal -->
					
					<script>
					var option_table=1;
					
					$("#product_search").click(function(){
						var product_name=$("input[name='product_name']").val();
						showTable(product_name);
					});
					$("#custom_search").click(function(){
						var custom_name=$("input[name='custom_name']").val();
						showTableCustom(custom_name);
					});
					$("#tag_search").click(function(){
						var tag_name=$("input[name='tag_name']").val();
						showTableTag(tag_name);
					});
					
					function showTableCustom(name){
						option_table=1;
						$("#custom_modal").modal("show");
						$('.custom_sort_table').DataTable({
					    	ajax: '${pageContext.request.contextPath}/center/design/page/pageList.json?custom_name='+name,
					        columns: [
					             {data: "page_name"},
					             {data: "create_time" },
					             {data: "option"}
					         ],
					        bDestroy:!0,
					    	bLengthChange:!1,
					        bFilter:!1,
					        bAutoWidth:!1,
					        iDisplayLength:5,
					        oLanguage: {
				                oAria: {
				                    sSortAscending: ": 升序排序",
				                    sSortDescending: ": 降序排序"
				                },
				                oPaginate: {
				                    sFirst: "首页",
				                    sLast: "末页",
				                    sNext: "下一页",
				                    sPrevious: "上一页"
				                },
				                sEmptyTable: "没有微页面数据",
				                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
				                sInfoEmpty: "当前 0 - 0 条  共  0 条",
				                sInfoFiltered: "(filtered from _MAX_ total entries)",
				                sInfoPostFix: "",
				                sDecimal: "",
				                sThousands: ",",
				                sLengthMenu: "显示 _MENU_ 条",
				                sLoadingRecords: "加载中...",
				                sProcessing: "进行中...",
				                sSearch: "Search:",
				                sSearchPlaceholder: "",
				                sUrl: "",
				                sZeroRecords: "没有微页面数据"
				            }
					    });
					}
					
					function showTableTag(name){
						option_table=2;
						$("#tag_modal").modal("show");
						$('.tag_sort_table').DataTable({
					    	ajax: '${pageContext.request.contextPath}/center/productGroup/groupList.json?group_name='+name,
					        columns: [
					             {data: "group_name"},
					             {data: "create_time" },
					             {data: "option"}
					         ],
					        bDestroy:!0,
					    	bLengthChange:!1,
					        bFilter:!1,
					        bAutoWidth:!1,
					        iDisplayLength:5,
					        oLanguage: {
				                oAria: {
				                    sSortAscending: ": 升序排序",
				                    sSortDescending: ": 降序排序"
				                },
				                oPaginate: {
				                    sFirst: "首页",
				                    sLast: "末页",
				                    sNext: "下一页",
				                    sPrevious: "上一页"
				                },
				                sEmptyTable: "没有商品组数据",
				                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
				                sInfoEmpty: "当前 0 - 0 条  共  0 条",
				                sInfoFiltered: "(filtered from _MAX_ total entries)",
				                sInfoPostFix: "",
				                sDecimal: "",
				                sThousands: ",",
				                sLengthMenu: "显示 _MENU_ 条",
				                sLoadingRecords: "加载中...",
				                sProcessing: "进行中...",
				                sSearch: "Search:",
				                sSearchPlaceholder: "",
				                sUrl: "",
				                sZeroRecords: "没有商品分组数据"
				            }
					    });
					}
					
					function showTable(product_name){
						option_table=3;
						$("#select_modal").modal("show");
						$('.product_sort_table').DataTable({
					    	ajax: '${pageContext.request.contextPath}/center/product/productList.json?product_name='+product_name,
					        columns: [
					             {data: "product_info"},
					             {data: "sale_price" },
					             {data: "stock"},
					             {data: "option"}
					         ],
					        bDestroy:!0,
					    	bLengthChange:!1,
					        bFilter:!1,
					        bAutoWidth:!1,
					        iDisplayLength:5,
					        oLanguage: {
				                oAria: {
				                    sSortAscending: ": 升序排序",
				                    sSortDescending: ": 降序排序"
				                },
				                oPaginate: {
				                    sFirst: "首页",
				                    sLast: "末页",
				                    sNext: "下一页",
				                    sPrevious: "上一页"
				                },
				                sEmptyTable: "没有商品数据",
				                sInfo: "当前 _START_ - _END_ 条    共  _TOTAL_ 条",
				                sInfoEmpty: "当前 0 - 0 条  共  0 条",
				                sInfoFiltered: "(filtered from _MAX_ total entries)",
				                sInfoPostFix: "",
				                sDecimal: "",
				                sThousands: ",",
				                sLengthMenu: "显示 _MENU_ 条",
				                sLoadingRecords: "加载中...",
				                sProcessing: "进行中...",
				                sSearch: "Search:",
				                sSearchPlaceholder: "",
				                sUrl: "",
				                sZeroRecords: "没有商品数据"
				            }
					    });
					}
					 
					function selectProduct(id,name){
						console.log(name);
						
						if(option_table==1){//选中微页面
							console.log("微页面");
							  
							if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
								var index=$(".delete_menu").attr("index");//菜单索引
								root_menu_list[index].type="2";
								root_menu_list[index].body.link.page="index";
								root_menu_list[index].body.link.url=id;
								root_menu_list[index].body.link.title=name;
							}
							if($(".delete_menu").attr("ischild")=='1'){//二级菜单
								var index=$(".delete_menu").attr("index").split("-");
								root_menu_list[index[0]].childs[index[1]].type="2";
								root_menu_list[index[0]].childs[index[1]].body.link.page="index";
								root_menu_list[index[0]].childs[index[1]].body.link.url=id; 
								root_menu_list[index[0]].childs[index[1]].body.link.title=name;
							}
						
						}else if(option_table==2){//选中商品组
							console.log("商品组");
							if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
								var index=$(".delete_menu").attr("index");//菜单索引
								root_menu_list[index].type="2";
								root_menu_list[index].body.link.page="productGroup";
								root_menu_list[index].body.link.url=id;
								root_menu_list[index].body.link.title=name;
							}
							if($(".delete_menu").attr("ischild")=='1'){//二级菜单
								var index=$(".delete_menu").attr("index").split("-");
								root_menu_list[index[0]].childs[index[1]].type="2";
								root_menu_list[index[0]].childs[index[1]].body.link.page="productGroup";
								root_menu_list[index[0]].childs[index[1]].body.link.url=id;
								root_menu_list[index[0]].childs[index[1]].body.link.title=name;
							}
						
						}else if(option_table==3){  
							console.log("商品详情");
							if($(".delete_menu").attr("ischild")=='0'){//表示一级菜单
								var index=$(".delete_menu").attr("index");//菜单索引
								root_menu_list[index].type="2";
								root_menu_list[index].body.link.page="detail";
								root_menu_list[index].body.link.url=id; 
								root_menu_list[index].body.link.title=name; 
							}
							if($(".delete_menu").attr("ischild")=='1'){//二级菜单
								var index=$(".delete_menu").attr("index").split("-");
								root_menu_list[index[0]].childs[index[1]].type="2";
								root_menu_list[index[0]].childs[index[1]].body.link.page="detail";
								root_menu_list[index[0]].childs[index[1]].body.link.url=id;
								root_menu_list[index[0]].childs[index[1]].body.link.title=name;
								
							}
							
						} 
						
						$(".close").click(); //关闭弹出框
						freshMenu(root_menu_list); 
						initRirght(); //刷新右边设置内容
					}
					</script>