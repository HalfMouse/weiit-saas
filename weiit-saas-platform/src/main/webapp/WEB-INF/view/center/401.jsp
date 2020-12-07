<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>

<html lang="zh"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>提示-404</title>
<style type="text/css">
html {background:none;background-color:#f0eeee;}
body {padding:0;}
#header { width:952px;margin:0 auto; height:120px;background:none;box-shadow:none;position:static;}
#content { font-family:"微软雅黑"; background:url("${pageContext.request.contextPath}/resource/images/404.png") no-repeat 122px 0px;width:952px;margin:0 auto; font-size:18px;color:#999;}
#content p {padding:180px 0 0 326px; line-height:38px;}
#content p a.backhome {font-size:14px;}
#content p a.backhome span {width:80px;}
</style>
</head>
<body>
<div>
<div id="content" style="height: 530px;">
<p>
对不起，你无此权限操作，
<br/>请时光倒流回前一秒，或联系管理员。<br>
<a href="JavaScript:history.go(-1)" class="adaptbtn2 btn-green42 backhome"><span class="adaptbtn2">返回</span></a>&nbsp;&nbsp;&nbsp;&nbsp;<br>
</p>
</div>
</div>

</body></html>