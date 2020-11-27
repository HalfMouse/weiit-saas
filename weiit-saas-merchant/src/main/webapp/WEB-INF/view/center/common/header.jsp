<%@page import="com.weiit.resource.common.utils.WeiitUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="weiyun" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
	<link href="${pageContext.request.contextPath}/favicon.ico" rel="shortcut icon">
	<%@include file="../common/css.jsp" %>
    <%@include file="../common/js.jsp" %>
    <c:set value="<%=WeiitUtil.getFileDomain() %>" var="imageDomain"/>
    <script type="text/javascript">
    	var basePath="${pageContext.request.contextPath}";
    </script>
</head>
 	

<body>
	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">