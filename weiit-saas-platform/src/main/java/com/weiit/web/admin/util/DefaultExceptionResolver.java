package com.weiit.web.admin.util;

import org.apache.shiro.authz.AuthorizationException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
 
/**
 * 
 * Title: DefaultExceptionResolver.java
 * Description: spring 统一异常处理
 * Company: 微云时代 http://weiyunshidai.com/
 * @author hzy 
 * @date 2017年3月30日
 */
public class DefaultExceptionResolver extends SimpleMappingExceptionResolver{

	@Override
	protected ModelAndView doResolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		String viewName = determineViewName(ex,request);
		response.setCharacterEncoding("UTF-8");
		if (viewName != null) {
			String message=ex.getMessage();
			if(message==null){
				message=ex.getClass().getName();
			}
			// JSP格式返回
			if (!(request.getHeader("accept").contains("application/json")  || 
					(request.getHeader("X-Requested-With")!= null && 
						request.getHeader("X-Requested-With").contains("XMLHttpRequest") ))) {
				// 如果不是异步请求
				Integer statusCode = determineStatusCode(request, viewName);
				if (statusCode != null) {
					applyStatusCodeIfPossible(request, response, statusCode);
				}
				System.out.println("JSP格式返回" + viewName);
				ModelAndView mvn= getModelAndView(viewName, ex, request); 
				mvn.addObject("logsError", message);  
				return mvn;
			}else {// JSON格式返回
				if (ex instanceof AuthorizationException) {
					return getModelAndView("redirect:/center/asyn401", ex, request);
			    }else{
			    	ModelAndView mvn= getModelAndView("redirect:/center/asynError", ex, request); 
			    	mvn.addObject("logsError", URLEncoder.encode(message) );  
					return mvn;
			    }
			}
		}else{
			return null;
		}
	}

}
