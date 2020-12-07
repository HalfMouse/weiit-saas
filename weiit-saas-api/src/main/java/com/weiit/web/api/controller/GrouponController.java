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
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 拼团 活动
 *
 * @author tangjian
 * @version 1.0
 * @date：2018年5月7日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/api/groupon")
public class GrouponController extends FrontController {
    @Resource
    GrouponService grouponService;

    @Resource
    ProductService productService;

    @Resource
    UserService userService;

    @Resource
    RedisUtil redisUtil;

    @Resource
    PlatformService platformService;

    @Resource
    OrderService orderService;

    @Resource
    MessageService messageService;


    private static final String NOTIFY_GROUPON = "api/groupon/notifyGroupon";


    /**
     * * 微页面 拼团活动列表
     */
    @RequestMapping("/grouponListByIds")
    @ResponseBody
    public String grouponListByIds(@RequestHeader(required = false, value = "token") String token) throws Exception {
        logger.info("进入 GrouponController-list,拼团活动列表");
        FormMap formMap = getFormMap();

        if (formMap.get("shop_id") == null) {
            return toJsonAPI(ApiResponseCode.PARAM_ERROR);
        }
        if (!StringUtils.isEmpty(formMap.getStr("groupon_ids"))&&!"".equals(formMap.getStr("groupon_ids")) ) {
            formMap.put("groupon_ids", StringUtils.strip(formMap.getStr("groupon_ids"), "[]").split(","));
        }

        List<E> list = grouponService.grouponListByIds(formMap);

        return toJsonAPI(list);
    }


    /**
     * 拼团商品详情页以及正在拼团  统一调商品详情接口吧
     */
    @RequestMapping("/grouponProduct")
    @ResponseBody
    public String grouponProduct(@RequestHeader String token) {
        logger.info("进入 GrouponController-grouponProduct,拼团商品详情页");

        //活动进入应传  groupon_id/product_id
        E result = new E();
        //销售价  、拼团价 的价格范围
        FormMap formMap = getFormMap();

        //未判断是否生效拼团
        E grouponInfo =grouponService.selectOne(formMap);
        //商品详情
        result.put("productDetail", productService.productDetail(formMap));
        //正在拼团
        PageHelper.startPage(1, 5);
        result.put("inProcessGroupon", grouponService.inProcessGroupon(formMap));
        //扩展信息  共有多少人拼单
        E extInfo =grouponService.inProcessGrouponExt(formMap);

        extInfo.put("groupon_number",grouponInfo.get("groupon_number"));
        extInfo.put("groupon_price",grouponInfo.get("groupon_price"));
        result.put("extInfo", extInfo);
        //已有多少人拼单成功 已拼多少件
        result.put("hasGrouponCount", grouponService.hasGrouponCount(formMap));

        return toJsonAPI(result);
    }


    /**
     * 拼团成功页面  所需的数据
     */

    @RequestMapping(value = "/grouponSuccessPage")
    @ResponseBody
    public String grouponSuccessPage(@RequestHeader String token, @RequestParam String g_order_id) {
        logger.info("进入 GrouponController-grouponSuccessPage,【拼团成功页面  所需的数据】");

        FormMap formMap = getFormMap();

        if (formMap.get("user_id")==null){
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
        E result = new E();

        //返回拼团商品基本信息  图片
        E productInfo = grouponService.getProductInfoByGOrderId(formMap);
        result.put("productInfo", productInfo);
        //返回在拼团人的头像信息
        List<E> headImgList = grouponService.getJoinGrouponInfo(formMap);

        result.put("headImgList", headImgList);

        //返回是否 团长信息
        E userGrouponInfo = grouponService.getUserGrouponInfoByGOrderId(formMap);
        if (userGrouponInfo != null && userGrouponInfo.get("parent_id") != null && userGrouponInfo.getInt("parent_id") < 0) {
            result.put("isOriginator", true);
        } else {
            result.put("isOriginator", false);
        }


        return toJsonAPI(result);
    }


    /**
     * 查看正在拼团的人
     */
    @RequestMapping("/getJoinGrouponInfo")
    @ResponseBody
    public String getJoinGrouponInfo(@RequestHeader String token) throws Exception {
        logger.info("GrouponController-getJoinGrouponInfo,【查看正在拼团的人】");
        //让前端传 g_order_id/groupon_id / ,是为groupon_order 表中id
        FormMap formMap = getFormMap();
        E result = new E();
        result.put("user_img", grouponService.getJoinGrouponInfo(formMap));
        //返回自己是否已拼团
        int count = grouponService.isJoinGrouponByOrderId(formMap);
        result.put("isJoin", false);
        if (count > 0) {
            result.put("isJoin", true);
        }


        result.put("groupon_number", grouponService.selectOne(formMap).getStr("groupon_number"));

        return toJsonAPI(result);
    }


    /**
     * 参与拼团接口
     */
    @RequestMapping("/joinGroupon")
    @ResponseBody
    public String joinGroupon(@RequestHeader("token") String token) throws Exception {
        logger.info("进入 grouponController-joinGroupon,【参与拼团接口】");
//		//参数  g_order_id/share_user_id/groupon_id/address_id/payment_type/count/item_id/product_id/
        FormMap formMap = getFormMap();
//
        if (formMap.get("user_id") != null) {
            //
            E grouponOrder = grouponService.getGrouponOrderById(formMap);

            if (grouponOrder == null) {
                return toJsonAPI(ApiResponseCode.GROUPON_PEOPLE_ENOUGH);
            }
            //!=1  表示该单不在拼团进行中   已完或已结束
            if (grouponOrder.getInt("state") != Constants.GROUPON_ORDER_STATE_ING) {
                return toJsonAPI(ApiResponseCode.GROUPON_PEOPLE_ENOUGH);
            }

            //返回自己是否已拼团
            int count = grouponService.isJoinGrouponByOrderId(formMap);
            if (count > 0) {
                return toJsonAPI(ApiResponseCode.GROUPON_ING);
            }

            return processGroupon(formMap, false);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }





    /**
     * 拼团商品规格检查接口
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/productSpecCheck", method = RequestMethod.POST)
    public String productSpecCheck() throws Exception {
        logger.info("GrouponController-productSpecCheck，【拼团商品规格检查接口】");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("product_id"))) {
            return toJsonAPI("", "必须传递product_id", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("spec_custom"))) {
            return toJsonAPI("", "必须传递spec_custom", "1000");
        }
        //根据product_id,spec_custom查询商品item信息
        E item = grouponService.productSpecCheck(formMap);
        if (item != null) {
            //返回拼团限购

            return toJsonAPI(item);
        } else {
            return toJsonAPI("", "此商品已被下架", "1000");
        }


    }


    /**
     * 发起拼团接口  先支付（支付对象 groupon_order）  ，
     *
     * @author lhq
     * @date 2018年5月16日
     */
    @RequestMapping("/startGroupon")
    @ResponseBody
    public String startGroupon(@RequestHeader("token") String token) throws Exception {
        logger.info("进入 grouponController-startGroupon,发起拼团接口");
//		//参数  groupon_id/product_id/address_id  购买数量  count 取绝对值(不限购的情况下可购买多个)   //支付完成才能成功发起拼团 、item_id
        FormMap formMap = getFormMap();
//
        if (formMap.get("user_id") != null) {
            //付钱就能发起拼团
            return processGroupon(formMap, true);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }


    /**
     * 处理拼团
     *
     * @param formMap
     * @param is_leader 是否团长
     */
    public String processGroupon(FormMap formMap, boolean is_leader) {

        E result = new E();
        E resultPay = new E();
        result.put("payment_type", formMap.getStr("payment_type"));

        //生成order_num 订单号
        String order_num = Constants.ORDER_GROUPON + System.currentTimeMillis() + StringUtils.leftPad(formMap.getStr("user_id"), 8, RandomStringUtils.randomNumeric(8));

        formMap.put("order_num", order_num);
        if (is_leader) {
            formMap.put("parent_id", -1);
        } else {
            formMap.put("parent_id", formMap.getStr("g_order_id"));
        }

        //
        E grouponInfo = grouponService.selectOne(formMap);

        //开团后的有效时间
        if (grouponInfo.getDate("end_time").compareTo(DateUtil.addDate(10, new Date(), grouponInfo.getInt("expire_time"))) > 0) {
            formMap.put("end_time", DateUtil.addDate(10, new Date(), grouponInfo.getInt("expire_time")));
        } else {
            formMap.put("end_time", grouponInfo.getDate("end_time"));
        }


        formMap.put("state", Constants.GROUPON_ORDER_STATE_NOPAY);


        //如果是多规格商品  请求参数应带 item_id  并根据它及product_id 获取该商品的拼团价  * 购买数量 = 总价
        E checkInfo = grouponService.productSpecCheck(formMap);
        BigDecimal groupon_price =  checkInfo!= null ? checkInfo.getBigDecimal("groupon_price") : grouponInfo.getBigDecimal("groupon_price");


        //计算的拼团总价
        DecimalFormat df = new DecimalFormat("#.00");
        BigDecimal sum_price = groupon_price.multiply(new BigDecimal(formMap.getInt("count")));

        //计算运费
        E expressInfo = productService.calcExpressPriceForActivity(formMap);

        formMap.put("express_money",expressInfo.getStr("expressPrice"));
        formMap.put("express_template_id",expressInfo.getStr("express_template_id"));


        //支付金额 =  拼团价+ 运费
        sum_price=sum_price.add(new BigDecimal(expressInfo.getStr("expressPrice")));

        formMap.put("pay_price", df.format(sum_price));

        //生成订单
        grouponService.insertGrouponOrder(formMap);




        //是否发起者
        if (is_leader) {
            resultPay.put("g_order_id", formMap.getStr("g_order_id"));
        } else {
            resultPay.put("g_order_id", formMap.getStr("parent_id"));
        }

        //完成订单需要  父orderId
        formMap.put("g_order_id", resultPay.getStr("g_order_id"));

        //余额支付
        if (formMap.getInt("payment_type") == Constants.PAY_BALANCE) {
            //判断用户余额  //大于 时，返回 1 //等于 时，返回 0  //小于 时，返回 -1

            //余额值 重新获取
            E newUserInfo = userService.userInfo(formMap);
            BigDecimal balance = new BigDecimal(newUserInfo.getDouble("balance"));


            if (balance.compareTo(sum_price) > 0) {
                //扣除余额  ，添加余额记录  负数
                formMap.put("balance", df.format(sum_price.negate()));
                formMap.put("last_balance", df.format(balance.subtract(sum_price)));
                //
                formMap.put("type", 4);
                formMap.put("state", -1);
                formMap.put("origin_id", order_num);
                formMap.put("logRemark", "拼团购物消费");
                userService.addBalanceAndLog(formMap);

                completeOrder(formMap, grouponInfo);
                //
                return toJsonAPI(resultPay);

            } else {
              return  toJsonAPI("","余额不足","1001004");
            }
        } else if (formMap.getInt("payment_type") == Constants.PAY_WX) {

            result.put("wx_open_id", formMap.get("wx_open_id"));
            result.put("out_trade_no", order_num);
            result.put("total_fee", new BigDecimal(formMap.getStr("pay_price")).multiply(new BigDecimal(100)).intValue());
            result.put("body", "weiyun");
            result.put("trade_type", "JSAPI");
            result.put("spbill_create_ip", "127.0.0.1");
            result.put("notifyUrl", Constants.SERVER_HOST + NOTIFY_GROUPON);
            result.put("open_id_type", formMap.get("open_id_type"));
            result.put("shop_id", formMap.getStr("shop_id"));


            resultPay.put("payInfo", platformService.wxPay(result));
            return toJsonAPI(resultPay);
        }

        return "";
    }


    /**
     * 微信异步通知接口
     */
    @RequestMapping(value = "/notifyGroupon")
    public void notifyGroupon(HttpServletRequest request, HttpServletResponse response) throws Exception {

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
                    logger.info("进入 grouponController-notifyGroupon,【微信异步通知接口】\n 请求参数 "+kvm.toString());

                    FormMap formMap = new FormMap();

                    formMap.put("order_num", kvm.get("out_trade_no").toString());
                    formMap.put("check_num", kvm.get("transaction_id"));
                    E groupOrderInfo = grouponService.getGrouponOrderById(formMap);

                    formMap.put("groupon_id", groupOrderInfo.get("groupon_id"));
                    formMap.put("shop_Id", groupOrderInfo.get("shop_id"));

                    E grouponInfo = grouponService.selectOne(formMap);
                    if (!SignUtils.checkSign(kvm, null, grouponService.getMchKeyByGrouponOrderNo(formMap.getStr("order_num")).getStr("partner_key"))) {
                        logger.error("notifyBargain is error,check signature FAIL,out_trade_no is {}", formMap.getStr("out_trade_no"));
                        response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[check signature FAIL]]></return_msg></xml>");
                        return;
                    }

                    DecimalFormat df = new DecimalFormat("#.00");


                    formMap.put("payment_type", "0");
                    //支付金额
                    formMap.put("pay_price", df.format(new BigDecimal(kvm.get("cash_fee")).divide(new BigDecimal(100))));

                    formMap.put("g_order_id", groupOrderInfo.getInt("parent_id") > 0 ? groupOrderInfo.getInt("parent_id") : groupOrderInfo.getInt("g_order_id"));

                    formMap.put("user_id",groupOrderInfo.getStr("user_id"));
                    //查询用户信息及授权信息
                    E userAndAuthInfo =platformService.selectUserAndAuthInfoByUserId(formMap);
                    formMap.putAll(userAndAuthInfo);

                    completeOrder(formMap, grouponInfo);

                    //防止重复回调
                    redisUtil.set(RedisKey.WX_NOTIFY + kvm.get("out_trade_no"), kvm.get("out_trade_no"), 60 * 60 * 24 * 3);
                    response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");
                } else {
                    response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
        }


    }


    public void completeOrder(FormMap formMap, E grouponInfo) {
        //支付完  更新拼团订单  为进行中状态
        formMap.put("state", Constants.GROUPON_ORDER_STATE_ING);
        formMap.put("pay_time", new Date());
        grouponService.updateGrouponOrderByOrderNum(formMap);

        //参团判断是否 满团 ,g_order_id
        //查看进行中状态 的人数（已拼团）
        List<E> grouponList = grouponService.getJoinGrouponInfo(formMap);
        logger.info("\n 参团人数 {}",grouponList.size());

        if (grouponList.size()==1){
            //发送  开团成功通知
            sendStartGrouponMsg(formMap);
        }else {
            //发送参团通知
            sendJoinGrouponMsg(formMap);
        }

        //刚好拼团满
        if (grouponInfo.getInt("groupon_number") - grouponList.size() <= 0) {
            //更新该拼团订单下的所有进行中的订单状态为拼团成功
            formMap.put("state", Constants.GROUPON_ORDER_STATE_SUCCESS);
            grouponService.updateAllGrouponOrderById(formMap);
            logger.info("\n 【grouponList is {}】",grouponList);
            for (E groupon : grouponList) {
                logger.info("\n 【groupon is {}】",groupon);


                //场景  存在  二人团  三人或以上都支付成功
                if (redisUtil.get(RedisKey.SUCCESS_ORDER + groupon.get("order_num")) != null) {
                    break;
                }
                FormMap orderInfo = new FormMap();
                orderInfo.put("order_num", groupon.getStr("order_num"));
                orderInfo.put("check_num", formMap.get("check_num"));

                //total_price = smark_price
                orderInfo.put("total_price", groupon.getBigDecimal("smarket_price"));
                orderInfo.put("pay_price",groupon.getBigDecimal("pay_price"));
                orderInfo.put("user_id", groupon.getStr("user_id"));
                //可优化  用户信息存取redis ？
                E user = userService.userInfo(orderInfo);
                orderInfo.put("user_name", user.getStr("user_name"));
                orderInfo.put("address_id", groupon.getStr("address_id"));
                orderInfo.put("payment_type", formMap.getStr("payment_type"));


                orderInfo.put("express_money", groupon.getStr("express_money"));
                orderInfo.put("express_template_id", groupon.getStr("express_template_id"));



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
                orderInfo.put("shop_id", groupon.getStr("shop_id"));

                orderService.insertOrder(orderInfo);

                FormMap itemInfo = new FormMap();
                itemInfo.put("product_id", groupon.getStr("product_id"));
                itemInfo.put("product_name", groupon.getStr("product_name"));
                itemInfo.put("product_img", groupon.getStr("product_img"));
                itemInfo.put("smarket_price", groupon.getStr("smarket_price"));
                itemInfo.put("sale_price", groupon.getStr("sale_price"));
                itemInfo.put("count", groupon.get("count"));

                //商品规格描述
                itemInfo.put("item_id", groupon.getStr("item_id"));
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
                itemInfo.put("pay_price", groupon.getDouble("pay_price")-orderInfo.getDouble("express_money"));
                itemInfo.put("order_num", groupon.getStr("order_num"));
                itemInfo.put("order_id", orderInfo.getStr("order_id"));
                itemInfo.put("shop_id", groupon.getStr("shop_id"));

                orderService.insertOrderItem(itemInfo);

                formMap.put("item_id", groupon.getStr("item_id"));
                formMap.put("count", groupon.getStr("count"));
                formMap.put("product_id", groupon.getStr("product_id"));

                // 更新商品、商品item库存  product_id  item_id count
                productService.updateProductAndItemStock(formMap);


                // 拼团成功通知
                sendSuccessGrouponMsg(groupon);

                //防止重复记录订单
                redisUtil.set(RedisKey.SUCCESS_ORDER + groupon.get("order_num"), groupon.get("order_num"), 60*60*24);


                //拼团暂时不发送短信
//                orderService.sendBossMessage(formMap);

            }

        }
    }



    //发送开团通知
    public void sendStartGrouponMsg(FormMap formMap){
        //  开团通知
        formMap.put("business_type",10);
        E templateMsg = platformService.selectShopTemplateMsg(formMap);

        if (templateMsg!=null){

            //发起者的openId
            List<String> openIds = new ArrayList<String>();
            openIds.add(formMap.getStr("wx_open_id"));

            FormMap pushMap = new FormMap();
            pushMap.put("appid",formMap.getStr("authorizer_app_id"));


            E msgInfo = grouponService.selectStartGrouponMsgInfo(formMap);


            /**
             *
             产品名称
             {{keyword1.DATA}}
             拼团价
             {{keyword2.DATA}}
             截至时间
             {{keyword3.DATA}}
             成团人数
             {{keyword4.DATA}}
             订单编号
             {{keyword5.DATA}}

             * */
            //小程序模板
            if (formMap.getInt("open_id_type")==0){
                E keywords = new E();
                keywords.put("keyword1",msgInfo.getStr("product_name"));
                keywords.put("keyword2",msgInfo.getStr("groupon_price"));
                keywords.put("keyword3",DateUtil.format(msgInfo.getDate("end_time"),"yyyy-MM-dd HH:mm:ss"));
                keywords.put("keyword4",msgInfo.getStr("groupon_number"));
                keywords.put("keyword5", formMap.getStr("order_num"));

                //订单详情页
                String page = String.format("pages/collageList/collageList");

                messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword2.DATA");
            }else if (formMap.getInt("open_id_type")==1){
                E keywords = new E();
                /**
                 {{first.DATA}}商品名称：{{keyword1.DATA}}商品价格：{{keyword2.DATA}}组团人数：{{keyword3.DATA}}拼团类型：{{keyword4.DATA}}组团时间：{{keyword5.DATA}}{{remark.DATA}}
                 *您好，已成功发起一个拼团。<br>商品名称：新鲜车厘子2斤<br>商品价格：30元<br>组团人数：3<br>拼团类型：团长免单<br>组团时间：48小时<br>感谢您的支持。<br>
                 * */
                keywords.put("first","您好，已成功发起一个拼团。");
                keywords.put("keyword1",msgInfo.getStr("product_name"));
                keywords.put("keyword2",msgInfo.getStr("groupon_price")+Constants.WEIITSPLIT+"#FF0000");
                keywords.put("keyword3",formMap.getStr("groupon_number"));
                keywords.put("keyword4","团长开单");
                keywords.put("keyword5","截至为 "+DateUtil.format(msgInfo.getDate("end_time"),"yyyy-MM-dd HH:mm:ss"));
                keywords.put("remark","感谢您的支持");


                String page =String.format(Constants.MP_TEMPLATE_URL+"collageList?type=fight",formMap.getStr("authorizer_app_id"));

                messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
            }
        }
    }


    //发送参团通知
    public void  sendJoinGrouponMsg(FormMap formMap){
        formMap.put("business_type",11);
        E templateMsg = platformService.selectShopTemplateMsg(formMap);

        if (templateMsg!=null){

            //发起者的openId
            List<String> openIds = new ArrayList<String>();
            openIds.add(formMap.getStr("wx_open_id"));

            FormMap pushMap = new FormMap();
            pushMap.put("appid",formMap.getStr("authorizer_app_id"));


            E msgInfo = grouponService.selectStartGrouponMsgInfo(formMap);


            /**
             *
             商品名称
             {{keyword1.DATA}}
             拼团价
             {{keyword2.DATA}}
             单号
             {{keyword3.DATA}}
             参团时间
             {{keyword4.DATA}}
             * */
            //小程序模板
            if (formMap.getInt("open_id_type")==0){
                E keywords = new E();
                keywords.put("keyword1",msgInfo.getStr("product_name"));
                keywords.put("keyword2",msgInfo.getStr("groupon_price"));
                keywords.put("keyword3",formMap.getStr("order_num"));
                keywords.put("keyword4",DateUtil.format(msgInfo.getDate("create_time"),"yyyy-MM-dd HH:mm:ss"));
                //订单详情页
                String page = String.format("pages/collageList/collageList");

                messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword2.DATA");
            }else if (formMap.getInt("open_id_type")==1){
                E keywords = new E();
                /**
                 {{first.DATA}}商品：{{keyword1.DATA}}拼团价：{{keyword2.DATA}}团长：{{keyword3.DATA}}拼团人数：{{keyword4.DATA}}截止时间：{{keyword5.DATA}}{{remark.DATA}}
                 *您好，恭喜你参团成功。<br>商品：苹果<br>拼团价：29元<br>团长：黑格尔<br>拼团人数：2人<br>截止时间：2月21日<br>谢谢惠顾。
                 * */

                //查看团长信息
                E mrsWu = grouponService.selectMrsWuByJoinOrderNum(formMap);

                keywords.put("first","您好，恭喜你参团成功。");
                keywords.put("keyword1",msgInfo.getStr("product_name"));
                keywords.put("keyword2",msgInfo.getStr("groupon_price")+Constants.WEIITSPLIT+"#FF0000");
                keywords.put("keyword3",mrsWu.getStr("user_name"));
                keywords.put("keyword4",msgInfo.getStr("groupon_number"));
                keywords.put("keyword5","截至为 "+DateUtil.format(mrsWu.getDate("end_time"),"yyyy-MM-dd HH:mm:ss"));
                keywords.put("remark","谢谢惠顾");


                String page =String.format(Constants.MP_TEMPLATE_URL+"collageList?type=fight",formMap.getStr("authorizer_app_id"));

                messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
            }
        }
    }


    //发送拼团成功通知
    public void sendSuccessGrouponMsg(E groupon){

        FormMap formMap = new FormMap();
        formMap.putAll(groupon);

        formMap.put("business_type",12);

        //查询用户所属店铺的authorizer_app_id
        E authorizerAppId = grouponService.selectAuthorizerAppIdByUserId(formMap);
        formMap.putAll(authorizerAppId);

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
             拼团价格
             {{keyword2.DATA}}
             订单号
             {{keyword3.DATA}}
             支付时间
             {{keyword4.DATA}}
             * */
            //小程序模板
            if (formMap.getInt("open_id_type")==0){
                E keywords = new E();
                keywords.put("keyword1",formMap.getStr("product_name"));
                keywords.put("keyword2",formMap.getStr("pay_price"));
                keywords.put("keyword3",formMap.getStr("order_num"));
                keywords.put("keyword4",DateUtil.format(formMap.getDate("pay_time")==null?(new Date()):formMap.getDate("pay_time"),"yyyy-MM-dd HH:mm:ss"));
                //订单- 全部  -1

                String page = "pages/Order/Order?id=-1";

                messageService.maPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page,"keyword2.DATA");
            }else if (formMap.getInt("open_id_type")==1){
                E keywords = new E();
                /**
                 {{first.DATA}}订单编号：{{keyword1.DATA}}团购商品：{{keyword2.DATA}}{{remark.DATA}}
                 *恭喜您拼团成功！我们将尽快为您发货。<br>订单编号：21568458456568<br>团购商品：手机<br>感谢你的使用
                 * */

                keywords.put("first","恭喜您拼团成功！我们将尽快为您发货。");
                keywords.put("keyword1",formMap.getStr("order_num"));
                keywords.put("keyword2",formMap.getStr("product_name"));
                keywords.put("remark","感谢你的使用");


                String page =String.format(Constants.MP_TEMPLATE_URL+"Order?type=fight",formMap.getStr("authorizer_app_id"));

                messageService.mpPush(templateMsg.getStr("wx_template_id"),keywords,openIds,pushMap,page);
            }
        }
    }






    /**
     * 我的拼团 包括发起的和参与的
     */
    @ResponseBody
    @RequestMapping("/getMyGroupon")
    public String getMyGroupon(@RequestHeader String token) {
        logger.info("进入 grouponController-getMyGroupon,我的拼团 包括发起的和参与的");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            return toJsonAPI(new PageInfo<E>(grouponService.getMyGroupon(formMap)));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 店铺下的所有拼团商品列表
     */
    @ResponseBody
    @RequestMapping("getShopAllGroupon")
    public String getShopAllGroupon() {
        logger.info("进入 grouponController-getShopAllGroupon,店铺下的所有拼团商品");
        FormMap formMap = getFormMap();
        //shop_id
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        return toJsonAPI(new PageInfo<E>(grouponService.getShopAllGroupon(formMap)));

    }





    /***
     * 拼团订单支付  待支付订单/继续支付
     *g_order_id  payment_type
     * */
    @RequestMapping(value = "/grouponOrderPay")
    @ResponseBody
    public String grouponOrderPay(@RequestHeader String token,@RequestParam String order_num, @RequestParam Integer payment_type) {

        FormMap formMap = getFormMap();

        if (formMap.get("user_id") == null) {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

        //订单信息
        E orderInfo = grouponService.getGrouponOrderById(formMap);
        formMap.put("groupon_id",orderInfo.get("groupon_id"));
        E grouponInfo = grouponService.selectOne(formMap);

//        if (orderInfo==null){
//            return toJsonAPI(ApiResponseCode.PARAM_ERROR);
//        }

        if (orderInfo.getInt("state") != Constants.GROUPON_ORDER_STATE_NOPAY) {
            return toJsonAPI(ApiResponseCode.ORDER_STATE_ERROR);
        }

        double payPrice = orderInfo.getDouble("pay_price");

        DecimalFormat df = new DecimalFormat("#.00");



        formMap.put("pay_price",orderInfo.get("pay_price"));

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
                formMap.put("origin_id", orderInfo.getStr("order_num"));
                formMap.put("user_name", formMap.getStr("user_name"));
                formMap.put("logRemark", "拼团购物消费");
                formMap.put("check_num", formMap.get("order_num"));

                userService.addBalanceAndLog(formMap);

                completeOrder(formMap, grouponInfo);

                return toJsonAPI(ApiResponseCode.SUCCESS);

            } else {
                return toJsonAPI(ApiResponseCode.BALANCE_NOT_ENOUGH);
            }
        } else if (formMap.getInt("payment_type") == Constants.PAY_WX) {
            E result = new E();
            result.put("wx_open_id", formMap.get("wx_open_id"));
            result.put("out_trade_no", orderInfo.getStr("order_num"));
            result.put("total_fee", getInterValue(new BigDecimal(payPrice).multiply(new BigDecimal(100))));
            result.put("body", "weiyun");
            result.put("trade_type", "JSAPI");
            result.put("spbill_create_ip", "127.0.0.1");
            result.put("notifyUrl", Constants.SERVER_HOST + NOTIFY_GROUPON);
            result.put("open_id_type", formMap.get("open_id_type"));
            result.put("shop_id", formMap.getStr("shop_id"));
            return toJsonAPI(platformService.wxPay(result));
        } else {
            return toJsonAPI(ApiResponseCode.PARAM_ERROR);
        }
    }


}