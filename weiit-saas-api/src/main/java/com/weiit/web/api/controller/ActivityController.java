package com.weiit.web.api.controller;


import com.github.pagehelper.PageHelper;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.api.service.ActivityService;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 活动接口
 */

@Controller
@RequestMapping(value = "/api/activity")
public class ActivityController extends FrontController {
    @Resource
    private ActivityService activityService;

    /**
     * 优惠券列表
     *
     * */
    @ResponseBody
    @RequestMapping(value = "/couponList", method = RequestMethod.POST)
    public String couponList() throws Exception {
        logger.info("【优惠券列表】,ActivityController-couponList");
        FormMap formMap = getFormMap();
        List<E> couponList = activityService.couponList(formMap);

        return toJsonAPI(couponList);

    }
    /**
     * 购物车页面  优惠券列表分可用不可用状态
     *
     * cart_ids
     * */
    @ResponseBody
    @RequestMapping(value = "/getUserCouponListForCart", method = RequestMethod.POST)
    public String getUserCouponListForCart() throws Exception {
        logger.info("【购物车页面  优惠券列表分可用不可用状态】ActivityController-getUserCouponListForCart");
        FormMap formMap = getFormMap();
        if (formMap.get("user_id")!=null){
            List<E> couponList = activityService.getUserCouponListForCart(formMap);
            Map result= new HashMap();
            result.put("coupons",couponList);
            return toJsonAPI(result);
        }else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }

    /**
     * 领取优惠券
     */

    @ResponseBody
    @RequestMapping(value = "/couponGet", method = RequestMethod.POST)
    public String couponGet(@RequestHeader("token") String token) throws Exception {
        logger.info("【活动】接口调用创建计划获取优惠券,ActivityController-couponGet");
        FormMap formMap = getFormMap();
        //判断用户是否登录
        if (formMap.get("user_id") != null) {
            //把优惠券ID传进去，查询这张优惠券的数量，
            E coupon = activityService.couponNumber(formMap);
            formMap.putAll(coupon);
            //优惠券库存数量是否大于0，大于0可领取
            if (coupon.getInt("number") > 0) {
                //优惠券是否限制领取， -1不限制。
                //未使用状态
                formMap.set("state",0);
                if (coupon.getInt("max_limit") == 0) {
                    activityService.couponGet(formMap);
                    return toJsonAPI("","领取成功","0");
                } else {//优惠券限制领取
                    E ReceiveNum = activityService.userCouponReceiveNum(formMap);
                    //优惠券领取的张数和限制的张数比较是否可以领取
                    if (ReceiveNum.getInt("count") < coupon.getInt("max_limit")) {
                        activityService.couponGet(formMap);
                        return toJsonAPI("","领取成功","0");
                    } else {
                        return toJsonAPI("", "您已领取" + coupon.getInt("max_limit") + "张优惠券，快去使用吧！！！", "4000");
                    }
                }
            } else {
                return toJsonAPI("", "没有优惠券可领取", "4000");
            }
        } else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }
    }


    /**
     * 微页面  优惠券展示   不展示是否领取  过滤失效优惠券
     *
     * @author lhq
     * @date 2018年5月10日
     */

    @RequestMapping(value = "/couponListByIds", method = RequestMethod.POST)
    @ResponseBody
    public String couponListByIds() {
        logger.info("ActivityController-couponListByIds，微页面  优惠券展示");
        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("coupon_ids"))&& formMap.getInt("couponGetType")==1) {
            //自动获取
            if (formMap.get("showNum")==null || formMap.getStr("showNum").equals("")){
                PageHelper.startPage(1,4);
            }else {
                PageHelper.startPage(1,formMap.getInt("showNum")==0?4:formMap.getInt("showNum"));
            }
        } else {
            if (formMap.getStr("coupon_ids").contains("[")) {
                formMap.put("coupon_ids", convertJson(formMap.getStr("coupon_ids"), String[].class));
            } else {
                formMap.put("coupon_ids", formMap.getStr("coupon_ids").split(","));
            }
        }
        List<E> list = activityService.couponListByIds(formMap);

        return toJsonAPI(list);
    }





}
