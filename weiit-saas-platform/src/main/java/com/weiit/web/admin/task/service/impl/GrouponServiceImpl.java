package com.weiit.web.admin.task.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.init.service.OrderService;
import com.weiit.web.admin.task.mapper.GrouponMapper;
import com.weiit.web.admin.task.service.GrouponService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
@Service
public class GrouponServiceImpl extends AbstractService implements GrouponService {

    @Resource
    GrouponMapper grouponMapper;

    @Resource
    RedisUtil redisUtil;

    @Resource
    OrderService orderService;

    @Override
    public BaseMapper setMapper() {
        return grouponMapper;
    }

    @Override
    public List<E> selectGrouponList(FormMap formMap) {
        return grouponMapper.selectGrouponList(formMap);
    }

    @Override
    public E selectGrouponById(String formMap) {
        return grouponMapper.selectGrouponById(formMap);
    }

    @Override
    public List<E> selectGrouponOrderList(FormMap formMap) {
        return grouponMapper.selectGrouponOrderList(formMap);
    }

    @Override
    public void updateGrouponState(FormMap formMap) {
        grouponMapper.updateGrouponState(formMap);
    }

    @Override
    public void updateGrouponOrderState(FormMap formMap) {
        grouponMapper.updateGrouponOrderState(formMap);
    }

    @Override
    public E selectTemplateOne(FormMap formMap) {
        return grouponMapper.selectTemplateOne(formMap);
    }
    
    @Override
    public void complateOrder(E grouponOrder) {
        if (redisUtil.get("successOrder:" + grouponOrder.get("order_num")) != null) {
            return;
        }
        FormMap orderInfo = new FormMap();
        orderInfo.put("order_num", grouponOrder.getStr("order_num"));
        orderInfo.put("check_num", grouponOrder.get("check_num"));

        //total_price = smark_price
        orderInfo.put("total_price", grouponOrder.getBigDecimal("smarket_price"));
        orderInfo.put("pay_price", grouponOrder.getBigDecimal("pay_price"));
        orderInfo.put("user_id", grouponOrder.getStr("user_id"));
        orderInfo.put("user_name", grouponOrder.getStr("user_name"));
        orderInfo.put("address_id", grouponOrder.getStr("address_id"));
        orderInfo.put("payment_type", grouponOrder.getStr("payment_type"));

        //查询用户收货地址
        E address = orderService.selectUserAddressById(orderInfo);


        if (address != null) {
            orderInfo.put("consignee", address.getStr("consignee"));
            orderInfo.put("address", address.getStr("province") + " " + address.getStr("city") + " " + address.getStr("district") + " " + address.getStr("address_detail"));
            orderInfo.put("phone", address.getStr("phone"));
        }

        orderInfo.put("order_type", 0);
        orderInfo.put("state", 1);
        orderInfo.put("create_time", new Date());
        orderInfo.put("update_time", new Date());
        orderInfo.put("pay_time", new Date());
        orderInfo.put("shop_id", grouponOrder.getStr("shop_id"));

        orderService.insertOrder(orderInfo);

        FormMap itemInfo = new FormMap();
        itemInfo.put("product_id", grouponOrder.getStr("product_id"));
        itemInfo.put("product_name", grouponOrder.getStr("product_name"));
        itemInfo.put("product_img", grouponOrder.getStr("product_img"));
        itemInfo.put("smarket_price", grouponOrder.getStr("smarket_price"));
        itemInfo.put("sale_price", grouponOrder.getStr("sale_price"));
        itemInfo.put("count", grouponOrder.get("count"));

        //商品规格描述
        itemInfo.put("item_id", grouponOrder.getStr("item_id"));
        E itemDetail = orderService.getProductItemById(itemInfo);
        if (itemDetail != null && StringUtils.isNotBlank(itemDetail.getStr("spec_custom"))) {
            String[] keyIds = itemDetail.getStr("spec_custom").split(";");
            itemInfo.put("keyIds", keyIds);
            List<E> specInfoList = orderService.getSpecInfoByIds(itemInfo);
            String spec_content = "";
            for (E spec : specInfoList) {
                spec_content += spec.getStr("key_name") + ";";
            }
            itemInfo.put("spec_content", spec_content);
        }
        itemInfo.put("pay_price", grouponOrder.getBigDecimal("pay_price"));
        itemInfo.put("order_num", grouponOrder.getStr("order_num"));
        itemInfo.put("order_id", orderInfo.getStr("order_id"));
        itemInfo.put("shop_id", grouponOrder.getStr("shop_id"));

        orderService.insertOrderItem(itemInfo);

        FormMap updateStock = new FormMap();
        updateStock.put("item_id", grouponOrder.getStr("item_id"));
        updateStock.put("count", grouponOrder.getStr("count"));
        updateStock.put("product_id", grouponOrder.getStr("product_id"));

        // 更新商品、商品item库存  product_id  item_id count
        orderService.updateProductAndItemStock(updateStock);

        //防止重复记录订单
        redisUtil.set("successOrder:" + grouponOrder.get("order_num"), grouponOrder.get("order_num"), 60 * 60 * 24);
    }

    @Override
    public void processEndGroupon(E groupon,List<E> grouponOrderList) {
        if (grouponOrderList != null && grouponOrderList.size() > 0) {
            //拼团活动结束  若未开启模拟成团，未成团订单将自动关闭并退款至余额；若已开启模拟成团，未成的团将立即模拟成团。
            if (groupon.getInt("virtual_groupon") == 1) {

                for (E grouponOrder : grouponOrderList) {
                    TaskLogger.log("拼团结束  未成团订单_成图 order_num" + grouponOrder.get("order_num"));

                    // 更新订单为成团状态
                    FormMap updateOrderParam = new FormMap();
                    updateOrderParam.put("update_state", 3);
                    updateOrderParam.put("g_order_id", grouponOrder.get("g_order_id"));
                    updateGrouponOrderState(updateOrderParam);
                    //完成订单
                    complateOrder(grouponOrder);
                }
            } else {

                for (E grouponOrder : grouponOrderList) {
                    if (redisUtil.get("successOrder:" + grouponOrder.get("order_num")) != null) {
                        return;
                    }

                    TaskLogger.log("拼团结束  未成团订单_退款 order_num" + grouponOrder.get("order_num"));

                    // 更新订单为失败状态
                    FormMap updateOrderParam = new FormMap();
                    updateOrderParam.put("update_state", 2);
                    updateOrderParam.put("g_order_id", grouponOrder.get("g_order_id"));
                    updateGrouponOrderState(updateOrderParam);

                    DecimalFormat df = new DecimalFormat("#.00");

                    FormMap userMap = new FormMap();
                    userMap.put("user_id", grouponOrder.get("user_id"));
                    E newUserInfo = orderService.userInfo(userMap);
                    BigDecimal balance = new BigDecimal(newUserInfo.getDouble("balance"));
                    //扣除余额  ，添加余额记录  负数
                    userMap.put("balance", df.format(new BigDecimal(grouponOrder.getStr("pay_price"))));
                    userMap.put("last_balance", df.format(balance.add(new BigDecimal(grouponOrder.getStr("pay_price")))));
                    //
                    userMap.put("type", 3);
                    userMap.put("state", 0);
                    userMap.put("origin_id", grouponOrder.getStr("order_num"));
                    userMap.put("user_name", grouponOrder.getStr("user_name"));
                    userMap.put("logRemark", "未完成拼团退款");

                    orderService.addBalanceAndLog(userMap);

                    //防止重复记录订单
                    redisUtil.set("successOrder:" + grouponOrder.get("order_num"), grouponOrder.get("order_num"), 60 * 60 * 24);
                }

            }
        }
    }
}
