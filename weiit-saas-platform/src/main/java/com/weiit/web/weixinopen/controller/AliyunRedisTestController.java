package com.weiit.web.weixinopen.controller;


import com.github.binarywang.wxpay.exception.WxPayException;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.base.AdminController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.IOException;

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
