package com.weiit.web.api.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 登录相关Mapper
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface UserMapper extends BaseMapper{
	
	/**
     * 个人中心接口
     * @param formMap
     * @return 返回个人中心结果
     */
	E userInfo(FormMap formMap);

	E getShopInfo(FormMap formMap);

	E selectUserInfoByOpenId(FormMap formMap);

	E selectMerchantInfoByShopId(FormMap formMap);

	void updateUserInfo(FormMap formMap);
	
	void myAddressSave(FormMap formMap);
	
	List<E> myAddressList(FormMap formMap);

	int myAddressCount(FormMap formMap);

	void myAddressCancelAllDefault(FormMap formMap);
	
	void myAddressUpdate(FormMap formMap);
	
	List<E> myCoupons(FormMap formMap);
	
	void myAddressDelete(FormMap formMap);
	
	List<E> myCollectionList(FormMap formMap);

	int myCollectionCount(FormMap formMap);

	void myCollectionDelete(FormMap formMap);
	
	void addSuggest(FormMap formMap);
	
	List<E> myIntegralLog(FormMap formMap);

	List<E> myBalanceLog(FormMap formMap);
	
	void myBalanceExtract(FormMap formMap);
	/**
	 * 插入余额记录
	 * @param formMap
	 * */
	void insertBalance(FormMap formMap);

	int addCashLog(FormMap formMap);

	int addUserPageViewLog(FormMap formMap);

	int addUserShopViewLog(FormMap formMap);


	void updateUserIntegral(FormMap formMap);

	void updateUserPhone(FormMap formMap);

	void addUserIntegralLog(FormMap formMap);
}
