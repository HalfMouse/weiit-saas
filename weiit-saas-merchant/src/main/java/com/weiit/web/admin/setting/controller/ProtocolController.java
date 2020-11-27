package com.weiit.web.admin.setting.controller;


import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.setting.service.ProtocolService;
import com.weiit.web.admin.setting.service.SettingService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;

/**
 * 设计页面
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/setting")
public class ProtocolController extends AdminController{

	public static Logger logger=Logger.getLogger(SettingController.class);

	@Resource
	private ProtocolService protocolService;



    /**
     * 服务协议 页面
     */
    @RequestMapping("/protocol")
    public UIview protocol() {
    	logger.info("进入 SettingController-protocol,服务协议"); 
    	UIview result=UIView("/center/setting/protocol",false);
    	FormMap formMap = getFormMap(); 
		List<E> list = protocolService.selectList(formMap); 
		result.addObject("queryParam", formMap);
		result.addObject("protocolList", list); 
    	return result;
    }
    
    
    /**
     * 服务协议 修改
     */
    @RequestMapping("/protocolEdit")
    public UIview protocolEdit() {
    	logger.info("进入 SettingController-protocolAdd,服务协议"); 
    	UIview result=UIView("/center/setting/protocolEdit",false); 
    	FormMap formMap = getFormMap(); 
		E info = protocolService.selectOne(formMap); 
		result.addObject("queryParam", formMap);
		result.addObject("infoMap", info); 
		result.addObject("title", "服务协议编辑"); 
    	return result;
    }
    
    /**
     * 服务协议 保存
     */
    @RequestMapping("/protocolSave")
    public UIview protocolSave() {
    	logger.info("进入 SettingController-protocolSave,服务协议"); 
    	UIview result=UIView("redirect:protocol",false);
    	FormMap formMap = getFormMap(); 
    	if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){ 
    		protocolService.insert(formMap); 
		}else{ 
			protocolService.edit(formMap);
		}
    	return result;
    }
    
}