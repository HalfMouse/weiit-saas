package com.weiit.web.admin.order.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;


/**
 * 订单管理mapper
 * @author zhouliang
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface OrdersMapper extends BaseMapper {
	
	/**
     * 查询用户地址信息
     * @return
     */
	E queryAddressById(FormMap map);
	
	/**
	 * 根据订单编号获取订单详情
	 * @param orderid
	 * @return
	 */
	List<E> queryOrdersDetail(FormMap map);
	
	/**
     * 查询不同状态的订单数
     * @return
     */
	E queryOrderCount(FormMap map);
	
	/**
     * 查询订单付款数量
     * @return
     */
	E queryOrderPayCount(FormMap map);
	
	/**
     * 查询用户积分数
     * @return
     */
	E queryUserLogsCount(FormMap map);
	
	/**
     * 查询月订单数量
     * @return
     */
	List<E> queryMonthOrders(FormMap map);
	
	/**
     * 修改订单状态
     * @return
     */
	int updateStatus(FormMap formMap);
	
	/**
     * 根据订单ID查询订单详情
     * @return
     */
	List<E> selectOrderDetailByOrderId(FormMap formMap);
	
	/**
     * 根据订单ID查询订单详情
     * @return
     */
	int updateProductStockByProductId(FormMap formMap);
	
	/**
     * 根据itemId修改商品item的库存
     * @return
     */
	int updateProductItemStockByItemId(FormMap formMap);
	
	/**
     * 评论查询
     * @return
     */
	List<E> selectOrderEvaluateList(FormMap map);
	
	/**
     * 修改评论
     * @return
     */
	int editOrderEvaluate(FormMap formMap);
	
	E selectOrderDashBoard(FormMap formMap);

	/**
     * 订单发货模板消息发送数据查询
     * @return
     */
	E selectOrderTimplateOne(FormMap formMap);
}
