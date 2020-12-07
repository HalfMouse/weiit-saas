package com.weiit.web.base;



import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.weiit.core.controller.BaseController;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.util.JWTUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;

/**
 * 控制器
 * @author 半个鼠标
 * @Email：137075251@qq.com
 * @date：2017年2月4日 上午3:07:07
 * @version 1.0
 */
public class FrontController extends BaseController {



	public final Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
	 * 直接返回json对象
	 * 
	 * @param object
	 * @return
	 */
	public String toJson(Object object) {

		String result =JSON.toJSONString(object, SerializerFeature.WriteMapNullValue,
		SerializerFeature.DisableCircularReferenceDetect);
		logger.info("返回参数:{}",result);
		return result;
	}

	/**
	 * 直接返回api接口，默认方法返回成功状态
	 * 
	 * @param object
	 * @return
	 */
	public String toJsonAPI(Object object) {
		E e = new E();
		e.set("code", "0");
		e.set("message", "success");
		e.set("data", object);
		return toJson(e);
	}

	/**
	 * 直接返回api接口，可自定义返回message,code
	 * 
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
		return toJson(e);
	}

	public String toJsonAPI(ApiResponseCode apiResponseCode){
		E result = new E();
		result.set("code", apiResponseCode.getCode());
		result.set("message", apiResponseCode.getMessage());
//		if (!apiResponseCode.getCode().equals("0")){
//			logger.warn("code is {},message is{}",apiResponseCode.getCode(),apiResponseCode.getMessage());
//		}

		return toJson(result);
	}
	
	/**
	 *
	 * 重写BaseController的方法。 默认所有请求 header 带 token 参数  初了firewall
	 * */
	@Override
	public FormMap getFormMap() {
		FormMap formMap=super.getFormMap();
		//找到用户所属的店铺ID
		String value = this.getRequest().getHeader("token");
		if (!StringUtils.isEmpty(value)){
			E token = JWTUtil.unsign(value,E.class);
			if (token!=null){
				formMap.put("shop_id",token.getStr("shop_id"));
				formMap.put("user_id",token.getStr("user_id"));
				formMap.put("user_name",token.getStr("user_name"));
				formMap.put("user_img",token.getStr("user_img"));
				formMap.put("wx_open_id",token.getStr("wx_open_id"));
				formMap.put("open_id_type",token.getStr("open_id_type"));
				formMap.put("authorizer_app_id",token.getStr("authorizer_app_id"));
				logger.info("\n token ：{}",value);
			}
		}
		logger.info("\n【请求参数为:】{}",formMap.toString());
		return formMap;
	}
		

	public  <T> T convertJson(String json,Class clazz){
		return (T) JSON.parseObject(json,clazz);
	}

	/**
	 * 四舍五入
	 *
	 * */
	public double getDoubleValue(BigDecimal bigDecimal){
		return bigDecimal.setScale(2,BigDecimal.ROUND_HALF_DOWN).doubleValue();
	}

	/**
	 * 四舍五入支付精度缺失会少一分钱
	 *
	 * */
	public int getInterValue(BigDecimal bigDecimal){
		return bigDecimal.setScale(0,BigDecimal.ROUND_HALF_DOWN).intValue();
	}




	
}
