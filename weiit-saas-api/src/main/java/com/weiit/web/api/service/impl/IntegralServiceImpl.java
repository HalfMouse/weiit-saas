package com.weiit.web.api.service.impl;

import com.github.binarywang.wxpay.util.SignUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.api.mapper.IntegralMapper;
import com.weiit.web.api.service.IntegralService;
import com.weiit.web.api.service.OrderService;
import com.weiit.web.api.service.PlatformService;
import com.weiit.web.api.service.ProductService;
import com.weiit.web.api.service.UserService;
import com.weiit.web.base.ApiService;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.Constants;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.DateUtil;
import com.weiit.web.weixinopen.util.XMLUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by 罗鸿强 on 2018/9/19.
 */
@Service
public class IntegralServiceImpl extends ApiService implements IntegralService{

    @Autowired
    IntegralMapper integralMapper;


    @Autowired
    UserService userService;

    @Autowired
    ProductService productService;

    @Autowired
    PlatformService platformService;

    @Autowired
    RedisUtil redisUtil;


    @Autowired
    OrderService orderService;

    @Override
    public BaseMapper setMapper() {
        return integralMapper;
    }

    @Override
    public String selectIntegralProductList(FormMap formMap) {

        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        return toJsonAPI(new PageInfo<E>(integralMapper.selectIntegralProductList(formMap)));
    }

    @Override
    public String updateUserPhoneInfo(FormMap formMap) {

        if (redisUtil.get(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone"))==null || StringUtils.isEmpty(formMap.getStr("mobilePhone"))){
            return toJsonAPI(ApiResponseCode.VALICODE_ERROR);
        }

        //验证验证码
        String code = redisUtil.get(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone")).toString();

        if (!StringUtils.equals(code,formMap.getStr("validateCode"))){
            return toJsonAPI(ApiResponseCode.VALIDATE_CODE_ERROR);
        }

        //更新用户信息
        formMap.put("user_phone",formMap.getStr("mobilePhone"));
        userService.updateUserPhone(formMap);



        //查看店铺是否已设置积分赠送
        FormMap paramMap = new FormMap();
        paramMap.put("item_code","INTEGRALSET");
        paramMap.put("item_name","PERSONAL");
        paramMap.put("shop_id",formMap.getStr("shop_id"));

        E shopParam = selectShopParamByCode(paramMap);

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







        //删除验证码
        redisUtil.del(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone"));

        return toJsonAPI(ApiResponseCode.SUCCESS);
    }

    @Override
    public String shareSuccess(FormMap formMap) {

        //每天前三次分享有效
        Long count = redisUtil.lGetListSize(RedisKey.SHARELINK+formMap.getStr("user_id"));
        if (count>2){
            return toJsonAPI(ApiResponseCode.SUCCESS);
        }

        redisUtil.lSet(RedisKey.SHARELINK+formMap.getStr("user_id"),System.currentTimeMillis(), DateUtil.getSurplusSecond());

        //查看店铺是否已设置积分赠送
        FormMap paramMap = new FormMap();
        paramMap.put("item_code","INTEGRALSET");
        paramMap.put("item_name","SHARE");
        paramMap.put("shop_id",formMap.getStr("shop_id"));

        E shopParam = selectShopParamByCode(paramMap);

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
        return toJsonAPI(ApiResponseCode.SUCCESS);
    }

    @Override
    public String selectIntegralLogList(FormMap formMap) {

        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        return toJsonAPI(new PageInfo<E>(integralMapper.selectIntegralLogList(formMap)));
    }

    @Override
    public String integralProductDetail(FormMap formMap) {
        E result = new E();

        E integralInfo = integralMapper.selectById(formMap);
        result.put("integralInfo",integralInfo);
        formMap.put("product_id",integralInfo.getStr("product_id"));

        result.put("productDetail",productService.productDetail(formMap));



        return toJsonAPI(result);
    }

    @Override
    public String integralOrderList(FormMap formMap) {
        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        return toJsonAPI(integralMapper.selectList(formMap));
    }


    /**
     * @params token   ,  validate_id,validate_id_token  ,address_id,count
     *
     * validate_id  积分商城中的商品ID
     * validate_id_token
     * address_id 地址ID
     * count 购买数量
     * 下单
     *
     * */
    @Override
    public String integralOrder(FormMap formMap) {

        if (formMap.get("user_id") != null) {

            E integralInfo = integralMapper.selectById(formMap);

            if (integralInfo==null){
                toJsonAPI(ApiResponseCode.INTEGRAL_PAST);
            }
            E userInfo = userService.selectUserInfoByOpenId(formMap);

            //用户积分
            BigDecimal userIntegral = new BigDecimal(userInfo.getDouble("integral"));
            //所需积分
            BigDecimal integral = new BigDecimal(integralInfo.getDouble("integral"));
            //产品市场价
            BigDecimal smarketPrice = new BigDecimal(integralInfo.getDouble("smarket_price"));
            //检验用户的积分是否充足
            if (userIntegral.compareTo(integral)<0){
                return toJsonAPI(ApiResponseCode.INTEGRAL_NOT_ENOUGH);
            }

            //如果有购买限制   ，检验购买和已购买的  的数量  是否大于限制。

            int maxLimit = integralInfo.getInt("max_limit");
            if (maxLimit>0){

                if (formMap.getInt("count")>maxLimit){
                    return toJsonAPI(ApiResponseCode.INTEGRAL_MAX_LIMIT);
                }

                //查看已购买数量
                int hasBuyCount = integralMapper.selectHasBuyCount(formMap);


                if (formMap.getInt("count")+hasBuyCount>maxLimit){
                    return toJsonAPI(ApiResponseCode.INTEGRAL_MAX_LIMIT);
                }
            }

            DecimalFormat df = new DecimalFormat("#.00");

            //生成积分订单
            formMap.put("product_id",integralInfo.getInt("product_id"));
            formMap.put("item_id",integralInfo.getInt("item_id"));

            //所需积分金额
            BigDecimal pay_price =new BigDecimal(0);
            if(integralInfo.getDouble("integral_price").compareTo(new Double(0.00))>0){
                pay_price = new BigDecimal(integralInfo.getDouble("integral_price")).multiply(new BigDecimal(formMap.getStr("count")));
            }

            smarketPrice = smarketPrice.multiply(new BigDecimal(formMap.getStr("count")));

            formMap.put("smarketPrice",df.format(smarketPrice));
            //计算邮费
            E  postage = productService.calcExpressPriceForActivity(formMap);
            formMap.put("expressPrice",postage.getStr("expressPrice"));
            formMap.put("express_money",postage.getStr("expressPrice"));
            formMap.put("express_template_id",postage.getStr("express_template_id"));


            //所需积分
            integral = integral.multiply(new BigDecimal(formMap.getStr("count")));

            String order_num =  Constants.INTEGRAL + System.currentTimeMillis() + StringUtils.leftPad(formMap.getStr("user_id"), 8, RandomStringUtils.randomNumeric(8));

            formMap.put("order_num",order_num);
            formMap.put("integral",integral);
            pay_price=pay_price.add(new BigDecimal(postage.getStr("expressPrice")));
            formMap.put("pay_price",df.format(pay_price));
            formMap.put("product_id",integralInfo.getStr("product_id"));
            formMap.put("item_id",integralInfo.getStr("item_id"));
            formMap.put("state",0);

            integralMapper.insert(formMap);


            if (formMap.getInt("payment_type") == Constants.PAY_BALANCE) {
                BigDecimal balance = userInfo.getBigDecimal("balance");
                if (balance.compareTo(pay_price) > 0) {
                    //扣除余额  ，添加余额记录  负数
                    formMap.put("balance", df.format(pay_price.negate()));
                    formMap.put("last_balance", df.format(balance.subtract(pay_price)));
                    //
                    formMap.put("type", 4);
                    formMap.put("state", -1);
                    formMap.put("origin_id", order_num);
                    formMap.put("user_name", formMap.getStr("user_name"));
                    formMap.put("logRemark", "积分商城消费");
                    formMap.put("check_num", order_num);
                    userService.addBalanceAndLog(formMap);

                    completeOrder(integralInfo,formMap);

                    return toJsonAPI(ApiResponseCode.SUCCESS);

                } else {
                    return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
                }
            } else  {

                E result = new E();
                //返回微信支付所需参数 notify_url
                result.put("wx_open_id", formMap.get("wx_open_id"));
                result.put("out_trade_no", order_num);
                result.put("total_fee", pay_price.multiply(new BigDecimal(100).abs()).intValue());
                result.put("body", "weiit");
                result.put("trade_type", "JSAPI");
                result.put("spbill_create_ip", "127.0.0.1");
                result.put("notifyUrl", Constants.SERVER_HOST + "api/integral/notifyPay");
                result.put("open_id_type", formMap.get("open_id_type"));
                result.put("shop_id", formMap.getStr("shop_id"));

                return toJsonAPI(platformService.wxPay(result));
            }
            //支付成功后扣除积分？  再发起支付时页判断积分充足
        }else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }




    /**
     *
     * integralPay   继续支付
     *
     * order_num,token,payment
     * */
    public String integralPay(FormMap formMap){


        //查询订单
        E orderInfo = integralMapper.selectOrderByOrderNum(formMap);



        if (orderInfo==null || orderInfo.getInt("state")!=Constants.INTEGRAL_ORDER_STATE_NOPAY){
            return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
        }
        double payPrice = orderInfo.getDouble("pay_price");
        DecimalFormat df = new DecimalFormat("#.00");

        int paymentType = formMap.getInt("payment_type");
        if (formMap.getInt("payment_type") == Constants.PAY_BALANCE) {

            formMap.putAll(orderInfo);
            formMap.put("expressPrice",formMap.getStr("express_money"));
            //场景   一开始微信下单未支付   后余额支付
            formMap.put("payment_type",paymentType);
            formMap.put("smarketPrice",df.format(new BigDecimal(formMap.getStr("smarket_price")).multiply(new BigDecimal(formMap.getStr("count")))));

            E userInfo = userService.userInfo(formMap);

            BigDecimal balance = userInfo.getBigDecimal("balance");
            if (balance.compareTo(new BigDecimal(payPrice)) > 0) {
                //扣除余额  ，添加余额记录  负数
                formMap.put("balance", df.format(new BigDecimal(payPrice).negate()));
                formMap.put("last_balance", df.format(balance.subtract(new BigDecimal(payPrice))));
                //
                formMap.put("type", 4);
                formMap.put("state", -1);
                formMap.put("origin_id", formMap.getStr("order_num"));
                formMap.put("user_name", formMap.getStr("user_name"));
                formMap.put("logRemark", "积分商城消费");
                formMap.put("check_num", formMap.getStr("order_num"));
                userService.addBalanceAndLog(formMap);


                completeOrder(orderInfo,formMap);

                return toJsonAPI(ApiResponseCode.SUCCESS);

            } else {
                return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
            }
        } else if (formMap.getInt("payment_type") == Constants.PAY_WX) {

            E result = new E();
            //返回微信支付所需参数 notify_url
            result.put("wx_open_id", formMap.get("wx_open_id"));
            result.put("out_trade_no", formMap.getStr("order_num"));
            result.put("total_fee", new BigDecimal(payPrice).multiply(new BigDecimal(100).abs()).intValue());
            result.put("body", "weiit");
            result.put("trade_type", "JSAPI");
            result.put("spbill_create_ip", "127.0.0.1");
            result.put("notifyUrl", Constants.SERVER_HOST + "api/integral/notifyPay");
            result.put("open_id_type", formMap.get("open_id_type"));
            result.put("shop_id", formMap.getStr("shop_id"));

            return toJsonAPI(platformService.wxPay(result));
        }

        return "";
    }



    public void notifyPay(HttpServletRequest request, HttpServletResponse response)  {
        logger.info("进入 bargainController-notifyBargain,【 微信支付完成异步通知     可用统一回调接口】");
        //验证是否微信回调成功

        try {
            synchronized (this) {
                //验证完 在check  抛出异常
                Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
                if ("SUCCESS".equals(kvm.get("result_code").toString()) && "SUCCESS".equals(kvm.get("return_code").toString())) {
                    //!=null  此订单处理ok
                    if (redisUtil.get(RedisKey.WX_NOTIFY + kvm.get("out_trade_no")) != null) {
                        response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");
                        return;
                    }

                    FormMap formMap = new FormMap();
                    formMap.put("order_num", kvm.get("out_trade_no"));

                    //订单信息
                    E integralOrderInfo = integralMapper.selectOrderByOrderNum(formMap);
                    formMap.putAll(integralOrderInfo);


                    formMap.put("user_id",integralOrderInfo.getStr("user_id"));
                    //查询用户信息及授权信息
                    E userAndAuthInfo =platformService.selectUserAndAuthInfoByUserId(formMap);
                    formMap.putAll(userAndAuthInfo);


                    //查询商户的支付信息
                    E paymentInfo = integralMapper.getMchKeyByOrderNum(formMap);

                    if (!SignUtils.checkSign(kvm, null,paymentInfo.getStr("partner_key"))) {
                        logger.error("notifyBargain is error,out_trade_no is {}", formMap.getStr("out_trade_no"));
                        response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[check signature FAIL]]></return_msg></xml>");
                        return;
                    }

                    DecimalFormat df = new DecimalFormat("#.00");

                    formMap.put("payment_type", "0");
                    //支付金额
                    formMap.put("check_num", kvm.get("transaction_id"));


                    //物流费用 和物流模板
                    formMap.put("smarketPrice",df.format(new BigDecimal(integralOrderInfo.getStr("smarket_price")).multiply(new BigDecimal(integralOrderInfo.getStr("count")))));
                    formMap.put("expressPrice",formMap.getStr("express_money"));

                    completeOrder(integralOrderInfo, formMap);


                    //防止重复回调
                    redisUtil.set(RedisKey.WX_NOTIFY + kvm.get("out_trade_no"), kvm.get("out_trade_no"), 60 * 60 * 24 * 3);
                    response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
//            throw new Exception("notifyBargain error");
        }

    }



    @Override
    public E selectShopParamByCode(FormMap formMap) {
        return integralMapper.selectShopParamByCode(formMap);
    }

    @Override
    public List<E> selectShopParamList(FormMap formMap) {
        return integralMapper.selectShopParamList(formMap);
    }


    /**
     *
     * @param integralOrderInfo (product_id,product_name,product_img,sale_price)
     * @param formMap  (user_id,i_order_id,pay_price,check_num,expressPrice,express_template_id,payment_type,order_num,address_id,shop_id,item_id,smarketPrice,count)
     *
     * */
    public void completeOrder(E integralOrderInfo, FormMap formMap) {

        formMap.put("state", Constants.INTEGRAL_ORDER_STATE_PAY);
        formMap.put("pay_time", new Date());
        formMap.put("pay_price", formMap.getStr("pay_price"));
        formMap.put("i_order_id", formMap.getStr("i_order_id"));
        //更新积分订单信息
        integralMapper.updateIntegralById(formMap);

        //todo 扣除积分

        E userInfo = userService.selectUserInfoByOpenId(formMap);

        BigDecimal updateIntegral = new BigDecimal(userInfo.getStr("integral")).subtract(new BigDecimal(integralOrderInfo.getStr("integral")));
        formMap.put("updateIntegral",updateIntegral);

        userService.updateUserIntegral(formMap);

        //添加积分记录
        formMap.put("i_integral",integralOrderInfo.getStr("integral"));
        formMap.put("i_last_integral",updateIntegral);
        formMap.put("i_remark","积分兑换");
        formMap.put("i_type",3);
        formMap.put("i_state",-1);
        formMap.put("i_origin_id",formMap.getStr("order_num"));

        userService.addUserIntegralLog(formMap);







        //  添加weiit_order weiit_order_item

        FormMap orderInfo = new FormMap();
        orderInfo.put("order_num", formMap.getStr("order_num"));
        orderInfo.put("check_num", formMap.get("check_num"));

        //total_price = smark_price
        orderInfo.put("total_price", formMap.getStr("smarketPrice"));
        orderInfo.put("pay_price", formMap.getStr("pay_price"));
        orderInfo.put("user_id", formMap.getStr("user_id"));
        //可优化  用户信息存取redis ？
        E user = userService.userInfo(orderInfo);
        orderInfo.put("user_name", user.getStr("user_name"));
        orderInfo.put("address_id", formMap.getStr("address_id"));
        orderInfo.put("express_money", formMap.getStr("expressPrice"));
        orderInfo.put("express_template_id", formMap.getStr("express_template_id"));
        orderInfo.put("payment_type", formMap.getStr("payment_type"));

        //查询用户收货地址
        E address = orderService.selectUserAddressById(orderInfo);


        if (address != null) {
            orderInfo.put("consignee", address.getStr("consignee"));
            orderInfo.put("address", address.getStr("province") + " " + address.getStr("city") + " " + address.getStr("district") + " " + address.getStr("address_detail"));
            orderInfo.put("phone", address.getStr("phone"));
        }



        orderInfo.put("order_type", 0);
        orderInfo.put("state", Constants.ORDER_STATE_DELIVER);
        orderInfo.put("create_time", new Date());
        orderInfo.put("update_time", new Date());
        orderInfo.put("pay_time", new Date());
        orderInfo.put("shop_id", formMap.getStr("shop_id"));


        orderService.insertOrder(orderInfo);

        FormMap itemInfo = new FormMap();
        itemInfo.put("product_id", integralOrderInfo.getStr("product_id"));
        itemInfo.put("product_name", integralOrderInfo.getStr("product_name"));
        itemInfo.put("product_img", integralOrderInfo.getStr("product_img"));
        itemInfo.put("smarket_price", integralOrderInfo.getStr("smarket_price"));
        itemInfo.put("sale_price", integralOrderInfo.getStr("sale_price"));
        itemInfo.put("count", formMap.getStr("count"));

        //商品规格描述
        itemInfo.put("item_id", integralOrderInfo.getStr("item_id"));
        E itemDetail = productService.getProductItemById(itemInfo);
        if (itemDetail != null && StringUtils.isNotBlank(itemDetail.getStr("spec_custom"))) {
            String[] keyIds = itemDetail.getStr("spec_custom").split(";");
            itemInfo.put("keyIds", keyIds);
            List<E> specInfoList = productService.getSpecInfoByIds(itemInfo);
            String spec_content = "";
            for (E spec : specInfoList) {
                spec_content += spec.getStr("key_name") + ";";
            }
            itemInfo.put("spec_content", spec_content);
        }

        itemInfo.put("shop_id", formMap.getStr("shop_id"));

        itemInfo.put("pay_price", formMap.getDouble("pay_price")-formMap.getDouble("expressPrice"));
        itemInfo.put("order_num", formMap.getStr("order_num"));
        itemInfo.put("order_id", orderInfo.getStr("order_id"));
        itemInfo.put("shop_id", formMap.getStr("shop_id"));

        orderService.insertOrderItem(itemInfo);


        //发送模板通知

        formMap.put("item_id", integralOrderInfo.getStr("item_id"));
        formMap.put("count", formMap.getStr("count"));
        formMap.put("product_id", integralOrderInfo.getStr("product_id"));

        // 更新商品、商品item库存  product_id  item_id count
        productService.updateProductAndItemStock(formMap);


        orderService.sendBossMessage(formMap);


    }




}
