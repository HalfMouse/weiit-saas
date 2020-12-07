package com.weiit.web.admin.init.mapper;

import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

/**
 * 订单相关Mapper
 * @author 半个鼠标
 * @date：2017-7-5 上午11:39:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface OrderMapper extends BaseMapper{
	
	/**
	 * 查询所有订单
	 * @param formMap
	 * @return
	 */
	List<E> selectOrderList(FormMap formMap);
	
	/**
	 * 查询订单总数
	 * @param formMap
	 * @return
	 */
	E selectShopOrderCount(FormMap formMap);
	
	/**
	 * 查询统计记录
	 * @param formMap
	 * @return
	 */
	List<E> selectOrderSurveyList(FormMap formMap);
	
	/**
	 * 查询渠道商下面的所有商户的订单列表
	 * @param formMap
	 * @return
	 */
	List<E> selectShopOrderList(FormMap formMap);

	E selectUserAddressById(FormMap formMap);

	void insertOrder(FormMap formMap);

	void insertOrderItem(FormMap formMap);

	void updateProductStock(FormMap formMap);

	void updateItemStock(FormMap formMap);

	E getProductItemById(FormMap formMap);

	List<E> getSpecInfoByIds(FormMap formMap);

	void insertBalance(FormMap formMap);

	void updateUserInfo(FormMap formMap);

	E userInfo(FormMap formMap);

}
