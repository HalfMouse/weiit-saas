package com.weiit.web.admin.ump.controller;


import com.github.binarywang.wxpay.bean.order.WxPayNativeOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.github.pagehelper.PageHelper;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.web.admin.login.service.LoginService;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.ump.service.BargainService;
import com.weiit.web.admin.ump.service.GrouponService;
import com.weiit.web.admin.ump.service.UmpService;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixin.util.XMLUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 设计页面
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/ump")
public class UmpController extends AdminController {
	
	public static Logger logger= Logger.getLogger(UmpController.class);
	
	@Resource
	private UmpService umpService;
	
	@Resource
	private BargainService bargainService;

	@Resource
	private GrouponService grouponService;
	
	@Resource
	private LoginService loginService;
	
	@Resource
	private WeixinOpenService wxOpenService;
	@Resource
	private ParameterService parameterService;

	@Resource
	RedisUtil redisUtil;
	
	@RequestMapping("/dashboard")
    public UIview dashboard() {
    	logger.info("进入 UmpController-dashboard,常规营销");
    	
    	FormMap formMap=new FormMap();
    	formMap.set("type", 1);
    	//1、查询所有的常规营销活动服务
    	List<E> allSeviceList=umpService.selectServiceList(formMap);
    	
    	//获得所有商户的营销活动，登录的时候已经查询了所有的商户可用的服务编码(，每个服务编码即表示服务订购了)
    	List<E> merchantSeviceList=(List<E>)this.getSession().getAttribute("merchantServiceNumList");
    	
    	//对比编号是否有权限，有权限的标明,筛选规则：所有的服务先认为是没有权限，一旦发现商户的权限集合里面存在，则标明有权限
    	for (E allService : allSeviceList) {
    		allService.set("is_auth", "-1");//先把服务设置为没有权限
    		
			for (E merchantService : merchantSeviceList) {
				if(allService.getStr("service_num").equals(merchantService.getStr("service_num"))){//如果商户有该服务编号的权限
					allService.set("is_auth", "1");//设置有权限;
					break;
				}
			}
		}
    	
    	UIview result=UIView("/center/ump/dashboard",false);
    	result.addObject("allServiceList", allSeviceList);
    	return result;
    }
	
	@RequestMapping("/scene")
    public UIview scene() {
    	logger.info("进入 UmpController-scene,场景营销");
    	
    	FormMap formMap=new FormMap();
    	formMap.set("type",2);
    	//1、查询所有的常规营销活动服务
    	List<E> allSeviceList=umpService.selectServiceList(formMap);
    	
    	//获得所有商户的营销活动，登录的时候已经查询了所有的商户可用的服务编码(，每个服务编码即表示服务订购了)
    	List<E> merchantSeviceList=(List<E>)this.getSession().getAttribute("merchantServiceNumList");
    	
    	//对比编号是否有权限，有权限的标明,筛选规则：所有的服务先认为是没有权限，一旦发现商户的权限集合里面存在，则标明有权限
    	for (E allService : allSeviceList) {
    		allService.set("is_auth", "-1");//先把服务设置为没有权限
    		
			for (E merchantService : merchantSeviceList) {
				if(allService.getStr("service_num").equals(merchantService.getStr("service_num"))){//如果商户有该服务编号的权限
					allService.set("is_auth", "1");//设置有权限;
					break;
				}
			}
		}
    	UIview result=UIView("/center/ump/scene",false);
    	result.addObject("allServiceList", allSeviceList);
    	return result;
    }

    /**
	 * 营销入口设置
	 *
	 * */
	@RequestMapping("/enterPoint")
    public UIview enterPoint() {
    	logger.info("进入 UmpController-enterPoint,入口设置");
		//获取请求参数
		FormMap formMap = getFormMap();
		formMap.put("item_code", "YINGXIAO");
		UIview result=UIView("/center/ump/enterPoint",false);
		List<E> list=parameterService.selectList(formMap);
		for (E info : list) {
			formMap.set(info.getStr("item_name"), info.get("state"));
			formMap.set(info.getStr("item_name")+"_ITEM", info.get("item_value"));
			formMap.set(info.getStr("item_name")+"_ID", info.get("id"));
		}
		result.addObject("queryParam", formMap);
    	return result;
    }


	/**
	 * 积分设置 保存
	 */
	@RequestMapping("/enterSave")
	public UIview enterSave() {
		logger.info("进入 IntegralController-enterSave,入口设置 保存");
		FormMap formMap = getFormMap();
		UIview result=UIView("enterPoint",true);

		List<FormMap> list=new ArrayList<FormMap>();

		FormMap grouponInfo = new FormMap();
		grouponInfo.put("validate_id", formMap.get("GROUPON_ID"));
		grouponInfo.put("item_value", formMap.get("GROUPON_ITEM"));
		grouponInfo.put("state", formMap.get("GROUPON"));
		grouponInfo.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("GROUPON_ID").equals("")){
			grouponInfo.put("item_code", "YINGXIAO");
			grouponInfo.put("item_name", "GROUPON");
			grouponInfo.put("item_desc", "我的拼团");
		}
		FormMap bargainInfo = new FormMap();
		bargainInfo.put("validate_id", formMap.get("BARGAIN_ID"));
		bargainInfo.put("item_value", formMap.get("BARGAIN_ITEM"));
		bargainInfo.put("state", formMap.get("BARGAIN"));
		bargainInfo.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("BARGAIN_ID").equals("")){
			bargainInfo.put("item_code", "YINGXIAO");
			bargainInfo.put("item_name", "BARGAIN");
			bargainInfo.put("item_desc", "我的砍价");
		}

		list.add(grouponInfo);
		list.add(bargainInfo);
		parameterService.editBatch(list);
		result.addPNotifyMessage("设置操作成功！");
		return result;
	}

	@RequestMapping("/serviceDetail")
    public UIview serviceDetail() {
    	logger.info("进入 UmpController-serviceDetail,服务详情");
    	
    	FormMap formMap = getFormMap();
    	//查询订购时长
    	List<E> orderTimeList=umpService.selectOrderTimeList(null);
    	//查询服务详情
    	E serviceDetail=umpService.selectServiceByServiceNum(formMap);
    	
    	UIview result=UIView("/center/ump/serviceDetail",false);
    	result.addObject("orderTimeList", orderTimeList);
    	result.addObject("serviceDetail", serviceDetail);
    	
    	return result;
    }
	
	
	/**
	 * 创建付款二维码，并保持订单信息到redis中
	 * @return
	 * @throws WxPayException
     * @throws ParseException 
	 */
	@RequestMapping("/servicePay")
	public UIview servicePay() throws WxPayException, ParseException {
		logger.info("进入 UmpController-servicePay,商户订购系统版本服务");
		
		UIview result= UIView("/center/ump/servicePay",false);
		E merchant=(E)this.getSession().getAttribute("merchant");
		
		FormMap formMap = getFormMap();
		
		E serviceInfo=loginService.selectServiceByServiceNum(formMap);
		
		E orderTimeInfo=loginService.selectOrderTimeConfigByName(formMap);
		
		double pay_price=0.00;
		double total_price=0.00;//不优惠的价格
		if(serviceInfo!=null&&orderTimeInfo!=null){
			pay_price=(serviceInfo.getDouble("service_price")*orderTimeInfo.getInt("day")/366)*orderTimeInfo.getDouble("order_time_discount")/10;//按照供应价x(每个订购时长对应的天数数/366)
			total_price=(serviceInfo.getDouble("service_price")*orderTimeInfo.getInt("day")/366);
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:ss:mm");
	 		String begin_time=null;
	 		String expire_time=null;
	 		String create_time=null;
	 		formMap.set("mrch_id", merchant.getStr("mrch_id"));
	 		E merchantService=loginService.selectMerchantServiceByServiceNum(formMap);
	 		if(merchantService==null){//如果是首次付费
	 			begin_time=sf.format(new Date());
	 			
	 			Calendar c = Calendar.getInstance();
		 		c.add(Calendar.DAY_OF_MONTH, orderTimeInfo.getInt("day"));//加多少天
	 			expire_time=sf.format(c.getTime());
	 		}else{
	 			
	 			begin_time=sf.format(new SimpleDateFormat("yyyy-MM-dd hh:ss:mm").parse(merchantService.getStr("create_time")).getTime());
	 			
	 			Date date = new SimpleDateFormat("yyyy-MM-dd hh:ss:mm").parse(merchantService.getStr("expire_time"));//把原来的日期先格式化
	 			Calendar c = Calendar.getInstance();
	 	 		c.setTime(date);
	 	 		c.add(Calendar.DAY_OF_MONTH, orderTimeInfo.getInt("day"));//原来的日期上面加x天，表示续费了
	 	 		expire_time=sf.format(c.getTime());
	 		}
	 		create_time=sf.format(new Date());
			String out_trade_no="ZX"+System.currentTimeMillis();//订单编号
	    	String product_id=out_trade_no;//商品id=订单编号
	    	String body="开通“"+serviceInfo.getStr("service_name")+"”服务,服务费用:"+pay_price+"元.";
	    	String trade_type="NATIVE";
	    	String spbill_create_ip="127.0.0.1";
	    	String notifyUrl="http://merchant.wstore.me/center/ump/servicePayFinish";
	    	WxPayUnifiedOrderRequest payInfo = WxPayUnifiedOrderRequest.newBuilder()
					.outTradeNo(out_trade_no+"")
					.totalFee((int)(pay_price*100))
					.body(body)
					.productId(product_id)
					.tradeType(trade_type)
					.spbillCreateIp(spbill_create_ip)
					.notifyUrl(notifyUrl)
					.build();
	    	
	    	 WxPayNativeOrderResult orderResult= wxOpenService.getMyWeixinPay().createOrder(payInfo);
	    	 //扫描支付链接
	    	 this.logger.info("扫描支付链接:"+orderResult.getCodeUrl());
	    	 WeiitQrCodeUtil qrCodeUtil=new WeiitQrCodeUtil();
	     	 String weixin_qr_code =qrCodeUtil.createQRCodeAndUploadQcloud(orderResult.getCodeUrl());
	     	 
	     	 //将订单付款信息存储到redis中，缓存2个小时,2个小时不付款，就自动销毁
	     	 FormMap payOrderInfo=new FormMap();
	     	 payOrderInfo.set("out_trade_no", out_trade_no);
	     	 payOrderInfo.set("pay_price", pay_price);
	     	 payOrderInfo.set("total_price",total_price);
	     	 payOrderInfo.set("body", body);
	     	 payOrderInfo.set("weixin_qr_code", weixin_qr_code);
	     	 payOrderInfo.set("mrch_id",merchant.getStr("mrch_id"));
	     	 payOrderInfo.set("expire_time", expire_time);
	     	 payOrderInfo.set("begin_time", begin_time);
	     	 payOrderInfo.set("create_time", create_time);
	     	 payOrderInfo.set("service_num", serviceInfo.getStr("service_num"));
	     	 payOrderInfo.set("product_name", serviceInfo.getStr("service_name"));
	     	 payOrderInfo.set("account",merchant.getStr("account"));
	     	 payOrderInfo.set("state", 0);
	     	 boolean flag=redisUtil.set(out_trade_no+"", payOrderInfo,7200);//设置消耗时间，让其自动销毁
	     	 if(flag){
	     		 result.addObject("payOrderInfo", payOrderInfo);
	     	 }
	     	 return result;
		}else{
			result.addObject("error", "生成微信支付二维码异常,请联系客服人员热线:0755-36953215");
    		return result;
		}
		
		
	}
	
	/**
	 * 付款完成后回调，要求：1修改商户的版本信息，以及他的版本的到期时间。2 通知其已缴费成功。3、记录其缴费记录.4、通知公司运营中心注意此事
	 * @param request
	 * @param response
	 * @return
	 * @throws WxPayException
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping("/servicePayFinish")
	public void versionPayFinish(HttpServletRequest request,HttpServletResponse response) throws WxPayException, IOException {
		logger.info("进入 UmpController-servicePayFinish,微信二维码支付成功回调");
		
	   	try {
	            synchronized (this) {
	                Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
	                
	                //获得原订单编号
                	String out_trade_no=kvm.get("out_trade_no");
                	
                	FormMap payOrderInfo=(FormMap)redisUtil.get(out_trade_no);
                	if(payOrderInfo!=null&&payOrderInfo.getInt("state")!=1){
                		if (kvm.get("result_code").equals("SUCCESS")) {
                			
    	                	this.logger.info("out_trade_no: " + kvm.get("out_trade_no") + " pay SUCCESS!");
    	                	
    	                
    	                	loginService.payFinishServiceTrans(payOrderInfo);
    	                	
    	                	//付款记录后，刷新redis缓存的订单信息，改为已经付款成功.
    	                	payOrderInfo.set("state", 1);
    	                	redisUtil.set(out_trade_no, payOrderInfo);
    	                	
    	                	response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");

    	                	
    	                } else {
    	                    this.logger.error("out_trade_no: " + kvm.get("out_trade_no") + " result_code is FAIL");
    	                  //付款记录后，刷新redis缓存的订单信息，改为已经付款失败.
    	                	payOrderInfo.set("state", -1);
    	                	redisUtil.set(out_trade_no, payOrderInfo);
    	                    response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
    	                }
                	}else{
                		this.logger.error("out_trade_no: " + kvm.get("out_trade_no") + " result_code is FAIL");
                		//付款记录后，刷新redis缓存的订单信息，改为已经付款.
 	                	payOrderInfo.set("state", -1);
 	                	redisUtil.set(out_trade_no, payOrderInfo);
 	                    response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
                	}
	                
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            this.logger.error("notifyCart is fail ,result_code is FAIL");
	            
	            response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
	    }
	}
	
	/**
	 * 检查是否付款成功,state=1表示订单成功
	 * @param request
	 * @param response
	 * @throws WxPayException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping("/servicePayCheck")
	public String balanceRechargeCheck(HttpServletRequest request,HttpServletResponse response) throws WxPayException, IOException {
		logger.info("进入 UmpController-servicePayCheck,检查服务是否付费成功");
		FormMap formMap=getFormMap();
		FormMap payOrderInfo=(FormMap)redisUtil.get(formMap.getStr("out_trade_no"));
		if(payOrderInfo!=null){
			return toJsonAPI(payOrderInfo,"","0");
		}else{
			return toJsonAPI("","","1000");
		}
		
	}
	
	@RequestMapping("/spread")
    public UIview spread() {
    	logger.info("进入 UmpController-spread,我要推广");
    	
    	UIview result=UIView("/center/ump/spread",false);
    	return result;
    }


	/**
	 *
	 * 活动产品列表
	 * @author lhq
	 * @date 2018年5月7日
	 * */
	@RequestMapping(value = "/activityProductList",method = RequestMethod.GET)
	@ResponseBody
	public E activityProductList(@RequestParam String token,Integer page ,Integer rows,Integer activityType) {
		logger.info("进入ProductGroupController-activityProductList,活动产品列表");
		FormMap formMap=new FormMap();
		E result = new E();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			result.put("activityProductList",null);
			return result;
		}
		formMap.put("page", page);
		formMap.put("rows", rows);
		PageHelper.startPage(formMap.getPage(),formMap.getRows());
		List<E> list;
		//砍价商品
		if (activityType==1){
			list=bargainService.selectList(formMap);
		}
		//拼团商品
		else {
			list= grouponService.selectProductList(formMap);
		}
		result.put("activityProductList",list);
		//绑定上一次参数
		return result;
	}
    
}