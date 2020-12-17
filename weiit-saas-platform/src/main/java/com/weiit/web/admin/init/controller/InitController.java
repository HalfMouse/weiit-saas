package com.weiit.web.admin.init.controller;

import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.init.service.InitService;
import com.weiit.web.common.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * 店铺 初始化 数据 
 * @author hzy 
 * @date 2018年7月27日
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/shop")
public class InitController extends AdminController {
	
	public static Logger logger=Logger.getLogger(InitController.class);
	
	@Resource
	private InitService initService;
 
    /**
     * 店铺 初始化 数据  
     */
    @RequestMapping("/init")
    public UIview init() {
    	logger.info("进入InitController-init, 店铺 初始化 数据  "); 
    	FormMap formMap=getFormMap(); 
    	UIview result = UIView("shopList",true);
    	try {
    		initService.insertInit(formMap);
    		result.addErrorMessage("店铺数据初始页成功！");
		} catch (Exception e) {
			e.printStackTrace();
			result.addErrorMessage("店铺数据初始页失败！");
		}
    	return result;
    }
  
}