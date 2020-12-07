package com.weiit.web.admin.login.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.binarywang.wxpay.bean.order.WxPayNativeOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.ShopService;
import com.weiit.web.admin.login.service.LoginService;
import com.weiit.web.admin.system.controller.LoginController;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;
import com.weiit.web.weixin.util.XMLUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;

/**
 * 
 * @author 半个鼠标
 * @date：2017-8-20 下午6:13:38
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/manager")
public class LoginImplController extends AdminController{

	public static Logger logger = Logger.getLogger(LoginImplController.class);
	
	@Resource
	private LoginService loginService;
	
	@Resource
	private LoginController loginController;
	
	@Resource
	private ShopService shopService;
	
	@Resource
	private WeixinOpenService wxOpenService;
	 
	@Resource
	RedisUtil redisUtil;
	
	
	@RequestMapping("/partnerLogin")
	public ModelAndView f2blogin() {
		logger.info("进入 LoginImplController-login,管理员登录");
		
		ModelAndView result= loginController.login();
		E authUserInfo=getSessionLoginUser();
		if(authUserInfo!=null){
			logger.info("开始查询管理员账号的shopid和appid ");
			
	        FormMap seachMap=new FormMap();
	        seachMap.set("manager_id",authUserInfo.getInt("manager_id"));
	        seachMap.set("parent_id",authUserInfo.getInt("manager_id"));
			E shopidAndAppid= loginService.getManagerShopIdAndAppId(seachMap);
			
		    logger.info("将shop_id 和app_id保存到session中,"+toJson(shopidAndAppid));
		    //如果是商户登录，查询店铺信息，方便后端页面上判断是否可用
		    if(shopidAndAppid!=null&&shopidAndAppid.getInt("shop_id")>0){
		    	seachMap.set("shop_id", shopidAndAppid.getInt("shop_id"));
		    	E shopInfo=loginService.selectShopInfo(seachMap);
		    	getSession().setAttribute("shopInfo",shopInfo);
		    }
		    getSession().setAttribute("role_sign",shopidAndAppid.getStr("role_sign"));
		    getSession().setAttribute("manager_id",authUserInfo.getInt("manager_id"));
		    getSession().setAttribute("app_id",shopidAndAppid.getInt("app_id"));
		    
		    //新增业务开始
		    //登录成功查询管理员最后剩余余额 
		    double last_balance=0.00;
		    E balanceInfo=loginService.selectSystemManagerLastBalance(seachMap);
		    if(balanceInfo!=null){
		    	last_balance=balanceInfo.getDouble("last_balance");
		    }
		    getSession().setAttribute("last_balance", last_balance);
		    //新增业务结束
		    
		    this.getRequest().setAttribute("logsMessage", "系统管理-:-登录操作-:-账号:"+authUserInfo.getStr("account_name")+"登陆成功");
		}else{
			
			this.getRequest().setAttribute("logsError", "系统管理-:-登录操作-:-账号:"+this.getRequest().getParameter("account_name")+"登陆失败");
		}
		return result;
	}
	
	/**
	 * 渠道商余额收支明细
	 * @return
	 */
	@RequestMapping("/balanceLog")
	public ModelAndView balanceLog() {
		logger.info("进入 LoginImplController-balanceLog,渠道商收支明细");
		
		ModelAndView result= new ModelAndView();
		result.setViewName("/center/system/balanceLog");
		
		FormMap formMap = getFormMap();
		List<E> balanceList=loginService.selectSystemManagerBalanceList(formMap);
		result.addObject("balanceList", balanceList);
		
		result.addObject("queryParam", formMap);
		return result;
	}
	
	/**
	 * 渠道商余额查询
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryBalance")
	public String queryBalance() {
		logger.info("进入 LoginImplController-queryBalance,渠道商总额查询");
		
		FormMap formMap = getFormMap();
		E info=loginService.selectSystemManagerLastBalanceByValidateId(formMap);
		if(info!=null){
			return toJsonAPI(info);
		}else{
			return toJsonAPI("","","1000");
		}
		
	}
	
	/**
	 * 管理员给渠道商预存
	 * @return
	 */
	@RequestMapping("/addBalance")
	public ModelAndView addBalance() {
		logger.info("进入 LoginImplController-addBalance,管理员给渠道商预存");
		
		ModelAndView result= new ModelAndView();
		result.setViewName("redirect:/center/system/manager/list") ;
		FormMap formMap = getFormMap();
		long num=System.currentTimeMillis();
		formMap.set("num", "YC"+num);
		E info=loginService.selectSystemManagerLastBalanceByValidateId(formMap);
		if(info!=null){
			formMap.set("last_balance", info.getDouble("last_balance")+formMap.getDouble("balance"));
		}else{
			formMap.set("last_balance", formMap.getDouble("balance"));
		}
		formMap.set("remark", "系统预存,预存金额"+formMap.getDouble("balance")+"元.");
		formMap.set("type", 1);
		formMap.set("state", 1);
		
		loginService.insertManagerBalance(formMap);
		return result;
	}
	
	/**
	 * 渠道商自己预存充值
	 * @return
	 */
	@RequestMapping("/balanceRecharge")
	public UIview balanceRecharge() {
		logger.info("进入 LoginImplController-balanceRecharge,渠道商预存充值");
		
		UIview result= UIView("/center/system/balanceRecharge",false);
		return result;
		
	}
	
	/**
	 * 创建付款二维码，并保持订单信息到redis中
	 * @return
	 * @throws WxPayException
	 */
	@RequestMapping("/balancePrewOrder")
	public UIview balancePrewOrder() throws WxPayException {
		logger.info("进入 LoginImplController-balancePrewOrder,渠道商订单提交");
		
		UIview result= UIView("/center/system/balancePrewOrder",false);
		
		FormMap formMap = getFormMap();
		
		int pay_price=0;//支付金额
		int give_price=0;//赠送金额
		if(formMap.getInt("package")==1){//3580充值，无赠送
			pay_price=3580;
			give_price=2300;
		}else if(formMap.getInt("package")==2){//5880充值，赠送5500
			pay_price=5880;
			give_price=5500;
		}else if(formMap.getInt("package")==3){//19800充值，赠送21000
			pay_price=19800;
			give_price=21000;
		}else{//发起支付时会失败
			pay_price=0;
			give_price=0;
		}
		
		String out_trade_no="ZX"+System.currentTimeMillis();//订单编号
    	String product_id=out_trade_no;//商品id=订单编号
    	String body="充值金额:"+pay_price+"元,赠送金额:"+give_price+"元.";
    	String trade_type="NATIVE";
    	String spbill_create_ip="127.0.0.1";
    	String notifyUrl="http://partner.wstore.me/center/manager/balanceRechargeFinish";
    	WxPayUnifiedOrderRequest payInfo = WxPayUnifiedOrderRequest.newBuilder()
				.outTradeNo(out_trade_no+"")
				.totalFee(pay_price*100)
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
     	 E payOrderInfo=new E();
     	 payOrderInfo.set("out_trade_no", out_trade_no);
     	 payOrderInfo.set("pay_price", pay_price);
     	 payOrderInfo.set("give_price", give_price);
     	 payOrderInfo.set("body", body);
     	 payOrderInfo.set("weixin_qr_code", weixin_qr_code);
     	 payOrderInfo.set("manager_id",formMap.getStr("manager_id"));
     	 payOrderInfo.set("state", 0);
     	 boolean flag=redisUtil.set(out_trade_no+"", payOrderInfo,7200);
     	 if(flag){
     		 result.addObject("payOrderInfo", payOrderInfo);
     	 }
		return result;
		
	}
	
	/**
	 * 付款完成后回调
	 * @param request
	 * @param response
	 * @return
	 * @throws WxPayException
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping("/balanceRechargeFinish")
	public void balanceRechargeFinish(HttpServletRequest request,HttpServletResponse response) throws WxPayException, IOException {
		logger.info("进入 LoginImplController-balancePrewOrder,渠道商订单提交");
		
		UIview result= UIView("/center/system/balanceRechargeFinish",false);
		
	   	try {
	            synchronized (this) {
	                Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
	                
	                //获得原订单编号
                	String out_trade_no=kvm.get("out_trade_no");
                	
                	E payOrderInfo=(E)redisUtil.get(out_trade_no);
                	if(payOrderInfo!=null&&payOrderInfo.getInt("state")!=1){
                		if (kvm.get("result_code").equals("SUCCESS")) {
                			
    	                	this.logger.info("out_trade_no: " + kvm.get("out_trade_no") + " pay SUCCESS!");
    	                	
    	                	FormMap param=new FormMap();
    	                	param.set("num", out_trade_no);
    	                	param.set("validate_id", payOrderInfo.getStr("manager_id"));
    	                	E info=loginService.selectSystemManagerLastBalanceByValidateId(param);
    	                	if(info!=null){
    	                		param.set("last_balance", info.getDouble("last_balance")+payOrderInfo.getDouble("pay_price"));
    	                	}else{
    	                		param.set("last_balance", payOrderInfo.getDouble("pay_price"));
    	                	}
    	                	param.set("balance", payOrderInfo.getDouble("pay_price"));
    	                	param.set("remark", payOrderInfo.getStr("body"));
    	                	param.set("type", 3);
    	                	param.set("state", 1);
    	                		
    	                	loginService.insertManagerBalance(param);
    	                	
    	                	//付款记录后，刷新redis缓存的订单信息，改为已经付款成功.
    	                	payOrderInfo.set("state", 1);
    	                	redisUtil.set(out_trade_no, payOrderInfo);
    	                	
    	                	//4、通知公司运营中心注意此事
    	                	FormMap canshu=new FormMap();
    	                	canshu.set("business_type", "2");//渠道在线通知运营人员为2
    	                	E notifyPhone=shopService.selectNotifyPhoneByBusinessType(canshu);
    	                			
    	                	String [] notifyMsg={"渠道商在线充值,充值金额:"+payOrderInfo.getDouble("pay_price")+"元,充值编号:"+out_trade_no};
    	                	WeiitUtil.sendMobileMessage(notifyPhone.getStr("notify_phone"), "147671", notifyMsg);//147671为自定义模板，模板内容[运营中心请注意：请相关工作人员跟进业务“{1}”，回T退订]
    	                	
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
	@RequestMapping("/balanceRechargeCheck")
	public String balanceRechargeCheck(HttpServletRequest request,HttpServletResponse response) throws WxPayException, IOException {
		logger.info("进入 LoginImplController-balancePrewOrder,渠道商订单提交");
		FormMap formMap=getFormMap();
		E payOrderInfo=(E)redisUtil.get(formMap.getStr("out_trade_no"));
		if(payOrderInfo!=null){
			if(payOrderInfo.getInt("state")==1){
				//刷新最后余额
    		    double last_balance=0.00;
    		    E balanceInfo=loginService.selectSystemManagerLastBalance(formMap);
    		    if(balanceInfo!=null){
    		    	last_balance=balanceInfo.getDouble("last_balance");
    		    }
    		    getSession().setAttribute("last_balance", last_balance);
			}
			return toJsonAPI(payOrderInfo,"","0");
		}else{
			return toJsonAPI("","","1000");
		}
		
	}
}
