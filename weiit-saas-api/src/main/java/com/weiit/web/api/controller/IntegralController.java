package com.weiit.web.api.controller;

import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.api.service.IntegralService;
import com.weiit.web.api.service.RegisterService;
import com.weiit.web.api.service.UserService;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.DateUtil;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 积分商城  控制器
 *
 * @author tangjian
 * @version 1.0
 * @date：2018年5月7日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/api/integral")
public class IntegralController extends FrontController {



    @Autowired
    IntegralService integralService;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    RegisterService registerService;

    @Autowired
    UserService userService;


    /**
     *  1. 积分商品列表
     * */

    @RequestMapping("/selectIntegralProductList")
    @ResponseBody
    public String selectIntegralProductList(@RequestHeader("token") String token){

        FormMap formMap = getFormMap();

        return integralService.selectIntegralProductList(formMap);
    }



    /**
     * 2. 积分记录列表
     *
     * */
    @RequestMapping("/selectIntegralLogList")
    @ResponseBody
    public String selectIntegralLogList(@RequestHeader("token") String token){

        FormMap formMap = getFormMap();

        return integralService.selectIntegralLogList(formMap);
    }






    /**
     * 3.  积分商品详情
     *  validate_id,validate_id_token
     *
     * */

    @ResponseBody
    @RequestMapping("integralProductDetail")
    public String integralProductDetail(@RequestHeader String token){
        FormMap formMap =getFormMap();
        return integralService.integralProductDetail(formMap);
    }





    /**
     * 积分订单列表
     *
     * */
    @ResponseBody
    @RequestMapping("integralOrderList")
    public String integralOrderList(@RequestHeader String token){
        FormMap formMap =getFormMap();
        return integralService.integralOrderList(formMap);
    }



    /**
     * 4.  积分商品  提交支付订单
     *
     * */
    @RequestMapping("integralOrder")
    @ResponseBody
     public String integralOrder(@RequestHeader("token") String token){
         FormMap formMap = getFormMap();

         return integralService.integralOrder(formMap);
     }

     /**
      * 继续支付
      *
      * */
    @RequestMapping("integralPay")
    @ResponseBody
     public String integralPay(@RequestHeader("token") String token){
         FormMap formMap = getFormMap();

         return integralService.integralPay(formMap);
     }


    /**
     * 5.  微信支付回调
     *
     * */
    @RequestMapping("notifyPay")
    @ResponseBody
    public void notifyPay(HttpServletRequest request, HttpServletResponse response){

         integralService.notifyPay(request,response);
    }


    /**
     * 获取验证码
     *
     * */
    @RequestMapping("/getValidateCode")
    public String getValidateCode(@RequestHeader String token){
        logger.info("\n【完善信息  获取验证码】");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("mobilePhone"))){
            return toJsonAPI(ApiResponseCode.MOBILE_PHONE_NULL);
        }
        //防止ip  盗刷

        //判断手机是否已注册商户
        formMap.set("account",formMap.getStr("mobilePhone"));
        //一天内该业务只能接受五条验证码
        Long count = redisUtil.lGetListSize(RedisKey.USERACCOUNT_COUNT+formMap.getStr("mobilePhone"));
        if (count>4){
            return toJsonAPI(ApiResponseCode.VALIDATE_CODE_MAX_ERROR);
        }


        String code = RandomStringUtils.randomNumeric(6);
        //把手机号与验证码放入缓存中
        redisUtil.set(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone"),code,60*10);
        redisUtil.lSet(RedisKey.USERACCOUNT_COUNT+formMap.getStr("mobilePhone"),code, DateUtil.getSurplusSecond());


        String [] msg ={code};
        boolean sendState= WeiitUtil.sendMobileMessage(formMap.getStr("mobilePhone"), "216539", msg);

        return toJsonAPI(ApiResponseCode.SUCCESS);


    }






    /**
     * 完善信息 (手机号码)  + 积分  mobilePhone  valicode
     *
     * */
    @RequestMapping(value = "/updateUserPhoneInfo")
    @ResponseBody
    public String updateUserPhoneInfo(@RequestHeader String token){
        logger.info("\n【完善信息 (手机号码)  + 积分】");

        FormMap formMap = getFormMap();
        return integralService.updateUserPhoneInfo(formMap);
    }





    /**
     *分享成功之后，如果已设置赠送积分
     *
     * */
    @RequestMapping(value = "/shareSuccess")
    @ResponseBody
    public String shareSuccess(@RequestHeader String token){
        logger.info("\n【分享链接 + 积分】");

        FormMap formMap = getFormMap();
        return integralService.shareSuccess(formMap);
    }








    /**
     *后台管理   配置积分设置
     *
     * */



}
