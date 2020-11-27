<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!-- 表单验证开始 -->
<div id="custonDiv1" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>店招设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">选择风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="dianzhao1" checked class="styled" value="0" >经典风格
						</label>
						<label class="radio-inline">
							<input type="radio" name="dianzhao1" class="styled" value="1" >高雅风格
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">卡片封面:</label>
					<div class="col-md-6 "> 
						背景色<input type="text" name="dianzhao2" id="dianzhao2" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
					</div>
				</div>	
				<div class="form-group">
					<label class="control-label col-md-2 text-right">店招图片：</label>
					<div class="col-md-6 text-left">
						<input type="file" name="filedianzhao"  class="bootstrap-uploader" id="filedianzhao" src="">
						<input type="hidden" name="dianzhao3" id="dianzhao3" value="">
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv2" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>图片模板设置</h4></legend>
				<div class="form-group"> 
					<label class="control-label col-md-2 text-right">显示方式：</label>
					<div class="col-md-10">
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1" checked class="styled" value="0" >
							<img src="https://mch.wxrrd.com/image/placehold/pic05.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="1" >
							<img src="https://mch.wxrrd.com/image/placehold/pic01.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="2" >
							<img src="https://mch.wxrrd.com/image/placehold/pic02.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="3" >
							<img src="https://mch.wxrrd.com/image/placehold/pic03.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="4" >
							<img src="https://mch.wxrrd.com/image/placehold/pic04.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="5" >
							<img src="https://mch.wxrrd.com/image/placehold/pic06.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="6" >
							<img src="https://mch.wxrrd.com/image/placehold/pic07.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="7" >
							<img src="https://mch.wxrrd.com/image/placehold/pic08.png" height="40" width="50">	
						</label>
						<label class="radio-inline" style="margin-left:5px;">
							<input type="radio" name="tupian1"  class="styled" value="8" >
							<img src="https://mch.wxrrd.com/image/placehold/pic09.png" height="40" width="50">	
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:20px;">
					<div class="col-md-4">
						<button type="button" class="btn btn-primary" onclick="addTupian(2)">添加图标<i class="icon-checkmark3 position-right"></i></button>
					</div>
				</div> 
				<div class="form-group" style="padding:0px;margin: 0px;padding-left:12px;padding-right:12px;">
					<div class="col-md-12 alert-danger">
						<table class="col-md-12" id="tupianTable">
							<tr id="tupianTr">
								<td>
									<input type="file" name="filetupian1"  class="bootstrap-uploader" id="filetupian1" src="">
									<input type="hidden" name="tupianimg1" id="tupianimg1" value="">
								</td>
								<td>
									<div class="form-group" style="padding-top:10px;margin-bottom:10px;">
										<label class="control-label col-md-3 text-right">图片标题：</label>
										<div class="col-md-7">
											<input type="text"  name="tupianname1" id="tupianname1" class="form-control" required="required" value="">
										</div>
									</div>
									<div class="form-group" style="padding-bottom: 15px;">
										<label class="control-label col-md-3 text-right">图片链接：</label>
										<div class="col-md-7">
											<input type="hidden" name="tupianurl1" id="tupianurl1" value="">
											<select class="select" data-width="100%" name="tupianurltype1" id="tupianurltype1">
												<option value="">--请选择--</option>
												<option value="0" >微页面</option>
												<option value="1">商品分组页</option>
												<option value="2">商品页</option>
												<option value="3">直接购买</option>
												<option value="4">店铺主页</option>
												<option value="5">个人中心</option>
												<option value="6">列表页</option>
											</select>
										</div>
									</div>
								</td>
								<td><a href="javascript:;" onclick="delRowTupian(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a></td>
							</tr>
						</table>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv3" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>图标导航</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">选择风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="tubiao1" checked="checked" class="styled" value="0" >导航
						</label>
						<label class="radio-inline">
							<input type="radio" name="tubiao1" class="styled" value="1" >分组
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示图标：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="tubiao2" checked="checked" class="styled" value="0" >图标居上
						</label>
						<label class="radio-inline">
							<input type="radio" name="tubiao2" class="styled" value="1" >图标居左
						</label>
						<label class="radio-inline">
							<input type="radio" name="tubiao2" class="styled" value="2" >不显示图标
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">图标大小：</label>
					<div class="col-md-4">
						<input type="text"  name="tubiao3" id="tubiao3" class="form-control" value="">
					</div>像素
				</div>
				<div class="form-group" style="padding-left:20px;">
					<div class="col-md-4">
						<button type="button" class="btn btn-primary" onclick="">添加图标<i class="icon-checkmark3 position-right"></i></button>
					</div>
				</div> 
				<div class="form-group" style="padding:0px;margin: 0px;padding-left:12px;padding-right:12px;">
					<div class="col-md-12 alert-danger">
						<table  class="col-md-12">
							<tr>
								<td rowspan="2">
									<input type="file" name="filetubiao1"  class="bootstrap-uploader" id="filetubiao1" src="">
									<input type="hidden" name="tubiaoimg1" id="tubiaoimg1" value="">
								</td>
								<td>
									<div class="form-group" style="padding-top:10px;margin-bottom:10px;">
										<label class="control-label col-md-3 text-right">图片标题：</label>
										<div class="col-md-9">
											<label class="radio-inline" style="padding:0px;margin:0px;">
												<input type="text" style="width:150px;"  name="tubiaoname1" id="tubiaoname1" class="form-control" required="required" value="">
											</label>
											<label class="radio-inline" style="padding:0px;margin:0px;">
												<input type="text" name="tubiaonamecolor1" id="tubiaonamecolor1" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
											</label>
										</div>
									</div>
									<div class="form-group" style="margin-bottom:10px;">
										<label class="control-label col-md-3 text-right">图片链接：</label>
										<div class="col-md-7">
											<input type="hidden" name="tubiaourl1" id="tubiaourl1" value="">
											<select class="select" data-width="100%" name="tubiaourltype1" id="tubiaourltype1">
												<option value="">--请选择--</option>
												<option value="0" >微页面</option>
												<option value="1">商品分组页</option>
												<option value="2">商品页</option>
												<option value="3">直接购买</option>
												<option value="4">店铺主页</option>
												<option value="5">个人中心</option>
												<option value="6">列表页</option>
											</select>
										</div>
									</div>
									<div class="form-group" style="padding-bottom: 15px;">
										<label class="control-label col-md-3 text-right">背景颜色：</label>
										<div class="col-md-6 "> 
											<input type="text" name="tubiaocolor1" id="tubiaocolor1" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
										</div>
									</div>
								</td>
								<td><a href="javascript:;" onclick="delRowTupian(this)"><i class="fa fa-trash-o fa-lg"></i>删除</a></td>
							</tr>
						</table>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv4" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>搜索设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">选择风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="sousuo1" checked="checked" class="styled" value="0" >普通搜索
						</label>
						<label class="radio-inline">
							<input type="radio" name="sousuo1" class="styled" value="1" >顶部搜索
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">卡片封面:</label>
					<div class="col-md-6 "> 
						外底色<input type="text" name="sousuo2" id="sousuo2" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">卡片封面:</label>
					<div class="col-md-6 "> 
						内底色<input type="text" name="sousuo3" id="sousuo3" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->		
			
<!-- 表单验证开始 -->
<div id="custonDiv5" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>商品设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">添加方式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="shangpin1" checked="checked" class="styled" value="0" >自动获取
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:30px;">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">显示个数：</label>
						<div class="col-md-2">
							<input type="text"  name="shangpin2" id="shangpin2" class="form-control" required="required" value="10">
						</div>最多显示10个
					</div>
				 	<div class="form-group">
						<label class="control-label col-md-2 text-right"> </label>
						<div class="col-md-8">
							<input type="checkbox" name="shangpin3" id="shangpin3" class="styled" value="1" >
							显示查看全部按钮  
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-2 text-right">排序规则：</label>
						<div class="col-md-6">
							<label class="radio-inline">
								<input type="radio" name="shangpin4" checked="checked" class="styled" value="0" >销量(最高销量最高的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="shangpin4"  class="styled" value="1" >最热(浏览次数最多的排在前面)
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">添加方式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="shangpin1" class="styled" value="1" >手动获取
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:30px;">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">选择商品：</label>
						<div class="col-md-6 text-left">
							 <button type="button" class="btn btn-primary" onclick="">选择商品<i class="icon-checkmark3 position-right"></i></button>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="shangpin5" checked="checked" class="styled" value="0" >大图
						</label>
						<label class="radio-inline">
							<input type="radio" name="shangpin5" class="styled" value="1" >小图
						</label>
						<label class="radio-inline">
							<input type="radio" name="shangpin5" class="styled" value="2" >列表
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示设置：</label>
					<div class="col-md-6">
						<label class="checkbox-inline">
							<input type="checkbox" name="shangpin6"  class="styled" value="1" >标题
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="shangpin7" class="styled" value="1" >购买按钮
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="shangpin8" class="styled" value="1" >价格
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="shangpin9" class="styled" value="1" >销量
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">按钮样式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="shangpin10" checked="checked" class="styled" value="0" >样式1
						</label>
						<label class="radio-inline">
							<input type="radio" name="shangpin10" class="styled" value="1" >样式2
						</label>
						<label class="radio-inline">
							<input type="radio" name="shangpin10" class="styled" value="2" >样式3
						</label>
						<label class="radio-inline">
							<input type="radio" name="shangpin10" class="styled" value="3" >样式4
						</label>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->		

<!-- 表单验证开始 -->
<div id="custonDiv6" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>商品分组</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">分组模版：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="spfz1" checked="checked" class="styled" value="0" >左侧菜单
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz1" class="styled" value="1" >顶部菜单
						</label>
					</div>
				</div>
				<div class="form-group" >
					<div class="form-group">
						<label class="control-label col-md-2 text-right">选择分组：</label>
						<div class="col-md-6 text-left">
							<button type="button" class="btn btn-primary" onclick="">选择商品<i class="icon-checkmark3 position-right"></i></button>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示数量：</label>
					<div class="col-md-3">
						<select class="select" data-width="100%" name="spfz2" id="spfz2">
							<option value="5" >5</option>
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
					</div>
				</div> 
				<div class="form-group">
					<label class="control-label col-md-2 text-right">排序：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="spfz3" checked="checked" class="styled" value="0" >按销量
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz3" class="styled" value="1" >按新增
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="spfz4" checked="checked" class="styled" value="0" >大图
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz4" class="styled" value="1" >小图
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz4" class="styled" value="2" >列表
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示设置：</label>
					<div class="col-md-6">
						<label class="checkbox-inline">
							<input type="checkbox" name="spfz5"  class="styled" value="0" >标题
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="spfz6" class="styled" value="1" >购买按钮
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="spfz7" class="styled" value="2" >价格
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="spfz8" class="styled" value="3" >销量
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">按钮样式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="spfz9" checked="checked" class="styled" value="0" >样式1
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz9" class="styled" value="1" >样式2
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz9" class="styled" value="2" >样式3
						</label>
						<label class="radio-inline">
							<input type="radio" name="spfz9" class="styled" value="3" >样式4
						</label>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->	

<!-- 表单验证开始 -->
<div id="custonDiv7" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>文本导航</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">导航名称：</label>
					<div class="col-md-5">
						<input type="text"  name="wbdaohang1" id="wbdaohang1" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">右侧文字：</label>
					<div class="col-md-5">
						<input type="text"  name="wbdaohang2" id="wbdaohang2" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">选择链接：</label>
					<div class="col-md-3">
						<input type="hidden"  name="wbdaohang4" id="wbdaohang4" value="">
						<select class="select" data-width="100%" name="wbdaohang3" id="wbdaohang3">
							<option value="">--请选择--</option>
							<option value="0" >微页面</option>
							<option value="1">商品分组页</option>
							<option value="2">商品页</option>
							<option value="3">直接购买</option>
							<option value="4">店铺主页</option>
							<option value="5">个人中心</option>
							<option value="6">列表页</option>
						</select>
					</div>
				</div> 
				<div class="form-group" >
					<div class="form-group">
						<label class="control-label col-md-2 text-right">左侧图标：</label>
						<div class="col-md-6 text-left">
							<input type="file" name="filewbdaohang1"  class="bootstrap-uploader" id="filewbdaohang1" src="">
							<input type="hidden" name="wbdaohang5" id="wbdaohang5" value="">
						</div>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv8" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>标题设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">标题名：</label>
					<div class="col-md-5">
						<input type="text"  name="biaoti1" id="biaoti1" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">日期：</label>
					<div class="col-md-5">
						<input type="text" class="form-control pickadate-translated" name="biaoti2" id="biaoti2" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">作者：</label>
					<div class="col-md-5">
						<input type="text"  name="biaoti3" id="biaoti3" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">链接标题：</label>
					<div class="col-md-5">
						<input type="text"  name="biaoti4" id="biaoti4" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">链接地址：</label>
					<div class="col-md-3">
						<input type="hidden"  name="biaoti6" id="biaoti6"  value="">
						<select class="select" data-width="100%" name="biaoti5" id="biaoti5">
							<option value="">--请选择--</option>
							<option value="0" >微页面</option>
							<option value="1">商品分组页</option>
							<option value="2">商品页</option>
							<option value="3">直接购买</option>
							<option value="4">店铺主页</option>
							<option value="5">个人中心</option>
							<option value="6">列表页</option>
						</select>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv9" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>富文本内容</h4></legend>
				<div class="form-group" style="padding-left:5px;padding-right:5px;"> 
					<div class="col-md-12">
						<script id="editor"  type="text/plain" style="width:100%;height:300px;"></script>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv10" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>语音设置</h4></legend>
				<div class="form-group">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">选择音频：</label>
						<div class="col-md-6 text-left">
							<input type="text"  name="yuyin1" id="yuyin1" class="form-control" required="required" value="请选择语音">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">选择风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="yuyin2" checked="checked" class="styled" value="0" >模仿微信对话样式
						</label>
						<label class="radio-inline">
							<input type="radio" name="yuyin2" class="styled" value="1" >简易音乐播放器
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">标题：</label>
					<div class="col-md-5">
						<input type="text"  name="yuyin3" id="yuyin3" class="form-control" required="required" value="${infoMap.name}">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">循环：</label>
					<div class="col-md-6">
						<label class="checkbox-inline">
							<input type="checkbox" name="yuyin4" class="styled" value="0" >开启循环播放
						</label>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">头像：</label>
						<div class="col-md-6 text-left">
							<input type="file" name="fileyuyin1"  class="bootstrap-uploader" id="fileyuyin1" src="">
							<input type="hidden" name="yuyin5" id="yuyin5" value="">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">气泡：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="yuyin6" checked="checked" class="styled" value="0" >居左
						</label>
						<label class="radio-inline">
							<input type="radio" name="yuyin6" class="styled" value="1" >居右
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">播放：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="yuyin7" checked="checked" class="styled" value="0" >暂停后再恢复播放时，从头开始
						</label><br/>
						<label class="radio-inline" style="margin-left:0px;">
							<input type="radio" name="yuyin7" class="styled" value="1" >暂停后再恢复播放时，从暂停位置开始
						</label>
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv11" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>视频设置</h4></legend>
				<div class="form-group" style="padding-left:20px;">
					<label class="control-label col-md-10">
					填写视频网站获取的通用代码
					 </label> 
				</div>
				<div class="form-group">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">视频地址：</label>
						<div class="col-md-8 text-left">
							<textarea rows="4" cols="" name="shipin1" id="shipin1" class="form-control"><iframe frameborder="0" width="100%" height="200" src="https://v.qq.com/iframe/player.html?vid=n0341nmmg98&tiny=0&auto=0" style="z-index: 1; "></iframe>
							</textarea>
						</div>
					</div>
				</div>
				<div class="form-group" style="padding-left:20px;">
					<label class="control-label col-md-10 text-danger">
					温馨提示：手机中不支持flash，请不要填写.swf结尾的代码<br/><br/>
					特别注意：请务必填写以 "https://" 开头的视频地址,否则视频不显示!
					 </label> 
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->	

<!-- 表单验证开始 -->
<div id="custonDiv12" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>公告设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">公告内容：</label>
					<div class="col-md-5">
						<input type="text"  name="gonggao1" id="gonggao1" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">公告链接：</label>
					<div class="col-md-3">
						<input type="hidden"  name="gonggao3" id="gonggao3" value="" >
						<select class="select" data-width="100%" name="gonggao2" id="gonggao2">
							<option value="">--请选择--</option>
							<option value="0" >微页面</option>
							<option value="1">商品分组页</option>
							<option value="2">商品页</option>
							<option value="3">直接购买</option>
							<option value="4">店铺主页</option>
							<option value="5">个人中心</option>
							<option value="6">列表页</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">背景色:</label>
					<div class="col-md-6 "> 
						<input type="text" name="gonggao4" id="gonggao4" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->	

<!-- 表单验证开始 -->
<div id="custonDiv13" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>客服电话</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">文本：</label>
					<div class="col-md-5">
						<input type="text"  name="kefu1" id="kefu1" class="form-control" required="required" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">电话：</label>
					<div class="col-md-5">
						<input type="text"  name="kefu2" id="kefu2" class="form-control" required="required" value="">
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv14" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>空白高度设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">空白高度：</label>
					<div class="col-md-5">
						<input type="text"  name="kongbai1" id="kongbai1" class="form-control" required="required" value="">
					</div>像素
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv15" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>辅助线设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">样式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="fuzuxian1" checked="checked" class="styled" value="0" >实线
						</label>
						<label class="radio-inline">
							<input type="radio" name="fuzuxian1" class="styled" value="1" >虚线
						</label>
						<label class="radio-inline">
							<input type="radio" name="fuzuxian1" class="styled" value="1" >点线
						</label>
					</div>      
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">颜色:</label>
					<div class="col-md-6 "> 
						<input type="text" name="fuzuxian2" id="fuzuxian2" class="form-control colorpicker-show-input" data-preferred-format="hex" value="#f75d1c">
					</div>
				</div>
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv16" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>优惠券设置</h4></legend>
				<div class="form-group">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">优惠券：</label>
						<div class="col-md-6 text-left">
							<input type="text"  name="youhuiquan1" id="youhuiquan1" class="form-control" required="required" value="">
						</div>
					</div>
					<div class="form-group" style="padding-left:20px;">
						<div class="col-md-4">
							<button type="button" class="btn btn-primary" onclick="">添加优惠券<i class="icon-checkmark3 position-right"></i></button>
						</div>
					</div> 
				</div> 
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv17" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>拼团设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">添加方式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="pintuan1" checked="checked" class="styled" value="0" >自动获取
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:30px;">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">显示个数：</label>
						<div class="col-md-2">
							<input type="text"  name="pintuan2" id="pintuan2" class="form-control" required="required" value="10">
						</div>最多显示30个
					</div>
				 	<div class="form-group">
						<label class="control-label col-md-2 text-right"> </label>
						<div class="col-md-8">
							<input type="checkbox" name="pintuan3"  class="styled" value="0" >
							显示查看全部按钮  
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-2 text-right">排序规则：</label>
						<div class="col-md-6">
							<label class="radio-inline">
								<input type="radio" name="pintuan4" checked="checked" class="styled" value="0" >销量(最高销量最高的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="pintuan4"  class="styled" value="1" >最热(浏览次数最多的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="pintuan4"  class="styled" value="2" >最新(最新开始的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="pintuan4"  class="styled" value="3" >最快结束(离活动结束时间最近的排在前面)
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">添加方式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="pintuan1" class="styled" value="1" >手动获取
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:30px;">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">选择活动：</label>
						<div class="col-md-6 text-left">
							 <button type="button" class="btn btn-primary" onclick="">添加拼团<i class="icon-checkmark3 position-right"></i></button>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="pintuan5" checked="checked" class="styled" value="0" >大图
						</label>
						<label class="radio-inline">
							<input type="radio" name="pintuan5" class="styled" value="1" >小图
						</label>
						<label class="radio-inline">
							<input type="radio" name="pintuan5" class="styled" value="2" >列表
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示设置：</label>
					<div class="col-md-9">
						<label class="checkbox-inline">
							<input type="checkbox" name="pintuan6"  class="styled" value="0" >标题
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pintuan7" class="styled" value="1" >购买按钮
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pintuan8" class="styled" value="2" >价格
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="pintuan9" class="styled" value="3" >成团人数
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">按钮样式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="pintuan10" checked="checked" class="styled" value="0" >样式1
						</label>
						<label class="radio-inline">
							<input type="radio" name="pintuan10" class="styled" value="1" >样式2
						</label>
						<label class="radio-inline">
							<input type="radio" name="pintuan10" class="styled" value="2" >样式3
						</label>
						<label class="radio-inline">
							<input type="radio" name="pintuan10" class="styled" value="3" >样式4
						</label>
					</div>
				</div>
				
			</fieldset>
	</div>
</div>
<!-- /form validation -->

<!-- 表单验证开始 -->
<div id="custonDiv18" class="panel panel-flat hide" style="padding-top:0px;margin-top:0px;">
	<div class="panel-body"  style="padding:0px;margin: 0px;">
			<fieldset class="content-group">
				<legend class="text-bold btn-default" style="padding:0px 20px 0px;"><h4>秒杀商品设置</h4></legend>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">添加方式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="miaosha1" checked="checked" class="styled" value="0" >自动获取
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:30px;">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">显示个数：</label>
						<div class="col-md-2">
							<input type="text"  name="miaosha2" id="miaosha2" class="form-control" required="required" value="5">
						</div>最多显示30个
					</div>
				 	<div class="form-group">
						<label class="control-label col-md-2 text-right"> </label>
						<div class="col-md-8">
							<input type="checkbox" name="miaosha3"  class="styled" value="0" >
							显示查看全部按钮  
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-2 text-right">排序规则：</label>
						<div class="col-md-6">
							<label class="radio-inline">
								<input type="radio" name="miaosha4" checked="checked" class="styled" value="0" >销量(最高销量最高的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="miaosha4"  class="styled" value="1" >最热(浏览次数最多的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="miaosha4"  class="styled" value="2" >最新(最新开始的排在前面)
							</label><br/>
							<label class="radio-inline" style="margin-left:0px;">
								<input type="radio" name="miaosha4"  class="styled" value="3" >最快结束(离活动结束时间最近的排在前面)
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">添加方式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="miaosha1" class="styled" value="1" >手动获取
						</label>
					</div>
				</div>
				<div class="form-group" style="padding-left:30px;">
					<div class="form-group">
						<label class="control-label col-md-2 text-right">选择活动：</label>
						<div class="col-md-6 text-left">
							  <button type="button" class="btn btn-primary" onclick="">添加秒杀<i class="icon-checkmark3 position-right"></i></button>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示风格：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="miaosha5" checked="checked" class="styled" value="0" >大图
						</label>
						<label class="radio-inline">
							<input type="radio" name="miaosha5" class="styled" value="1" >小图
						</label>
						<label class="radio-inline">
							<input type="radio" name="miaosha5" class="styled" value="2" >列表
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">显示设置：</label>
					<div class="col-md-6">
						<label class="checkbox-inline">
							<input type="checkbox" name="miaosha6"  class="styled" value="0" >标题
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="miaosha7" class="styled" value="1" >购买按钮
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="miaosha8" class="styled" value="2" >价格
						</label>
						<label class="checkbox-inline">
							<input type="checkbox" name="miaosha9" class="styled" value="3" >销量
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2 text-right">按钮样式：</label>
					<div class="col-md-6">
						<label class="radio-inline">
							<input type="radio" name="miaosha10" checked="checked" class="styled" value="0" >样式1
						</label>
						<label class="radio-inline">
							<input type="radio" name="miaosha10" class="styled" value="1" >样式2
						</label>
						<label class="radio-inline">
							<input type="radio" name="miaosha10" class="styled" value="2" >样式3
						</label>
						<label class="radio-inline">
							<input type="radio" name="miaosha10" class="styled" value="3" >样式4
						</label>
					</div>
				</div>
				
			</fieldset>
	</div>
</div>
<!-- /form validation -->		
