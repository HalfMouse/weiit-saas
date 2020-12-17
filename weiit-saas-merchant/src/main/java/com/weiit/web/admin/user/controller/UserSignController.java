package com.weiit.web.admin.user.controller;

import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.user.service.UserSignService;
import com.weiit.web.base.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 会员提现，审核 
 * @author hzy
 * @date 2018年3月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/user")
public class UserSignController extends AdminController {
	public static Logger logger= Logger.getLogger(UserSignController.class);
	 
	@Resource
	private UserSignService userSignService;
	
	/**
     *  会员-标签组列表
     */
	@RequestMapping("/userSignList")
	public UIview userSignList() throws Exception {
		
		logger.info("进入UserSignController-userSignList,会员-标签组列表");
		
    	FormMap formMap=getFormMap();
    	
    	List<E> list=userSignService.selectList(formMap);
    	UIview result = UIView("/center/user/userSignList",false);
    	
        result.addObject("pageInfo", new PageInfo<E>(list));
		return result;
	}
	
	/**
	 * 会员-编辑查询信息
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/userSignView")
	public String userSignView() throws Exception {
		
		logger.info("进入UserSignController-userSignView,会员标签组查询view");
		
    	FormMap formMap=getFormMap();
    	
    	E sign=userSignService.selectOne(formMap);
    	return toJsonAPI(sign);
	}
	
	/**
	 * 会员-标签组新增或者编辑
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userSignSaveOrEdit")
	public UIview userSignSaveOrEdit() throws Exception {
		
		logger.info("进入UserSignController-userSignSaveOrEdit, 会员-标签组新增或者编辑");
		UIview result = UIView("userSignList",true);
		
    	FormMap formMap=getFormMap();
    	
    	if(StringUtils.isEmpty(formMap.getStr("validate_id"))){//新增
    		userSignService.insert(formMap);
    	}else{//编辑
    		userSignService.edit(formMap);
    	}
		return result;
	} 
	
    /**
     *  会员-标签组删除
     */
	@RequestMapping("/userSignRemove")
	public UIview userSignRemove() throws Exception {
		
		logger.info("进入UserSignController-userSignRemove, 会员-标签组删除");

    	FormMap formMap=getFormMap();
    	userSignService.remove(formMap);
    	
    	UIview result = UIView("userSignList",true);
		result.addPNotifyMessage("标签组删除成功");
		return result;
	} 
	
  
}
