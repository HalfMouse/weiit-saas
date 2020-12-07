package com.weiit.web.weixinopen.controller;


import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;

import com.github.binarywang.wxpay.bean.notify.WxScanPayNotifyResult;
import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.github.binarywang.wxpay.bean.order.WxPayNativeOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.github.binarywang.wxpay.util.SignUtils;
import com.google.gson.Gson;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.base.AdminController;


import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 阿里云redis线上测试，因为阿里云redis不允许外网访问，提供内部测试接口确保redis是ok的。
 * @author 半个鼠标
 *
 */
@RestController
@RequestMapping("/aliyun/redis")
public class AliyunRedisTestController extends AdminController{

    @Resource
    RedisUtil redisUtil;
    
    /**
     * 测试阿里云redis测试
     * @return
     * @throws WxPayException
     * @throws IOException
     */
    @ResponseBody
   	@RequestMapping(value = "/test")
   	public String test() {
    	
    	redisUtil.set("test", "weiit");
    	
    	Object obj=redisUtil.get("test");
    	return toJsonAPI(obj);
	           
   	}
    
}
