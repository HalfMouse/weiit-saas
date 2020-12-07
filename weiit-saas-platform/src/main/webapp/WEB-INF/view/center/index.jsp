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
        <title>移动电商-服务中心系统</title>  
        <link href="${pageContext.request.contextPath}/favicon.ico" rel="shortcut icon">
        <%@include file="./common/css.jsp" %>
        <%@include file="./common/js.jsp" %>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/pages/session_timeout.min.js"></script>
        <c:set value="<%=WeiitUtil.getFileDomain() %>" var="imageDomain"/>
        <style type="text/css">    
            * {    
                margin: 0px;    
                padding: 0px;   
            }    
            html,body,.mainbox{  
                position: relative;  
                width: 100%;  
                height: 100%;  
            }  
            .mainbox header{  
                position: absolute;  
                top: 0;  
                left: 0;  
                right: 0;  
                z-index: 3;  
            }  
            .mainbox .left{  
                position: fixed;  
                top: 40px;  
                left: 0;  
                height: 100%;  
                width: 200px;  
                background:#263238;  
                z-index: 2;  
            }  
            .mainbox .right{  
                position: absolute;  
                top: 50px;  
                padding-left: 200px;  
                background: #f5f5f5;  
                width: 100%;  
                height:93%;
                box-sizing:border-box;  
                overflow: hidden;  
            }  
            
            
        </style>   
    </head>  
    <body>  
        <div class="mainbox">    
            <header>  
               <%@include file="top.jsp" %>
            </header>  
            <div class="left" id="left">  
               <%@include file="left.jsp" %>
            </div>  
            <div class="right" id="right" >  
                <iframe  src="${pageContext.request.contextPath}/center/order/dashboard" name="rightIframe" id="rightIframe" frameborder="0" scrolling="yes" width="100%" height="100%"></iframe>  
            </div>  
        </div>   
        
    </body>  
    <c:if test="${sessionScope.shopInfo.is_deleted==-1 }">
    <script>
    $(function() {
        // Session timeout
        
        $.sessionTimeout({
            heading: 'h5',
            title: '站点服务到期了，请联系平台方！',
            message: '您的服务已经到期,如需继续使用请联系平台方重新开通!',
            ignoreUserActivity: true,
            warnAfter: 1000,
            redirAfter: 30000,
            keepBtnText: "重新连接",
            keepBtnClass: "btn btn-primary",
            logoutBtnText: "退出",
            logoutBtnClass: "btn btn-danger",
            keepAliveUrl: '/',
            redirUrl: '${pageContext.request.contextPath}/center/manager/logout',
            logoutUrl: '${pageContext.request.contextPath}/center/manager/logout'
        });
        
    });
    
    </script>
    </c:if>
     <script>
	function openOnRight(url){
		FullScreenShow("加载中...");  
		var iframe=document.getElementById("rightIframe");
		iframe.src=url;
		if (iframe.attachEvent){    
		    iframe.attachEvent("onload", function(){    
		    	 FullScreenHide ();
		    });
		} else {    
		    iframe.onload = function(){        
		        FullScreenHide ();
		    };
		}
	}
	</script>
</html>  