package com.weiit.web.api.service;


import java.util.List;
import java.util.Map;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;


/**
 * 用户相关Service
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface UserService extends BaseService{
	
	/**
	 * 查询用户信息 --个人中心
	 * @param formMap
	 * @return
	 * */
	E userInfo(FormMap formMap);



	/**
	 *获取店铺信息
	 *
	 * */
	E getShopInfo(FormMap formMap);


	/**
	 * 查询用户信息
	 * @param formMap
	 * @return
	 * */
	E selectUserInfoByOpenId(FormMap formMap);

	/**
	 * g更新用户信息 --生日 账号信息
	 * @param formMap
	 * */
	void updateUserInfo(FormMap formMap);

	/**
	 * 保存用户地址信息
	 * @param formMap
	 * */
	void myAddressSaveTrans(FormMap formMap);

	/**
	 * 查询用户地址信息
	 * @param formMap
	 * @return 用户地址信息列表
	 * */
	List<E> myAddressList(FormMap formMap);

	/**
	 * 查询用户地址总数
	 * @param formMap
	 * @return 用户地址信息列表
	 * */
	int myAddressCount(FormMap formMap);

	/**
	 * 取消默认地址信息
	 * @param formMap
	 * */
	void myAddressCancelAllDefault(FormMap formMap);

	/**
	 * 设置默认收货地址
	 * @param formMap
	 * */
	void myAddressUpdateTrans(FormMap formMap);

	/**
	 * 查询用户的优惠券信息
	 * @param formMap
	 * @return 用户的优惠券信息
	 * */
	List<E> myCoupons(FormMap formMap);

	/**
	 * 删除地址
	 * @param formMap
	 * */
	void myAddressDelete(FormMap formMap);

	/**
	 * 查询用户的收藏
	 * @param formMap
	 * @return 用户收藏
	 * */
	List<E> myCollectionList(FormMap formMap);


	/**
	 * 查询用户的收藏总数 做分页用（）
	 * @param formMap
	 * @return 收藏总数
	 * */
	int  myCollectionCount (FormMap formMap);

	/**
	 * 删除用户收藏
	 * @param formMap
	 * */
	void myCollectionDelete(FormMap formMap);

	/**
	 * 添加意见反馈
	 * @param formMap
	 * */
	void addSuggest(FormMap formMap);
	/**
	 * 操作（增加。扣除）余额及添加记录
	 * @param formMap
	 * */
	void addBalanceAndLog(FormMap formMap);

	/**
	 * 查询用户积分记录
	 * @param formMap
	 * @return 用户积分记录
	 * */
	List<E> myIntegralLog(FormMap formMap);

	/**
	 * 查询用户余额变更记录
	 * @param formMap
	 * @return 用户余额记录
	 * */
	List<E> myBalanceLog(FormMap formMap);

	/**
	 * 余额体现
	 * @param formMap
	 *
	 * */
	void myBalanceExtract(FormMap formMap);

	/**
	 * 插入余额流水
	 * @param formMap
	 * */
	void insertBalance(FormMap formMap);

	/**
	 * 添加提现记录
	 * @param formMap
	 * @return
	 * */
	int addCashLog (FormMap formMap);


	/**
	 * 用户访问微页面记录
	 * @param formMap limit  是否限制记录  一个用户一天一次记录
	 * @return
	 * */
	void addUserPageViewLog (FormMap formMap,boolean limit);

	/**
	 * 添加用户访问店铺记录
	 * @param formMap
	 * @return
	 * */
	void addUserShopViewLog (FormMap formMap);


	/**
	 * 更新用户积分
	 *
	 * */

	void updateUserIntegral(FormMap formMap);

	/**
	 * 更新用户手机
	 *
	 * */

	void updateUserPhone(FormMap formMap);

	/**
	 * 更新用户积分
	 *
	 * */

	void addUserIntegralLog(FormMap formMap);



	/**
	 * 查询商户信息
	 *
	 * */
	E selectMerchantInfoByShopId(FormMap formMap);


}
