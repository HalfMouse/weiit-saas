package com.weiit.web.admin.ump.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.publics.mapper.ParameterMapper;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.ump.service.CouponService;
import com.weiit.web.admin.util.DateUtil;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.common.Constants;
import com.weiit.web.weixinopen.service.WeixinOpenService;

import me.chanjar.weixin.common.error.WxErrorException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * 营销管理-》优惠券
 * @author 半个鼠标
 * @date：2018年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping(value = "/ump/coupons")
public class CouponsController extends AdminController {

	public static Logger logger= Logger.getLogger(CouponsController.class);

	@Resource
	private CouponService couponService;

	@Resource
	ParameterService parameterService;

	@Resource
	WeixinOpenService weixinOpenService;
	  
	/**
	 * 优惠券》优惠券列表
	 */
	@RequestMapping("/couponsList")
	public UIview couponsList(){
		logger.info("进入CouponsController-couponsList,优惠券列表展示");
		
		UIview view = UIView("/center/ump/coupons/couponsList",false);
    	FormMap formMap=getFormMap();
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=couponService.selectList(formMap);
       
    	view.addObject("pageInfo", new PageInfo<E>(list));
    	view.addObject("queryParam", formMap);
		return view;
	}
	
    /**
     * 优惠券》优惠券创建
     */
	@RequestMapping("/create")
	public UIview create(){
		UIview view=UIView("/center/ump/coupons/couponsCreate", false);
		return view;
	}
	
    /**
     * 优惠券 》编辑
     */
	@RequestMapping("/edit")
	public UIview edit(){
		logger.info("进入CouponsController-edit,优惠券编辑");
		
		UIview view=UIView("/center/ump/coupons/couponsCreate", false);
		FormMap formMap=getFormMap();
		E coupon=couponService.selectCoupon(formMap);
		
		view.addObject("coupon", coupon);
		return view;
	}
	
    /**
     * 优惠券 》优惠券新增保存
     * @throws Exception 
     */
	@RequestMapping("/save")
	public ModelAndView save(){
		logger.info("进入CouponsController-save,优惠券新增保存");
		
		UIview view=UIView("couponsList", true);
	    FormMap formMap=getFormMap();
	    //判断优惠形式type=1,2,3
	    if(formMap.getInt("type")==1){//优惠形式表示“指定金额”
	        formMap.set("coupon_discount", null);
	        formMap.set("random_min_price", null);
	        formMap.set("random_max_price", null);
	    }else if(formMap.getInt("type")==2){//优惠形式表示“打折”
	        formMap.set("coupon_price", null);
	        formMap.set("random_min_price", null);
	        formMap.set("random_max_price", null);
	    }else{//优惠形式表示“指定金额（随机）”
	        formMap.set("coupon_discount", null);
	        formMap.set("coupon_price", null);
	    }
	    //判断生效条件is_condition=-1,1
		//生效条件表示“无条件”
	    if(formMap.getInt("is_condition")==-1){
	        formMap.set("condition_price", null);
	    }
		formMap.put("state",1);

	    //判断使用有效期方式use_type=1 固定范围  ,2  指定时间范围
		//使用有效期表示“固定范围”
	    if(formMap.getInt("use_type")==1){
	        formMap.set("from_day", null);
	        formMap.set("to_day", null);
	        //如果开始时间小于当前时间   则优惠券处于未生效状态  ,其他情况都是生效状态
			if (System.currentTimeMillis()< DateUtil.getTimeByString(formMap.getStr("start_time"),"yyyy/MM/dd HH:mm:ss")){
				formMap.put("state",-2);
			}
	    }else{
	        formMap.set("start_time", null);
	        formMap.set("end_time", null);
	    }
	    //判断没人领取限制
		//使用有效期表示“不限制领取熟量”
	    if(formMap.getInt("maxLimitType")==1){
	        formMap.set("max_limit", 0);
	    }
	    //判断可使用商品
		//使用有效期表示“全网商品通用”
	    if(formMap.getInt("product_range_type")==1){
	        formMap.set("product_ids", null);
	    }else{
	        formMap.set("product_ids", formMap.getStr("selectProductValues"));
	    }
	    //判断是新增还是修改
		//新增优惠券判断
		if(StringUtils.isEmpty(formMap.getStr("validate_id"))){
			couponService.insert(formMap);
		}else{//修改优惠券
			couponService.edit(formMap);
		}
		return view;
	}
	
	/**
	 * 优惠券》优惠券列表》生效&不生效
	 */
	@RequestMapping("/state")
	public UIview state(){
		logger.info("进入CouponsController-state,优惠券生效&不生效操作");
		
		UIview view=UIView("couponsList", true);
		FormMap formMap=getFormMap();
		formMap.set("onlyUpdateState", "state");
		couponService.edit(formMap);
		return view;
	}
	
	/**
	 * 优惠券》优惠券列表》删除
	 */
	@RequestMapping("/remove")
	public UIview remove(){
		logger.info("进入CouponsController-remove,优惠券删除");
		
		UIview view=UIView("couponsList", true);
		FormMap formMap=getFormMap();
		formMap.set("state", "0");
		List<E> list=couponService.selectCouponUserList(formMap);
		if(list.size() > 0){//该优惠券还有未使用的用户
			view.addErrorMessage("删除失败，该优惠券还有未使用的用户!");
		}else{
			couponService.remove(formMap);
			view.addPNotifyMessage("优惠券删除成功！");
		} 
		return view;
	}
 
    /**
     * 优惠券 派发用户列表 
     */ 
	@RequestMapping("/couponsGive")
	public UIview couponsGive(){
		logger.info("进入CouponsController-couponsGive,优惠券推广与派发");
		
		UIview view = UIView("/center/ump/coupons/couponsGive",false);
    	FormMap formMap=getFormMap();
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	//查询没有领取该优惠券的用户列表与领取了但是没有超过优惠券最大设置限购数的用户列表

    	List<E> list=couponService.selectNoCouponUserList(formMap);
    	
    	view.addObject("pageInfo", new PageInfo<E>(list));
    	view.addObject("queryParam", formMap);


		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		if (publicInfo!=null){
			//获取公众号优惠券地址  和 链接
			formMap.put("item_name","COUPONSMPQRCODE");
			E paramInfo = parameterService.selectShopParamByName(formMap);
			this.getSession().setAttribute("couponMpQrCodeUrl",String.format(Constants.COUPON_QR_CODE,publicInfo.getStr("authorizer_app_id")));
			if (paramInfo!=null){
				this.getSession().setAttribute("couponMpQrcode",paramInfo.getStr("item_value"));
			}else {
				WeiitQrCodeUtil qrCodeUtil = new WeiitQrCodeUtil();
				String qrCodePath = qrCodeUtil.createQRCodeAndUploadQcloud(String.format(Constants.COUPON_QR_CODE,publicInfo.getStr("authorizer_app_id")));
				//入库
				FormMap insertParam = new FormMap();
				insertParam.put("item_code","COUPONQRCODE");
				insertParam.put("item_name","COUPONSMPQRCODE");
				insertParam.put("item_value",WeiitUtil.getFileDomain()+qrCodePath);
				insertParam.put("item_desc","公众号优惠券领取二维码");
				insertParam.put("state",0);
				insertParam.put("shop_id",formMap.get("shop_id"));
				parameterService.insert(insertParam);
				this.getSession().setAttribute("couponMpQrcode",WeiitUtil.getFileDomain()+qrCodePath);
			}
		}
		E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
		if (miniPublicInfo!=null){
			//获取公众号优惠券地址  和 链接
			formMap.put("item_name","COUPONSMAQRCODE");
			E paramInfo = parameterService.selectShopParamByName(formMap);
			if (paramInfo!=null){
				this.getSession().setAttribute("couponMaQrcode",paramInfo.getStr("item_value"));
			}else {
				try {
					formMap.put("appid",miniPublicInfo.getStr("authorizer_app_id"));
					File file = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(miniPublicInfo.getStr("authorizer_app_id")).getQrcodeService().createWxaCode("pages/Receive_coupons/Receive_coupons",225);
					String qrCodePath = WeiitUtil.uploadFile(FileUtils.readFileToByteArray(file),"png");

					FormMap insertParam = new FormMap();
					insertParam.put("item_code","COUPONQRCODE");
					insertParam.put("item_name","COUPONSMAQRCODE");
					insertParam.put("item_value",WeiitUtil.getFileDomain()+qrCodePath);
					insertParam.put("item_desc","小程序优惠券领取二维码");
					insertParam.put("state",0);
					insertParam.put("shop_id",formMap.get("shop_id"));
					parameterService.insert(insertParam);
					this.getSession().setAttribute("couponMaQrcode",WeiitUtil.getFileDomain()+qrCodePath);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return view;
	}
	
	/**
	 * 派发优惠券  保存 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/couponsGiveSave")
	public UIview couponsGiveSave(){
		logger.info("进入CouponsController-couponsGiveSave,优惠券推广提交");
		
		FormMap formMap=getFormMap();
		String message=couponService.insertCouponUserTrans(formMap);
		UIview view = UIView("couponsGive?validate_id="+formMap.getStr("validate_id")+"&validate_id_token="+formMap.getStr("validate_id_token"),true);
		if(message==null){
			view.addPNotifyMessage("会员优惠券派送成功！");
		}else{
			view.addErrorMessage(message);
		}
		return view;
	}
	
	/**
	 * 派发优惠券记录
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/couponsUserList")
	public UIview couponsUserList(){
		logger.info("进入CouponsController-couponsUserList,发优惠券记录");
		
		UIview view = UIView("/center/ump/coupons/couponsUserList",false);
    	FormMap formMap=getFormMap();
    	E coupon = couponService.selectOne(formMap);
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	//查询该优惠券已经派发过的用户
    	List<E> list=couponService.selectCouponUserList(formMap);
    	
    	view.addObject("pageInfo", new PageInfo<E>(list));
    	view.addObject("queryParam", formMap);
    	view.addObject("coupon", coupon);
		return view; 
	}

	
	/**
	 * 派发优惠券》回收
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/couponsUserRemove")
	public UIview couponsUserRemove(){
		logger.info("进入CouponsController-couponsUserRemove,派发优惠券 回收");
		
		FormMap formMap=getFormMap();
		String message=couponService.removeCouponUserTrans(formMap);
		UIview view = UIView("couponsUserList?validate_id="+formMap.getStr("validate_id")+"&validate_id_token="+formMap.getStr("validate_id_token"),true);
		if(message==null){
			view.addPNotifyMessage("优惠券回收成功!");
		}else{
			view.addErrorMessage(message);
		}
		return view;
	}


	/**
	 * 装修页面 获取优惠券列表
	 *
	 *
	 * */
	@RequestMapping(value = "/getCouponList",method = RequestMethod.GET)
	@ResponseBody
	public E getCouponList(@RequestParam String token,String coupon_name) {
		logger.info("进入CouponsController-getCouponList,获取优惠券列表");
		FormMap formMap=new FormMap();
		E result = new E();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			result.put("couponList",null);
			return result;
		}
		formMap.put("coupon_name",coupon_name);
		List<E> list = couponService.selectList(formMap);
		result.put("couponList",list);
		//绑定上一次参数
		return result;
	}


	/**
	 * 微页面  优惠券展示   不展示是否领取  过滤失效优惠券
	 * @author lhq
	 * @date 2018年5月10日
	 * */

	@RequestMapping(value = "/couponListByIds",method = RequestMethod.GET)
	@ResponseBody
	public String couponListByIds(@RequestParam String token,String coupon_ids,Integer couponType){
		logger.info("ActivityController-couponListByIds，微页面  优惠券展示");
		FormMap formMap = new FormMap();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			return "";
		}
		formMap.put("couponType",couponType);
		if (!StringUtils.isEmpty(coupon_ids) && couponType==0){
			formMap.put("coupon_ids", StringUtils.strip(coupon_ids, "[]").split(","));
		}
		formMap.put("end_time",new Date());
		List<E> list = couponService.couponListByIds(formMap);
		return toJsonAPI(list);
	}
	
}