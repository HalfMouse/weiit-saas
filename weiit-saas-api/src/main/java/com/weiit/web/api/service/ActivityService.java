package com.weiit.web.api.service;

import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

/**
 * 活动相关Service
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface ActivityService extends BaseService {

	/**
	 * 获取优惠券列表
	 * @param formMap
	 * @return 优惠券列表
	 * */
	List<E> couponList(FormMap formMap);

	/**
	 * 购物车页面  用户优惠券列表分可用不可用状态
	 * @param formMap
	 * @return
	 * */
	List<E> getUserCouponListForCart(FormMap formMap);


	/**
	 * 活动页面 获取优惠券列表
	 * @param formMap
	 * @return 优惠券列表
	 * */
	List<E> couponListByIds(FormMap formMap);

	/**
	 * 领取优惠券
	 * @param formMap
	 * */
	void couponGet(FormMap formMap);


	/**
	 * 根据优惠券ID  获取优惠券的库存  限制领取数量
	 * @param formMap
	 * @return 获取优惠券的库存  限制领取数量
	 * */
	E couponNumber(FormMap formMap);

	/**
	 * 根据优惠券ID  用户ID 获取用户持有该优惠券的数量
	 * @param formMap
	 * @return
	 * */
	E userCouponReceiveNum(FormMap formMap);



}
