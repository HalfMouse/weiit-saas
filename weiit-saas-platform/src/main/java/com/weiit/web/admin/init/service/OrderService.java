package com.weiit.web.admin.init.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 订单相关Service
 * @author 半个鼠标
 * @date：2017-7-5 上午11:39:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface OrderService extends BaseService{
	
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


	/**
	 *	根据ID  查询用户收货地址
	 *	@param formMap
	 *  @return 用户收货地址
	 * */
	E selectUserAddressById(FormMap formMap);



	/**
	 * 创建订单相关操作
	 * @param formMap
	 * */
	void insertOrder(FormMap formMap);


	/**
	 * 添加订单详情记录
	 * @param formMap
	 *
	 * */
	void insertOrderItem(FormMap formMap);

	/**
	 * 查询商品Item 信息
	 * @param formMap
	 * @return
	 * */
	E getProductItemById(FormMap formMap);

	/**
	 * 根据specIDs 查询SKU  信息
	 * @param formMap 请求参数
	 * @return
	 * */
	List<E> getSpecInfoByIds(FormMap formMap);


	/**
	 * 更新商品 和 商品item 的库存
	 * @param formMap
	 * */
	void updateProductAndItemStock(FormMap formMap);


	/**
	 * 查询用户信息 --个人中心
	 * @param formMap
	 * @return
	 * */
	E userInfo(FormMap formMap);


	/**
	 * 操作（增加。扣除）余额及添加记录
	 * @param formMap
	 * */
	void addBalanceAndLog(FormMap formMap);
}
