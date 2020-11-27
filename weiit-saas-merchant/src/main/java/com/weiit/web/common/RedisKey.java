package com.weiit.web.common;

/**
 * Created by 罗鸿强 on 2018/5/7.
 */
public class RedisKey {
    public static final String USERACCOUNT ="userAccount:";

    public static final String SHOPID ="shopId:";

    public static final String WX_NOTIFY ="wxnotify:";

    //一个已支付订单只可往订单表加一条记录
    public static final String SUCCESS_ORDER ="successOrder:";

    public static final String WEIXINOPENINFO ="wxOpenInfoConfig";
    public static final String WEIXINREFRESHTOKEN ="wxRefreshToken:";

    public static final String USERVIEWLOG ="userViewLog:";

    public static final String MSGID ="msgid:";

    public static final String LIMIT ="linitShopId:";
    
    public static final String MINIFORMID ="mina:openId:";

    public static final String MERCHANT_SHOP ="mrch:shopId:";
}
