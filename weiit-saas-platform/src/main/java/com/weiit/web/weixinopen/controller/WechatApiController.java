package com.weiit.web.weixinopen.controller;


import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.open.bean.result.WxOpenAuthorizerInfoResult;
import me.chanjar.weixin.open.bean.result.WxOpenQueryAuthResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/weixinopen")
public class WechatApiController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    
    @Resource
    private WeixinOpenService wxOpenService;
    
    @RequestMapping("/goto_auth_url_show")
    @ResponseBody
    public String gotoPreAuthUrlShow(){
        return "<a href='goto_auth_url'>go</a>";
    }
    
    @RequestMapping("/goto_auth_url")
    public void gotoPreAuthUrl(HttpServletRequest request, HttpServletResponse response) throws WxErrorException{
        String host = request.getHeader("host");
        String url = "http://"+host+"/weiit-vstore-b2c-wsc-api/weixinopen/portal";
        try {
            url = wxOpenService.getOpenConfig().getWxOpenComponentService().getPreAuthUrl(url);
            response.sendRedirect(url);
        } catch (IOException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }
    
    @RequestMapping("/portal")
    @ResponseBody
    public WxOpenQueryAuthResult jump(@RequestParam("auth_code") String authorizationCode){
        try {
            WxOpenQueryAuthResult queryAuthResult = wxOpenService.getOpenConfig().getWxOpenComponentService().getQueryAuth(authorizationCode);
            logger.info("getQueryAuth", queryAuthResult);
            return queryAuthResult;
        } catch (WxErrorException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }
    
    @RequestMapping("/get_authorizer_info")
    @ResponseBody
    public WxOpenAuthorizerInfoResult getAuthorizerInfo(@RequestParam String appId){
        try {
            return wxOpenService.getOpenConfig().getWxOpenComponentService().getAuthorizerInfo(appId);
        } catch (WxErrorException e) {
            logger.error("getAuthorizerInfo", e);
            throw new RuntimeException(e);
        }
    }
}
