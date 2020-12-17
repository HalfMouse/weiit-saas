package com.weiit.web.admin.task.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.init.service.OrderService;
import com.weiit.web.admin.task.mapper.OrderConfirmMapper;
import com.weiit.web.admin.task.service.OrderConfirmService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
@Service
public class OrderConfirmServiceImpl extends AbstractService implements OrderConfirmService {

    @Resource
    OrderConfirmMapper orderConfirmMapper;

    @Resource
    RedisUtil redisUtil;

    @Resource
    OrderService orderService;

    @Override
    public BaseMapper setMapper() {
        return orderConfirmMapper;
    }
    
    @Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public void processEndOrder(E order) {
        if (redisUtil.get("successOrdera:" + order.get("order_num")) != null) {
            return;
        }

        TaskLogger.log("订单支付15天未发货_退款 order_num" + order.get("order_num"));

        // 更新订单为失败状态
        FormMap updateOrderParam = new FormMap();
        updateOrderParam.put("state",1);
        updateOrderParam.put("update_state",-1);
        updateOrderParam.put("order_id", order.get("order_id"));
        orderConfirmMapper.edit(updateOrderParam);

        DecimalFormat df = new DecimalFormat("#.00");

        FormMap userMap = new FormMap();
        userMap.put("user_id", order.get("user_id"));
        E newUserInfo = orderService.userInfo(userMap);
        BigDecimal balance = new BigDecimal(newUserInfo.getDouble("balance"));
        //添加余额  ，添加余额记录
        userMap.put("balance", df.format(new BigDecimal(order.getStr("pay_price"))));
        userMap.put("last_balance", df.format(balance.add(new BigDecimal(order.getStr("pay_price")))));
        //
        userMap.put("type", 3);
        userMap.put("state", 0);
        userMap.put("origin_id", order.getStr("order_num"));
        userMap.put("user_name", newUserInfo.getStr("user_name"));
        userMap.put("logRemark", "订单支付15天未发货");
        userMap.put("shop_id", order.get("shop_id"));

        orderService.addBalanceAndLog(userMap);

        //防止重复记录订单
        redisUtil.set("successOrder:" + order.get("order_num"), order.get("order_num"), 60 * 60 * 24);
 
    }
    
    @Override
    public  List<E> selectOrderUnpaidList(FormMap formMap){
    	return orderConfirmMapper.selectOrderUnpaidList(formMap);
    }
}
