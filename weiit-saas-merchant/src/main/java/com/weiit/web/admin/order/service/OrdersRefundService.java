package com.weiit.web.admin.order.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;


/**
 *
* @ClassName: OrdersRefundService
* @Description: 退换货service接口
* @author lcm
* @date 2017年3月9日 上午10:39:20
*
 */
public interface OrdersRefundService extends BaseService {

   E selectRefunOne(FormMap formMap);

   void insertBalanceLog(FormMap balanceLogInfo);

    void updateUserPrice(FormMap balanceLogInfo);

	/**
     * 订单退货审核模板消息发送数据查询
     * @return
     */
	E selectOrderTimplateOne(FormMap formMap);
}

