package com.weiit.web.admin.order.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;


/**
 * 
* @ClassName: OrdersRefundMapper 
* @Description: 退换货Mapper接口
* @author lcm
* @date 2017年3月9日 上午10:42:36 
*
 */
public interface OrdersRefundMapper extends BaseMapper {
 
	/**
	 * 根据订单编号获取订单详情
	 * @param orderid
	 * @return
	 */
	public List<E> queryOrdersRefundDetail(FormMap map);
 
	/**
	 * 更新订单详细状态
	 * @param map
	 */
	void updateOrderDetailStatus(FormMap map);

	/**
	 * 查询退货退款订单信息
	 * @param map
	 */
	E selectRefunOne(FormMap formMap);


	/**
	 * 插入用户余额明细表
	 * @param map
	 */
	void insertBalanceLog(FormMap balanceLogInfo);

	/**
	 * 修改用户表的余额
	 * @param map
	 */
	void uodateUserPrice(FormMap balanceLogInfo);
	
	/**
     * 订单退货审核模板消息发送数据查询
     * @return
     */
	E selectOrderTimplateOne(FormMap formMap);
}
