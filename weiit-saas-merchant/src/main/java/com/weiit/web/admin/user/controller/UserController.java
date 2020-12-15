package com.weiit.web.admin.user.controller;


import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.user.service.UserService;
import com.weiit.web.admin.user.service.UserSignService;
import com.weiit.web.base.AdminController;

/**
 * 会员管理》会员信息
 * @author：半个鼠标
 * @date：2018年2月6日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends AdminController{
	
	public static Logger logger=Logger.getLogger(UserController.class);
	
	@Resource
	private UserService userService;
	
	@Resource
	private UserSignService userSignService;

    @RequestMapping("/userList")
    public UIview userList() {
    	logger.info("进入 UserController-userList,会员列表");
    	
    	UIview view=UIView("/center/user/userList",false);
    	
    	FormMap formMap = getFormMap();
    	
    	List<E> signList=userSignService.selectList(formMap);
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> userList = userService.selectUserList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(userList));
		view.addObject("signList", signList); 
		view.addObject("queryParam", formMap);
    	return view;
    }


	/**
	 * 会员管理》充值余额或者赠送积分
	 * @throws Exception
	 */
	@RequestMapping("/changeBalanceOrIntegral")
	public UIview changeBalanceOrIntegral(){
		logger.info("进入UserController-changeBalanceOrIntegral,会员余额充值或赠送积分");

		UIview view = UIView("userList",true);
		FormMap formMap=getFormMap();
		userService.updateBalanceOrIntegralTrans(formMap);
		return view;
	}

    
	/**
	 * 会员管理》单个 禁用 ，启用
	 * @throws Exception 
	 */
	@RequestMapping("/state")
	public UIview state(){
		logger.info("进入UserController-state,会员启用或者禁用");
		
		UIview view = UIView("userList",true);
		FormMap formMap=getFormMap(); 
		userService.forbiddenOrOpen(formMap);
		return view;
	}
	
	/**
	 * 会员管理》  批量 禁用 ，启用
	 * @throws Exception 
	 * */
	@RequestMapping(value="/stateBatch")
	public UIview stateBatch(){
		logger.info("进入UserController-stateBatch,批量启用或禁用");
		
		UIview view = UIView("userList",true);
		FormMap formMap=getFormMap();
		String[] validate_id=(String[])this.getRequest().getParameterValues("validate_id");
		String validate_ids=StringUtils.join(validate_id,",");
		formMap.set("validate_ids", validate_ids);
		userService.forbiddenOrOpenBatch(formMap);
		return view;
	} 


	/**
	 * 会员管理》查询用户余额记录
	 * @throws Exception 
	 */
	@RequestMapping("/balanceList")
	public UIview balanceList() {
		logger.info("进入UserController-balanceList,会员余额记录");
		
		UIview view = UIView("/center/user/balanceList",false);
		FormMap forMap = getFormMap();
		List<E> balancelist = userService.selectBalanceList(forMap);
		
		view.addObject("pageInfo", new PageInfo<E>(balancelist));
		view.addObject("queryParam", forMap);
		return view;
	}
	
	/**
	 * 会员管理》查询用户积分记录
	 * @throws Exception 
	 */
	@RequestMapping("/integralList")
	public UIview integralList() {
		logger.info("进入UserController-integralList,会员积分记录");
		
		UIview view = UIView("/center/user/integralList",false);
		FormMap formMap = getFormMap();
		List<E> integralList = userService.selectIntegralList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(integralList));
		view.addObject("queryParam", formMap);
		return view;
	}
	
	/**
	 *会员管理》查询会员地址
	 * @throws Exception 
	 */
	@RequestMapping("/addressList")
	public UIview addressList() {
		logger.info("进入UserController-addressList,会员地址展示");
		
		UIview view = UIView("/center/user/addressList",false);
		FormMap formMap = getFormMap();
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> addresslist = userService.selectAddressList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(addresslist));
		view.addObject("queryParam", formMap);
		return view;
	}
	
	/**
	 * 会员管理》批量打标签
	 * @return
	 */
	@RequestMapping("/userSignLogAdd")
	public UIview userSignLogAdd() {
		logger.info("进入UserController-userSignLogAdd,会员批量打标签");
		
		UIview view = UIView("userList",true);
		FormMap formMap = getFormMap();
		String [] ids=formMap.getStr("ids").split("\\|");//用户id
		
		String [] sign_ids=this.getRequest().getParameterValues("sign_id");
		for (String sign_id : sign_ids) {
			formMap.set("sign_id", sign_id);
			for (String user_id : ids) {
				formMap.set("user_id", user_id);
				userSignService.insertSignLog(formMap);
			}
		}
		return view;
	}
}