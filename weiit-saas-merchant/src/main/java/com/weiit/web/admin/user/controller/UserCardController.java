package com.weiit.web.admin.user.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.user.service.UserCardService;
import com.weiit.web.admin.user.service.UserService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 会员管理》会员卡管理
 * @author：半个鼠标
 * @date：2018年2月6日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping(value = "/user")
public class UserCardController extends AdminController {
	
	public static Logger logger= Logger.getLogger(UserCardController.class);
	
	@Resource
	private UserService userService;
	
	@Resource
	private UserCardService userCardService;
	
	@Resource
    ParameterService parameterService;

	/**
     * 会员卡》会员卡列表
     */
    @RequestMapping("/userCardList")
    public UIview userCardList(){
    	logger.info("进入 UserCardController-userCardList,会员卡列表");
    	
    	UIview view=UIView("/center/user/userCardList",false);
    	FormMap formMap = getFormMap();
    	List<E> cardlist = userCardService.selectList(formMap);
    	//查询店铺信息
    	E shopInfo=userCardService.selectShopInfo(formMap);
    	
    	view.addObject("cardList", cardlist);
    	view.addObject("queryParam", formMap);
    	view.addObject("shopInfo", shopInfo);
    	return view;
    }
    
    /**
     * 会员卡》会员卡创建
     */
    @RequestMapping("/userCardCreate")
    public UIview userCardCreate() {
    	logger.info("进入 UserCardController-userCardCreate,会员卡创建"); 
    	
    	UIview view=UIView("/center/user/userCardCreate",false);
    	FormMap formMap=getFormMap();
    	//查询店铺信息
    	E shopInfo=userCardService.selectShopInfo(formMap);
    	view.addObject("shopInfo", shopInfo);
    	return view;
    }
    
	/**
     * 优惠券 保存 
     */
	@RequestMapping("/userCardSave")
	public UIview userCardSave() throws Exception {
    	logger.info("进入 UserCardController-userCardSave,会员卡创建提交"); 
    	
    	UIview view=UIView("userCardList", true);
		try { 
	        FormMap formMap=getFormMap();
	        if(formMap.getInt("card_bg_type")==0){
	        	formMap.put("card_img", null);
			}else{
				formMap.put("card_bg_color", null);
			}
	        if(StringUtils.isEmpty(formMap.getStr("is_free_shippiing"))){
	        	formMap.put("is_free_shippiing", -1);
			}
	        if(StringUtils.isEmpty(formMap.getStr("discountCheck"))){
	        	formMap.put("discount", -1);
			}
	        if(StringUtils.isEmpty(formMap.getStr("integralCheck"))){
	        	formMap.put("give_integral", -1);
			}
	        if(formMap.getInt("limit_type")==1){
	        	formMap.put("start_time", null);
	        	formMap.put("end_time", null);
			}
	        if(formMap.getInt("type")==1){
	        	formMap.put("order_count", -1);
	        	formMap.put("order_total", -1);
				formMap.put("integral_count", -1);
			}
			if(StringUtils.isEmpty(formMap.getStr("validate_id"))){
				userCardService.insert(formMap);
			}else{
				userCardService.edit(formMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return view;
		
	} 
	
	/**
     * 会员卡》编辑
     */
	@RequestMapping("/userCardEdit")
	public UIview userCardEdit(){
    	logger.info("进入 UserCardController-userCardEdit,会员卡编辑"); 
    	
    	UIview view=UIView("/center/user/userCardCreate",false);
		FormMap formMap=getFormMap();
		//查询会员卡信息
		E infoMap=userCardService.selectOne(formMap);
		//查询店铺信息
		E shopInfo=userCardService.selectShopInfo(formMap);
		
		view.addObject("infoMap", infoMap);
		view.addObject("shopInfo", shopInfo);
		return view;
	}
	
    /**
     * 会员卡》删除
     */
	@RequestMapping("/userCardRemove")
	public UIview userCardRemove(){
		logger.info("进入 UserCardController-userCardRemove,会员卡删除"); 
		
		UIview view=UIView("userCardList", true);
		FormMap map=getFormMap();
		userCardService.remove(map);
		
		view.addPNotifyMessage("删除成功.");
		return view;
	}
    
    /**
     * 会员卡管理》进入发卡页面
     * @return
     */
    @RequestMapping("/userCardGive")
    public UIview userCardGive() {
    	logger.info("进入 UserCardController-userCardGive,会员发卡");
    	
    	UIview view=UIView("/center/user/userCardGive",false);
    	FormMap formMap = getFormMap();
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> list = userCardService.selectNoCardUserList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(list));
		view.addObject("queryParam", formMap);
    	return view;
    }
    
    /**
     * 会员卡管理》发卡页面 对用户进行发卡
     * @return
     */
    @RequestMapping("/userCardGiveSave")
    public UIview userCardGiveSave() {
    	logger.info("进入 UserCardController-userCardGiveSave,会员发卡提交"); 
    	
    	FormMap formMap = getFormMap();
    	UIview view=UIView("userCardGive?validate_id="+formMap.getStr("validate_id")+"&validate_id_token="+formMap.getStr("validate_id_token"),true);
    	userCardService.insertUserCardTrans(formMap);
    	return view;
    }
    
    /**
     * 会员卡管理--查询卡片用户
     * @return
     */
    @RequestMapping("/userCardUser")
    public UIview userCardUser() {
    	logger.info("进入 UserCardController-userCardUser,会员卡用户查询");
    	
    	UIview view=UIView("/center/user/userCardUser",false);
    	FormMap formMap = getFormMap();
    	E cardInfo=userCardService.selectOne(formMap);
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> list = userCardService.selectHaveCardUserList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(list));
		view.addObject("queryParam", formMap);
		view.addObject("cardInfo", cardInfo);
    	return view;
    }
    
    /**
     * 会员卡管理--会员退卡
     * @return
     */
    @RequestMapping("/userCardGiveRemove")
    public UIview userCardGiveRemove() {
    	logger.info("进入 UserCardController-userCardGiveRemove,会员退卡"); 
    	
    	FormMap formMap = getFormMap();
    	UIview view=UIView("userCardUser?validate_id="+formMap.getStr("card_id")+"&validate_id_token="+formMap.getStr("card_id_token"),true);
    	
    	String[] validate_id=(String[])this.getRequest().getParameterValues("validate_id");
		String validate_ids= StringUtils.join(validate_id,",");
		formMap.set("validate_ids", validate_ids);
    	userCardService.removeUserCard(formMap);
    	return view;
    }
    
    @RequestMapping("/userSet")
    public UIview userSet() {
    	logger.info("进入 UserCardController-userSet,会员设置");
    	
    	FormMap formMap = getFormMap();
    	formMap.put("item_code", "USERSET");
    	UIview view=UIView("/center/user/userSet",false);
    	List<E> list=parameterService.selectList(formMap);
    	for (E info : list) {
    		formMap.set(info.getStr("item_name"), info.get("item_value"));
    		formMap.set(info.getStr("item_name")+"_ID", info.get("id"));
		}
    	view.addObject("queryParam", formMap);  
    	return view;
    }
    
    @RequestMapping("/userSetSave")
    public UIview userSetSave() {
    	logger.info("进入 UserCardController-userSetSave,订单保存");
    	FormMap formMap = getFormMap();
    	UIview view=UIView("userSet",true);
    	
    	List<FormMap> list=new ArrayList<FormMap>();
    	
    	FormMap info11 = new FormMap();
		info11.put("validate_id", formMap.get("LOGINMODE_ID"));
		info11.put("item_value", formMap.get("LOGINMODE"));
		info11.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("LOGINMODE_ID").equals("")){
			info11.put("item_code", "USERSET");
			info11.put("item_name", "LOGINMODE"); 
			info11.put("item_desc", "会员登录方式:1手机号码登录，0微信授权登录"); 
			info11.put("state", 0); 
		}
		
		FormMap info22 = new FormMap();
		info22.put("validate_id", formMap.get("ORDERSUCCESS_ID"));
		info22.put("item_value", formMap.get("ORDERSUCCESS"));
		info22.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("ORDERSUCCESS_ID").equals("")){
			info22.put("item_code", "USERSET");
			info22.put("item_name", "ORDERSUCCESS"); 
			info22.put("item_desc", "订单交易成功:1短信提醒，0不提醒"); 
			info22.put("state", 0); 
		}
		
		FormMap info33 = new FormMap();
		info33.put("validate_id", formMap.get("INTEGRALCHANGE_ID"));
		info33.put("item_value", formMap.get("INTEGRALCHANGE"));
		info33.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("INTEGRALCHANGE_ID").equals("")){
			info33.put("item_code", "USERSET");
			info33.put("item_name", "INTEGRALCHANGE"); 
			info33.put("item_desc", "积分变动:1短信提醒，0不提醒"); 
			info33.put("state", 0); 
		}
		
		FormMap info44 = new FormMap();
		info44.put("validate_id", formMap.get("BALANCECHANGE_ID"));
		info44.put("item_value", formMap.get("BALANCECHANGE"));
		info44.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("BALANCECHANGE_ID").equals("")){
			info44.put("item_code", "USERSET");
			info44.put("item_name", "BALANCECHANGE"); 
			info44.put("item_desc", "余额变动:1短信提醒，0不提醒"); 
			info44.put("state", 0); 
		}
		
		list.add(info11);
		list.add(info22);
		list.add(info33);
		list.add(info44);
		
    	parameterService.editBatch(list);
    	return view;
    }
    
    /**
	 *  查询会员卡图片素材
	 */
	@RequestMapping("/pictureSource_usercard")
	public ModelAndView pictureSource_usercard() throws Exception {
		logger.info("进入UserCardController-pictureSource_usercard,会员卡图片素材加载");
		
		UIview result = UIView("/center/user/pictureSource_usercard",false);
    	FormMap formMap=getFormMap();
    	formMap.set("parent_id", 4);//表示官方会员卡图片素材
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=userCardService.selectUserCardPictureSourceList(formMap);
        result.addObject("pageInfo", new PageInfo<E>(list));
		return result;
	}
    
}