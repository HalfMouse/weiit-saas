package com.weiit.web.api.controller;


import com.github.binarywang.wxpay.util.SignUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.api.service.*;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.Constants;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.DateUtil;
import com.weiit.web.weixinopen.util.XMLUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;
/**
 * 订单接口
 *
 * @author tangjian
 * @version 1.0
 * @date：2018年5月7日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/api/order")
public class OrderController extends FrontController {
    @Resource
    private OrderService orderService;

    @Resource
    UserService userService;

    @Resource
    PlatformService platformService;

    @Resource
    ProductService productService;

    @Resource
    RedisUtil redisUtil;

    @Resource
    MessageService messageService;

    @Resource
    IntegralService integralService;

    /**
     * 订单确认接口
     *
     * @return
     * @throws Exception
     * 参数有cart_ids,address_id,payment_type,remark,express_type,express_money,  coupon_id(用户优惠券表的id)   优惠券ID ,pay_price
     */
    @ResponseBody
    @RequestMapping(value = "/addOrder", method = RequestMethod.POST)
    public String addOrder(@RequestHeader("token") String token) throws Exception {
        logger.info("【商品】提交订单,orderController-addOrder");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //核对订单信息,重新计算总额
            double sum = 0;
            double payPrice = 0;
            List<E> cartList = orderService.selectUserCartList(formMap);
            if (cartList == null && cartList.size()==0) {
                return toJsonAPI("", "创建订单失败，购物车为空", "1006");
            }
            for (E cart : cartList) {
                sum = sum + cart.getDouble("smarket_price") * cart.getInt("count");
                payPrice = payPrice + cart.getDouble("sale_price") * cart.getInt("count");
            }

            formMap.put("order_num", Constants.ORDER_SHOP + System.currentTimeMillis() + StringUtils.leftPad(formMap.getStr("user_id"), 8, RandomUtils.nextInt(1000000) + ""));
            formMap.put("total_price", sum);

            //计算优惠金额
            double coupon_price =0.0;
            //表示有优惠券抵扣   小程序传undifined
            if(!StringUtils.isEmpty(formMap.getStr("coupon_id")) && !formMap.getStr("coupon_id").equals("undefined")){
                E coupon=orderService.selectUserCouponById(formMap);
                if (coupon==null){
                    return toJsonAPI("", "创建订单失败，优惠券不在使用时间", "1005");
                }else if(coupon.getInt("state")==-1){
                    return toJsonAPI("", "创建订单失败，优惠券已过期", "1005");
                }else if(coupon.getInt("state")==1){
                    return toJsonAPI("", "创建订单失败，优惠券已使用", "1005");
                }

                //都是可用优惠券  不用判断 无条件或是满减

                //通用商品  若有售后问题打包退回
                if (coupon.getInt("product_range_type")==1){
                    //指定金额
                    if(coupon.getInt("type")==1){
                        coupon_price=coupon.getDouble("coupon_price");
                        for (E cart : cartList) {
                            //销售金额 -优惠金额*（销售金额/支付金额）= 商品的实际支付金额（售后的退款金额）
                            double salePrice = cart.getDouble("sale_price") * cart.getInt("count");
                            cart.set("coupon_pay",salePrice-calcPayPrice(salePrice,payPrice,coupon_price));
                            cart.set("pay_price",calcPayPrice(salePrice,payPrice,coupon_price));
                        }

                    }
                    //打折
                    else if(coupon.getInt("type")==2) {
                        coupon_price= getDoubleValue(new BigDecimal(payPrice).multiply(new BigDecimal(10).subtract(new BigDecimal(coupon.getStr("coupon_discount"))).divide(new BigDecimal(10))));

                        for (E cart : cartList) {
                            //销售金额 -优惠金额*（销售金额/支付金额）= 商品的实际支付金额（售后的退款金额）
                            double salePrice = cart.getDouble("sale_price") * cart.getInt("count");
                            cart.set("coupon_pay",getDoubleValue(new BigDecimal(salePrice).multiply(new BigDecimal(10-coupon.getInt("coupon_discount"))).divide(new BigDecimal(10))));
                            cart.set("pay_price",getDoubleValue(new BigDecimal(salePrice).multiply(new BigDecimal(coupon.getInt("coupon_discount"))).divide(new BigDecimal(10))));
                        }
                    }
                }//指定商品
                else if (coupon.getInt("product_range_type")==2){
                    String [] product_ids = coupon.getStr("product_ids").split(",");
                    //指定金额
                    boolean flag = false;
                    if(coupon.getInt("type")==1){
                        coupon_price=coupon.getDouble("coupon_price");
                        for(String productId:product_ids){
                            for (E cart : cartList) {
                                if (cart.getStr("product_id").equals(productId)){
                                    //
                                    cart.set("coupon_pay",coupon_price);
                                    //未测精度缺失
                                    cart.set("pay_price",cart.getDouble("sale_price") * cart.getInt("count")-coupon_price);
                                    flag=true;
                                    break;
                                }
                            }
                            if (flag){
                                break;
                            }
                        }
                    }else if(coupon.getInt("type")==2) {//打折
                        double temp_price =0.0;
                        for(String productId:product_ids){
                            for (E cart : cartList) {
                                if (cart.getStr("product_id").equals(productId)){

                                    temp_price+=cart.getDouble("sale_price") * cart.getInt("count");
                                    //该件商品的支付金额    方便售后退货
                                    cart.set("coupon_pay",getDoubleValue(new BigDecimal(cart.getDouble("sale_price") * cart.getInt("count")).multiply(new BigDecimal(10-coupon.getInt("coupon_discount")).divide(new BigDecimal(10)))));
                                    cart.set("pay_price",getDoubleValue(new BigDecimal(cart.getDouble("sale_price") * cart.getInt("count")).multiply(new BigDecimal(coupon.getInt("coupon_discount")).divide(new BigDecimal(10)))));
                                }
                            }
                        }
                        coupon_price=getDoubleValue(new BigDecimal(temp_price).multiply(new BigDecimal(10-coupon.getInt("coupon_discount")).divide(new BigDecimal(10))));
                    }
                }
                //更新用户优惠券 的订单使用及折扣金额
                formMap.put("coupon_price",coupon_price);
                orderService.updateUserCouponById(formMap);
            }

            //计算邮费
            formMap.put("cartList",cartList);
            //计算邮费
            orderService.calcPostage(formMap);

            //订单总额付款价=订单本应付款总额+运费-优惠金额
            payPrice=payPrice+formMap.getDouble("expressPrice")-coupon_price;
            formMap.put("pay_price", payPrice);

            //查询用户收货地址
            E address = orderService.selectUserAddressById(formMap);
            if (address != null) {
                formMap.put("consignee", address.getStr("consignee"));
                formMap.put("address", address.getStr("province") + " " + address.getStr("city") + " " + address.getStr("district") + " " + address.getStr("address_detail"));
                formMap.put("phone", address.getStr("phone"));
            }
            formMap.put("order_type", 0);
            formMap.put("state", 0);
//            formMap.put("express_type", 0);//0表示快递，1表示货到付款，2表示上面取货
            //物流费用
            formMap.put("express_money", formMap.getDouble("expressPrice"));
            //新增weiit_order表
            orderService.insertOrder(formMap);






            //新增weiit_order_item表
            for (E cart : cartList) {
                FormMap itemPram = new FormMap();
                itemPram.put("product_id", cart.getStr("product_id"));
                itemPram.put("product_name", cart.getStr("product_name"));
                itemPram.put("product_img", cart.getStr("product_img"));
                itemPram.put("smarket_price", cart.getStr("smarket_price"));
                itemPram.put("sale_price", cart.getStr("sale_price"));
                itemPram.put("count", cart.getStr("count"));
                itemPram.put("spec_content", cart.getStr("spec_content"));
                itemPram.put("item_id", cart.getStr("item_id"));
                itemPram.put("shop_id", formMap.getStr("shop_id"));
                //商品小计=商品销售价*数量
                itemPram.put("pay_price", cart.get("pay_price")==null?cart.getDouble("sale_price") * cart.getInt("count"):cart.get("pay_price"));
                //来自于订单主键
                itemPram.put("order_id", formMap.getStr("order_id"));
                itemPram.put("order_num", formMap.getStr("order_num"));

                orderService.insertOrderItem(itemPram);
            }

            //t 发送订单生成模板通知
            formMap.put("productName",cartList.get(0).getStr("product_name"));


            sendOrderCreateMsg(formMap);

            //清理购物车
            orderService.clearUserCart(formMap);

            DecimalFormat df = new DecimalFormat("#.00");
            //判断是否使用优惠券，优惠券状态变更,weiit_user_coupons
            //update weiit_user_coupons set state=1 where coupon_id and user_id=

            if (formMap.getInt("payment_type") == Constants.PAY_BALANCE) {
                //余额值 重新获取
                E newUserInfo = userService.userInfo(formMap);
                BigDecimal balance = new BigDecimal(newUserInfo.getDouble("balance"));


                if (balance.compareTo(new BigDecimal(payPrice)) > 0) {
                    //扣除余额  ，添加余额记录  负数
                    formMap.put("balance", df.format(new BigDecimal(payPrice).negate()));
                    formMap.put("last_balance", df.format(balance.subtract(new BigDecimal(payPrice))));
                    //
                    formMap.put("type", 4);
                    formMap.put("state", -1);
                    formMap.put("origin_id", formMap.getStr("order_num"));
                    formMap.put("user_name", formMap.getStr("user_name"));
                    formMap.put("logRemark", "购物消费");

                    userService.addBalanceAndLog(formMap);

                    //更新订单状态
                    formMap.put("state", Constants.ORDER_STATE_DELIVER);

                    processOrder(formMap, cartList);


                    return toJsonAPI(ApiResponseCode.SUCCESS);

                } else {
                    return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
                }
            } else if (formMap.getInt("payment_type") == Constants.PAY_WX) {
                E result = new E();
                //返回微信支付所需参数 notify_url
                result.put("wx_open_id", formMap.get("wx_open_id"));
                result.put("out_trade_no", formMap.getStr("order_num"));
                result.put("total_fee", getInterValue(new BigDecimal(payPrice).multiply(new BigDecimal(100))));
                result.put("body", "weiyun");
                result.put("trade_type", "JSAPI");
                result.put("spbill_create_ip", "127.0.0.1");
                result.put("notifyUrl", Constants.SERVER_HOST + "api/order/notifyCart");
                result.put("open_id_type", formMap.get("open_id_type"));
                result.put("shop_id", formMap.getStr("shop_id"));

                return toJsonAPI(platformService.wxPay(result));
            }

            //如果业务订单购买后要送积分，则奖励积分，并且记录积分记录,weiit_user,weiit_user_integral_log

            return toJsonAPI("订单创建成功");

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }

    public void sendOrderCreateMsg(FormMap formMap){
        //  砍价成功通知
        formMap.put("business_type",5);
        E templateMsg = platformService.selectShopTemplateMsg(formMap);

        if (templateMsg!=null){

            //发起者的openId
            List<String> openIds = new ArrayList<String>();
            openIds.add(formMap.getStr("wx_open_id"));

            FormMap pushMap = new FormMap();
            pushMap.put("appid",formMap.getStr("authorizer_app_id"));


            //小程序模板
            if (formMap.getInt("open_id_type")==0){
                E keywords = new E();
                keywords.put("keyword1",formMap.getStr("productName"));
                keywords.put("keyword2",formMap.getStr("pay_price"));
                keywords.put("keyword3",formMap.getStr("order_num"));
                keywords.put("keyword4", DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss"));

                //订单详情页
                String page = String.format("pages/order_details/order_details?order_num=%s",formMap.getStr("order_num"));

                messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword2.DATA");
            }else if (formMap.getInt("open_id_type")==1){
                E keywords = new E();
                /**
                 *   {{first.DATA}}时间：{{keyword1.DATA}}商品名称：{{keyword2.DATA}}订单号：{{keyword3.DATA}}{{remark.DATA}}
                 *订单生成通知<br>时间：2014年7月21日 18:36<br>商品名称：苹果iphone8plus<br>订单号：GW234892938<br>您的订单已经创建成功，现在就去支付.
                 * */
                keywords.put("first","订单生成通知");
                keywords.put("keyword1",DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
                keywords.put("keyword2",formMap.getStr("productName"));
                keywords.put("keyword3",formMap.getStr("order_num"));
                keywords.put("remark","您的订单已经创建成功,支付金额为"+formMap.getStr("pay_price")+Constants.WEIITSPLIT+"#FF0000");


                String page =String.format(Constants.MP_TEMPLATE_URL+"orderDetails?order_num=%s",formMap.getStr("authorizer_app_id"),formMap.getStr("order_num"));

                messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
            }
        }
    }


    public   double calcPayPrice(double salePrice,double sumPayPrice,double couponPrice){
        return new BigDecimal(salePrice-couponPrice*(salePrice/sumPayPrice)).setScale(2,BigDecimal.ROUND_HALF_DOWN).doubleValue();
    }


    /**
    *   根据购物车ID cart_ids  address_id计算购物车邮费
    * */
    @RequestMapping("/calcPostage")
    @ResponseBody
    public String calcPostage(){
        FormMap formMap =getFormMap();
        Map result = new HashMap();
        if (formMap.get("cart_ids")==null || formMap.get("cart_ids")==""){
            result.put("expressPrice",0.0);
        }else {
            formMap = orderService.calcPostage(formMap);
            result.put("expressPrice",formMap.get("expressPrice"));
        }
        return toJsonAPI(result);
    }



    @RequestMapping(value = "/notifyCart")
//    @ResponseBody
    public void notifyCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        String FEATURE = null;
        try {
            // This is the PRIMARY defense. If DTDs (doctypes) are disallowed, almost all XML entity attacks are prevented
            // Xerces 2 only - http://xerces.apache.org/xerces2-j/features.html#disallow-doctype-decl
            FEATURE = "http://apache.org/xml/features/disallow-doctype-decl";
            dbf.setFeature(FEATURE, true);

            // If you can't completely disable DTDs, then at least do the following:
            // Xerces 1 - http://xerces.apache.org/xerces-j/features.html#external-general-entities
            // Xerces 2 - http://xerces.apache.org/xerces2-j/features.html#external-general-entities
            // JDK7+ - http://xml.org/sax/features/external-general-entities
            FEATURE = "http://xml.org/sax/features/external-general-entities";
            dbf.setFeature(FEATURE, false);

            // Xerces 1 - http://xerces.apache.org/xerces-j/features.html#external-parameter-entities
            // Xerces 2 - http://xerces.apache.org/xerces2-j/features.html#external-parameter-entities
            // JDK7+ - http://xml.org/sax/features/external-parameter-entities
            FEATURE = "http://xml.org/sax/features/external-parameter-entities";
            dbf.setFeature(FEATURE, false);

            // Disable external DTDs as well
            FEATURE = "http://apache.org/xml/features/nonvalidating/load-external-dtd";
            dbf.setFeature(FEATURE, false);

            // and these as well, per Timothy Morgan's 2014 paper: "XML Schema, DTD, and Entity Attacks"
            dbf.setXIncludeAware(false);
            dbf.setExpandEntityReferences(false);

            // And, per Timothy Morgan: "If for some reason support for inline DOCTYPEs are a requirement, then
            // ensure the entity settings are disabled (as shown above) and beware that SSRF attacks
            // (http://cwe.mitre.org/data/definitions/918.html) and denial
            // of service attacks (such as billion laughs or decompression bombs via "jar:") are a risk."

            // remaining parser logic
        } catch (ParserConfigurationException e) {
            // This should catch a failed setFeature feature
            logger.info("ParserConfigurationException was thrown. The feature '" +
                    FEATURE + "' is probably not supported by your XML processor.");
        }
//        catch (SAXException e) {
//            // On Apache, this should be thrown when disallowing DOCTYPE
//            logger.error("A DOCTYPE was passed into the XML document");
//        }
        catch (Exception e) {
            // XXE that points to a file that doesn't exist
            logger.error("IOException occurred, XXE may still possible: " + e.getMessage());
        }

        try {
            synchronized (this) {
                Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
                if (kvm.get("result_code").equals("SUCCESS")) {
                    //!=null  此订单处理ok
                    if(redisUtil.get(RedisKey.WX_NOTIFY+kvm.get("out_trade_no"))!=null){
                        response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");
                        return;
                    }
                    FormMap formMap = new FormMap();
                    formMap.put("order_num", kvm.get("out_trade_no"));
                    formMap.put("check_num", kvm.get("transaction_id"));
                    //商户key 信息
                    E mchKeyInfo = orderService.getMchkeyByOrderNum(formMap.getStr("order_num"));
                    if (mchKeyInfo != null && SignUtils.checkSign(kvm, null, mchKeyInfo.getStr("partner_key"))) {

                        //更新订单状态
                        formMap.put("state", Constants.ORDER_STATE_DELIVER);
                        formMap.put("order_id", mchKeyInfo.get("order_id"));
                        formMap.put("user_id", mchKeyInfo.get("user_id"));

                        //订单详情信息
                        List<E> orderItemList = orderService.getOrderItemByOrderNum(formMap.getStr("order_num"));

                        //查询用户信息及授权信息
                        E userAndAuthInfo =platformService.selectUserAndAuthInfoByUserId(formMap);
                        formMap.putAll(userAndAuthInfo);
                        //完成订单业务
                        processOrder(formMap, orderItemList);

                        //防止重复回调
                        redisUtil.set(RedisKey.WX_NOTIFY+kvm.get("out_trade_no"),kvm.get("out_trade_no"),60*60*24);

                        logger.info("out_trade_no: " + kvm.get("out_trade_no") + " pay SUCCESS!");
                        response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");

                    } else {
                        response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[check signature FAIL]]></return_msg></xml>");
                        this.logger.error("out_trade_no: " + kvm.get("out_trade_no") + " check signature FAIL");
                    }


                } else {
                    this.logger.error("out_trade_no: " + kvm.get("out_trade_no") + " result_code is FAIL");
                    response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.logger.error("notifyCart is fail ,result_code is FAIL");
            response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
        }

    }


    public void processOrder(FormMap formMap, List<E> list) {
        //更新订单状态
        orderService.updateOrderState(formMap);

        for (E item : list) {
            formMap.put("item_id", item.getStr("item_id"));
            formMap.put("count", item.getStr("count"));
            formMap.put("product_id", item.getStr("product_id"));
            // 更新商品、商品item库存  product_id  item_id count
            productService.updateProductAndItemStock(formMap);
        }
        // 发送订单支付成功通知
        //查询订单信息
        E orderInfo = orderService.selectOrderInfoByOrderNum(formMap);
        formMap.putAll(orderInfo);
        formMap.put("productName",list.get(0).getStr("product_name"));



        //查看店铺是否已设置积分赠送
        FormMap paramMap = new FormMap();
        paramMap.put("item_code","INTEGRALSET");
        paramMap.put("item_name","GOSHOP");
        paramMap.put("shop_id",formMap.getStr("shop_id"));

        E shopParam = integralService.selectShopParamByCode(paramMap);

        if (shopParam !=null && shopParam.getInt("state")==0 && shopParam.getInt("item_value")>0 ){
            //添加积分
            E userInfo = userService.selectUserInfoByOpenId(formMap);

            BigDecimal updateIntegral = new BigDecimal(userInfo.getStr("integral")).add(new BigDecimal(shopParam.getStr("item_value")));
            formMap.put("updateIntegral",updateIntegral);

            userService.updateUserIntegral(formMap);

            //添加积分记录
            formMap.put("i_integral",shopParam.getStr("item_value"));
            formMap.put("i_last_integral",updateIntegral);
            formMap.put("i_remark",shopParam.getStr("item_desc"));
            formMap.put("i_type",4);
            formMap.put("i_state",1);

            userService.addUserIntegralLog(formMap);
        }

        sendOrderPayMsg(formMap);


        //卖家接收发货通知
        orderService.sendBossMessage(formMap);


    }


    public void sendOrderPayMsg(FormMap formMap){
        //  订单支付成功通知
        formMap.put("business_type",3);
        E templateMsg = platformService.selectShopTemplateMsg(formMap);

        if (templateMsg!=null){

            //发起者的openId
            List<String> openIds = new ArrayList<String>();
            openIds.add(formMap.getStr("wx_open_id"));

            FormMap pushMap = new FormMap();
            pushMap.put("appid",formMap.getStr("authorizer_app_id"));

            /**
             *
             商品名称
             {{keyword1.DATA}}
             订单编号
             {{keyword2.DATA}}
             商家名称
             {{keyword3.DATA}}
             支付时间
             {{keyword4.DATA}}
             * */
            //小程序模板
            if (formMap.getInt("open_id_type")==0){
                E keywords = new E();
                keywords.put("keyword1",formMap.getStr("productName"));
                keywords.put("keyword2",formMap.getStr("pay_price"));
                keywords.put("keyword3",formMap.getStr("order_num"));
                keywords.put("keyword4", DateUtil.format(formMap.getDate("pay_time"),"yyyy-MM-dd HH:mm:ss"));

                //订单详情页
                String page = String.format("pages/order_details/order_details?order_num=%s",formMap.getStr("order_num"));

                messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword2.DATA");
            }else if (formMap.getInt("open_id_type")==1){
                E keywords = new E();
                /**
                 *   {{first.DATA}}用户名：{{keyword1.DATA}}订单号：{{keyword2.DATA}}订单金额：{{keyword3.DATA}}商品信息：{{keyword4.DATA}}{{remark.DATA}}
                 *您的订单已支付成功。 <br>用户名：123456789@qingpinji.com<br>订单号：2015698571200<br>订单金额：￥98.80<br>商品信息：星冰乐（焦糖味）  家乐氏香甜玉米片*2  乐天七彩爱情糖*3<br>如有问题请致电xxx客服热线400-8070028或直接在微信留言，客服在线时间为工作日10:00——18:00.客服人员将第一时间为您服务。
                 * */
                keywords.put("first","您的订单已支付成功。");
                keywords.put("keyword1",formMap.getStr("user_name"));
                keywords.put("keyword2",formMap.getStr("order_num"));
                keywords.put("keyword3",formMap.getStr("pay_price")+Constants.WEIITSPLIT+"#FF0000");
                keywords.put("keyword4",formMap.getStr("productName"));
                keywords.put("remark","祝您购物愉快");

                String page =String.format(Constants.MP_TEMPLATE_URL+"orderDetails?order_num=%s",formMap.getStr("authorizer_app_id"),formMap.getStr("order_num"));

                messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
            }
        }
    }

    /**
     * 订单列表接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/orderList")
    public String orderList(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-orderList");
        FormMap formMap = getFormMap();

        if (formMap.get("user_id") != null) {
            // 开启分页
            PageHelper.startPage(formMap.getPage(), formMap.getRows());
            List<E> orderList = orderService.selectOrderList(formMap);
            if (!orderList.isEmpty() && orderList.size() > 0) {
                for (int i = 0; i < orderList.size(); i++) {
                    E orderMap = orderList.get(i);
                    FormMap param = new FormMap();
                    param.put("order_num", orderMap.getStr("order_num"));
                    List<E> item = orderService.selectOrderDetails(param);
                    orderMap.put("item", item);
                }
            }
            return toJsonAPI(new PageInfo<E>(orderList));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * 订单详情接口
     *
     * @return
     * @throws Exception
     *
     * 参数order_id
     */
    @ResponseBody
    @RequestMapping(value = "/orderDetail", method = RequestMethod.POST)
    public String orderDetail(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-orderDetail");

        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            E orderInfo = orderService.selectOrderOne(formMap);

            List<E> orderItems = orderService.selectOrderDetails(formMap);
            orderInfo.put("item", orderItems);

            //优惠折扣信息
            formMap.put("order_num",orderInfo.get("order_num"));
            E userCouponInfo = orderService.selectUserCouponInfoByOrderNum(formMap);
            orderInfo.put("couponInfo", userCouponInfo);

            return toJsonAPI(orderInfo);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 订单物流查询接口
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/orderExpress", method = RequestMethod.POST)
    public String orderExpress(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-orderExpress");
        FormMap formMap = getFormMap();

        E result = new E();
        if (formMap.get("user_id") != null) {
            try {
                //调用接口 获取快递单号运转信息
                //express_code
                E expressBaseInfo = orderService.selectExpressInfoByCode(formMap);
                result.put("expressBaseInfo",expressBaseInfo);


                String expressInfo = WeiitUtil.getLogistics(formMap.getStr("express_code"), formMap.getStr("express_num"));

                if (expressInfo == null || expressInfo.equals("")) {
                    return toJsonAPI("", "该单号暂无物流进展，请稍后再试，或检查公司和单号是否有误！", "1003");
                }

                result.put("expressInfo",expressInfo);
                return toJsonAPI(result);
            } catch (Exception e) {
                return toJsonAPI("", "查询异常，请稍后再试！", "1003");
            }
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 确认收货
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/updateOrderState", method = RequestMethod.POST)
    public String updateOrderState(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-updateOrderState");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //交易完成
            formMap.put("state",4);
            orderService.updateOrderState(formMap);
            return toJsonAPI("");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 订单售后-添加订单售后
     *
     * @param token
     * @return
     * @throws Exception
     * param  id or ids?
     */
    @ResponseBody
    @RequestMapping(value = "/addOrderRefund", method = RequestMethod.POST)
    public String addOrderRefund(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-addOrderRefund");

        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //查询是否已申请售后
            E refundInfo = orderService.selectOrderRefundOne(formMap);

            E orderItemInfo = orderService.selectOrderItemOne(formMap);



            //判断这个用户是否有申请过售后.
            if (refundInfo==null){
                //判断这个订单是不是待发货状态

                    formMap.put("order_num",orderItemInfo.get("order_num"));
                    formMap.put("order_item_id",formMap.get("id"));
                    //已发货状态下退货退款,退商品的金额.
                    formMap.put("refund_money",orderItemInfo.getDouble("pay_price"));
                    formMap.set("refund_num", System.currentTimeMillis());
                    orderService.insertOrderRefund(formMap);

                    //退货申请通知

                    //查询店铺是否设置退货模板通知
                    formMap.put("business_type",15);
                    E templateMsg = platformService.selectShopTemplateMsg(formMap);
                    //判断用户是小程序用户还是公众号用户
                    if(templateMsg != null){



                        //发起者的openId
                        List<String> openIds = new ArrayList<String>();
                        //根据b_order_id  查询发起者的openId
                        openIds.add(formMap.getStr("wx_open_id"));

                        FormMap pushMap = new FormMap();
                        pushMap.put("appid",formMap.getStr("authorizer_app_id"));

                        //小程序模板
                        if (formMap.getInt("open_id_type")==0){

                            /**
                             *
                             *
                             * 商品名称
                             {{keyword1.DATA}}
                             订单编号
                             {{keyword2.DATA}}
                             金额
                             {{keyword3.DATA}}
                             退货地址
                             {{keyword4.DATA}}
                             退货状态
                             {{keyword5.DATA}}
                             退款说明
                             {{keyword6.DATA}}
                             * */

                            E keywords = new E();
                            keywords.put("keyword1",orderItemInfo.getStr("product_name"));
                            keywords.put("keyword2",orderItemInfo.getStr("order_num"));
                            keywords.put("keyword3",orderItemInfo.getStr("pay_price"));
                            keywords.put("keyword4","待填写");
                            keywords.put("keyword5","待审核");
                            keywords.put("keyword6",orderItemInfo.getStr("remark"));

                            String page = String.format("pages/order_details/order_details?order_num=%s",orderItemInfo.getStr("order_num"));

                            messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword3.DATA");
                        }else if (formMap.getInt("open_id_type")==1){

                            /**
                             *{{first.DATA}}订单编号：{{keyword1.DATA}}商品信息：{{keyword2.DATA}}商品数量：{{keyword3.DATA}}商品金额：{{keyword4.DATA}}{{remark.DATA}}
                             *你好，您的退货申请已受理
                             订单编号：1010011211
                             商品信息：著名扳手手机
                             商品数量：2
                             商品金额：0.5元
                             我们在收到货后，会于1个工作日内给您打款，如有问题，可直接在公众号留言咨询客服哦！
                             * */
                             E keywords = new E();
                            keywords.put("first","你好，您的退货申请已受理");
                            keywords.put("keyword1",formMap.getStr("order_num"));
                            keywords.put("keyword2",orderItemInfo.getStr("product_name"));
                            keywords.put("keyword3",orderItemInfo.getStr("count"));
                            keywords.put("keyword4",orderItemInfo.getStr("pay_price")+"元"+Constants.WEIITSPLIT+"#FF0000");
                            keywords.put("remark","等待商家确认");


                            String page =String.format(Constants.MP_TEMPLATE_URL+"orderDetails?order_num=%s",formMap.getStr("authorizer_app_id"),formMap.getStr("order_num"));

                            messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,null);
                        }
                    }

                    /**
                     * 商品名称 {{keyword1.DATA}}
                     订单编号 {{keyword2.DATA}}
                     金额 {{keyword3.DATA}}
                     退货地址 {{keyword4.DATA}}
                      退货状态 {{keyword5.DATA}}
                     退款说明 {{keyword6.DATA}}
                     * */



                    return toJsonAPI("","申请售后成功","0");

            }else{
                return toJsonAPI("","已提交申请,请勿再次提交","0");
            }
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 订单售后列表
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/orderRefundList", method = RequestMethod.POST)
    public String orderRefundList(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-orderRefundList");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //查询售后订单列表信息
            PageHelper.startPage(formMap.getPage(), formMap.getRows());
            List<E> orderRefundList = orderService.selectOrderRefundList(formMap);

            //list 返回分页信息
            return toJsonAPI(new PageInfo<E>(orderRefundList));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 订单售后详情
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/orderRefundDetail", method = RequestMethod.POST)
    public String orderRefundDetail(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-orderRefundDetail");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //查询售后订单详情信息
            E orderRefundDetail = orderService.selectOrderRefundDetail(formMap);

            return toJsonAPI(orderRefundDetail);

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 售后-物流公司查询接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/expressCompany", method = RequestMethod.POST)
    public String expressCompany(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-expressCompany");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            List<E> companyList = orderService.selectExpressCompanyList(formMap);
            return toJsonAPI(companyList);

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 售后-物流信息填写提交
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/addOrderRefundExpress", method = RequestMethod.POST)
    public String addOrderRefundExpress(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-addOrderRefundExpress");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            formMap.put("state",2);
            orderService.updateOrderRefundExpress(formMap);

            orderService.updateOrderRefundState(formMap);
            return toJsonAPI("");

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 订单售后-取消售后操作
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/orderRefundCancel", method = RequestMethod.POST)
    public String orderRefundCancel(@RequestHeader("token") String token) throws Exception {
        logger.info("【订单】接口调用创建计划,OrderController-orderRefundCancel");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //修改售后订单状态，state=-1表示取消售后订单
            formMap.set("state", -1);
            orderService.updateOrderRefundState(formMap);
            return toJsonAPI("");

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /***
     * 订单支付  代支付订单/继续支付
     *
     * */
    @RequestMapping(value = "/orderPay")
    @ResponseBody
    public String orderPay(@RequestHeader String token, @RequestParam String order_num, @RequestParam Integer payment_type) {
        logger.info("【订单支付  代支付订单/继续支付】,OrderController-orderPay");
        FormMap formMap = getFormMap();

        if (formMap.get("user_id") == null) {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

        //订单信息
        E orderInfo = orderService.getOrderInfoByOrderNum(order_num);

        if (orderInfo.getInt("state") != Constants.ORDER_STATE_ING) {
            return toJsonAPI(ApiResponseCode.ORDER_STATE_ERROR);
        }

        //订单详情信息
        List<E> orderItemList = orderService.getOrderItemByOrderNum(order_num);

        double payPrice = orderInfo.getDouble("pay_price");

        DecimalFormat df = new DecimalFormat("#.00");

        if (payment_type == Constants.PAY_BALANCE) {
            //余额值 重新获取
            E newUserInfo = userService.userInfo(formMap);
            BigDecimal balance = new BigDecimal(newUserInfo.getDouble("balance"));


            if (balance.compareTo(new BigDecimal(payPrice)) > 0) {
                //扣除余额  ，添加余额记录  负数
                formMap.put("balance", df.format(new BigDecimal(payPrice).negate()));
                formMap.put("last_balance", df.format(balance.subtract(new BigDecimal(payPrice))));
                //
                formMap.put("type", 4);
                formMap.put("state", -1);
                formMap.put("origin_id", order_num);
                formMap.put("user_name", formMap.getStr("user_name"));
                formMap.put("logRemark", "购物消费");

                userService.addBalanceAndLog(formMap);

                //更新订单状态
                formMap.put("state", Constants.ORDER_STATE_DELIVER);

                processOrder(formMap, orderItemList);

                return toJsonAPI(ApiResponseCode.SUCCESS);

            } else {
                return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
            }
        } else if (formMap.getInt("payment_type") == Constants.PAY_WX) {
            E result = new E();
            result.put("wx_open_id", formMap.get("wx_open_id"));
            result.put("out_trade_no", formMap.getStr("order_num"));
            result.put("total_fee", getInterValue(new BigDecimal(payPrice).multiply(new BigDecimal(100))));
            result.put("body", "weiyun");
            result.put("trade_type", "JSAPI");
            result.put("spbill_create_ip", "127.0.0.1");
            result.put("notifyUrl", Constants.SERVER_HOST + "api/order/notifyCart");
            result.put("open_id_type", formMap.get("open_id_type"));
            result.put("shop_id", formMap.getStr("shop_id"));
            return toJsonAPI(platformService.wxPay(result));
        } else {
            return toJsonAPI(ApiResponseCode.PARAM_ERROR);
        }
    }

//    @RequestMapping("test")
//    @ResponseBody
//    public void test(){
//        FormMap formMap = getFormMap();
//        System.out.println(formMap.toString());
//
//
//        if (formMap.getStr("a").equals("undefined")){
//            System.out.println(true);
//        }else {
//            System.out.println(false);
//        }
//
//        System.out.println(formMap.getStr("a"));
//
//    }



}
