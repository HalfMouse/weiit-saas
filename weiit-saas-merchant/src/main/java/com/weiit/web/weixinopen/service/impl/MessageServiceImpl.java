package com.weiit.web.weixinopen.service.impl;

import cn.binarywang.wx.miniapp.bean.WxMaTemplateMessage;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.admin.util.JsonUtil;
import com.weiit.web.common.FormTemplateVO;
import com.weiit.web.common.RedisKey;
import com.weiit.web.weixinopen.service.MessageService;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpTemplateMsgService;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by 罗鸿强 on 2018/7/23.
 */
@Service
public class MessageServiceImpl implements MessageService {
    public final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    WeixinOpenService weixinOpenService;

    @Resource
    RedisUtil redisUtil;
 
    public String maPush(String templateId, E keywords, List<String> openIds, FormMap formMap, String page, String emphasisKeyword){
        logger.error("maBatchPush 开始批量发送 templateId {},\nkeywords is {} ,\nopenIds is {},\nformMap {}",templateId,keywords,openIds,formMap);

        List<WxMaTemplateMessage.Data> lists = new ArrayList<WxMaTemplateMessage.Data>();
        for (Iterator<Map.Entry<String, Object>> its = keywords.entrySet().iterator(); its.hasNext(); ) {
            Map.Entry<String, Object> entry = its.next();
            lists.add( new WxMaTemplateMessage.Data(entry.getKey(), entry.getValue().toString()));
        }

        for (String openId :openIds){
            String formId =getValidFormId(openId);
            if (StringUtils.isEmpty(formId)){
                logger.info("发送模板消息失败 formId is empty，openId is {}",openId);
                continue;
            }
            WxMaTemplateMessage wxMaTemplateMessage = WxMaTemplateMessage.builder()
                    .templateId(templateId)
                    .toUser(openId)
                    .formId(formId)
                    .page(page)
                    .data(lists)
                    .emphasisKeyword(emphasisKeyword)
                    .build();
            try {
                weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("appid")).getMsgService().sendTemplateMsg(wxMaTemplateMessage);
            } catch (WxErrorException e) {
                e.printStackTrace();
                continue;
            }
        }
        return null;
    }


    /**
     * 参数	是否必填	说明
     * touser	是	接收者openid
     * template_id	是	模板ID
     * url	否	模板跳转链接
     * miniprogram	否	跳小程序所需数据，不需跳小程序可不用传该数据
     * appid	是	所需跳转到的小程序appid（该小程序appid必须与发模板消息的公众号是绑定关联关系，暂不支持小游戏）
     * pagepath	否	所需跳转到小程序的具体页面路径，支持带参数,（示例index?foo=bar），暂不支持小游戏
     * data	是	模板数据
     * color	否	模板内容字体颜色，不填默认为黑色
     */
    public String mpPush(String templateId, E keywords, List<String> openIds, FormMap formMap, String url){
        logger.error("mpBatchPush 开始批量发送 templateId {},\n keywords is {} openIds is {},\nformMap {}",templateId,keywords,openIds,formMap);
        WxMpTemplateMsgService wxMpTemplateMsgService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMpServiceByAppid(formMap.getStr("appid")).getTemplateMsgService();
        WxMpTemplateMessage wxMpTemplateMessage = WxMpTemplateMessage.builder()
                .templateId(templateId)
                .url(url)
                .build();

        for (Iterator<Map.Entry<String, Object>> it = keywords.entrySet().iterator(); it.hasNext(); ) {
            Map.Entry<String, Object> entry = it.next();
            if (entry.getValue().toString().contains("|")) {
                String[] value = entry.getValue().toString().split("\\|");
                wxMpTemplateMessage.addData(new WxMpTemplateData(entry.getKey(), value[0], value[1]));
            } else {
                wxMpTemplateMessage.addData(new WxMpTemplateData(entry.getKey(), entry.getValue().toString()));
            }
        }
        for (String openId : openIds){
            wxMpTemplateMessage.setToUser(openId);
            try {
                wxMpTemplateMsgService.sendTemplateMsg(wxMpTemplateMessage);
            } catch (WxErrorException e) {
                e.printStackTrace();
                logger.error("mpBatchPush error,openid is {}",openId);
                //一个发送失败不影响
                continue;
            }
        }


        return null;
    }



    /**
     * 根据用户获取有效的推送码
     *
     * @param openId 用户的openid
     * @return 推送码
     */
    public String getValidFormId(String openId) {
        List<Object> formTemplates =redisUtil.lGet(RedisKey.MINIFORMID + openId, 0, -1);

        String validFormId = "";
        int trimStart = 0;
        int size;
        for (int i = 0; i < (size = formTemplates.size()); i++) {
            FormTemplateVO formTemplateVO = JsonUtil.convertValue(formTemplates.get(i),FormTemplateVO.class);
            if (formTemplateVO.getExpire() > System.currentTimeMillis()) {
                validFormId = formTemplateVO.getFormId();
                trimStart = i + 1;
                break;
            }
        }

//         移除本次使用的和已过期的
        redisUtil.ltrim( RedisKey.MINIFORMID+ openId, trimStart == 0 ? size : trimStart, -1);

        return validFormId;
    }


}
