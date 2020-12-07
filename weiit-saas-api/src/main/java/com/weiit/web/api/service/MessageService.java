package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/23.
 *

 *
 */
public interface MessageService {


    /**
     *
     * 小程序发送
     * @param templateId   templateId 要发送的模板Id
     * @param keywords 模版对应的占位符
     * @param openIds  要接收的用户
     * @param page  指定跳转页
     * @param emphasisKeyword     模板需要放大的关键词，不填则默认无放大     填写模板的占位符   如keyword1.DATA
     *
     *  模板内容字体颜色 color 属性值已经废弃(小程序官方)
     * */
    String maPush(String templateId, E keywords, List<String> openIds, FormMap formMap, String page,String emphasisKeyword);

    /**
     *
     * 服务号发送
     * @param templateId   templateId 要发送的模板Id
     * @param keywords 模版对应的占位符
     * @param openIds  要接收的用户
     * @param url 指定跳转url   公众号 http://wx8f9a626168f98ff1.wx.ustore.wang
     * */
    String mpPush(String templateId, E keywords, List<String> openIds, FormMap formMap, String url);



}
