package com.weiit.web.admin.init.controller;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.init.service.smallProgramService;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;


/**
 *服务协议相关业务
 * @author 唐
 *  @date：2017年6月30日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/smallprogram")
public class smallProgramController extends AdminController {

    @Resource
    private smallProgramService smallProgramService;

    @Resource
    WeixinOpenService weixinOpenService;



    /**
     * 小程序版本信息
     */
    @RequestMapping("/list")
    public UIview smallProgramList() {
        logger.info("进入 smallprogram-smallProgramList,小程序发布");
        UIview view=UIView("/center/init/smallProgramList",false);
        FormMap formMap = getFormMap();
        E smallProgramInfo = smallProgramService.selectOne(formMap);
        view.addObject("smallProgramInfo", smallProgramInfo);
        return view;
    }


    /**
     *
     * 新版本发布
     * */

    @RequestMapping("/newVersionPush")
    public UIview newVersionPush(){
        UIview view=UIView("list",true);
        weixinOpenService.publishMiniNewVersion(null);

        view.addPNotifyMessage("发布完成");
        return view;
    }




}
