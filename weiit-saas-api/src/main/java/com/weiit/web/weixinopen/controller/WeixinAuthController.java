package com.weiit.web.weixinopen.controller;


import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.common.RedisKey;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutImageMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.bean.message.WxOpenXmlMessage;
import me.chanjar.weixin.open.bean.result.WxOpenAuthorizerInfoResult;
import me.chanjar.weixin.open.bean.result.WxOpenQueryAuthResult;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 *
 *
 * demo
 */
@Controller
@RequestMapping("/weixinopen")
public class WeixinAuthController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private WeixinOpenService weixinOpenService;

    @Resource
    RedisUtil redisUtil;


    /**
     * 第一步，先获取verify_ticket,必须先获取该参数值，把数据库的weiit_weixin_open_info表中的component_verify_ticket先更换先，确保component_verify_ticket是最新的。
     *
     * @param requestBody
     * @param timestamp
     * @param nonce
     * @param signature
     * @param encType
     * @param msgSignature
     * @return
     */
//    @RequestMapping("/receive_ticket")
    public void receiveTicket(@RequestBody(required = false) String requestBody, @RequestParam("timestamp") String timestamp,
                                @RequestParam("nonce") String nonce, @RequestParam("signature") String signature,
                                @RequestParam(value = "encrypt_type", required = false) String encType,
                                @RequestParam(value = "msg_signature", required = false) String msgSignature,HttpServletResponse response) {

        this.logger.info("\n接收微信请求：[signature=[{}], encType=[{}], msgSignature=[{}]," + " timestamp=[{}], nonce=[{}], requestBody=[\n{}\n] ", signature, encType, msgSignature, timestamp, nonce, requestBody);

        WxOpenService wxOpenService =weixinOpenService.getInstance(null);
        if (!StringUtils.equalsIgnoreCase("aes", encType) || !wxOpenService.getWxOpenComponentService().checkSignature(timestamp, nonce, signature)) {
            throw new IllegalArgumentException("非法请求，可能属于伪造的请求！");
        }

        // aes加密的消息
        WxOpenXmlMessage inMessage = WxOpenXmlMessage.fromEncryptedXml(requestBody, wxOpenService.getWxOpenConfigStorage(), timestamp, nonce, msgSignature);
        this.logger.debug(inMessage.getComponentVerifyTicket());
        this.logger.debug("\n消息解密后内容为：\n{} ", inMessage.toString());
        if (inMessage.getComponentVerifyTicket() != null) {
            //key  小于10分钟的时候更新
            if (redisUtil.getExpire(RedisKey.WEIXINOPENINFO)<600){
                //更新数据库中微信第三方配置信息中的verify_ticket字段，确保最新.
                logger.info("\n 更新component_verify_ticket: {}",inMessage.getComponentVerifyTicket());
                FormMap formMap = new FormMap();
                formMap.set("component_verify_ticket", inMessage.getComponentVerifyTicket());
                weixinOpenService.editWeixinOpenInfoVerifyTicket(formMap);
                //刷新实例，redis缓存会被刷新.
                weixinOpenService.freshInstance();
            }

        }

        try {
            String out = wxOpenService.getWxOpenComponentService().route(inMessage);
            this.logger.debug("\n组装回复信息：{}", out);
            response.getWriter().write(out);
        } catch (Exception e) {
            this.logger.error("receive_ticket", e);
        }
    }

    /**
     * 入口访问
     *
     * @return
     */
//    @RequestMapping("/goto_show")
    @ResponseBody
    public String gotoPreAuthUrlShow() {
        return "<a href='goto_auth'>go</a>";
    }

    /**
     * 第二步，直接去授权,请求此链接，会直接进入到一个展示二维码的页面，此页面即为公众号管理者的授权页面。
     *
     * @param request
     * @param response
     * @throws WxErrorException
     */
//    @RequestMapping("/goto_auth")
    public void goto_auth(HttpServletRequest request, HttpServletResponse response) throws WxErrorException {
        String host = request.getHeader("host");
        String url = "http://" + host + "/weixinopen/auth_ok";
        try {
            url = weixinOpenService.getInstance(null).getWxOpenComponentService().getPreAuthUrl(url);
            response.sendRedirect(url);
        } catch (Exception e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }

    /**
     * 第三步,公众号管理员点击同意授权后，会进入此方法，此发展主要目的是将刚刚授权成功的信息陈述到页面展示。
     *
     * @param authorizationCode
     * @return
     */
//    @RequestMapping("/auth_ok")
//    @ResponseBody
    public WxOpenQueryAuthResult auth_ok(@RequestParam("auth_code") String authorizationCode) {
        try {
            WxOpenQueryAuthResult queryAuthResult = weixinOpenService.getInstance(null).getWxOpenComponentService().getQueryAuth(authorizationCode);

            //入库参数 RefreshToken
            queryAuthResult.getAuthorizationInfo().getAuthorizerRefreshToken();
            queryAuthResult.getAuthorizationInfo().getAuthorizerAccessToken();


            logger.info("getQueryAuth", queryAuthResult);
            return queryAuthResult;
        } catch (WxErrorException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }

    /**
     * 第四步，一旦已经授权过的公众号，第三方都可以使用appid进行再次拉取公众号信息.
     *
     * @param appId
     * @return
     */
    @RequestMapping("/get_auth_info")
    @ResponseBody
    public WxOpenAuthorizerInfoResult get_auth_info(@RequestParam String appId) {
        try {
            FormMap formMap = new FormMap();
            formMap.put("appid",appId);

            return weixinOpenService.getInstance(null).getWxOpenComponentService().getAuthorizerInfo(appId);
        } catch (WxErrorException e) {
            logger.error("getAuthorizerInfo", e);
            throw new RuntimeException(e);
        }
    }

    /**
     * 公共事件响应方法，该url是配置在第三方平台上面的事件响应url，配置此url的目的是，一旦今后公众号授权交给了此第三方，那后面公众号上面点击公众号上面的事件操作，都会转到此url上面。
     *
     * @param requestBody
     * @param appId
     * @param signature
     * @param timestamp
     * @param nonce
     * @param openid
     * @param encType
     * @param msgSignature
     * @return
     */
    @RequestMapping("/{appId}/callback")
    public void callback(@RequestBody(required = false) String requestBody,
                           @PathVariable("appId") String appId,
                           @RequestParam("signature") String signature,
                           @RequestParam("timestamp") String timestamp,
                           @RequestParam("nonce") String nonce,
                           @RequestParam("openid") String openid,
                           @RequestParam("encrypt_type") String encType,
                           @RequestParam("msg_signature") String msgSignature,HttpServletResponse response) throws IOException {
        this.logger.info(
                "\n接收微信请求：[appId=[{}], openid=[{}], signature=[{}], encType=[{}], msgSignature=[{}],"
                        + " timestamp=[{}], nonce=[{}], requestBody=[\n{}\n] ",
                appId, openid, signature, encType, msgSignature, timestamp, nonce, requestBody);
        FormMap formMap = new FormMap();
        formMap.put("appid",appId);
        WxOpenService wxOpenService =weixinOpenService.getInstance(formMap);
        if (!StringUtils.equalsIgnoreCase("aes", encType) || !wxOpenService.getWxOpenComponentService().checkSignature(timestamp, nonce, signature)) {
            throw new IllegalArgumentException("非法请求，可能属于伪造的请求！");
        }

        String out = "";
        // aes加密的消息
        WxMpXmlMessage inMessage = WxOpenXmlMessage.fromEncryptedMpXml(requestBody, wxOpenService.getWxOpenConfigStorage(), timestamp, nonce, msgSignature);
        this.logger.debug("\n消息解密后内容为：\n{} ", inMessage.toString());
        // 全网发布测试用例
        if (StringUtils.equalsAnyIgnoreCase(appId, "wxd4f394586be1148a", "wxdb4dda5dc65edb4f")) {
            try {
                if (StringUtils.equals(inMessage.getMsgType(), "text")) {
                    //1、关于重试的消息排重，推荐使用msgid排重。
                    if (redisUtil.get(RedisKey.MSGID+inMessage.getMsgId())!=null){
                        return;
                    }
                    //关键字回复
                    if (StringUtils.equals(inMessage.getContent(), "TESTCOMPONENT_MSG_TYPE_TEXT")) {
                        out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                WxMpXmlOutMessage.TEXT().content("TESTCOMPONENT_MSG_TYPE_TEXT_callback")
                                        .fromUser(inMessage.getToUser())
                                        .toUser(inMessage.getFromUser())
                                        .build(),
                                wxOpenService.getWxOpenConfigStorage()
                        );
                    } else if (StringUtils.startsWith(inMessage.getContent(), "QUERY_AUTH_CODE:")) {
                        String msg = inMessage.getContent().replace("QUERY_AUTH_CODE:", "") + "_from_api";
                        WxMpKefuMessage kefuMessage = WxMpKefuMessage.TEXT().content(msg).toUser(inMessage.getFromUser()).build();
                        wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(appId).getKefuService().sendKefuMessage(kefuMessage);
                    }else if (StringUtils.startsWith(inMessage.getContent(), "IMAGE:")) {
                        out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                WxMpXmlOutImageMessage.IMAGE().mediaId("KaN7E8h52670GO2U7SCZEI2iuM5K_zU4whtQlCVDTao")
                                        .fromUser(inMessage.getToUser())
                                        .toUser(inMessage.getFromUser())
                                        .build(),
                                wxOpenService.getWxOpenConfigStorage()
                        );
                    }

                    redisUtil.set(RedisKey.MSGID+inMessage.getMsgId(),inMessage.getMsgId(),60*60);
                } else if (StringUtils.equals(inMessage.getMsgType(), "event")) {
                    //关于重试的消息排重，推荐使用FromUserName + CreateTime 排重。
                    if (redisUtil.get(RedisKey.MSGID+inMessage.getFromUser()+inMessage.getCreateTime())!=null){
                        response.getWriter().write( "success");
                        return;
                    }

                    /**
                     *
                     * 1 关注/取消关注事件

                     2 扫描带参数二维码事件

                     3 上报地理位置事件

                     4 自定义菜单事件

                     5 点击菜单拉取消息时的事件推送

                     6 点击菜单跳转链接时的事件推送
                     * */
                    WxMpKefuMessage kefuMessage = WxMpKefuMessage.TEXT().content(inMessage.getEvent() + "from_callback").toUser(inMessage.getFromUser()).build();
                    wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(appId).getKefuService().sendKefuMessage(kefuMessage);

                    redisUtil.set(RedisKey.MSGID+inMessage.getFromUser()+inMessage.getCreateTime(),inMessage.getFromUser(),60*60);

                }
            } catch (WxErrorException e) {
                logger.error("callback", e);
            }
        } else {
            WxMpXmlOutMessage outMessage = weixinOpenService.getWxOpenMessageRouter().route(inMessage, appId);
            if (outMessage != null) {
                out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(outMessage, wxOpenService.getWxOpenConfigStorage());
            }
        }
        response.getWriter().write( out);
    }
}
