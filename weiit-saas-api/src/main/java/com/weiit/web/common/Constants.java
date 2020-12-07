package com.weiit.web.common;

/**
 * Created by 罗鸿强 on 2018/5/15.
 * api 常量类
 */
public class Constants {
    // 微信支付结果回调url  前缀
//    线上
    public static final String SERVER_HOST ="https://api.ustore.wang/";
//    测试
//    public static final String SERVER_HOST ="https://api.woyoulian.com/";


    //线上
    public static final String MP_TEMPLATE_URL = "http://%s.wx.ustore.wang/";




    public static final String WEIITSPLIT = "weiitSplit";
    //测试
//    public static final String MP_TEMPLATE_URL = "http://%s.wx.woyoulian.com/";



    //拼团 order 前缀
    public static final String ORDER_GROUPON ="PT";
    //砍价
    public static final String ORDER_BARGAIN ="KJ";
    //直接购物
    public static final String ORDER_SHOP ="GW";
    //提现
    public static final String TAKE_CASH ="TX";
    //积分
    public static final String INTEGRAL ="JF";


    //支付方式，默认0表示微信支付，1表示账户余额支付,2表示支付宝,3表示网银,4表示其他

    public static final int PAY_WX=0;
    public static final int PAY_BALANCE=1;
    public static final int PAY_ALPAY=2;
    public static final int PAY_BANK=3;
    public static final int PAY_OTHER=4;


    //拼团订单状态
    public static final int GROUPON_ORDER_STATE_ING=1;
    public static final int GROUPON_ORDER_STATE_FAIL=2;
    public static final int GROUPON_ORDER_STATE_SUCCESS=3;
    public static final int GROUPON_ORDER_STATE_CANCEL=-1;
    public static final int GROUPON_ORDER_STATE_NOPAY=4;

    //砍价订单状态
    public static final int BARGAIN_ORDER_STATE_NOPAY=0;
    public static final int BARGAIN_ORDER_STATE_PAY=1;
    public static final int BARGAIN_ORDER_STATE_FAIL=-1;


    //积分订单状态
    public static final int INTEGRAL_ORDER_STATE_NOPAY=0;
    public static final int INTEGRAL_ORDER_STATE_PAY=1;
    public static final int INTEGRAL_ORDER_STATE_FAIL=-1;

    //购物订单

    //待付款
    public static final int ORDER_STATE_ING=0;
    //待发货
    public static final int ORDER_STATE_DELIVER=1 ;
    //待收货
    public static final int ORDER_STATE_TAKING=2;
    //待评价
    public static final int ORDER_STATE_COMMENTING=3;
    //完成
    public static final int ORDER_STATE_SUCCESS=4;
    //取消
    public static final int ORDER_STATE_CANCEL=-1;
}
