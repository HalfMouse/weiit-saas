package com.weiit.web.api.service;


import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 用户相关Service
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface PlatformService extends BaseService{
	
	/**
	 * 发送验证码
	 * @param formMap
	 * @return
	 * */
	boolean sendMobileMsg(FormMap formMap);
	
	/**
	 * 用户账号登录
	 * @param formMap
	 * @return 用户信息
	 * */
	E login(FormMap formMap);

	/**
	 * 用户微信登录
	 * @param formMap
	 * @return 用户信息
	 * */
	E weixinLogin(FormMap formMap);
	
	/**
	 * 用户注册
	 * @param formMap
	 */
	void register(FormMap formMap);
	
	/**
	 * 根据店铺域名查询店铺信息
	 * @param formMap
	 * @return
	 */
	E selectShopInfoByShopDomainPrex(FormMap formMap);



	
	/**
	 * 查询店铺所绑定的公众号信息
	 * @param formMap
	 * @return
	 */
	E selectWeixinPublicInfoByShopId(FormMap formMap);



	/**
	 * 查询店铺所绑定的公众号信息
	 * @param formMap
	 * @return
	 */
	E selectWeixinPublicInfoByAppId(FormMap formMap);


	/**
	 *
	 * 获取 微信支付  支付对象
	 * @param param
	 * @return 支付对象
	 * */
	WxPayMpOrderResult wxPay (E param);

	/**
	 *
	 * 获取 微信支付  支付对象
	 * @param formMap
	 * @return 支付配置信息  appid appkey mchid mchkey
	 * */
	E getPayInfoByOpenId(FormMap formMap);

	/**
	 *
	 * 插入物流LOGO数据(测试)
	 * @param formMap
	 * @return 支付配置信息  appid appkey mchid mchkey
	 * */
	int insertExpress(FormMap formMap);
	/**
	 *
	 * 插入物流LOGO数据(测试)
	 * @param formMap
	 * @return 支付配置信息  appid appkey mchid mchkey
	 * */
	List<E> getArea(FormMap formMap);


	/**
	 * 获取文章信息
	 *
	 * */

	E selectBlogInfoById(FormMap formMap);


	/**
	 * 查询店铺模板消息配置
	 *
	 * */
	E selectShopTemplateMsg(FormMap formMap);


	/**
	 * 根据SHOPID查询店铺信息
	 * @param formMap
	 * @return 店铺基本信息
	 * */
	E selectShopInfoById(FormMap formMap);

	/**
	 * 根据用户Id查询用户及店铺的授权信息
	 * @param formMap
	 * @return 店铺基本信息
	 * */
	E selectUserAndAuthInfoByUserId(FormMap formMap);

	/**
	 * 查询店铺默认引导页
	 * @param formMap
	 * @return 铺引导页
	 * */
	E selectShopIntroPage(FormMap formMap);
	/**
	 * 新增店铺默认引导页
	 * @param formMap
	 * */
	void saveIntroPage(FormMap formMap);
}
