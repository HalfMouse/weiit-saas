package com.weiit.web.common;

/**
 * Created by 罗鸿强 on 2018/5/7.
 */
public enum ApiResponseCode {
    SUCCESS("0","SUCCESS"),
    PARAM_ERROR("1001001","参数异常"),
    TOKEN_INVALID("1001002","请重新登录"),
    VALICODE_ERROR("1001003","验证码过期"),
    BALANCE_NOT_ENOUGH("1001004","余额不足"),
    GROUPON_PEOPLE_ENOUGH("1001005","拼团人数已满"),
    GROUPON_ING("1001005","该拼团进行中"),
    BARGAIN_NO_FINISH("1001006","当前有未完成的团"),
    GROUPON_PEOPLE_NOTEXIST("1001007","拼团异常"),
    BARGAIN_NO_HASBARGAIN("1001008","已帮好友砍价"),
    BARGAIN_HASDEAD("1001009","已完成或已过期的砍价"),
    ERROR_SIGN("1001010","错误签名"),
    BARGAIN_NO_ORDER("1001011","查无订单"),
    ORDER_STATE_ERROR("1001012","订单已完成"),
    WX_CODE_EMPTY("1001013","code 为空"),
    MOBILE_PHONE_NULL("1001014","手机号不能为空"),
    MERCH_HAS_EXIST("1001015","手机账户已注册"),
    VALIDATE_CODE_ERROR("1001016","验证码错误"),
    VALIDATE_CODE_MAX_ERROR("1001017","验证码次数上限"),
    FLOWPATH_ERROR("1001018","请按流程操作"),
    INTEGRAL_PAST("1001019","积分商品过期"),
    INTEGRAL_NOT_ENOUGH("1001020","亲，您的积分不足"),
    INTEGRAL_MAX_LIMIT("1001021","亲，已超兑换数量"),
    INTEGRAL_STATE_ERROR("1001022","稍后再试"),
    SHOP_NOTEL("1001023","店主未设置客服电话"),
    GROUPIDS_EMPTY("1001000","参数异常");


    private String code;
    private String message;





    ApiResponseCode(String code, String message) {
        this.code = code;
        this.message = message;
    }


    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }


}
