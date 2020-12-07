package com.weiit.web.weixinopen.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;

import com.weiit.web.base.FrontController;
import com.weiit.web.weixinopen.service.WeixinOpenService;

//import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.bean.message.WxOpenXmlMessage;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author <a href="https://github.com/007gzs">007</a>
 */
@RestController
@RequestMapping("/weixinopen/notify")
public class WeixinUserTestController extends FrontController{
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    private WeixinOpenService weixinOpenService;
    
    
    /**
     * 小程序获取用户信息,根据code获取
     * @param response
     * @param code
     * @param appid
     * @return
     */
    @ResponseBody
	@RequestMapping(value = "/getOAuth2UserInfoByMa")
	public String getOAuth2UserInfoByMa(HttpServletResponse response,@RequestParam(value = "code") String code,@RequestParam String appid) {
		try {
			WxMaJscode2SessionResult session =weixinOpenService.getInstance(null).getWxOpenComponentService().getWxMaServiceByAppid(appid).getUserService().getSessionInfo(code);
			this.logger.info(session.getSessionKey());
			this.logger.info(session.getOpenid());
			return toJsonAPI(session);
		} catch (WxErrorException e) {
			this.logger.error(e.getError().toString());
			return toJsonAPI("", "获取微信openId失败", "1008");
		}
	}
    
    /**
     * 微信公众号获取用户信息,根据code获取
     * @param response
     * @param code
     * @param appid
     * @return
     */
    @ResponseBody
	@RequestMapping(value = "/getOAuth2UserInfoByMp")
	public String getOAuth2UserInfoByMp(HttpServletResponse response,@RequestParam(value = "code") String code,@RequestParam String appid) {
    	WxMpOAuth2AccessToken accessToken;
		WxMpUser wxMpUser;
		try {
			WxOpenService wxOpenService = weixinOpenService.getInstance(null);
			accessToken = wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(appid).oauth2getAccessToken(code);
			wxMpUser =  wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(appid).oauth2getUserInfo(accessToken, "zh_CN");
//			wxOpenService.getWxOpenComponentService().
			this.logger.info("获得基本信息：{}", wxMpUser.toString());
			return toJsonAPI(wxMpUser);
		} catch (WxErrorException e) {
			this.logger.error(e.getError().toString());
			return toJsonAPI("", "获取微信基本信息资料失败", "1008");
		}
	}
}
