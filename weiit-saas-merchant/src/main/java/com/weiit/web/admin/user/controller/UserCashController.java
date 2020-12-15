package com.weiit.web.admin.user.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.user.service.UserCashService;
import com.weiit.web.base.AdminController;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
public class UserCashController extends AdminController {
	public static Logger logger= Logger.getLogger(UserCashController.class);
	 
	@Resource
	private UserCashService userCashService;
	
	/**
     *  会员提现 审核 查询 
     */
	@RequestMapping("/userCashList")
	public UIview userCashList() throws Exception {
		logger.info("进入InvoiceController-cashList, 会员提现列表查询");
    	FormMap formMap=getFormMap();
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=userCashService.selectList(formMap);
    	UIview result = UIView("/center/user/userCashList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
		return result;
	}
	
	/**
     *  会员提现 审核 查询  详细 
     */
	@RequestMapping("/userCashDetail")
	public UIview userInvoiceDetail() throws Exception {
		logger.info("进入InvoiceController-userInvoiceDetail, 会员提现列表查询");
    	FormMap formMap=getFormMap();
    	E infoMap=userCashService.selectOne(formMap);
    	UIview result = UIView("/center/user/userCashDetail",false);
        result.addObject("infoMap", infoMap);
		return result;
	} 
	
    /**
     *  会员提现 审核   审核和驳回
     */
	@RequestMapping("/userCashState")
	public UIview userCashState() throws Exception {
		logger.info("进入InvoiceController-cashState, 会员提现审核和驳回");

    	FormMap formMap=getFormMap();
    	userCashService.edit(formMap); 
    	UIview result = UIView("userCashList",true);
		result.addPNotifyMessage("会员提现审核操作完成");
		return result;
	} 
	
  
}
