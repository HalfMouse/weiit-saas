package com.weiit.web.weixinopen.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.common.RedisKey;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutImageMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutNewsMessage;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.bean.message.WxOpenXmlMessage;
import me.chanjar.weixin.open.util.WxOpenCryptUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

/**
 * Created by 罗鸿强 on 2018/7/16.
 */
@Controller
@RequestMapping(value = "/")
public class WeixinAuthContoller {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    WeixinOpenService weixinOpenService;

    @RequestMapping("weixinopen/receive_ticket")
    public void receiveTicket(@RequestBody(required = false) String requestBody, @RequestParam("timestamp") String timestamp,
                              @RequestParam("nonce") String nonce, @RequestParam("signature") String signature,
                              @RequestParam(value = "encrypt_type", required = false) String encType,
                              @RequestParam(value = "msg_signature", required = false) String msgSignature, HttpServletResponse response) {

        this.logger.info("\n接收微信请求：[signature=[{}], encType=[{}], msgSignature=[{}]," + " timestamp=[{}], nonce=[{}], requestBody=[\n{}\n] ", signature, encType, msgSignature, timestamp, nonce, requestBody);

        WxOpenService wxOpenService =weixinOpenService.getOpenConfig();
        if (!StringUtils.equalsIgnoreCase("aes", encType) || !wxOpenService.getWxOpenComponentService().checkSignature(timestamp, nonce, signature)) {
            throw new IllegalArgumentException("非法请求，可能属于伪造的请求！");
        }

        // aes加密的消息
        WxOpenXmlMessage inMessage = WxOpenXmlMessage.fromEncryptedXml(requestBody, wxOpenService.getWxOpenConfigStorage(), timestamp, nonce, msgSignature);
        this.logger.debug(inMessage.getComponentVerifyTicket());
        this.logger.debug("\n消息解密后内容为：\n{} ", inMessage.toString());
        if (inMessage.getComponentVerifyTicket() != null) {
                logger.info("\n 更新component_verify_ticket: {}",inMessage.getComponentVerifyTicket());
                FormMap formMap = new FormMap();
                formMap.set("component_verify_ticket", inMessage.getComponentVerifyTicket());
                weixinOpenService.editWeixinOpenInfoVerifyTicket(formMap);
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
    @RequestMapping("weixinopen/{appId}/callback")
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
        this.logger.debug("消息解密后内容为：{} ", inMessage.toString());
        // 全网发布测试用例
       // if (StringUtils.equalsAnyIgnoreCase(appId, "wxd4f394586be1148a", "wxdb4dda5dc65edb4f")) {
            try {
                /**
                 * https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140453
                 * 普通消息
                 * MsgType :文本消息 text  图片消息 image  语音消息voice  视频消息video 小视频消息 shortvideo 地理位置消息location  链接消息 link
                 *
                 * 事件接收
                 * */
                if (StringUtils.equals(inMessage.getMsgType(), "text")) {

                    //1关注时回复，2收到消息回复，3关键词回复
                    formMap.set("type_id", "3");
                    formMap.set("key_name", inMessage.getContent());
                    E reply = weixinOpenService.selectReplyOne(formMap);
                    if(reply==null){
                        out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                WxMpXmlOutMessage.TEXT().content("欢迎关注！")
                                        .fromUser(inMessage.getToUser())
                                        .toUser(inMessage.getFromUser())
                                        .build(),
                                wxOpenService.getWxOpenConfigStorage());
                    }else{
                        // 1文本， 2图文，3图片
                        if(reply.getStr("reply_type").equals("1")){
                            out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                    WxMpXmlOutMessage.TEXT().content(reply.getStr("reply_content"))
                                            .fromUser(inMessage.getToUser())
                                            .toUser(inMessage.getFromUser())
                                            .build(),
                                    wxOpenService.getWxOpenConfigStorage());
                        }else if(reply.getStr("reply_type").equals("2")){
                            formMap.set("media_id", reply.getStr("reply_content"));
                            E imageText=weixinOpenService.selectReplyImageText(formMap);

                            WxMpXmlOutNewsMessage.Item item = new WxMpXmlOutNewsMessage.Item();
                            item.setDescription(imageText.getStr("main_body"));
                            item.setPicUrl(imageText.getStr("cover_img"));
                            item.setTitle(imageText.getStr("title"));
                            item.setUrl(imageText.getStr("original_link"));
                            out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                    WxMpXmlOutMessage.NEWS()
                                            .fromUser(inMessage.getToUser())
                                            .toUser(inMessage.getFromUser())
                                            .addArticle(item)
                                            .build(),
                                    wxOpenService.getWxOpenConfigStorage());
                        }else if(reply.getStr("reply_type").equals("3")){
                            out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                    WxMpXmlOutMessage.IMAGE()
                                            .fromUser(inMessage.getToUser())
                                            .toUser(inMessage.getFromUser())
                                            .mediaId(reply.getStr("reply_content"))
                                            .build(),
                                    wxOpenService.getWxOpenConfigStorage());
                        }
                    }
                    //全网发布 要用到的
//                    if (StringUtils.equals(inMessage.getContent(), "TESTCOMPONENT_MSG_TYPE_TEXT")) {
//                        out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
//                                WxMpXmlOutMessage.TEXT().content("TESTCOMPONENT_MSG_TYPE_TEXT_callback")
//                                        .fromUser(inMessage.getToUser())
//                                        .toUser(inMessage.getFromUser())
//                                        .build(),
//                                wxOpenService.getWxOpenConfigStorage()
//                        );
//                    } else if (StringUtils.startsWith(inMessage.getContent(), "QUERY_AUTH_CODE:")) {
//                        String msg = inMessage.getContent().replace("QUERY_AUTH_CODE:", "") + "_from_api";
//                        WxMpKefuMessage kefuMessage = WxMpKefuMessage.TEXT().content(msg).toUser(inMessage.getFromUser()).build();
//                        wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(appId).getKefuService().sendKefuMessage(kefuMessage);
//                    }



                } else if (StringUtils.equals(inMessage.getMsgType(), "event")) {

                    /**
                     *
                     * 1 关注/取消关注事件

                     2 扫描带参数二维码事件

                     3 上报地理位置事件

                     4 自定义菜单事件

                     5 点击菜单拉取消息时的事件推送

                     6 点击菜单跳转链接时的事件推送


                     * */

                    //关注 取消事件 事件类型，subscribe(订阅)、unsubscribe(取消订阅)

                    if (StringUtils.equals(inMessage.getEvent(),"subscribe")){
                        //1关注时回复，2收到消息回复，3关键词回复
                        formMap.set("type_id", "1");
                        E reply = weixinOpenService.selectReplyOne(formMap);
                        if(reply==null){
                            out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                    WxMpXmlOutMessage.TEXT().content("等你很久了，点击进入商城看看吧！")
                                            .fromUser(inMessage.getToUser())
                                            .toUser(inMessage.getFromUser())
                                            .build(),
                                    wxOpenService.getWxOpenConfigStorage());
                        }else{
                            // 1文本， 2图文，3图片
                            if(reply.getStr("reply_type").equals("1")){
                                out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                        WxMpXmlOutMessage.TEXT().content(reply.getStr("reply_content"))
                                                .fromUser(inMessage.getToUser())
                                                .toUser(inMessage.getFromUser())
                                                .build(),
                                        wxOpenService.getWxOpenConfigStorage());
                            }else if(reply.getStr("reply_type").equals("2")){
                                formMap.set("media_id", reply.getStr("reply_content"));
                                E imageText=weixinOpenService.selectReplyImageText(formMap);

                                WxMpXmlOutNewsMessage.Item item = new WxMpXmlOutNewsMessage.Item();
                                item.setDescription(imageText.getStr("main_body"));
                                item.setPicUrl(imageText.getStr("cover_img"));
                                item.setTitle(imageText.getStr("title"));
                                item.setUrl(imageText.getStr("original_link"));
                                out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                        WxMpXmlOutMessage.NEWS()
                                                .fromUser(inMessage.getToUser())
                                                .toUser(inMessage.getFromUser())
                                                .addArticle(item)
                                                .build(),
                                        wxOpenService.getWxOpenConfigStorage());
                            }else if(reply.getStr("reply_type").equals("3")){
                                out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                        WxMpXmlOutMessage.IMAGE()
                                                .fromUser(inMessage.getToUser())
                                                .toUser(inMessage.getFromUser())
                                                .mediaId(reply.getStr("reply_content"))
                                                .build(),
                                        wxOpenService.getWxOpenConfigStorage());
                            }
                        }
                    }else if (StringUtils.equals(inMessage.getEvent(),"weapp_audit_success")){
                        //更新审核结果  发布代码
                        wxOpenService.getWxOpenComponentService().getWxMaServiceByAppid(appId).getCodeService().release();
                        formMap.put("status",0);
                        formMap.put("reason","审核成功");
                        weixinOpenService.updateMiniAudit(formMap);
                    }else if (StringUtils.equals(inMessage.getEvent(),"weapp_audit_fail")){
                        formMap.put("status",1);
                        formMap.put("reason","审核失败");
                        weixinOpenService.updateMiniAudit(formMap);
                    }else if(StringUtils.equals(inMessage.getEvent().toUpperCase(Locale.CHINA),"CLICK")){
                        out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(
                                WxMpXmlOutMessage.TEXT().content(inMessage.getEventKey())
                                        .fromUser(inMessage.getToUser())
                                        .toUser(inMessage.getFromUser())
                                        .build(),
                                wxOpenService.getWxOpenConfigStorage());
                    }
//                    WxMpKefuMessage kefuMessage = WxMpKefuMessage.TEXT().content(inMessage.getEvent() + "from_callback").toUser(inMessage.getFromUser()).build();
//                    wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(appId).getKefuService().sendKefuMessage(kefuMessage);
                }
            } catch (Exception e) {
                logger.error("callback", e);
            }
//        } else {
//            WxMpXmlOutMessage outMessage = weixinOpenService.getWxOpenMessageRouter().route(inMessage, appId);
//            if (outMessage != null) {
//                out = WxOpenXmlMessage.wxMpOutXmlMessageToEncryptedXml(outMessage, wxOpenService.getWxOpenConfigStorage());
//            }
//        }
        logger.info(out);
        response.getWriter().write(out);
    }

}
