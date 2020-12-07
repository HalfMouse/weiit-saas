package com.weiit.web.api.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.weiit.resource.common.utils.DateUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.api.mapper.ProductMapper;
import com.weiit.web.api.service.OrderService;
import com.weiit.web.api.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.OrderMapper;


/**
 * 订单接口实现类
 *
 * @version 1.0
 * @author：半个鼠标
 * @date：2018年3月14日
 * @company http://www.wei-it.com 微邦互联
 */
@Service
@Transactional(readOnly = false)//需要事务操作必须加入此注解
public class OrderServiceImpl extends AbstractService implements OrderService {

    @Resource
    private OrderMapper orderMapper;

    @Resource
    ProductMapper productMapper;


    @Resource
    UserService userService;

    @Override
    public BaseMapper setMapper() {
        return orderMapper;
    }

    @Override
    public List<E> selectOrderList(FormMap formMap) {
        return orderMapper.selectOrderList(formMap);
    }


    @Override
    public E selectOrderOne(FormMap formMap) {
        return orderMapper.selectOrderOne(formMap);
    }

    @Override
    public List<E> selectOrderDetails(FormMap formMap) {
        return orderMapper.selectOrderDetails(formMap);
    }

    @Override
    public void updateOrderState(FormMap formMap) {
        orderMapper.updateOrderState(formMap);
    }

    @Override
    public void insertOrderRefund(FormMap formMap) {
        orderMapper.insertOrderRefund(formMap);
    }

    @Override
    public List<E> selectOrderRefundList(FormMap formMap) {
        return orderMapper.selectOrderRefundList(formMap);
    }

    @Override
    public int selectOrderRefundCount(FormMap formMap) {
        return orderMapper.selectOrderRefundCount(formMap);
    }

    @Override
    public E selectOrderRefundDetail(FormMap formMap) {
        return orderMapper.selectOrderRefundDetail(formMap);
    }

    @Override
    public void updateOrderRefundState(FormMap formMap) {
        orderMapper.updateOrderRefundState(formMap);
    }

    @Override
    public void insertOrder(FormMap formMap) {
        orderMapper.insertOrder(formMap);
    }

    @Override
    public E selectUserAddressById(FormMap formMap) {
        return orderMapper.selectUserAddressById(formMap);
    }


    @Override
    public void insertOrderItem(FormMap formMap) {
        orderMapper.insertOrderItem(formMap);
    }

    @Override
    public List<E> selectUserCartList(FormMap formMap) {
        return orderMapper.selectUserCartList(formMap);
    }

    @Override
    public List<E> selectExpressCompanyList(FormMap formMap) {
        return orderMapper.selectExpressCompanyList(formMap);
    }

    @Override
    public void updateOrderRefundExpress(FormMap formMap) {
        orderMapper.updateOrderRefundExpress(formMap);
    }

    @Override
    public void clearUserCart(FormMap formMap) {
        orderMapper.clearUserCart(formMap);
    }

    @Override
    public E getOrderInfoByOrderNum(String orderNum) {
        return orderMapper.getOrderInfoByOrderNum(orderNum);
    }

    @Override
    public E getMchkeyByOrderNum(String orderNum) {
        return orderMapper.getMchkeyByOrderNum(orderNum);
    }

    @Override
    public E selectUserCouponById(FormMap formMap) {
        return orderMapper.selectUserCouponById(formMap);
    }

    @Override
    public void updateUserCouponById(FormMap formMap) {
        orderMapper.updateUserCouponById(formMap);
    }




    /**
     * address_id  cart_ids
     */
    @Override
    public FormMap calcPostage(FormMap formMap) {
        List<E> cartList;
        if (formMap.get("cartList") != null) {
            cartList = (List<E>) formMap.get("cartList");
        } else {
            cartList = selectUserCartList(formMap);
        }
        List<E> postageList = new ArrayList<E>();
        for (E cart : cartList) {
            //先判断商品是否有统一运费  且为0的商品，既免运费商品 包邮商品  有则全场包邮
            if (cart.getStr("express_config").equals("-1") && cart.getDouble("express_money") == 0.0) {
                formMap.put("expressPrice", 0.0);
                return formMap;
            }
            postageList.add(calcProduct(cart,formMap));
        }

        formMap.put("expressPrice", calcPrice(postageList));

        return formMap;
    }

    public E calcProduct(E product,FormMap formMap){
            E postage = new E();
            postage.put("product_id", product.get("product_id"));
            postage.put("count", product.get("count"));
            //-1统一价格，0运费模板
            postage.put("express_config", product.get("express_config"));
            postage.put("express_money", product.get("express_money"));
            if (product.getInt("express_config") == 0) {
                postage.put("shipping_id", product.get("express_template_id"));
                postage.put("weight", product.get("weight"));
                postage.put("volume", product.get("volume"));
                //根据express_template_id  和address_id  确定物流模板
                formMap.put("shipping_id", product.get("express_template_id"));
                List<E> shipItemList = getShipItemByShipId(formMap);
                //只有默认模板
                boolean lookFlag = false;
                if (shipItemList.size() > 1) {
                    E addressInfo = selectUserAddressById(formMap);
                    if (addressInfo!=null){
                        for (E shipItem : shipItemList) {
                            //匹配  配送区域  ,匹配上则按 匹配方案
                            if (shipItem.getStr("areas_names").contains(addressInfo.getStr("city"))) {
                                postage.put("shipping_config", shipItem.get("shipping_config"));
                                postage.put("start_standard", shipItem.get("start_standard"));
                                postage.put("start_fee", shipItem.get("start_fee"));
                                postage.put("add_standard", shipItem.get("add_standard"));
                                postage.put("add_fee", shipItem.get("add_fee"));
                                lookFlag = true;
                                break;
                            }
                        }
                    }
                }
                //没有区域方案  或 未找到可配送区域  则选择默认方案
                if (!lookFlag) {
                    postage.put("shipping_config", shipItemList.get(0).get("shipping_config"));
                    postage.put("start_standard", shipItemList.get(0).get("start_standard"));
                    postage.put("start_fee", shipItemList.get(0).get("start_fee"));
                    postage.put("add_standard", shipItemList.get(0).get("add_standard"));
                    postage.put("add_fee", shipItemList.get(0).get("add_fee"));
                }

            }
        return postage;
    }

    public double calcPrice(List<E> list) {
        List<String> temp = new ArrayList<String>();
        //统一运费
        Double unifyPrice = 0.0;
        //模板运费
        Double templatePrice = 0.0;
        for (E e : list) {
            if (!temp.contains(e.getStr("product_id"))) {
                if (e.getStr("express_config").equals("0")) {
                    Double sumcount = 0.0;
                    for (E shipping : list) {
                        //同一物流模板的商品  统计出总数  总体重  总件数 总体积
                        if (shipping.getStr("express_config").equals("0") && e.getStr("shipping_id").equals(shipping.getStr("shipping_id"))) {
                            if (e.getStr("shipping_config").equals("0")) {
                                sumcount = sumcount + (shipping.getDouble("weight") * shipping.getDouble("count"));
                            }else if (e.getStr("shipping_config").equals("1")) {
                                sumcount = sumcount + shipping.getDouble("count");
                            }else if (e.getStr("shipping_config").equals("2")) {
                                sumcount = sumcount + (shipping.getDouble("volume") * shipping.getDouble("count"));
                            }
                            //此商品已计入邮费
                            temp.add(shipping.getStr("product_id"));
                        }
                    }
                    Double start_fee = e.getDouble("start_fee");
                    if (sumcount - e.getDouble("start_standard") > 0) {
                        Double add_fee = Math.ceil((sumcount - e.getDouble("start_standard")) / e.getDouble("add_standard")) * e.getDouble("add_fee");
                        templatePrice = templatePrice + (start_fee + add_fee);
                    } else {
                        templatePrice = templatePrice + start_fee;
                    }
                } else {
                    Double price = e.getDouble("express_money");
//                    if (unifyPrice == 0.0 || unifyPrice < price) {
//                        unifyPrice = price;
//                    }
                    if (unifyPrice < price) {
                        unifyPrice = price;
                    }
                }
            }
        }
        return unifyPrice + templatePrice;
    }

    @Override
    public E selectOrderRefundOne(FormMap formMap) {
        return orderMapper.selectOrderRefundOne(formMap);
    }
    @Override
    public E selectPaymentTypeInfo(FormMap formMap) {
        return orderMapper.selectPaymentTypeInfo(formMap);
    }


    public List<E> getShipItemByShipId(FormMap formMap) {

        return orderMapper.getShipItemByShipId(formMap);
    }

    @Override
    public List<E> getOrderItemByOrderNum(String order_num) {
        return orderMapper.getOrderItemByOrderNum(order_num);
    }

    @Override
    public E selectOrderItemOne(FormMap formMap) {
        return orderMapper.selectOrderItemOne(formMap);
    }
    @Override
    public E selectUserCouponInfoByOrderNum(FormMap formMap) {
        return orderMapper.selectUserCouponInfoByOrderNum(formMap);
    }

    @Override
    public E selectExpressInfoByCode(FormMap formMap) {
        return orderMapper.selectExpressInfoByCode(formMap);
    }


    @Override
    public E selectOrderInfoByOrderNum(FormMap formMap) {
        return orderMapper.selectOrderInfoByOrderNum(formMap);
    }

    @Override
    public void sendBossMessage(FormMap formMap) {

        E merchantInfo = userService.selectMerchantInfoByShopId(formMap);
        String [] notifyMsg={formMap.getStr("user_name"), DateUtil.dateToString(new Date(),null)};
        WeiitUtil.sendMobileMessage(merchantInfo.getStr("account"), "220055", notifyMsg);

    }

    @Override
    public int selectOrderProductCount(FormMap formMap) {
        return orderMapper.selectOrderProductCount(formMap);
    }

}
