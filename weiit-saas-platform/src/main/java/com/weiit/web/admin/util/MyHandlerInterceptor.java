package com.weiit.web.admin.util;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.weiit.core.entity.FormMap; 
import com.weiit.web.admin.publics.service.LogService;

/** 
 * Title: DefaultExceptionResolver.java
 * Description: spring拦截器。 记录日志
 * Company: 微云时代 http://weiyunshidai.com/
 * @author hzy 
 * @date 2017年3月30日
 */
public class MyHandlerInterceptor extends  HandlerInterceptorAdapter{
	@Resource
	private LogService logService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2, ModelAndView mview) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object arg2, Exception ex)
			throws Exception {
		if(ex!=null){
			System.out.println("error"+ex.getMessage());
		}else{
			if( request.getAttribute("logsMessage")!=null && !request.getAttribute("logsMessage").toString().equals("") ){
				FormMap formMap=new FormMap();
				String message=request.getAttribute("logsMessage").toString();
				String messArr[]=message.split("-:-");
				formMap.put("shop_id", request.getSession().getAttribute("shop_id"));
				formMap.put("app_id", request.getSession().getAttribute("app_id"));
	        	formMap.put("log_level", 0);
	        	formMap.put("service_module", messArr[0]);
				formMap.put("log_name", messArr[1]);
	        	formMap.put("content", messArr[2]); 
 
				logService.insert(formMap);
			}else if( request.getAttribute("logsError")!=null && !request.getAttribute("logsError").toString().equals("") ){
				FormMap formMap=new FormMap();
				String error=request.getAttribute("logsError").toString();
				String messArr[]=error.split("-:-");
				formMap.put("shop_id", request.getSession().getAttribute("shop_id"));
				formMap.put("app_id", request.getSession().getAttribute("app_id"));
	        	formMap.put("log_level", 2);
	        	if(messArr.length==3){
		        	formMap.put("service_module", messArr[0]);
					formMap.put("log_name", messArr[1]);
		        	formMap.put("content", messArr[2]);
	        	}else{
		        	formMap.put("service_module", "系统异常");
					formMap.put("log_name", "内部异常");
		        	formMap.put("content", error);
	        	}
				logService.insert(formMap);
			}
		}
	}

}
