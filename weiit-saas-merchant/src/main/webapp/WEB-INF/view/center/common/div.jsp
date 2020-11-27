<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!-- 删除业务统一表单提交 -->
<form action="" method="post" id="removeForm">
</form>

<!-- 导出业务统一表单提交 -->
<form action="" method="post" id="fileExportForm">
</form>
<!-- 提示内容 -->
<c:if test="${isPNotify eq true }">
<script>
 $(function(){
	 new PNotify({title: '提示操作',text: '${text}',addclass: 'bg-info'});
	 }
);
</script>
</c:if>

<c:if test="${isError eq true }">
<script>
 $(function(){
	 new PNotify({title: '提示操作',text: '${text}',addclass: 'bg-danger'});
	 }
);
</script>
</c:if>
<!-- 图片素材调起控件缓存ID -->
<input type="hidden" class="cacheOpenSourceId"/>
<!-- 商品弹出框控件数据交互ID -->
<input type="hidden" id="cacheOpenProductId" value=''/>
<script>
$(function(){
	/*当点击rightIframe中的页面时，把top页面悬浮的内容都隐藏*/
	$("body").click(function(){
		$('.dropdown', parent.document).each(function(){$(this).removeClass("open");});
	});
	
});
</script>