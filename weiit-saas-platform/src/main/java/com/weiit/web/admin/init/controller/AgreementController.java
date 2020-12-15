package com.weiit.web.admin.init.controller;

import com.alibaba.druid.util.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.init.service.AgreementService;
import com.weiit.web.common.AdminController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

import java.util.List;

/**
 *服务协议相关业务
 * @author 唐
 *  @date：2017年6月30日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/agreement")
public class AgreementController extends AdminController {
    @Resource
    private AgreementService agreementService;



    /**
     * 服务协议列表
     */
    @RequestMapping("/list")
    public UIview agreementList() {
        logger.info("进入 UserController-agreementList,服务协议列表");


        UIview view=UIView("/center/init/agreementList",false);
        FormMap formMap = getFormMap();
        // 开启分页
        PageHelper.startPage(formMap.getPage(), formMap.getRows());
        List<E> agreementList = agreementService.selectAgreementList(formMap);
        FormMap agreementInfo= new FormMap();
        for (E agreement:agreementList ){
            if (!StringUtils.isEmpty(agreement.getStr("protocol_content"))){
                String content=agreement.get("protocol_content").toString();
                String protocol_content = content.replaceAll("<[^>]+>","");;
                agreement.put("protocol_content",protocol_content.substring(0,25));
            }
        }
        view.addObject("pageInfo", new PageInfo<E>(agreementList));
        view.addObject("queryParam", formMap);
        return view;
    }


    /**
     * 添加服务协议
     */
    @RequestMapping("/add")
    public UIview Addagreement(){
        logger.info("进入 UserController-Addagreement,添加服务协议");
        FormMap formMap = getFormMap();
        UIview view=UIView("/center/init/agreementCreate",false);
        return view;
    }

    /**
     * 新增服务协议     编辑保存
     */
    @RequestMapping("/insert")
    public UIview Insertagreement(){
        logger.info("进入 UserController-Insertagreement,新增服务协议");
        FormMap formMap = getFormMap();
        if (formMap.getStr("agreementId") == null || formMap.getStr("agreementId").equals("")){
            agreementService.insert(formMap);
        }else{
            agreementService.edit(formMap);
        }
        UIview view=UIView("redirect:list",false);
        return view;
    }


    /**
     * 编辑服务协议
     */
    @RequestMapping("/edit")
    public UIview edit(){
        logger.info("进入 UserController-editagreement,编辑服务协议");
        FormMap formMap = getFormMap();
        E infoMap =agreementService.selectOne(formMap);
        UIview view=UIView("/center/init/agreementCreate",false);
        view.addObject("infoMap",infoMap);
        return view;
    }
}
