package com.weiit.web.weixinopen.controller;


import java.io.IOException;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaMessage;
import cn.binarywang.wx.miniapp.bean.WxMaTemplateMessage;
import cn.binarywang.wx.miniapp.bean.template.WxMaTemplateLibraryGetResult;
import cn.binarywang.wx.miniapp.bean.template.WxMaTemplateLibraryListResult;
import cn.binarywang.wx.miniapp.bean.template.WxMaTemplateListResult;

import com.github.binarywang.wxpay.bean.notify.WxScanPayNotifyResult;
import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.github.binarywang.wxpay.bean.order.WxPayNativeOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.github.binarywang.wxpay.util.SignUtils;
import com.google.gson.Gson;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.web.admin.util.JsonUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.FrontController;
import com.weiit.web.weixin.util.XMLUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;

import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.bean.message.WxOpenXmlMessage;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


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

//    @ResponseBody
//   	@RequestMapping(value = "/findTemplateLibraryKeywordList")
//   	public List<WxMaTemplateLibraryGetResult.KeywordInfo> findTemplateLibraryKeywordList(String id)  {
//		try {
//			WxMaTemplateLibraryGetResult wxMaTemplateListResult =wxOpenService.getOpenConfig().getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca").getTemplateService().findTemplateLibraryKeywordList(id);
//
//			List<WxMaTemplateLibraryGetResult.KeywordInfo> list = wxMaTemplateListResult.getKeywordList();
//			for (WxMaTemplateLibraryGetResult.KeywordInfo keywordInfo :list){
//				System.out.println("ID:"+keywordInfo.getKeywordId());
//				System.out.println("名称"+keywordInfo.getName());
//				System.out.println("示例"+keywordInfo.getExample());
//			}
//			return list;
//		} catch (WxErrorException e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
//
//
//    @ResponseBody
//   	@RequestMapping(value = "/addTemplate")
//   	public void addTemplate(String id)  {
//		try {
//
//			String string ="[2,4,6,19,15]";
//
//			List<Integer> list = JsonUtil.convertValue(string,List.class);
//			wxOpenService.getOpenConfig().getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca").getTemplateService().addTemplate("AT0310",list);
//
//
//		} catch (WxErrorException e) {
//			e.printStackTrace();
//		}
//	}

    @ResponseBody
   	@RequestMapping(value = "/sendTemplateMsg")
   	public void sendTemplateMsg() throws WxErrorException {

    	List<WxMaTemplateMessage.Data> list = new ArrayList<WxMaTemplateMessage.Data>();
		WxMaTemplateMessage.Data data = new WxMaTemplateMessage.Data("keyword1","无恙问题");
		WxMaTemplateMessage.Data data2 = new WxMaTemplateMessage.Data("keyword2","5858");
		list.add(data);
		list.add(data2);

		WxMaTemplateMessage wxMaTemplateMessage  = WxMaTemplateMessage.builder()
				.templateId("f9nV9AcMvC5T_zgK6F2V25NbmprFt7xSGJ6s6T5naLo")
				.toUser("oHV4u5Z57puyw4IGuYqO9v70cO0E")
				.formId("wxdde6d44348f138ca")
				.data(list).build();
		wxOpenService.getInstance(null).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca").getMsgService().sendTemplateMsg(wxMaTemplateMessage);
	}

//	public static void main(String[] args) {
//		Map param = new HashMap();
//		param.put("keyword1","x");
//		param.put("keyword2","xxx");
////		Set set = param.keySet();
////		System.out.printf("===");
//		for (Object key : param.keySet()) {
//			System.out.println(key + ":" + param.get(key));
//		}
//
//	}



}
