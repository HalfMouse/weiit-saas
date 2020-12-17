package com.weiit.web.admin.init.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.init.service.NotifyService;
import com.weiit.web.common.AdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-07-03.
 */

@Controller
@RequestMapping(value = "/notify")
public class NotifyController extends AdminController{

    @Resource
    private NotifyService notifyService;

    /**
     * 短信通知列表
     */
    @RequestMapping("/list")
    public UIview notifyList(){
        logger.info("进入 UserController-notifyList,短信通知列表");
        FormMap formMap=getFormMap();
        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        List<E> notifyInfo=notifyService.selectList(formMap);
        for (E notifytype:notifyInfo){
            String types=notifytype.get("business_type").toString();
            if (types.equals("1")){
                notifytype.put("business_types","渠道商开通商户提醒");
            }else if(types.equals("2")){
                notifytype.put("business_types","渠道商在线充值提醒");
            }else if(types.equals("3")){
                notifytype.put("business_types","商户自主订购系统版本提醒");
            }else if(types.equals("4")){
                notifytype.put("business_types","商户自主订购服务功能提醒");
            }else{
                notifytype.put("business_types","官网注册新会员提醒");
            }
        }
        UIview view =UIView("/center/init/notifyList",false);
        view.addObject("pageInfo",new PageInfo<E>(notifyInfo));
        return view;
    }

    /**
     * 短信通知编辑
     */
    @RequestMapping("/edit")
    public UIview edit(){
        logger.info("进入 UserController-edit,短信通知编辑");
        FormMap formMap=getFormMap();
        E infoMap =notifyService.selectOne(formMap);
        String business_types=infoMap.get("business_type").toString();
        if (business_types.equals("1")){
            infoMap.put("business_types","渠道商开通商户提醒");
        }else if(business_types.equals("2")){
            infoMap.put("business_types","渠道商在线充值提醒");
        }else if(business_types.equals("3")){
            infoMap.put("business_types","商户自主订购系统版本提醒");
        }else if(business_types.equals("4")){
            infoMap.put("business_types","商户自主订购服务功能提醒");
        }else{
            infoMap.put("business_types","官网注册新会员提醒");
        }
        UIview view =UIView("/center/init/notifyEdit",false);
        view.addObject("infoMap",infoMap);
        return view;
    }


    /**
     * 短信通知编辑保存
     */
    @RequestMapping("/save")
    public UIview save(){
        logger.info("进入 UserController-save,短信通知编辑保存");
        FormMap formMap=getFormMap();
        notifyService.edit(formMap);
        UIview view =UIView("redirect:list",false);
        return view;
    }


}
