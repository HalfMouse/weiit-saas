package com.weiit.web.api.controller;


import com.github.binarywang.wxpay.util.SignUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.api.service.IntegralService;
import com.weiit.web.api.service.PlatformService;
import com.weiit.web.api.service.UserService;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.Constants;
import com.weiit.web.common.RedisKey;
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
import java.util.List;
import java.util.Map;


/**
 * 用户相关接口
 *
 * @author tangjian
 * @version 1.0
 * @date：2018年5月7日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "api/user")
public class UserController extends FrontController {
    @Resource
    private UserService userService;

    @Resource
    PlatformService platformService;


    @Resource
    IntegralService integralService;

    @Resource
    RedisUtil redisUtil;

    /**
     * 个人中心
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/userInfo")
    public String userInfo(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-userInfo");

        FormMap formMap = getFormMap();

        //判断用户token真实的，重新查询用户信息出来
        if (formMap.get("user_id") != null) {
            E userInfo = userService.userInfo(formMap);
            //会员主页访问记录
            formMap.put("page_type",1);
            userService.addUserPageViewLog(formMap,false);

            return toJsonAPI(userInfo);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }



    /**
     * 入口配置
     *
     * */

    @ResponseBody
    @RequestMapping("/enterPointConfig")
    public String enterPointConfig(@RequestHeader String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-enterPointConfig");
        FormMap formMap = getFormMap();
        //判断用户token真实的，重新查询用户信息出来
        if (formMap.get("user_id") != null) {
            formMap.put("item_code","YINGXIAO");
            return toJsonAPI(integralService.selectShopParamList(formMap));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }


    /**
     * 个人信息 修改接口,可以是普通信息修改，也可以是手机号码修改
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
    public String updateUserInfo(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-updateUserInfo");

        FormMap formMap = getFormMap();
        //判断用户token真实的，重新查询用户信息出来
        if (formMap.get("user_id") != null) {
            if (!StringUtils.isEmpty(formMap.getStr("code"))) {
                Object code = redisUtil.get(RedisKey.USERACCOUNT + formMap.getStr("user_account"));
                //表示新手机号码验证码正确
                if (code != null && code.toString().equals(formMap.getStr("code"))) {
                    //判断手机号码是否已经被注册
                    E otherUser = userService.userInfo(formMap);
                    //表示没有用户使用此手机号作为会员账户，可以直接修改
                    if (otherUser == null) {
                        userService.updateUserInfo(formMap);
                        return toJsonAPI(ApiResponseCode.SUCCESS);
                    } else {//表示已经有用户使用此手机作为账户，提示修改失败
                        return toJsonAPI("", "该手机号码已被绑定,请换手机号码", "1000");
                    }
                } else {
                    return toJsonAPI("", "验证码错误或已失效", "1000");
                }
            } else {//表示其他信息变更
                userService.updateUserInfo(formMap);
                return toJsonAPI("", "修改成功", "0");
            }
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 我的优惠券接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myCoupons")
    public String myCoupons(@RequestHeader(required = false, value = "token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myCoupons");

        FormMap formMap = getFormMap();
        //判断用户是否登录
        if (formMap.get("user_id") != null) {
            List<E> coupons = userService.myCoupons(formMap);
            return toJsonAPI(new PageInfo<E>(coupons));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }


    }

    /**
     * 我的收获地址-新增保存接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myAddressSave", method = RequestMethod.POST)
    public String myAddressSave(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myAddressSave");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("consignee"))) {
            return toJsonAPI("", "请输入收件人姓名", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("phone"))) {
            return toJsonAPI("", "请输入收件人手机号码", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("province")) || StringUtils.isEmpty(formMap.getStr("city")) || StringUtils.isEmpty(formMap.getStr("district"))) {
            return toJsonAPI("", "请选择省市", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("address_detail"))) {
            return toJsonAPI("", "请输入收件人的详细地址", "1000");
        }
        if (formMap.get("user_id") != null) {
            //调用地址新增事务
            userService.myAddressSaveTrans(formMap);
            return toJsonAPI(formMap.get("id"));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }

    /**
     * 我的收货地址-列表接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myAddressList", method = RequestMethod.POST)
    public String myAddressList(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myAddressList");
        FormMap formMap = getFormMap();
        //判断用户是否登录
        if (formMap.get("user_id") != null) {
            //查询当前用户的所有的收货地址
            List<E> addressList = userService.myAddressList(formMap);

            return toJsonAPI(new PageInfo<E>(addressList));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }



    /**
     * 获取客服电话
     *
     * */
    @ResponseBody
    @RequestMapping(value = "/getShopInfo", method = RequestMethod.POST)
    public String getShopTel(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-getShopTel");
        FormMap formMap = getFormMap();
        //判断用户是否登录
        if (formMap.get("user_id") != null) {
            E shopInfo = userService.getShopInfo(formMap);

            if (StringUtils.isEmpty(shopInfo.getStr("shop_tel"))){
                return toJsonAPI(ApiResponseCode.SHOP_NOTEL);
            }
            return toJsonAPI(shopInfo);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }



    /**
     * 我的收获地址-更新接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myAddressUpdate", method = RequestMethod.POST)
    public String myAddressUpdate(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myAddressUpdate");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("consignee"))) {
            return toJsonAPI("", "请输入收件人姓名", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("phone"))) {
            return toJsonAPI("", "请输入收件人手机号码", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("province")) || StringUtils.isEmpty(formMap.getStr("city")) || StringUtils.isEmpty(formMap.getStr("district"))) {
            return toJsonAPI("", "请选择省市", "1000");
        }
        if (StringUtils.isEmpty(formMap.getStr("address_detail"))) {
            return toJsonAPI("", "请输入收件人的详细地址", "1000");
        }
        if (formMap.get("user_id") != null) {
            //调用地址修改事务
            userService.myAddressUpdateTrans(formMap);
            return toJsonAPI("");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 我的收获地址-删除接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myAddressDelete", method = RequestMethod.POST)
    public String myAddressDelete(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myAddressDelete");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            userService.myAddressDelete(formMap);
            return toJsonAPI("");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 我的收获地址-设置默认接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myAddressSetDefault", method = RequestMethod.POST)
    public String myAddressSetDefault(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myAddressSetDefault");

        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //固定设置为默认
            formMap.put("is_default", "0");
            //调用地址修改事务
            userService.myAddressUpdateTrans(formMap);
            return toJsonAPI("");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 我的收藏接口(即商品收藏接口)
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myCollectionList", method = RequestMethod.POST)
    public String myCollectionList(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myCollection");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            PageHelper.startPage(formMap.getPage(), formMap.getRows());
            List<E> collectionList = userService.myCollectionList(formMap);
            return toJsonAPI(new PageInfo<E>(collectionList));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * 我的收藏-删除接口(即商品收藏-删除接口)
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myCollectionDelete", method = RequestMethod.POST)
    public String myCollectionDelete(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myCollectionDelete");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            userService.myCollectionDelete(formMap);
            return toJsonAPI("");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 意见反馈接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/addSuggest", method = RequestMethod.POST)
    public String addSuggest(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-addSuggest");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            userService.addSuggest(formMap);
            return toJsonAPI("");
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }


    }

    /**
     * 我的积分记录接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myIntegralLog", method = RequestMethod.POST)
    public String myIntegralLog(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myIntegralLog");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            List<E> userIntegralLog = userService.myIntegralLog(formMap);
            return toJsonAPI(userIntegralLog);
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     * 我的余额记录接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/myBalanceLog", method = RequestMethod.POST)
    public String myBalanceLog(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myBalanceLog");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            List<E> userIntegralLog = userService.myBalanceLog(formMap);
            return toJsonAPI(new PageInfo<E>(userIntegralLog));
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * 余额提现接口
     *
     * @param token
     * @return
     * @throws Exception cash_type cash_account cash_money remark
     */
    @ResponseBody
    @RequestMapping(value = "/myBalanceExtract", method = RequestMethod.POST)
    public String myBalanceExtract(@RequestHeader("token") String token) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myBalanceExtract");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            //用户提现的金额
            BigDecimal getBalance = new BigDecimal(formMap.getStr("cash_money"));
            //查询出的金额
            E newUserInfo = userService.userInfo(formMap);
            if (newUserInfo.getBigDecimal("balance").compareTo(getBalance) > 0) {

                BigDecimal SurplusBalance = newUserInfo.getBigDecimal("balance").subtract(getBalance);
                formMap.set("balance", SurplusBalance);
                //更新余额
                userService.myBalanceExtract(formMap);


                String cash_num = Constants.TAKE_CASH + System.currentTimeMillis() + StringUtils.leftPad(formMap.getStr("user_id"), 8, RandomStringUtils.randomNumeric(8));

                //变动金额
                formMap.put("balance", getBalance.negate());
                //剩余金额
                formMap.put("last_balance", SurplusBalance);
                formMap.put("state", -1);
                //提现业务
                formMap.put("type", 5);
                formMap.put("user_name", formMap.getStr("user_name"));
                formMap.put("logRemark", "提现金额:" + getBalance);
                formMap.put("origin_id", cash_num);
                //余额记录
                userService.insertBalance(formMap);

                //后台提现记录
                formMap.put("cash_num", cash_num);

                userService.addCashLog(formMap);

                return toJsonAPI("");
            } else {
                return toJsonAPI("", "金额不足，请正确填写", "4000");
            }

        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }

    /**
     *  余额充值接口
     *
     * @param token
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/balanceRecharge", method = RequestMethod.POST)
    public String balanceRecharge(@RequestHeader("token") String token, @RequestParam String money) throws Exception {
        logger.info("【用户】接口调用创建计划,UserController-myBalanceRecharge");
        FormMap formMap = getFormMap();
        E result = new E();
        String orderNo = Constants.TAKE_CASH + System.currentTimeMillis() + StringUtils.leftPad(formMap.getStr("user_id"), 8, RandomStringUtils.randomNumeric(8));
        result.put("wx_open_id", formMap.get("wx_open_id"));
        result.put("out_trade_no", orderNo);
        result.put("total_fee", new BigDecimal(money).multiply(new BigDecimal(100)).intValue());
        result.put("body", "weiyun");
        result.put("trade_type", "JSAPI");
        result.put("spbill_create_ip", "127.0.0.1");
        result.put("notifyUrl", Constants.SERVER_HOST + "api/user/notifyCash");
        result.put("open_id_type", formMap.get("open_id_type"));
        result.put("shop_id", formMap.getStr("shop_id"));
        return toJsonAPI(platformService.wxPay(result));

    }


    @RequestMapping(value = "/notifyCash")
    public void notifyCash(HttpServletRequest request, HttpServletResponse response) {
        try {
            synchronized (this) {
                Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
                if (kvm.get("result_code").equals("SUCCESS")) {
                    //!=null  此订单处理ok
                    if (redisUtil.get(RedisKey.WX_NOTIFY + kvm.get("out_trade_no")) != null) {
                        response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");
                        return;
                    }
                    FormMap formMap = new FormMap();
                    formMap.put("wx_open_id", kvm.get("openid"));
                    //商户key 信息
                    E mchKeyInfo = platformService.getPayInfoByOpenId(formMap);

                    if (mchKeyInfo != null && SignUtils.checkSign(kvm, null, mchKeyInfo.getStr("partner_key"))) {
                        formMap.putAll(mchKeyInfo);
                        E user = userService.userInfo(formMap);
                        //用户充值的金额
                        BigDecimal rechargeBalance = new BigDecimal(kvm.get("total_fee")).divide(new BigDecimal(100));
                        //查询出的金额
                        BigDecimal balance = user.getBigDecimal("balance");
                        BigDecimal surplusBalance = balance.add(rechargeBalance);

                        DecimalFormat df = new DecimalFormat("#.00");

                        //扣除余额  ，添加余额记录  负数
                        formMap.put("balance", df.format(rechargeBalance));
                        formMap.put("last_balance", df.format(surplusBalance));
                        //
                        formMap.put("type", 4);
                        formMap.put("state", -1);
                        formMap.put("origin_id", kvm.get("out_trade_no"));
                        formMap.put("user_name", user.getStr("user_name"));
                        formMap.put("logRemark", "购物消费");
                        userService.addBalanceAndLog(formMap);
                        //
                        logger.info("out_trade_no: " + kvm.get("out_trade_no") + " pay SUCCESS!");


                        //防止重复回调
                        redisUtil.set(RedisKey.WX_NOTIFY + kvm.get("out_trade_no"), kvm.get("out_trade_no"), 60 * 60 * 24 * 3);

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
        }

    }


}
