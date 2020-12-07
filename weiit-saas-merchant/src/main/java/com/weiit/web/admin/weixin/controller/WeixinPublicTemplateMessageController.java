package com.weiit.web.admin.weixin.controller;


import cn.binarywang.wx.miniapp.api.WxMaTemplateService;
import cn.binarywang.wx.miniapp.bean.template.WxMaTemplateAddResult;
import cn.binarywang.wx.miniapp.bean.template.WxMaTemplateListResult;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.util.JsonUtil;
import com.weiit.web.admin.weixin.service.WeixinPublicTemplateMessageService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.mp.bean.template.WxMpTemplate;
import me.chanjar.weixin.open.api.WxOpenService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 公众号设置-模板消息
 *
 * @author 半个鼠标
 * @version 1.0
 * @date：2018年2月14日 上午2:01:43
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping("/weixin/templateMessage")
public class WeixinPublicTemplateMessageController extends AdminController {

    @Resource
    private WeixinPublicTemplateMessageService templateService;

    @Resource
    private WeixinOpenService wxOpenService;

    /**
     * 公众号模板消息列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("list")
    public UIview menuInit() throws Exception {

        FormMap formMap = getFormMap();

        UIview result = UIView("/center/weixin/weixinTemplateMessage", false);

        E publicInfo = (E) this.getSession().getAttribute("publicInfo");
        if (publicInfo != null) {
            formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));

            //查询我的模板消息，所有的模板
            List<E> myTemplateList = templateService.selectMyTemplateList(formMap);
            result.addObject("mytemplateList", myTemplateList);

        } else {
            result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
        }

        return result;

    }

    /**
     * 小程序模板消息列表
     *
     * @return
     * @throws Exception
     */

    @RequestMapping("miniMessageList")
    public UIview miniMessageList() throws Exception {

        FormMap formMap = getFormMap();

        UIview result = UIView("/center/miniprogram/miniTemplateMessage", false);

        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        if (miniPublicInfo != null) {
            formMap.set("authorizer_id", miniPublicInfo.getStr("authorizer_id"));

            //查询我的模板消息，所有的模板
            List<E> myTemplateList = templateService.selectMyTemplateList(formMap);
            result.addObject("mytemplateList", myTemplateList);

        } else {
            result.addObject("info", "对不起，小程序还没有绑定授权，请先绑定授权。");
        }

        return result;

    }

    /**
     * 模板消息自动配置,注意一定是公众号已经开通了模板消息才可以设置，行业分类最好是开通的时候已经设置好。
     *
     * @return
     * @throws Exception
     */

    @RequestMapping("/autoSet")
    public UIview autoSet() {

        UIview result;

        FormMap formMap = getFormMap();
        E publicInfo;
        if (!StringUtils.isEmpty(formMap.getStr("type")) && formMap.getInt("type") == 0) {
            publicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
            result = UIView("miniMessageList", true);
        } else {
            publicInfo = (E) this.getSession().getAttribute("publicInfo");
            result = UIView("list", true);
        }

        if (publicInfo != null) {
            formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
            formMap.set("appid", publicInfo.getStr("authorizer_app_id"));
            WxOpenService openService = wxOpenService.getInstance(formMap);
            try {
                if (!StringUtils.isEmpty(formMap.getStr("type")) && formMap.getInt("type") == 0) {

                    //先查询该小程序账号下所有模板  一次查询最多20  模板最多25个;
                    List<WxMaTemplateListResult.TemplateInfo> list = new ArrayList<WxMaTemplateListResult.TemplateInfo>();
                    WxMaTemplateService wxMaTemplateService = openService.getWxOpenComponentService().getWxMaServiceByAppid(publicInfo.getStr("authorizer_app_id")).getTemplateService();
                    int offset = 0;
                    int size = 20;
                    do {
                        WxMaTemplateListResult wxMaTemplateListResult =wxMaTemplateService.findTemplateList(offset*size, 20);
                        list.addAll(wxMaTemplateListResult.getList());
                        if (wxMaTemplateListResult.getList().size() < size) {
                            break;
                        }
                        offset++;
                    } while (true);

					//先删除原来的该小程序上面的所有模板
					for (WxMaTemplateListResult.TemplateInfo templateInfo : list) {
                        wxMaTemplateService.delTemplate(templateInfo.getTemplateId());
					}
					//删除自己数据库中存储的所有该小程序的模板
					templateService.removeTemplateMsg(formMap);

					//然后查询小程序需要初始化配置的模板集合
                    formMap.put("template_type",0);
					List<E> typeList=templateService.selectAllTemplateTypeList(formMap);
					//重新创建与新增
					for (E templateNew : typeList) {
                        List<Integer> lists = JsonUtil.convertValue(templateNew.getStr("template_content_eg").split("\\|")[1],List.class);
                        WxMaTemplateAddResult wxMaTemplateAddResult =wxMaTemplateService.addTemplate(templateNew.getStr("template_type_num"),lists);
						formMap.set("wx_template_id", wxMaTemplateAddResult.getTemplateId());
						formMap.set("template_type_id", templateNew.getStr("template_type_id"));
						formMap.set("template_type_num", templateNew.getStr("template_type_num"));
						formMap.set("template_msg_name", templateNew.getStr("template_type_name"));
						formMap.set("business_type", templateNew.getStr("business_type"));
						formMap.set("state",1);//默认初始化好就开启状态
						templateService.insertTemplateMsg(formMap);

					}

                } else {

                    List<WxMpTemplate> wxMytemplateList = openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getTemplateMsgService().getAllPrivateTemplate();
                    //先删除原来的该公众号上面的所有模板
                    for (WxMpTemplate wxMpTemplate : wxMytemplateList) {
                        openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getTemplateMsgService().delPrivateTemplate(wxMpTemplate.getTemplateId());
                    }
                    //删除自己数据库中存储的所有该公众号的模板
                    templateService.removeTemplateMsg(formMap);

                    //然后查询需要初始化配置的模板集合
                    formMap.put("template_type",2);
                    List<E> typeList = templateService.selectAllTemplateTypeList(formMap);
                    System.out.println(typeList.size());
                    //重新创建与新增
                    for (E templateNew : typeList) {
                        String wx_template_id = openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getTemplateMsgService().addTemplate(templateNew.getStr("template_type_num"));
                        formMap.set("wx_template_id", wx_template_id);
                        formMap.set("template_type_id", templateNew.getStr("template_type_id"));
                        formMap.set("template_type_num", templateNew.getStr("template_type_num"));
                        formMap.set("template_msg_name", templateNew.getStr("template_type_name"));
                        formMap.set("business_type", templateNew.getStr("business_type"));
                        formMap.set("state", 1);//默认初始化好就开启状态
                        templateService.insertTemplateMsg(formMap);

                    }
                }
                result.addPNotifyMessage("模板消息自动配置已经成功");
            } catch (Exception e) {
                e.printStackTrace();
                result.addErrorMessage("未开通模板消息,请登录公众平台->添加功能插件->模板消息,开通申请");
            }

        } else {
            result.addErrorMessage("对不起，还没有绑定授权，请先绑定授权");
        }

        return result;
    }


    public static void main(String[] args) {
        int offset = 0;
        do {
            if (offset > 20) {
                break;
            }
            System.out.println(""+offset);
            offset++;
        } while (true);
    }
    @RequestMapping("templateState")
    public UIview templateState() {

        UIview result ;

        FormMap formMap = getFormMap();
        E publicInfo;
        if (formMap.get("service_type")!=null){
            publicInfo  = (E) this.getSession().getAttribute("miniPublicInfo");
             result = UIView("miniMessageList", true);
        }else {
            publicInfo  = (E) this.getSession().getAttribute("publicInfo");
             result = UIView("list", true);
        }

        if (publicInfo != null) {
            formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
            if (formMap.getInt("state") == 1) {
                formMap.set("state", "-1");
            } else {
                formMap.set("state", "1");
            }

            templateService.editTemplateMsgState(formMap);
        } else {
            result.addErrorMessage("对不起，公众号还没有绑定授权，请先绑定授权");
        }
        return result;

    }



}
