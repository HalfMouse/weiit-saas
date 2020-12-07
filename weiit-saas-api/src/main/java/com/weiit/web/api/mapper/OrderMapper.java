package com.weiit.web.api.mapper;

import java.util.List;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;


/**
 * 订单相关Mapper
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface OrderMapper extends BaseMapper{
	
	 /**
     * 订单查询接口
     * @param formMap
     * @return 返回查询的订单结果
     */
	List<E> selectOrderList(FormMap formMap);
	
	E selectOrderOne(FormMap formMap);
	
	List<E> selectOrderDetails(FormMap formMap);
	
	void updateOrderState(FormMap formMap);
	
	void insertOrderRefund(FormMap formMap);
	
	List<E> selectOrderRefundList(FormMap formMap);

	int selectOrderRefundCount(FormMap formMap);

	E selectOrderRefundDetail(FormMap formMap);

	List<E> selectExpressCompanyList(FormMap formMap);
	
	void updateOrderRefundExpress(FormMap formMap);
	
	void updateOrderRefundState(FormMap formMap);

	void clearUserCart(FormMap formMap);

	//创建订单相关操作
	void insertOrder(FormMap formMap);

	E selectUserCouponById(FormMap formMap);

	E selectUserAddressById(FormMap formMap);

	E selectOrderInfoByOrderNum(FormMap formMap);

	void insertOrderItem(FormMap formMap);

	void updateUserCouponById(FormMap formMap);

	List<E> selectUserCartList(FormMap formMap);

	List<E> getOrderItemByOrderNum(String formMap);

	List<E> getShipItemByShipId(FormMap formMap);

	E getOrderInfoByOrderNum(String formMap);

	E getMchkeyByOrderNum(String formMap);

	E selectOrderItemOne(FormMap formMap);

	E selectUserCouponInfoByOrderNum(FormMap formMap);
	E selectExpressInfoByCode(FormMap formMap);

	int selectOrderProductCount(FormMap formMap);

	E selectOrderRefundOne (FormMap formMap);

	E selectPaymentTypeInfo (FormMap formMap);

	List<E> selectOrderItem (FormMap formMap);
}