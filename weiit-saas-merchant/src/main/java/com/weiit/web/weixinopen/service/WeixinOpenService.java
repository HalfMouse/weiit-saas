package com.weiit.web.weixinopen.service;


import com.github.binarywang.wxpay.service.WxPayService;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;

/**
 * 微信服务接口
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinOpenService{
	
	/**
	 * 获取第三方平台配置信息
	 * @return
	 */
	public WxOpenService getOpenConfig();


	/**
	 * 获取第三方平台配置信息
	 * @return
	 */
	WxOpenService getInstance(FormMap formMap);
	/**
	 * 获取微信支付配置
	 * @return
	 */
	public WxPayService getMyWeixinPay();
	
    /**
     * 第三方平台路由消息
     *
     * @param
     * @return
     */
	public WxOpenMessageRouter getWxOpenMessageRouter();


	/**
	 * 查询商户配置信息
	 *
	 * */
	E selectWxPublicInfo(FormMap formMap);

	E selectWxPublicInfoAndShopInfo(FormMap formMap);

}
