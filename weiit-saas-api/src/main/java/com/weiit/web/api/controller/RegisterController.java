package com.weiit.web.api.controller;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.utils.MD5Util;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.api.service.RegisterService;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.DateUtil;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by 罗鸿强
 * 小程序注册引流接口
 * @version 1.0
 * @date：2018年5月7日 上午2:01:43
 * @company http://www.wei-it.com
 */
@RestController
@RequestMapping(value = "/api/mini")
public class RegisterController extends FrontController{

    @Resource
    RedisUtil redisUtil;

    @Resource
    RegisterService registerService;


    @RequestMapping("/getValidateCode")
    public String getValidateCode(){
        logger.info("\n【蜗店官网注册 获取验证码】");
        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("mobilePhone"))){
            return toJsonAPI(ApiResponseCode.MOBILE_PHONE_NULL);
        }
        //防止ip  盗刷

        //判断手机是否已注册商户
        formMap.set("account",formMap.getStr("mobilePhone"));
        E merchInfo = registerService.selectMerchantByAccount(formMap);

        if (merchInfo!=null){
            return toJsonAPI(ApiResponseCode.MERCH_HAS_EXIST);
        }

        //一天内该业务只能接受五条验证码
        Long count = redisUtil.lGetListSize(RedisKey.USERACCOUNT_COUNT+formMap.getStr("mobilePhone"));
        if (count>4){
            return toJsonAPI(ApiResponseCode.VALIDATE_CODE_MAX_ERROR);
        }


        String code = RandomStringUtils.randomNumeric(6);
        //把手机号与验证码放入缓存中
        redisUtil.set(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone"),code,60*10);
        redisUtil.lSet(RedisKey.USERACCOUNT_COUNT+formMap.getStr("mobilePhone"),code,DateUtil.getSurplusSecond());


        String [] msg ={code,"10"};
        WeiitUtil.sendMobileMessage(formMap.getStr("mobilePhone"), "174854", msg);

        return toJsonAPI(ApiResponseCode.SUCCESS);
    }


    /**
     * 注册开通15天的商户
     *
     * */
    @RequestMapping("/register")
    public String register(){
        logger.info("\n【蜗店官网注册】");
        FormMap formMap = getFormMap();
        if (redisUtil.get(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone"))==null || StringUtils.isEmpty(formMap.getStr("mobilePhone"))){
            return toJsonAPI(ApiResponseCode.VALICODE_ERROR);
        }

        //验证验证码
        String code = redisUtil.get(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone")).toString();

        if (!StringUtils.equals(code,formMap.getStr("validateCode"))){
            return toJsonAPI(ApiResponseCode.VALIDATE_CODE_ERROR);
        }

        String password = RandomStringUtils.randomNumeric(6);
        formMap.set("type", formMap.getStr("type")==null?1:2);//小程序官网开通
        formMap.set("password", MD5Util.MD5Encode(password, "utf-8"));
        formMap.set("account",formMap.getStr("mobilePhone"));
        formMap.set("create_manager_id",12);
        formMap.set("update_manager_id",12);
        formMap.set("description",formMap.getStr("type")==null?"小程序官网注册":"服务号官网注册");
        formMap.set("version_expire_time", DateUtil.addDate(5,new Date(),15));
        formMap.set("version_num", "JCB001");
        registerService.insetMerch(formMap);

        String [] msg ={password};
        WeiitUtil.sendMobileMessage(formMap.getStr("mobilePhone"), "174942", msg);

        formMap.put("business_type","5");
        E notifyPhone = registerService.selectNotifyPhoneByBusinessType(formMap);
        String [] notifyMsg={"官网注册商户开通,商户账户为:"+formMap.getStr("mobilePhone")};
        WeiitUtil.sendMobileMessage(notifyPhone.getStr("notify_phone"), "147671", notifyMsg);
        //删除验证码
        redisUtil.del(RedisKey.USERACCOUNT+formMap.getStr("mobilePhone"));

        return toJsonAPI(ApiResponseCode.SUCCESS);
    }

}
