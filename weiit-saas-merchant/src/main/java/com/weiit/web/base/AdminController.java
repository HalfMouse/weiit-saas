package com.weiit.web.base;






import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.weiit.core.controller.BaseController;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;


/**
 * 后端视图控制器
 * 
 * @author 半个鼠标
 * @date：2017年2月4日 上午3:07:07
 * @version 1.0
 * @company http://www.wei-it.com
 */
public class AdminController extends BaseController {



//	@SuppressWarnings("rawtypes")
//	@ExceptionHandler(Exception.class)
//	@ResponseBody
//	public String handleException(HttpServletRequest request, HttpServletResponse response, Exception ex) {
//
//		logger.warn("api异常: {}"+ request.getRequestURI(), ex);
//
//		Writer exWriter=new StringWriter();
//		PrintWriter pw=new PrintWriter(exWriter);
//		ex.printStackTrace(pw);
//
//		Integer httpCode = null;
//		if (ex instanceof Exception) {
//			String msg = ex.printStackTrace();
//			if (msg != null && (msg.indexOf("Exception") != -1 || msg.indexOf("SQL") != -1)) {
//				msg = ":( 出BUG了，程序小哥正在努力修复中。";
//				logger.error("------------bug error----------");
//				logger.error(ex);
//			}
//
//		} else if (ex instanceof IllegalArgumentException || ex instanceof MissingServletRequestParameterException) {
//			httpCode = 400;
//		}
//		return toJsonAPI("",ex.getMessage(),"20005");
//	}

	/**
	 * 直接返回json对象
	 * @param object
	 * @return
	 */
	public String toJson(Object object) {
		return JSON.toJSONString(object, SerializerFeature.WriteMapNullValue,
				SerializerFeature.DisableCircularReferenceDetect);
	}

	/**
	 * 直接返回api接口，默认方法返回成功状态
	 * @param object
	 * @return
	 */
	public String toJsonAPI(Object object) {
		E e = new E();
		e.set("code", "0");
		e.set("message", "success");
		e.set("data", object);
		return JSON.toJSONString(e, SerializerFeature.WriteMapNullValue,
				SerializerFeature.DisableCircularReferenceDetect);
	}

	/**
	 * 直接返回api接口，可自定义返回message,code
	 * @param object
	 * @param message
	 * @param code
	 * @return
	 */
	public String toJsonAPI(Object object, String message, String code) {
		E e = new E();
		e.set("code", code);
		e.set("message", message);
		e.set("data", object);
		return JSON.toJSONString(e, SerializerFeature.WriteMapNullValue,
				SerializerFeature.DisableCircularReferenceDetect);
	}

	
	//重写BaseController的方法。在原有获取的参数集合里面，统一加上shop_id、app_id参数
	@Override
	public FormMap getFormMap() {
		FormMap formMap=super.getFormMap();
		if(getSession().getAttribute("shop_id")!=null){
			formMap.set("shop_id", getSession().getAttribute("shop_id"));
		}else {
			logger.info("\n session 丢失");
		}
		logger.info("请求参数formMap,"+formMap);
		return formMap;
	}
	
	//重写BaseController的方法。在原有获取的参数集合里面，统一加上shop_id、app_id参数
	@Override
	public FormMap getFormMap(boolean isCache) {
		FormMap formMap=super.getFormMap(isCache);
		//获取当前登录的管理者的所属店铺ID
		if(getSession().getAttribute("shop_id")!=null){
			formMap.set("shop_id", getSession().getAttribute("shop_id"));
		}
		//formMap.set("public_id", 1);
		logger.info("请求参数formMap为"+formMap);
		return formMap;
	}

	public  <T> T convertJson(String json,Class clazz){
		return (T) JSON.parseObject(json,clazz);
	}
	
	
	
}
