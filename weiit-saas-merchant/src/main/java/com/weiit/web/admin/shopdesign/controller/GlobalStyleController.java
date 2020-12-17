package com.weiit.web.admin.shopdesign.controller;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.shopdesign.service.GlobalStyleService;
import com.weiit.web.base.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * 设计页面
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/design/page")
public class GlobalStyleController extends AdminController {
	
	public static Logger logger= Logger.getLogger(GlobalStyleController.class);
	@Resource
	private GlobalStyleService globalStyleService;
   
    @RequestMapping("/globalStyle")
    public UIview globalStyle() {
    	logger.info("进入 GlobalStyleController-globalStyle,全店风格");
    	//获取请求传入参数
    	FormMap formMap=getFormMap(); 
    	//查询当前商户的登录页设计信息
    	E info=globalStyleService.selectOne(formMap);
    	//绑定参数返回
    	UIview result=UIView("/center/design/page/globalStyle",false);
        result.addObject("infoMap", info );
        result.addObject("queryParam", formMap);
    	
    	return result;
    }
    
    @RequestMapping("/globalStyleSave")
    public UIview globalStyleSave()  throws Exception {
    	logger.info("进入 GlobalStyleController-globalStyleSave,全店风格");
    	UIview result=UIView("globalStyle",true);
    	try { 
	        FormMap formMap=getFormMap();  
	    	if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){ 
	    		globalStyleService.insert(formMap); 
			}else{ 
				globalStyleService.edit(formMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
    	return result;
    }
    
}