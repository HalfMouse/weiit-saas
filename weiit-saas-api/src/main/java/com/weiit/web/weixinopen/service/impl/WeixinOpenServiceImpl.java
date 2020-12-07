package com.weiit.web.weixinopen.service.impl;


import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceImpl;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.JsonUtil;
import com.weiit.web.weixinopen.mapper.WeixinOpenMapper;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenInMemoryConfigStorage;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;
import me.chanjar.weixin.open.api.impl.WxOpenServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 微信服务接口实现类
 *
 * @version 1.0
 * @author：半个鼠标
 * @date：2018年3月14日
 * @company http://www.wei-it.com 微邦互联
 */
@Service
public class WeixinOpenServiceImpl extends AbstractService implements WeixinOpenService {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private WeixinOpenMapper weixinOpenMapper;


    @Resource
    RedisUtil redisUtil;

    @Override
    public BaseMapper setMapper() {
        return weixinOpenMapper;
    }

    @Override
    public E selectWeixinOpenInfo(FormMap formMap) {
        return weixinOpenMapper.selectWeixinOpenInfo(formMap);
    }

    @Override
    public E selectWxPublicInfo(FormMap formMap) {
        return weixinOpenMapper.selectWxPublicInfo(formMap);
    }


    @Override
    public void editWeixinOpenInfoVerifyTicket(FormMap formMap) {
        weixinOpenMapper.editWeixinOpenInfoVerifyTicket(formMap);
    }

    @Override
    public WxOpenService getInstance(FormMap formMap) {



        WxOpenInMemoryConfigStorage config = new WxOpenInMemoryConfigStorage();

        //mybatis  缓存清楚  flushCache="true" useCache="false"
        E weixinOpenInfo = weixinOpenMapper.selectWeixinOpenInfo(null);
        if (weixinOpenInfo == null) {
            this.logger.info("WeixinOpenServiceImpl-getInstance,获取第三方配置为空，请先配置微信第三方配置信息");
        } else {
            logger.info("weixinOpenInfo is{}",weixinOpenInfo.toString());
            //将查询的数据库的配置信息进行设置    重新授权需把 这两个redis key  都 删掉
            config.setComponentAppId(weixinOpenInfo.getStr("component_app_id"));
            config.setComponentAppSecret(weixinOpenInfo.getStr("component_app_secret"));
            config.setComponentToken(weixinOpenInfo.getStr("component_token"));
            config.setComponentAesKey(weixinOpenInfo.getStr("component_aes_key"));
            config.setComponentVerifyTicket(weixinOpenInfo.getStr("component_verify_ticket"));
        }
        if (formMap != null) {
            E wxPublicInfo = weixinOpenMapper.selectWxPublicInfo(formMap);
            logger.info("wxPublicInfo is{}",wxPublicInfo);
            config.setAuthorizerRefreshToken(formMap.getStr("appid"), wxPublicInfo.getStr("authorizer_fresh_token"));
        }
        //创建一个wxopenservice对象
        WxOpenService wxOpenService = new WxOpenServiceImpl();
        wxOpenService.setWxOpenConfigStorage(config);
        return wxOpenService;
    }





    @Override
    public WxOpenMessageRouter getWxOpenMessageRouter() {
        WxOpenMessageRouter router = new WxOpenMessageRouter(getInstance(null));
        return router;
    }

    @Override
    public void freshInstance() {
        E weixinOpenInfo = weixinOpenMapper.selectWeixinOpenInfo(null);
        if (weixinOpenInfo == null) {
            this.logger.info("WeixinOpenServiceImpl-getInstance,获取第三方配置为空，请先配置微信第三方配置信息");
        } else {
            //创建wxopenconfigstorage对象
            WxOpenInMemoryConfigStorage config = new WxOpenInMemoryConfigStorage();

            //将查询的数据库的配置信息进行设置
            config.setComponentAppId(weixinOpenInfo.getStr("component_app_id"));
            config.setComponentAppSecret(weixinOpenInfo.getStr("component_app_secret"));
            config.setComponentToken(weixinOpenInfo.getStr("component_token"));
            config.setComponentAesKey(weixinOpenInfo.getStr("component_aes_key"));
            config.setComponentVerifyTicket(weixinOpenInfo.getStr("component_verify_ticket"));
            redisUtil.set(RedisKey.WEIXINOPENINFO, JsonUtil.writeValueAsString(config), 7200);
        }
    }

    @Override
    public WxPayService getLocalInstancePay(E param) {

        //初始化公众号支付配置对象
        WxPayConfig payConfig = new WxPayConfig();
        if(param.getInt("open_id_type")==1){
            param.put("service_type_info",2);
        }else {
            param.put("service_type_info",0);
        }
        //根据shop_id public_type  确定 支付参数
        E result = weixinOpenMapper.getPayParamByShopIdAndType(param);

        //普通商户支付方式
        payConfig.setAppId(result.getStr("app_id"));
        payConfig.setMchId(result.getStr("partner_id"));
        payConfig.setMchKey(result.getStr("partner_key"));

        //服务商支付
//        payConfig.setAppId("wx8f9a626168f98ff1");
//        payConfig.setMchId("1504032141");
//        payConfig.setMchKey("");
//        payConfig.setSubAppId(result.getStr("app_id"));
//        payConfig.setSubMchId(result.getStr("partner_id"));

        /**在微信支付开发中，申请退款、发放现金红包、发放裂变红包等接口需要用到商户证书，微信服务器会验证商户证书的合法性*/
        //payConfig.setKeyPath("");

        WxPayService payService = new WxPayServiceImpl();
        payService.setConfig(payConfig);
        return payService;
    }

}
