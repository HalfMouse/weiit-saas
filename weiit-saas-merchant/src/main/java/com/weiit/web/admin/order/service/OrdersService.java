package com.weiit.web.admin.order.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 订单管理Service
 * @author zhouliang
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface OrdersService extends BaseService {

	E queryAddressById(FormMap map);
	
	List<E> queryOrdersDetail(FormMap map);
	
	E queryOrderCount(FormMap map);
	
	E queryOrderPayCount(FormMap map);
	
	E queryUserLogsCount(FormMap map);
	
	List<E> queryMonthOrders(FormMap map);
	
	int updateStatus(FormMap formMap);
	
	void updateStockTrans(FormMap formMap);
 
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
     * 订单发货，退货审核模板消息发送数据查询
     * @return
     */
	E selectOrderTimplateOne(FormMap formMap);
}
