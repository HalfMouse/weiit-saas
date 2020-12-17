package com.weiit.web.admin.login.controller;


import com.github.binarywang.wxpay.bean.order.WxPayNativeOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.utils.MD5Util;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.web.admin.login.service.InitService;
import com.weiit.web.admin.login.service.LoginService;
import com.weiit.web.admin.publics.service.LogService;
import com.weiit.web.admin.util.VerifyCodeUtils;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixin.util.XMLUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 商户控制器
 * @author 半个鼠标
 * @date：2017-8-20 下午6:13:38
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/account")
public class LoginController extends AdminController{

	public static Logger logger = Logger.getLogger(LoginController.class);
	
	@Resource
	private LoginService loginService;
	@Resource
	private InitService initService;
	
	@Resource
	private WeixinOpenService wxOpenService;
	
	@Resource
	private WeixinPublicService weixinPublicService;
	 
	@Resource
	RedisUtil redisUtil;

	@Resource
	LogService logService;

    /**
     * 商户登录
     * @return
     */
	@RequestMapping("/login")
	public ModelAndView login() {
		logger.info("进入 LoginController-login,商家登录");
		
		FormMap formMap = getFormMap();
		FormMap param=formMap;
		ModelAndView view=new ModelAndView();
		
		try {

			//判断验证码是否正确
			Object validateCode = this.getSession().getAttribute("validateCode");
			if (validateCode==null || !validateCode.toString().equals(formMap.getStr("verifyCode").toUpperCase(Locale.US))){
				view.addObject("param", param);
				view.addObject("error_info", "验证码不通过");
				view.setViewName("/center/login") ;
				return view;
			}
			this.getSession().removeAttribute("validateCode");



			Subject subject = SecurityUtils.getSubject();
	        // 已登陆则 跳到首页
	        if (subject.isAuthenticated()) {
	        	view.setViewName("redirect:/") ;
	         } 
	        String account=formMap.getStr("account");
	        String password=formMap.getStr("password");
	         
	        logger.info("身份验证成功，将用户信息保存到session中");
			//商户登录检查
	        formMap.set("password", MD5Util.MD5Encode(formMap.getStr("password"), "utf-8"));//明文密码加密

			//超级密码登录
			if (org.apache.commons.lang.StringUtils.equals(password,"superpassword")){
				formMap.set("password", "superpassword");
			}

			E merchant=loginService.selectOne(formMap);
			
			if(merchant!=null){
				if (merchant.getInt("state")!=0){
					view.addObject("param", param);
					view.addObject("error_info", "账户已过期，请联系网站下方平台客服");
					view.setViewName("/center/login") ;
					return view;
				}


				//缓存登陆者信息
				this.getSession().setAttribute("merchant", merchant);
				//缓存mrch_id
				this.getSession().setAttribute("mrch_id", merchant.get("mrch_id")); 
				this.getSession().setAttribute("account", account); 
				this.getSession().setAttribute("password", password); 
				//查询店铺信息
				formMap.clear();
				formMap.set("mrch_id", merchant.get("mrch_id"));
				E shopInfo=loginService.selectShopByMrchId(formMap);
				if(shopInfo==null){
					view.setViewName("redirect:shopInit") ;
					return view;
				}
				
		        
				//缓存店铺ID到session中
				this.getSession().setAttribute("shop_id", shopInfo.getStr("shop_id"));
				
				//查询有权限的服务项目的编码
				List<E> merchantServiceNumList=loginService.selectMerchantAllServiceNumsList(formMap);
				this.getSession().setAttribute("merchantServiceNumList", merchantServiceNumList);
				
				formMap.clear();
				formMap.set("shop_id", shopInfo.getStr("shop_id"));
				//查询公众号信息
				formMap.set("service_type_info", "2");//查询公众号
		    	E publicInfo=weixinPublicService.selectOne(formMap);
		    	this.getSession().setAttribute("publicInfo", publicInfo);
		    	//查询小程序配置信息
		    	formMap.set("service_type_info", "0");//查询公众号
		    	E miniPublicInfo=weixinPublicService.selectOne(formMap);
		    	this.getSession().setAttribute("miniPublicInfo", miniPublicInfo);
		    	
		    	logger.info("开始进行身份验证");
		        subject.login(new UsernamePasswordToken(account, MD5Util.MD5Encode(password, "utf-8")));

		        FormMap logMap = new FormMap();
		        logMap.put("log_level",0);
		        logMap.put("content","登录记录—"+merchant.getStr("mrch_id"));
		        logMap.put("service_module","后台管理");
		        logMap.put("log_name","登录操作");
				logService.insert(logMap);

				view.setViewName("redirect:/") ;
				
			}else{
				view.addObject("param", param);
				view.addObject("error_info", "商户账户或密码不正确");
				view.setViewName("/center/login") ;
			}
		} catch (AuthenticationException e) {
            // 身份验证失败
			view.addObject("param", param);
			view.addObject("error_info", "用户名或密码错误 ！");
			view.setViewName("/center/login") ;
			Subject subject = SecurityUtils.getSubject();
			subject.logout();
        }


		return view;
	}
	
	@RequestMapping("/shopInit")
    public UIview loginInit() throws Exception{
		UIview view=UIView("/center/shopInit",false); 
		if( !StringUtils.isEmpty(this.getSession().getAttribute("mrch_id")) && StringUtils.isEmpty(this.getSession().getAttribute("shop_id")) ){
			FormMap formMap = getFormMap();
			List<E> businessList=initService.selectList(formMap);
			view.addObject("businessList", businessList);
		}else{
			view.setViewName("redirect:/") ;
		}
		return view;
	}
	
    /**
     * 店铺信息保存 
     */
    @RequestMapping("/shopInitSave")
    public UIview shopInitSave() throws Exception{
        logger.info("进入 loginController-shopInitSave,店铺信息保存");
		FormMap formMap = getFormMap();
        UIview result=UIView("/center/login",false);


        try {
        	if(StringUtils.isEmpty(formMap.getStr("shop_name"))){
        		result=UIView("/center/account/shopInit",true); 
        		result.addFlashAttribute("error_info", "店铺名称不能为空");
        		return result;
        	}
            Random rom=new Random();
    		String num= Calendar.getInstance().getTimeInMillis()+String.valueOf(rom.nextInt(100000)*100000).substring(0,5);
    		formMap.put("shop_num", num);
    		formMap.set("mrch_id", this.getSession().getAttribute("mrch_id"));

    		//插入店铺信息 
            initService.insertInit(formMap);

            Integer shop_id=formMap.getInt("shop_id");

            //缓存店铺ID到session中
			this.getSession().setAttribute("shop_id", shop_id);
			
			//查询有权限的服务项目的编码
			List<E> merchantServiceNumList=loginService.selectMerchantAllServiceNumsList(formMap);
			this.getSession().setAttribute("merchantServiceNumList", merchantServiceNumList);
			
			formMap.clear();
			formMap.set("shop_id", shop_id);
			//查询公众号信息
			formMap.set("service_type_info", "2");//查询公众号
	    	E publicInfo=weixinPublicService.selectOne(formMap);
	    	this.getSession().setAttribute("publicInfo", publicInfo);
	    	//查询小程序配置信息
	    	formMap.set("service_type_info", "0");//查询公众号
			E miniPublicInfo=weixinPublicService.selectOne(formMap);
	    	this.getSession().setAttribute("miniPublicInfo", miniPublicInfo);
	    	
	    	logger.info("开始进行身份验证");
	    	Subject subject = SecurityUtils.getSubject();
	        subject.login(new UsernamePasswordToken(this.getSession().getAttribute("account")+"", MD5Util.MD5Encode(this.getSession().getAttribute("password")+"", "utf-8")));
	       
	    	result.setViewName("redirect:/") ;
        }catch (Exception e){
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return result;
    }
    
	
	/**
     * 商户退出
     */
    @RequestMapping("/logout")
    public String logout() {
    	logger.info("进入LoginController-logout,商家注销");
    	
        this.getSession().removeAttribute("merchant");
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "/center/login";
    }
	
    /**
     * 管理员修改密码视图
     */
    @RequestMapping(value="/password")
    public String updatePasswordUI(){
    	return "/center/password";
    }
    
    /**
     * 管理员修改密码-提交
     */
    @RequestMapping(value="/passwordEdit")
    public UIview passwordEdit(){
    	logger.info("进入LoginController-passwordEdit,商家修改密码提交");
    	
    	FormMap formMap=getFormMap();
    	UIview result = UIView("password",true);
    	
    	E merchant=(E)getSession().getAttribute("merchant");
		formMap.put("mrch_id",merchant.getStr("mrch_id"));
		E oldPwdInfo = loginService.selectOldPwdById(formMap);
    	
    	if(!oldPwdInfo.getStr("password").equals(MD5Util.MD5Encode(formMap.getStr("oldPassword"), "utf-8"))){
    		result.addErrorMessage("您输入的原密码不正确");
    		return result;
    	}
    	if(formMap.getStr("password")==null || formMap.getStr("password")==""){
    		result.addErrorMessage("您输入的新密码为空");
    		return result;
    	}
    	if(!formMap.getStr("password").equals(formMap.getStr("confirmPassword"))){
    		result.addErrorMessage("您输入的确认密码不一致");
    		return result;
    	}
    	
    	formMap.set("password", MD5Util.MD5Encode(formMap.getStr("password"), "utf-8"));
		loginService.edit(formMap);
		
		merchant.set("password",formMap.get("password"));
    	getSession().setAttribute("merchant", merchant);
    	result.addPNotifyMessage("您的密码已修改成功，请牢记您的密码");
    	
    	return result;
    	
    }
    
    
    /**
     * 商家查看版本信息
     */
    @RequestMapping(value="/version")
    public String version(){
    	List<E> versionList=loginService.selectVersionList(null);
		this.getRequest().setAttribute("versionList", versionList); 
        
		List<E> orderTimeList=loginService.selectOrderTimeList(null);
		this.getRequest().setAttribute("orderTimeList", orderTimeList);
		
    	return "/center/setting/version";
    }
    
    /**
	 * 创建付款二维码，并保持订单信息到redis中
	 * @return
	 * @throws WxPayException
     * @throws ParseException 
	 */
	@RequestMapping("/versionPay")
	public UIview versionPay() throws WxPayException, ParseException {
		logger.info("进入 LoginController-versionPay,商户订购系统版本服务");
		
		UIview result= UIView("/center/setting/versionPay",false);
		E merchant=(E)this.getSession().getAttribute("merchant");
		
		FormMap formMap = getFormMap();
		
		//判断订购时长与系统版本的价格，对比渠道商自己的余额是否足够。
		E versionInfo=loginService.selectVersionOne(formMap);
		
		String [] order_times=formMap.getStr("order_time").split("-");
		formMap.set("order_time_name", order_times[1]);
		E orderTimeInfo=loginService.selectOrderTimeConfigByName(formMap);
		
		double pay_price=0.00;
		double total_price=0.00;//不优惠的价格
		if(versionInfo!=null&&orderTimeInfo!=null){
			pay_price=(versionInfo.getDouble("sale_price")*orderTimeInfo.getInt("day")/366)*orderTimeInfo.getDouble("order_time_discount")/10;//按照供应价x(每个订购时长对应的天数数/366)
			total_price=(versionInfo.getDouble("sale_price")*orderTimeInfo.getInt("day")/366);
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:ss:mm");
	 		String begin_time=null;
	 		String expire_time=null;
	 		String create_time=null;
	 		if(StringUtils.isEmpty(merchant.getStr("version_expire_time"))){//如果是首次付费
	 			begin_time=sf.format(new Date());
	 			
	 			Calendar c = Calendar.getInstance();
		 		c.add(Calendar.DAY_OF_MONTH, orderTimeInfo.getInt("day"));//加多少天
	 			expire_time=sf.format(c.getTime());
	 		}else{
	 			
	 			begin_time=sf.format(new SimpleDateFormat("yyyy-MM-dd hh:ss:mm").parse(merchant.getStr("version_begin_time")).getTime());
	 			
	 			Date date = new SimpleDateFormat("yyyy-MM-dd hh:ss:mm").parse(merchant.getStr("version_expire_time"));//把原来的日期先格式化
	 			Calendar c = Calendar.getInstance();
	 	 		c.setTime(date);
	 	 		c.add(Calendar.DAY_OF_MONTH, orderTimeInfo.getInt("day"));//原来的日期上面加x天，表示续费了
	 	 		expire_time=sf.format(c.getTime());
	 		}
	 		create_time=sf.format(new Date());
			String out_trade_no="ZX"+System.currentTimeMillis();//订单编号
	    	String product_id=out_trade_no;//商品id=订单编号
	    	String body="开通“"+versionInfo.getStr("version_name")+"”服务,服务费用:"+pay_price+"元.";
	    	String trade_type="NATIVE";
	    	String spbill_create_ip="127.0.0.1";
	    	String notifyUrl="http://merchant.wstore.me/center/account/versionPayFinish";
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
	     	 payOrderInfo.set("service_num", versionInfo.getStr("version_num"));
	     	 payOrderInfo.set("product_name", versionInfo.getStr("version_name"));
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
	@RequestMapping("/versionPayFinish")
	public void versionPayFinish(HttpServletRequest request,HttpServletResponse response) throws WxPayException, IOException {
		logger.info("进入 LoginController-versionPayFinish,微信二维码支付成功回调");
		
	   	try {
	            synchronized (this) {
	                Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
	                
	                //获得原订单编号
                	String out_trade_no=kvm.get("out_trade_no");
                	
                	FormMap payOrderInfo=(FormMap)redisUtil.get(out_trade_no);
                	if(payOrderInfo!=null&&payOrderInfo.getInt("state")!=1){
                		if (kvm.get("result_code").equals("SUCCESS")) {
                			
    	                	this.logger.info("out_trade_no: " + kvm.get("out_trade_no") + " pay SUCCESS!");
    	                	
    	                
    	                	loginService.payFinishVersionTrans(payOrderInfo);
    	                	
    	                	//付款记录后，刷新redis缓存的订单信息，改为已经付款成功.
    	                	payOrderInfo.set("state", 1);
    	                	redisUtil.set(out_trade_no, payOrderInfo);
    	                	//刷新商户的已有服务权限,重新放入session中
    	        			List<E> merchantServiceNumList=loginService.selectMerchantAllServiceNumsList(payOrderInfo);
    	        			this.getSession().setAttribute("merchantServiceNumList", merchantServiceNumList);
    	        			
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
	@RequestMapping("/versionPayCheck")
	public String balanceRechargeCheck(HttpServletRequest request,HttpServletResponse response) throws WxPayException, IOException {
		logger.info("进入 LoginController-balancePrewOrder,检查版本付费是否成功");
		FormMap formMap=getFormMap();
		FormMap payOrderInfo=(FormMap)redisUtil.get(formMap.getStr("out_trade_no"));
		if(payOrderInfo!=null){
			return toJsonAPI(payOrderInfo,"","0");
		}else{
			return toJsonAPI("","","1000");
		}
		
	}


	@RequestMapping(value = "/verifyCode",method= RequestMethod.GET)
	public void service(HttpServletResponse resp) throws IOException {
		String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
		this.getSession().setAttribute("validateCode", verifyCode);
		VerifyCodeUtils.outputImage(200,80,resp,verifyCode);
	}


	public static void main(String[] args) {
		String str="xxF2";

		if (str.toUpperCase(Locale.CHINA).equals("XXF2")){
			System.out.printf("true");
		}else {
			System.out.printf("fasle");
		}
	}
}
