package com.weiit.web.weixinopen.service.impl;


import javax.annotation.Resource;

import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.admin.util.JsonUtil;
import com.weiit.web.common.RedisKey;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenInMemoryConfigStorage;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;
import me.chanjar.weixin.open.api.impl.WxOpenServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceImpl;
import com.weiit.core.entity.E;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.weixinopen.mapper.WeixinOpenMapper;
import com.weiit.web.weixinopen.service.WeixinOpenService;

/**
 * 微信服务接口实现类
 *
 * @version 1.0
 * @author：半个鼠标
 * @date：2018年3月14日
 * @company http://www.wei-it.com 微邦互联
 */
@Service
public class WeixinOpenServiceImpl extends WxOpenServiceImpl implements WeixinOpenService {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private WeixinOpenMapper weixinOpenMapper;

    @Resource
    RedisUtil redisUtil;

    @Override
    public WxOpenService getOpenConfig() {

        //查询微信第三方平台配置信息
        E openInfo = weixinOpenMapper.selectWeixinOpenInfo(null);

        WxOpenInMemoryConfigStorage configStorage = new WxOpenInMemoryConfigStorage();

        configStorage.setComponentAppId(openInfo.getStr("component_app_id"));
        configStorage.setComponentAppSecret(openInfo.getStr("component_app_secret"));
        configStorage.setComponentToken(openInfo.getStr("component_token"));
        configStorage.setComponentAesKey(openInfo.getStr("component_aes_key"));
        configStorage.setComponentVerifyTicket(openInfo.getStr("component_verify_ticket"));
        configStorage.setAuthorizerRefreshToken("wxb47cdc920eda00d2", "refreshtoken@@@qeRRqws2x0t_9morWvFjEAHw-IwYVAKHkm9JKY7K2M4");
        WxOpenService wxOpenService = new WxOpenServiceImpl();
        wxOpenService.setWxOpenConfigStorage(configStorage);
        return wxOpenService;
    }


    /**
     * 一定的确认平台方的component_verify_ticket  有效不为空
     */
    @Override
    public WxOpenService getInstance(FormMap formMap) {

        WxOpenInMemoryConfigStorage config = new WxOpenInMemoryConfigStorage();
        E weixinOpenInfo = weixinOpenMapper.selectWeixinOpenInfo(null);

        logger.info("\n weixinOpenInfo is {}",weixinOpenInfo);
        if (weixinOpenInfo == null) {
            this.logger.info("WeixinOpenServiceImpl-getInstance,获取第三方配置为空，请先配置微信第三方配置信息");
        } else {
            //将查询的数据库的配置信息进行设置    重新授权需把 这两个redis key  都 删掉
            config.setComponentAppId(weixinOpenInfo.getStr("component_app_id"));
            config.setComponentAppSecret(weixinOpenInfo.getStr("component_app_secret"));
            config.setComponentToken(weixinOpenInfo.getStr("component_token"));
            config.setComponentAesKey(weixinOpenInfo.getStr("component_aes_key"));
            config.setComponentVerifyTicket(weixinOpenInfo.getStr("component_verify_ticket"));
        }
        if (formMap != null) {
            E wxPublicInfo = selectWxPublicInfo(formMap);

            logger.info("\n weixinOpenInfo is {}",weixinOpenInfo);
            config.autoRefreshToken();
            config.setAuthorizerRefreshToken(formMap.getStr("appid"), wxPublicInfo.getStr("authorizer_fresh_token"));
        }
        //创建一个wxopenservice对象
        WxOpenService wxOpenService = new WxOpenServiceImpl();
        wxOpenService.setWxOpenConfigStorage(config);
        return wxOpenService;
    }





    /**
     * 配置平台端收款账户，固定收款，不需要从数据库查询,以蜗店收款为主
     */
    @Override
    public WxPayService getMyWeixinPay() {

        //初始化公众号支付配置对象
        WxPayConfig payConfig = new WxPayConfig();

        payConfig.setAppId("wx8f9a626168f98ff1");
        payConfig.setMchId("1504031991");
        payConfig.setMchKey("18565660736185656607361856566073");

        /**在微信支付开发中，申请退款、发放现金红包、发放裂变红包等接口需要用到商户证书，微信服务器会验证商户证书的合法性*/
        //payConfig.setKeyPath("");

        WxPayService payService = new WxPayServiceImpl();
        payService.setConfig(payConfig);
        return payService;
    }

    @Override
    public WxOpenMessageRouter getWxOpenMessageRouter() {
        WxOpenMessageRouter router = new WxOpenMessageRouter(getInstance(null));
        return router;
    }

    @Override
    public E selectWxPublicInfo(FormMap formMap) {
        return weixinOpenMapper.selectWxPublicInfo(formMap);
    }
    @Override
    public E selectWxPublicInfoAndShopInfo(FormMap formMap) {
        return weixinOpenMapper.selectWxPublicInfoAndShopInfo(formMap);
    }


}
