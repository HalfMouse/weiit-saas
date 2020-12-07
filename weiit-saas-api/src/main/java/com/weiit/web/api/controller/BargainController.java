package com.weiit.web.api.controller;


import com.github.binarywang.wxpay.util.SignUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.api.service.*;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.Constants;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.DateUtil;
import com.weiit.web.weixinopen.util.XMLUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.DecimalFormat;


import java.util.*;

/**
 * 砍价 活动
 *
 * @author tangjian
 * @version 1.0
 * @date：2018年5月7日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/api/bargain")
public class BargainController extends FrontController {
    @Resource
    private BargainService bargainService;

    @Resource
    UserService userService;

    @Resource
    OrderService orderService;

    @Resource
    ProductService productService;

    @Resource
    PlatformService platformService;

    @Resource
    MessageService messageService;


    @Autowired
    RedisUtil redisUtil;

    /**
     * 砍价活动 列表（更多砍价）
     *
     * @author tangjian
     * @date：2017年2月14日 上午2:01:43
     */
    @ResponseBody
    @RequestMapping("/selectBargainList")
    public String selectBargainList(@RequestHeader(value = "token") String token) throws Exception {
        logger.info("进入 bargainController-list,砍价活动列表");
        FormMap formMap = getFormMap();
        if (!StringUtils.isEmpty(token)) {
            if (formMap.get("user_id") != null) {
                //砍价列表
                PageHelper.startPage(formMap.getPage(), formMap.getRows());
                List<E> bargainList = bargainService.selectBargainList(formMap);
                return toJsonAPI(new PageInfo<E>(bargainList));
            } else {
                return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
            }
        }
        return toJsonAPI(ApiResponseCode.TOKEN_INVALID);

    }


    /**
     * 微页面(活动页) 根据bargain_ids 获取砍价商品活动列表
     */
    @ResponseBody
    @RequestMapping("/getProductByBargainIds")
    public String getProductByBargainIds(@RequestHeader String token) throws Exception {
        logger.info("进入 bargainController-getProductByBargainIds,微页面根据bargain_ids 获取砍价商品活动列表");
        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("bargain_ids"))) {
            PageHelper.startPage(1,formMap.getInt("showNum")==0?4:formMap.getInt("showNum"));
            //可定义一个异常Code类,,,或可跳转返回一个官方认可商店
//            return toJsonAPI(ApiResponseCode.GROUPIDS_EMPTY);
        } else {
            //小海 晓东  传参不一样
            if (formMap.getStr("bargain_ids").contains("[")) {
                formMap.put("bargain_ids", convertJson(formMap.getStr("bargain_ids"), String[].class));
            } else {

                formMap.put("bargain_ids", formMap.getStr("bargain_ids").split(","));
            }
        }

        List<E> BargainList = bargainService.getProductByBargainIds(formMap);
        return toJsonAPI(BargainList);
    }


    /**
     * * 我的砍价列表
     */
    @ResponseBody
    @RequestMapping("/userBargain")
    public String userBargain(@RequestHeader("token") String token) throws Exception {
        logger.info("进入 bargainController-userBargain,我的砍价");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            List<E> userBargain = bargainService.SelectUserBargain(formMap);
            return toJsonAPI(new PageInfo<E>(userBargain));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * * 去砍价，确认地址后生成砍价订单接口，同时砍一刀。返回到分享页面。必须传入bargain_id和token
     *
     *
     * shop_id=30, open_id_type=1, user_id=83, user_name=L, address_id=58, bargain_id=,
     */
    @ResponseBody
    @RequestMapping("/bargainOrder")
    public String bargainOrder(@RequestHeader("token") String token) throws Exception {
        logger.info("进入 bargainController-bargainOrder,确认地址后生成砍价订单接口，同时砍一刀");

        FormMap formMap = getFormMap();
        DecimalFormat df = new DecimalFormat("#.00");
        E result = new E();
        if (formMap.get("user_id") != null) {
            //查看是否有未完成该活动的砍价  跳往用户的砍价成功页面
            E hasBargainCount = bargainService.hasBargainCount(formMap);
            if (hasBargainCount != null && hasBargainCount.getInt("b_order_id") > 0) {
                result.put("b_order_id", hasBargainCount.getInt("b_order_id"));
                return toJsonAPI(result);
            }

            E bargainProduct = bargainService.selectOne(formMap);

            BigDecimal bargain_price = getBargainPriceTwo(bargainProduct.getBigDecimal("cut_price_min"), bargainProduct.getBigDecimal("cut_price_max"));
            BigDecimal max_price = bargainProduct.getBigDecimal("max_price");
            BigDecimal after_price = max_price.subtract(bargain_price);
            formMap.put("share_user_id", -1);
            formMap.put("state", 0);
            formMap.put("after_price", df.format(after_price));
            formMap.put("pay_price", df.format(after_price));
            formMap.put("bargain_price", df.format(bargain_price));
            formMap.put("product_id", bargainProduct.getStr("product_id"));
            formMap.put("item_id", bargainProduct.getStr("item_id"));
            //有效时间
            formMap.put("end_time", DateUtil.addDate(10, new Date(), bargainProduct.getInt("bargain_hour")).compareTo(bargainProduct.getDate("end_time")) > 0 ? bargainProduct.getDate("end_time") : DateUtil.addDate(10, new Date(), bargainProduct.getInt("bargain_hour")));

            //生成order_num
            Random random = new Random();
            String order_num = Constants.ORDER_BARGAIN + System.currentTimeMillis() + StringUtils.leftPad(formMap.getStr("user_id"), 8, random.nextInt(1000000) + "");
            formMap.put("order_num", order_num);

            formMap.put("remark", bargainRemark());


            bargainService.insertBargainOrder(formMap);

            bargainService.insertBargainLog(formMap);

            //  砍价成功通知
            formMap.put("business_type",14);
            E templateMsg = platformService.selectShopTemplateMsg(formMap);

            if (templateMsg!=null){

                //发起者的openId
                List<String> openIds = new ArrayList<String>();
                openIds.add(formMap.getStr("wx_open_id"));

                FormMap pushMap = new FormMap();
                pushMap.put("appid",formMap.getStr("authorizer_app_id"));


                //小程序模板
                if (formMap.getInt("open_id_type")==0){
                    //商品名称:北京欢乐谷<br>底价:10元<br>砍掉价格:2元<br>砍价状态:活动时间结束
                    E keywords = new E();
                    keywords.put("keyword1",bargainProduct.getStr("product_name"));
                    keywords.put("keyword2",bargainProduct.getStr("min_price"));
                    keywords.put("keyword3",formMap.getDouble("bargain_price"));
                    keywords.put("keyword4","砍价成功,快来查看吧");

                    //砍价成功页面
                    String page = String.format("pages/chopPage/chopPage?b_order_id=%s&bargain_id=%s",formMap.getInt("b_order_id"),formMap.getInt("bargain_id"));

                    messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword3.DATA");
                }else if (formMap.getInt("open_id_type")==1){
                    E keywords = new E();
                    /**
                     *   {{first.DATA}}商品名称：{{keyword1.DATA}}底价：{{keyword2.DATA}}{{remark.DATA}}
                     *好腻害！你的朋友们已经帮你砍到底价了！<br>商品名称：春雨面膜<br>底价：50元<br>感谢您的参与！如砍的够低了，我现在下单。
                     * */
                    keywords.put("first",String.format("好腻害！你的砍了%元呢！",formMap.getDouble("bargain_price")+Constants.WEIITSPLIT+"#FF0000"));
                    keywords.put("keyword1",bargainProduct.getStr("product_name"));
                    keywords.put("keyword2",bargainProduct.getStr("min_price"));
                    keywords.put("remark","感谢您的参与！如砍的够低了，我现在下单");

//                    //获取该店铺的shop_domain_prefix
//                    E shopInfo = platformService.selectShopInfoById(formMap);

                    String page =String.format(Constants.MP_TEMPLATE_URL+"freeGet?b_order_id=%s&bargain_id=%s",formMap.getStr("authorizer_app_id"),formMap.getInt("b_order_id"),formMap.getInt("bargain_id"));

                    messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
                }
            }

            result.put("b_order_id", formMap.getStr("b_order_id"));
            return toJsonAPI(result);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    private String bargainRemark() {
        String[] strings = {"神来一刀", "天海一刀", "绝世宝刀"};
        return strings[RandomUtils.nextInt(strings.length-1)];
    }

//    private BigDecimal getBargainPrice(BigDecimal mixValue, BigDecimal maxValue) {
//        int maxPrice = maxValue.intValue();
//        int minPrice = mixValue.intValue();
//        BigDecimal bargainPrice = new BigDecimal(minPrice + (int) (Math.random() * ((maxPrice - minPrice) + 1)));
//        return bargainPrice;
//    }
    private static BigDecimal getBargainPriceTwo(BigDecimal mixValue, BigDecimal maxValue) {
        return new BigDecimal( org.apache.commons.lang3.RandomUtils.nextDouble(mixValue.doubleValue(),maxValue.doubleValue())).setScale(2,BigDecimal.ROUND_HALF_DOWN);
    }



    /**
     * * 返回到分享页面。砍价成功页面)
     */
    @ResponseBody
    @RequestMapping("/bargainPage")
    public String bargainPage(@RequestHeader("token") String token) throws Exception {
        logger.info("进入【返回到分享页面。砍价成功页面】 bargainController-bargainPage,");
        //b_order_id  /share_user_id/ bargain_id
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            E e = new E();
            formMap.put("user_id", formMap.getStr("user_id"));

            //砍价活动详情
            E bargainProduct = bargainService.selectBargainInfo(formMap);

            //是否砍主
            formMap.put("is_bargain_owner", false);

            //判断用户是否已砍
            int count = bargainService.hasBargainByLogId(formMap);
            if (count > 0) {
                e.put("hasBargain", true);
                //如果砍了 判断是否发起者
                int is_bargain_owner = bargainService.hasBargainByLogId(formMap);
                if (is_bargain_owner > 0) {
                    e.put("is_bargain_owner", true);
                    //该砍价商品的邮费
                    formMap.put("count",1);
                    formMap.put("address_id",bargainProduct.get("address_id"));
                    formMap.put("product_id",bargainProduct.get("product_id"));
                    e.put("expressPrice",productService.calcExpressPriceForActivity(formMap).get("expressPrice"));

                }
            } else {
                e.put("hasBargain", false);
            }

            List<E> userBargainlog = bargainService.SelectBargainLogList(formMap);

            //已砍总额
            E alreadyBargain = bargainService.getBargainSumPrice(formMap);

            //owe  还有多少未砍
            DecimalFormat df = new DecimalFormat("0.00");
            double owe = bargainProduct.getDouble("max_price") - alreadyBargain.getDouble("bargainPrice");
            e.put("owe", df.format(owe));
            e.put("alreadyBargain", alreadyBargain.getStr("bargainPrice"));
            e.put("bargainProduct", bargainProduct);
            e.put("userBargainlog", userBargainlog);
            return toJsonAPI(e);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * * 帮忙砍价
     *
     * @param token b_order_id  share_user_id   没传 默认发起者
     */
    @ResponseBody
    @RequestMapping(value = "/helpBargain", method = RequestMethod.POST)
    public String helpBargain(@RequestHeader("token") String token) throws Exception {
        logger.info("进入 bargainController-helpBargain,【帮忙砍价】");
        E result = new E();
        result.put("isBargain", true);
        FormMap formMap = getFormMap();
        formMap.put("originLogId", formMap.getStr("log_id"));
        if (formMap.get("user_id") != null) {
            //double类型保留前两位。
            DecimalFormat df = new DecimalFormat("0.00");

            E bargaiLog = bargainService.selectUserBargainLog(formMap);
            //判断是否有砍价过
            if (bargaiLog == null) {
                //查询最后一个砍价的价格
                E bargainPrice = bargainService.selectLastBargain(formMap);

                formMap.put("bargain_id", bargainPrice.getStr("bargain_id"));
                //查询商家定的价格以及砍价商品的信息。
                E bargainInfo = bargainService.selectBargainLogOne(formMap);

                //用户这次砍的价格
                BigDecimal bargain_price = getBargainPriceTwo(bargainInfo.getBigDecimal("cut_price_min"), bargainInfo.getBigDecimal("cut_price_max"));
                //获取这个砍价活动的最后砍价值
                BigDecimal detaliPrice = bargainPrice.getBigDecimal("after_price");
                //剩余的价格减去用户坎的价格。
                BigDecimal after_price = detaliPrice.subtract(bargain_price);
                formMap.put("after_price", df.format(after_price));
                formMap.put("bargain_price", df.format(bargain_price));
                formMap.put("remark", bargainRemark());

                //判断砍价后剩余的价格是否小于商家定的最低价格
                if (after_price.compareTo(bargainInfo.getBigDecimal("min_price")) < 0) {
                    //商家定的最低价减去剩余的价格
                    BigDecimal bargaiPrice = detaliPrice.subtract(bargainInfo.getBigDecimal("min_price"));
                    formMap.put("after_price", df.format(bargainInfo.getBigDecimal("min_price")));
                    formMap.put("bargain_price", df.format(bargaiPrice));
                    //砍价成功  插入数据
                    bargainService.insertBargainLog(formMap);
                } else {//判断砍价后剩余的价格是否等于商家定的最低价格
                    bargainService.insertBargainLog(formMap);

                }
                //砍价成功通知

                //根据b_order_id  查询发起者的openId
                E receiveInfo = bargainService.selectOpenIdbyBOrderId(formMap.getStr("b_order_id"));
                FormMap templateMap = new FormMap();
                templateMap.putAll(receiveInfo);
                //模板信息
                //查看当前用户店铺有没有设置砍价成功通知
                templateMap.put("business_type",14);
                E templateMsg = platformService.selectShopTemplateMsg(templateMap);

                if (templateMsg!=null){

                    //发起者的openId
                    List<String> openIds = new ArrayList<String>();
                    openIds.add(receiveInfo.getStr("wx_open_id"));

                    FormMap pushMap = new FormMap();
                    pushMap.put("appid",receiveInfo.getStr("authorizer_app_id"));


                    //小程序模板
                    if (receiveInfo.getInt("open_id_type")==0){
                        //商品名称:北京欢乐谷<br>底价:10元<br>砍掉价格:2元<br>砍价状态:活动时间结束
                        E keywords = new E();
                        keywords.put("keyword1",bargainInfo.getStr("product_name"));
                        keywords.put("keyword2",bargainInfo.getStr("min_price"));
                        keywords.put("keyword3",formMap.getDouble("bargain_price"));
                        keywords.put("keyword4",String.format("你的朋友%s帮你砍价成功,快来查看吧",formMap.getStr("user_name")));

                        //砍价成功页面

                        String page = String.format("pages/chopPage/chopPage?b_order_id=%s&bargain_id=%s",formMap.getInt("b_order_id"),bargainInfo.getInt("bargain_id"));

                        messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword3.DATA");
                    }else if (receiveInfo.getInt("open_id_type")==1){
                        E keywords = new E();
                        /**
                         *   {{first.DATA}}商品名称：{{keyword1.DATA}}底价：{{keyword2.DATA}}{{remark.DATA}}
                         *好腻害！你的朋友们已经帮你砍到底价了！<br>商品名称：春雨面膜<br>底价：50元<br>感谢您的参与！如砍的够低了，我现在下单。
                         * */
                        keywords.put("first",String.format("好腻害！你的朋友%s已经帮你砍了%元呢！",formMap.getStr("user_name"),formMap.getDouble("bargain_price")+Constants.WEIITSPLIT+"#FF0000"));
                        keywords.put("keyword1",bargainInfo.getStr("product_name"));
                        keywords.put("keyword2",bargainInfo.getStr("min_price"));
                        keywords.put("remark","感谢您的参与！如砍的够低了，我现在下单");
                        String page =String.format(Constants.MP_TEMPLATE_URL+"freeGet?b_order_id=%s&bargain_id=%s",receiveInfo.getStr("authorizer_app_id"),formMap.getInt("b_order_id"),bargainInfo.getInt("bargain_id"));

                        messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
                    }
                }




                result.put("isBargain", false);


                //redis
            }
            return toJsonAPI(result);
        }
        return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
    }


    /**
     * 首页砍价  判断是否已砍
     *
     * @param token bargain_id
     */
    @ResponseBody
    @RequestMapping(value = "isBargain")
    public String isBargain(@RequestHeader String token) {
        logger.info("进入 bargainController-isBargain,【首页砍价  判断是否已砍】");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            E result = new E();
            result.put("isBargain", false);
            E hasBargainCount = bargainService.hasBargainCount(formMap);
            if (hasBargainCount != null && hasBargainCount.getInt("b_order_id") > 0) {
                result.put("isBargain", true);
                result.put("b_order_id", hasBargainCount.getInt("b_order_id"));
            }
            return toJsonAPI(result);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }


    /**
     * 砍价列表轮播消息  那个用户砍价支付完成的消息列表  暂取店铺15天内支付完成的
     */
    @RequestMapping(value = "bargainMessage")
    @ResponseBody
    public String bargainMessage() {
        logger.info("进入 bargainController-bargainMessage,【砍价列表轮播消息】");

        FormMap formMap = getFormMap();
        formMap.put("pay_time", DateUtil.addDate(5, new Date(), -15));
        List<E> list = bargainService.bargainMessage(formMap);
        return toJsonAPI(list);

    }


    /**
     * 砍价支付
     *
     * @param /payment_type/b_order_id/pay_price
     */
    @RequestMapping(value = "/bargainPay")
    @ResponseBody
    public String bargainPay(@RequestHeader String token) {
        logger.info("进入 bargainController-bargainPay,【砍价支付】");
        //砍价金额设定 防止出现负数
        E result = new E();
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {

            //查询当前砍价的最低支付价
            E bargainPrice = bargainService.selectLastBargain(formMap);

            //根据b_order_id 获取砍价订单信息 + s商品的信息
            E bargainOrderInfo = bargainService.getBargainOrderById(formMap);

            if (bargainOrderInfo.getInt("state") != Constants.BARGAIN_ORDER_STATE_NOPAY) {
                return toJsonAPI(ApiResponseCode.BARGAIN_HASDEAD);
            }
            DecimalFormat df = new DecimalFormat("#.00");
            //支付金额
            // 对比支付金额与最低金额      取绝对值

            BigDecimal pay_price = bargainPrice.getBigDecimal("after_price").abs();

            //运费金额
            formMap.put("count", 1);
            formMap.put("product_id", bargainOrderInfo.get("product_id"));
            E expressInfo = productService.calcExpressPriceForActivity(formMap);

            formMap.put("expressPrice",expressInfo.getStr("expressPrice"));
            formMap.put("express_template_id",expressInfo.getStr("express_template_id"));

            pay_price=pay_price.add(new BigDecimal(expressInfo.getStr("expressPrice")));
            formMap.put("pay_price", df.format(pay_price));


            if (formMap.getInt("payment_type") == Constants.PAY_BALANCE) {
                //判断用户余额  //大于 时，返回 1 //等于 时，返回 0  //小于 时，返回 -1
                //余额值 重新获取
                E newUserInfo = userService.userInfo(formMap);
                BigDecimal balance = newUserInfo.getBigDecimal("balance");
                if (balance.compareTo(bargainPrice.getBigDecimal("after_price")) > 0) {
                    //扣除余额  ，添加余额记录  负数
                    formMap.put("balance", df.format(pay_price.negate()));
                    formMap.put("last_balance", df.format(balance.subtract(pay_price)));
                    //
                    formMap.put("type", 4);
                    formMap.put("state", -1);
                    formMap.put("origin_id", bargainOrderInfo.getStr("order_num"));
                    formMap.put("user_name", formMap.getStr("user_name"));
                    formMap.put("logRemark", "砍价购物消费");
                    formMap.put("check_num", formMap.get("order_num"));
                    userService.addBalanceAndLog(formMap);
                    bargainOrderInfo.put("pay_price", df.format(pay_price));

                    completeOrder(bargainOrderInfo, formMap);

                    return toJsonAPI(ApiResponseCode.SUCCESS);

                } else {
                    return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
                }
            } else if (formMap.getInt("payment_type") == Constants.PAY_WX) {


                //返回微信支付所需参数 notify_url
                result.put("wx_open_id", formMap.get("wx_open_id"));
                result.put("out_trade_no", bargainOrderInfo.getStr("order_num"));
                result.put("total_fee", bargainPrice.getBigDecimal("after_price").multiply(new BigDecimal(100).abs()).intValue());
                result.put("body", "weiyun");
                result.put("trade_type", "JSAPI");
                result.put("spbill_create_ip", "127.0.0.1");
                result.put("notifyUrl", Constants.SERVER_HOST + "api/bargain/notifyBargain");
                result.put("open_id_type", formMap.get("open_id_type"));
                result.put("shop_id", formMap.getStr("shop_id"));

                return toJsonAPI(platformService.wxPay(result));
            }

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
        return "";
    }


    /**
     * 微信支付完成异步通知     可用统一回调接口
     * order_num
     */

    @RequestMapping(value = "/notifyBargain")
    public void notifyBargain(HttpServletRequest request, HttpServletResponse response) throws Exception {
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

                    E bargainOrderInfo = bargainService.getBargainOrderById(formMap);
//                    if (bargainOrderInfo == null) {
//                        logger.error("notifyBargain is error,out_trade_no is {}", formMap.getStr("out_trade_no"));
//                        response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[check signature FAIL]]></return_msg></xml>");
//                    }
//                    if (bargainOrderInfo.getInt("state") != Constants.BARGAIN_ORDER_STATE_NOPAY) {
//                        logger.error("notifyBargain is error,out_trade_no is {}", formMap.getStr("out_trade_no"));
//                        response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[check signature FAIL]]></return_msg></xml>");
//                    }

                    if (!SignUtils.checkSign(kvm, null, bargainService.getMchKeyBybargainOrderNo(formMap.getStr("order_num")).getStr("partner_key"))) {
                        logger.error("notifyBargain is error,out_trade_no is {}", formMap.getStr("out_trade_no"));
                        response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[check signature FAIL]]></return_msg></xml>");
                        return;
                    }

                    DecimalFormat df = new DecimalFormat("#.00");

                    formMap.put("user_id",bargainOrderInfo.getStr("user_id"));


                    //查询用户信息及授权信息
                    E userAndAuthInfo =platformService.selectUserAndAuthInfoByUserId(formMap);
                    formMap.putAll(userAndAuthInfo);

                    formMap.put("payment_type", "0");
                    //支付金额
                    formMap.put("pay_price", df.format(new BigDecimal(kvm.get("cash_fee")).divide(new BigDecimal(100))));
                    formMap.put("shop_id", bargainOrderInfo.getStr("shop_id"));
//                    formMap.put("check_num", bargainOrderInfo.getStr(kvm.get("transaction_id")));
                    formMap.put("check_num", kvm.get("transaction_id"));


                    //物流费用 和物流模板
                    formMap.put("address_id",bargainOrderInfo.getStr("address_id"));
                    formMap.put("product_id",bargainOrderInfo.getStr("product_id"));
                    formMap.put("count",1);
                    E expressInfo =productService.calcExpressPriceForActivity(formMap);
                    formMap.put("expressPrice",expressInfo.getStr("expressPrice"));
                    formMap.put("express_template_id",expressInfo.getStr("express_template_id"));
                    completeOrder(bargainOrderInfo, formMap);


                    //防止重复回调
                    redisUtil.set(RedisKey.WX_NOTIFY + kvm.get("out_trade_no"), kvm.get("out_trade_no"), 60 * 60 * 24 * 3);
                    response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("notifyBargain error");
        }

    }


    public void completeOrder(E bargainOrderInfo, FormMap formMap) {

        formMap.put("state", Constants.BARGAIN_ORDER_STATE_PAY);
        formMap.put("pay_time", new Date());
        formMap.put("pay_price", formMap.getStr("pay_price"));
        formMap.put("b_order_id", bargainOrderInfo.getStr("b_order_id"));
        //更新砍价订单信息
        bargainService.updateBargainOrderById(formMap);

        //  添加weiit_order weiit_order_item

        FormMap orderInfo = new FormMap();
        orderInfo.put("order_num", bargainOrderInfo.getStr("order_num"));
        orderInfo.put("check_num", formMap.get("check_num"));

        //total_price = smark_price
        orderInfo.put("total_price", bargainOrderInfo.getStr("smarket_price"));
        orderInfo.put("pay_price", formMap.getStr("pay_price"));
        orderInfo.put("user_id", bargainOrderInfo.getStr("user_id"));
        //可优化  用户信息存取redis ？
        E user = userService.userInfo(orderInfo);
        orderInfo.put("user_name", user.getStr("user_name"));
        orderInfo.put("address_id", bargainOrderInfo.getStr("address_id"));
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
        orderInfo.put("shop_id", bargainOrderInfo.getStr("shop_id"));


        orderService.insertOrder(orderInfo);

        FormMap itemInfo = new FormMap();
        itemInfo.put("product_id", bargainOrderInfo.getStr("product_id"));
        itemInfo.put("product_name", bargainOrderInfo.getStr("product_name"));
        itemInfo.put("product_img", bargainOrderInfo.getStr("product_img"));
        itemInfo.put("smarket_price", bargainOrderInfo.getStr("smarket_price"));
        itemInfo.put("sale_price", bargainOrderInfo.getStr("sale_price"));
        itemInfo.put("count", 1);

        //商品规格描述
        itemInfo.put("item_id", bargainOrderInfo.getStr("item_id"));
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

        itemInfo.put("shop_id", bargainOrderInfo.getStr("shop_id"));

        itemInfo.put("pay_price", formMap.getDouble("pay_price")-formMap.getDouble("expressPrice"));
        itemInfo.put("order_num", bargainOrderInfo.getStr("order_num"));
        itemInfo.put("order_id", orderInfo.getStr("order_id"));
        itemInfo.put("shop_id", bargainOrderInfo.getStr("shop_id"));

        orderService.insertOrderItem(itemInfo);


        formMap.put("item_id", bargainOrderInfo.getStr("item_id"));
        formMap.put("count", 1);
        formMap.put("product_id", bargainOrderInfo.getStr("product_id"));

        // 更新商品、商品item库存  product_id  item_id count
        productService.updateProductAndItemStock(formMap);

        orderService.sendBossMessage(formMap);


    }


}