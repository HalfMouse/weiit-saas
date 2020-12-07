package com.weiit.web.admin.order.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.order.mapper.OrdersRefundMapper;
import com.weiit.web.admin.order.service.OrdersRefundService;
//import com.weiit.web.admin.user.mapper.UserMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * 订单退换货实现类
 * @author hzy
 * qq:137075251 半个鼠标
 * email:google555@126.com
 * team: http://www.wei-it.com
 */
@Service
public class OrdersRefundServiceImpl extends AbstractService implements OrdersRefundService {
	
	@Resource
	private OrdersRefundMapper ordersRefundMapper;
	
//	@Resource
//	private UserMapper userMapper;


	@Override
	public BaseMapper setMapper() {
		return ordersRefundMapper;
	} 
 
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int edit(FormMap formMap) {
		ordersRefundMapper.edit(formMap);
		if(formMap.get("state").equals("2")){
			E refund=ordersRefundMapper.selectOne(formMap);
			Double salePrice = refund.getDouble("refund_money");
				 
			formMap.set("validate_id", refund.get("user_id"));
//			E user=userMapper.selectById(formMap);
			FormMap map =formMap;
			map.put("user_id",  refund.get("user_id"));
			map.put("user_name", refund.get("user_name"));
			map.put("balance", salePrice);
//			map.put("last_balance",user.getDouble("balance")+salePrice);
			map.put("last_balance",0);
			map.put("remark", "订单退款,退款编号:"+refund.getStr("refund_num"));
			map.put("type", "3");//退款
			map.put("state", "0");//收入
			map.put("shop_id", formMap.get("shop_id")); 
//			userMapper.insertBalanceLog(map);
			
			map.put("type", "1");
			map.put("balance", salePrice);//余额变更
//			userMapper.updateBalanceOrIntegral(map);
		}
		return 1;
	}

	@Override
	public E selectRefunOne(FormMap formMap) {
		return ordersRefundMapper.selectRefunOne(formMap);
	}

	@Override
	public void insertBalanceLog(FormMap balanceLogInfo) {
		ordersRefundMapper.insertBalanceLog(balanceLogInfo);
	}

	@Override
	public void updateUserPrice(FormMap balanceLogInfo) {
		ordersRefundMapper.uodateUserPrice(balanceLogInfo);
	}
	
	/**
     * 订单退货审核模板消息发送数据查询
     * @return
     */
	public E selectOrderTimplateOne(FormMap formMap){
		return ordersRefundMapper.selectOrderTimplateOne(formMap);
	}
}
