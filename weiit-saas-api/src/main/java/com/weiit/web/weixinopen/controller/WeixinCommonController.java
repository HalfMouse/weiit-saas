package com.weiit.web.weixinopen.controller;

import com.weiit.core.entity.FormMap;
import com.weiit.web.base.FrontController;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.open.api.WxOpenService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by 罗鸿强 on 2018/6/25.
 */

@Controller
@RequestMapping(value = "/weixin")
public class WeixinCommonController extends FrontController{

    @Autowired
    WeixinOpenService weixinOpenService;
    /**
     * JSSDK装载环境。【服务号】
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/JSSDKWxConfig")
    public String jsSDKWxConfig() {
        logger.info("WeixinCommonController-JSSDKWxConfig,【JSSDK装载环境】");
        try {
            FormMap formMap = getFormMap();
            if(StringUtils.isEmpty(formMap.getStr("currentUrl"))){
                return toJsonAPI("","必须输入currentUrl参数","1000");
            }
            WxOpenService wxOpenService = weixinOpenService.getInstance(formMap);
            WxJsapiSignature wxJsapiSignature =wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(formMap.getStr("appid")).createJsapiSignature(formMap.getStr("currentUrl"));
            Map<String, String> result = new HashMap<String, String>();
            result.put("appId", wxJsapiSignature.getAppId());
            result.put("timeStamp", wxJsapiSignature.getTimestamp()+"");
            result.put("nonceStr", wxJsapiSignature.getNonceStr());
            result.put("signature", wxJsapiSignature.getSignature());
            return toJsonAPI(result);
        } catch (Exception e) {
            this.logger.error(e.getStackTrace().toString());
            return toJsonAPI("", "JSSDK环境装载失败", "1008");
        }
    }



}
