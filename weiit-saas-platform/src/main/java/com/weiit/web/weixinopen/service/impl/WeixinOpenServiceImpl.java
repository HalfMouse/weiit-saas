package com.weiit.web.weixinopen.service.impl;


import javax.annotation.Resource;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaDomainAction;
import cn.binarywang.wx.miniapp.bean.code.WxMaCategory;
import cn.binarywang.wx.miniapp.bean.code.WxMaCodeSubmitAuditRequest;
import cn.binarywang.wx.miniapp.util.json.WxMaGsonBuilder;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.admin.util.JsonUtil;
import com.weiit.web.common.Constants;
import com.weiit.web.common.RedisKey;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenInMemoryConfigStorage;
import me.chanjar.weixin.open.api.impl.WxOpenMessageRouter;
import me.chanjar.weixin.open.api.impl.WxOpenServiceImpl;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceImpl;
import com.weiit.core.entity.E;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.weixinopen.mapper.WeixinOpenMapper;
import com.weiit.web.weixinopen.service.WeixinOpenService;

import java.util.ArrayList;
import java.util.List;

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
    public WxOpenService getOpenConfig() {

        //查询微信第三方平台配置信息
        E openInfo = weixinOpenMapper.selectWeixinOpenInfo(null);
        WxOpenInMemoryConfigStorage configStorage = new WxOpenInMemoryConfigStorage();

        configStorage.setComponentAppId(openInfo.getStr("component_app_id"));
        configStorage.setComponentAppSecret(openInfo.getStr("component_app_secret"));
        configStorage.setComponentToken(openInfo.getStr("component_token"));
        configStorage.setComponentAesKey(openInfo.getStr("component_aes_key"));
        configStorage.setComponentVerifyTicket(openInfo.getStr("component_verify_ticket"));
        WxOpenService wxOpenService = new WxOpenServiceImpl();
        wxOpenService.setWxOpenConfigStorage(configStorage);
        return wxOpenService;
    }


    @Override
    public WxOpenService getInstance(FormMap formMap) {

        WxOpenInMemoryConfigStorage config = new WxOpenInMemoryConfigStorage();
        E weixinOpenInfo = weixinOpenMapper.selectWeixinOpenInfo(null);
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
            E wxPublicInfo = weixinOpenMapper.selectWxPublicInfo(formMap);
            logger.info("wxPublicInfo is{}",wxPublicInfo);
            if (wxPublicInfo!=null){
                config.setAuthorizerRefreshToken(formMap.getStr("appid"), wxPublicInfo.getStr("authorizer_fresh_token"));
            }
        }

//        if (formMap != null) {
//            Object refreshToken = redisUtil.get(RedisKey.WEIXINREFRESHTOKEN + formMap.getStr("appid"));
//            config.autoRefreshToken();
//            if (refreshToken == null) {
//                E wxPublicInfo = weixinOpenMapper.selectWxPublicInfo(formMap);
//                config.setAuthorizerRefreshToken(formMap.getStr("appid"), wxPublicInfo.getStr("authorizer_fresh_token"));
//                //不用设置过期时间
//                redisUtil.set(RedisKey.WEIXINREFRESHTOKEN + formMap.getStr("appid"), wxPublicInfo.getStr("authorizer_fresh_token"));
//            } else {
//                config.setAuthorizerRefreshToken(formMap.getStr("appid"), refreshToken.toString());
//            }
//        }
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
        WxOpenMessageRouter router = new WxOpenMessageRouter(getOpenConfig());
        return router;
    }

    @Override
    public void editWeixinOpenInfoVerifyTicket(FormMap formMap) {
        weixinOpenMapper.editWeixinOpenInfoVerifyTicket(formMap);
    }



    @Override
    public void updateMiniAudit(FormMap formMap) {
        weixinOpenMapper.updateMiniAudit(formMap);
    }

    @Override
    public  E selectReplyOne(FormMap formMap) {
       return weixinOpenMapper.selectReplyOne(formMap);
    }

    @Override
    public  E selectReplyImageText(FormMap formMap){
        return weixinOpenMapper.selectReplyImageText(formMap);
     }

    @Override
    public void publishMiniNewVersion(FormMap formMap) {

        //查询版本信息
        E versionInfo = weixinOpenMapper.selectMiniVersionInfo(null);

        //查询已授权小程序列表（非个人）
        List<E> miniList = weixinOpenMapper.seleclMiniList(null);

        //发布
        if (miniList!=null &&miniList.size()>0){

            for (E miniInfo :miniList){
                 FormMap miniMap = new FormMap();
                 miniMap.putAll(miniInfo);

                 //如果当前有正在审核的低版本小程序 。先撤销审核，采用最新审核
                 E publicInfo = weixinOpenMapper.selectMiniAuthInfo(miniMap);
                 boolean undocodeaudit =false;
                 if (publicInfo!=null && versionInfo.getInt("template_id")>publicInfo.getInt("template_id")){
                     undocodeaudit= true;
                 }


                 uploadMiniCode(miniMap,versionInfo,undocodeaudit);
            }
        }


        //更新版本为已更新版本
        weixinOpenMapper.updateVersion(null);

    }


    public E uploadMiniCode(FormMap formMap, E versionInfo,boolean undocodeaudit) {
        E result = new E();
        result.put("msg","ok");
        try {
            if (StringUtils.isEmpty(formMap.getStr("authorizer_app_id"))) {
                return null;
            }
            formMap.put("appid", formMap.getStr("authorizer_app_id"));
            WxMaService wxMaService = getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("authorizer_app_id"));

            if (undocodeaudit){
                wxMaService.getCodeService().undoCodeAudit();
            }

            //获取最新模板Id  及版本号

            //extJson
            E param = new E();
            param.put("template_id", versionInfo.getLong("template_id"));
            param.put("user_version", versionInfo.getStr("version_no"));
            param.put("user_desc", formMap.getStr("signature"));


            E extConfig = new E();
            E ext = new E();
            extConfig.put("extAppid", formMap.getStr("authorizer_app_id"));
            extConfig.put("extEnable", true);
            extConfig.put("debug", false);
            ext.put("appid", formMap.getStr("authorizer_app_id"));


            ext.put("url", Constants.SERVER_HOST);
            ext.put("nick_name", formMap.getStr("nick_name"));
            ext.put("head_img", formMap.getStr("head_img"));
            ext.put("dev_name", "蜗店");
            ext.put("version_no", versionInfo.getStr("version_no"));
            //时间戳
            ext.put("commit_time", (versionInfo.getDate("create_time")).getTime());
            //描述
            ext.put("signature", formMap.getStr("signature"));


            List<E> tabBarList = new ArrayList<E>();

            List<String> switchTabUrl = new ArrayList<String>();


            //底部导航  tabBar
            List<E> navInfoList = weixinOpenMapper.selectNavInfoByShopId(formMap);
            if (navInfoList!=null &&navInfoList.size()>0){
                for(E navInfo : navInfoList){
                    E tabBar = new E();
                    tabBar.put("pagePath", getMiniPath(navInfo.getStr("nav_url")));
                    tabBar.put("text", navInfo.getStr("nav_name"));
                    tabBar.put("iconPath", navInfo.getStr("mini_path").split("\\|")[0]);
                    tabBar.put("selectedIconPath", navInfo.getStr("mini_path").split("\\|")[1]);
                    tabBarList.add(tabBar);
                    switchTabUrl.add(navInfo.getStr("nav_url"));

                    if (!StringUtils.isEmpty(navInfo.getStr("nav_value"))){
                        if (navInfo.getStr("nav_url").equals("index")  ){
                            ext.put("pageId",navInfo.getInt("nav_value"));
                        }else if (navInfo.getStr("nav_url").equals("productGroup")){
                            ext.put("productGroupId",navInfo.getInt("nav_value"));
                        }else if (navInfo.getStr("nav_url").equals("detail")){
                            ext.put("detailId",navInfo.getInt("nav_value"));
                        }
                    }
                }
            }

            E tabbar = new E();
            tabbar.put("list", tabBarList);

            ext.put("switchTabUrl",switchTabUrl);
            extConfig.put("ext", ext);
            extConfig.put("tabBar", tabbar);
            String config = WxMaGsonBuilder.create().toJson(extConfig);
            param.put("ext_json", config);
            String json = WxMaGsonBuilder.create().toJson(param);
            formMap.put("appid",formMap.getStr("authorizer_app_id"));

            try {
                wxMaService.post("https://api.weixin.qq.com/wxa/commit", json);
            } catch (WxErrorException e) {
                e.printStackTrace();
            }


                //提交审核
                // 1 获取小程序可配置的商家类目
                List<WxMaCategory> list = wxMaService.getCodeService().getCategory();

                //需要添加地址
                List<WxMaCategory> itemList = new ArrayList<WxMaCategory>();
                for (WxMaCategory wxMaCategory : list) {
                    WxMaCategory category = WxMaCategory.builder()
                            .address("pages/index/index")
                            .title(formMap.getStr("nick_name"))
                            .firstClass(wxMaCategory.getFirstClass())
                            .firstId(wxMaCategory.getFirstId())
                            .secondClass(wxMaCategory.getSecondClass())
                            .secondId(wxMaCategory.getSecondId())
                            .build();
                    itemList.add(category);
                    // 提交审核项的一个列表（至少填写1项，至多填写5项）填一个就行
                    break;
                }
                WxMaCodeSubmitAuditRequest wxMaCodeSubmitAuditRequest = WxMaCodeSubmitAuditRequest.builder().itemList(itemList).build();

                //审核Id  入库
                long auditid = wxMaService.getCodeService().submitAudit(wxMaCodeSubmitAuditRequest);



                //更新之前的版本为老版本。
                weixinOpenMapper.updateMiniAuth(formMap);

                FormMap authMap = new FormMap();
                authMap.put("audit_id", auditid);
                authMap.put("authorizer_app_id", formMap.getStr("authorizer_app_id"));
                authMap.put("origin_id", formMap.getStr("user_name"));
                authMap.put("version_no", versionInfo.getStr("version_no"));
                authMap.put("template_id", versionInfo.getLong("template_id"));
                authMap.put("shop_id", formMap.getStr("shop_id"));
                weixinOpenMapper.addMiniAuth(authMap);


        } catch (WxErrorException e) {
            e.printStackTrace();
            logger.error("msg","提交审核失败，app_id is{},\n error is {}\n code is {}",formMap.getStr("authorizer_app_id"),e.getError().getErrorMsg(),e.getError().getErrorCode());
        }

        return result;
    }


    public String getMiniPath(String url){
        return String.format("pages/%s/%s",url,url);
    }

}
