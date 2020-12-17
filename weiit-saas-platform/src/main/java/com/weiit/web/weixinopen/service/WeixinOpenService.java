package com.weiit.web.weixinopen.service;


import com.github.binarywang.wxpay.service.WxPayService;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;

/**
 * 微信服务接口
 *
 * @version 1.0
 * @author：半个鼠标
 * @date：2018年3月14日
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinOpenService extends BaseService {

    /**
     * 获取第三方平台配置信息
     *
     * @return
     */
    WxOpenService getOpenConfig();


    WxOpenService getInstance(FormMap formMap);

    /**
     * 获取微信支付配置
     *
     * @return
     */
    WxPayService getMyWeixinPay();

    /**
     * 第三方平台路由消息
     *
     * @param
     * @return
     */
    WxOpenMessageRouter getWxOpenMessageRouter();


    /**
     * 修改微信第三方平台的配置信息-verify_ticket字段
     *
     * @param formMap
     */
    void editWeixinOpenInfoVerifyTicket(FormMap formMap);

    /**
     * 更新小程序审核结果
     *
     * @param formMap
     */
    void updateMiniAudit(FormMap formMap);


    /**
     * 查询微信公众号自动回复配置
     *
     * @param formMap
     * @return
     */
    E selectReplyOne(FormMap formMap);

    /**
     * 查询微信公众号图文回复信息
     *
     * @param formMap
     * @return
     */
    E selectReplyImageText(FormMap formMap);

    /**
     *
     * publishMiniNewVersion\  新版本推送
     * */
    void publishMiniNewVersion(FormMap formMap);
}
