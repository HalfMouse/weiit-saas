package com.weiit.web.weixinopen.controller;


import com.github.binarywang.wxpay.bean.order.WxPayNativeOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixin.util.XMLUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;


@RestController
@RequestMapping("/weixinopen/pay")
public class WeixinPayController extends AdminController{

	public static final String ADMINDOMAIN="http://partner.wstore.me";
    @Resource
    private WeixinOpenService wxOpenService;
    
    /**
     * 模式二微信扫描支付,得到二维码的内容，将内容生成为二维码即可
     * @throws WxPayException
     * @throws IOException
     */
    @ResponseBody
   	@RequestMapping(value = "/scanPayQrcode")
   	public String scanPay() throws WxPayException, IOException {
    	
    	long out_trade_no=System.currentTimeMillis();
    	String product_id=System.currentTimeMillis()+"";
    	int total_free=1;
    	String body="test";
    	String trade_type="NATIVE";
    	String spbill_create_ip="127.0.0.1";
    	String notifyUrl=ADMINDOMAIN+"/weixinopen/pay/scanPayFinish";
    	WxPayUnifiedOrderRequest payInfo = WxPayUnifiedOrderRequest.newBuilder()
				.outTradeNo(out_trade_no+"")
				.totalFee(total_free)
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
    	 return toJsonAPI(weixin_qr_code);
	        
	           
   	}
    
    
    @ResponseBody
   	@RequestMapping(value = "/scanPayFinish")
   	public void scanPayFinish(HttpServletRequest request,HttpServletResponse response) throws IOException {
    	System.out.println(getFormMap());
    	 try {
             synchronized (this) {
                 Map<String, String> kvm = XMLUtil.parseRequestXmlToMap(request);
                 if (kvm.get("result_code").equals("SUCCESS")) {

                	 this.logger.info("out_trade_no: " + kvm.get("out_trade_no") + " pay SUCCESS!");
                     response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[ok]]></return_msg></xml>");

                 } else {
                     this.logger.error("out_trade_no: " + kvm.get("out_trade_no") + " result_code is FAIL");
                     response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
                 }
             }
         } catch (Exception e) {
             e.printStackTrace();
             this.logger.error("notifyCart is fail ,result_code is FAIL");
             response.getWriter().write("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[result_code is FAIL]]></return_msg></xml>");
         }
   	}
    
}
