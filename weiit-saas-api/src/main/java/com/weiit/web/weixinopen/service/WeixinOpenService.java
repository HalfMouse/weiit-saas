package com.weiit.web.weixinopen.service;



import com.github.binarywang.wxpay.service.WxPayService;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import com.weiit.web.base.FrontController;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;

/**
 * 微信服务接口
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinOpenService extends BaseService{
	
	/**
	 * 查询微信第三方平台配置信息
	 * @param formMap
	 * @return
	 */
	E selectWeixinOpenInfo(FormMap formMap);
	
	/**
	 * 修改微信第三方平台的配置信息-verify_ticket字段
	 * @param formMap
	 */
	void editWeixinOpenInfoVerifyTicket(FormMap formMap);
	
	/**
	 * 获取WxopenService实例
	 * @return
	 */
	public WxOpenService getInstance(FormMap formMap);


    /**
     * 第三方平台路由消息
     * @param
     * @return
     */
	public WxOpenMessageRouter getWxOpenMessageRouter();

  
	/**
	 * 刷新微信第三方配置信息
	 * @return
	 */
	public void freshInstance();

	/**
	 * 获取微信支付参数
	 * @param param
	 * @return 微信支付service
	 * */
	WxPayService getLocalInstancePay(E param);


	/**
	 * 获取公众号（服务号）、小程序的授权第三方平台信息
	 *
	 * */
	E selectWxPublicInfo(FormMap formMap);
}
