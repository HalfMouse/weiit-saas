package com.weiit.web.admin.order.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.order.service.OrdersService;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.setting.service.ExpressService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.weixinopen.service.MessageService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

//import com.weiit.web.admin.setting.service.ExpressService;

/**
 * 订单管理 
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController extends AdminController {
	public static Logger logger= Logger.getLogger(OrderController.class);
	@Resource
	private OrdersService ordersService;
	@Resource
    ParameterService parameterService;
	@Resource
	ExpressService expressService;
    @Resource
    MessageService messageService;
	
	/**
	 * 所有订单查询
	 */
    @RequestMapping("/orderList")
    public UIview orderList() {
    	logger.info("进入 OrderController-orderList,所有订单");

    	FormMap formMap = getFormMap();
    	List<E> expressList= expressService.selectList(formMap);
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List list = ordersService.selectList(formMap);
		UIview result = UIView("/center/order/orderList",false);
		result.addObject("pageInfo", new PageInfo<E>(list));
		result.addObject("queryParam", formMap); 
		result.addObject("expressList", expressList);
//		result.addObject("expressList", null);
		return result;
    }
    
	/**
	 * 订单管理》查询订单详情
	 */
	@RequestMapping("/orderDetail")
	public UIview orderDetail() throws Exception {
		logger.info("进入 OrderController-orderDetail, 订单管理》查询订单详情");
		FormMap formMap = getFormMap();
		if(formMap.getStr("validate_id").equals("") && !formMap.getStr("order_num").equals("")){
			formMap.set("validate_id", formMap.get("order_num"));
		}
		//查询订单详情
		E e = ordersService.selectOne(formMap);
		List<E> ordersDetailList = ordersService.queryOrdersDetail(formMap);
		// 返回到list页面
		UIview result = UIView("/center/order/orderDetail",false);
		result.addObject("order", e); 
		result.addObject("detail", ordersDetailList);
		// 绑定上一次参数
		result.addObject("queryParam", formMap);
		return result;
	}
	
	/**
	 * 订单管理》取消订单操作
	 */
	@RequestMapping("/orderCancel")
	public UIview orderCancel() throws Exception {
		logger.info("进入 OrderController-save, 订单管理》取消订单操作");
		FormMap formMap=getFormMap();
		UIview result = UIView("orderList",true);
		ordersService.updateStatus(formMap);
		result.addPNotifyMessage("订单取消操作成功！");
		return result;
	}
	
	/**
	 * 订单管理》 订单加星 ,取消加星
	 */
	@RequestMapping("/starOrder")
	public UIview starOrder() throws Exception {
		logger.info("进入 OrderController-starOrder, 订单管理》订单加星");
		FormMap formMap=getFormMap();
		UIview result = UIView("orderList",true);
		try {
			formMap.put("state", null);
		    ordersService.edit(formMap);
			result.addPNotifyMessage("订单操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("orders->订单加星出错.....");
		}
		return result;
	}
	
	/**
	 * 发货
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("shipOrder")
	public UIview shipOrder() throws Exception {
		FormMap paramMap=getFormMap();
		UIview result = UIView("orderList", true);
		try {
			paramMap.put("state", 2);
		    ordersService.edit(paramMap);  
			result.addPNotifyMessage("订单发货操作成功！");
			
			paramMap.put("business_type", 4);
			E info= ordersService.selectOrderTimplateOne(paramMap);
	        if(info!=null && !info.getStr("order_id").equals("")){
            	try {
            		String ruturnStr="";
	        		// 2为公众号，0为小程序
	        		if(info.getStr("service_type_info").equals("2")){  
	    		        String url ="http://"+info.getStr("authorizer_app_id")+".wx.ustore.wang";
	    		        FormMap formMap = new FormMap();
	    		        formMap.put("appid",info.getStr("authorizer_app_id"));
	
	    		        E keywords = new E(); 
	    		        //key  对应模板占位符  value   值 or 值|颜色值
	    		        keywords.put("first","亲，宝贝已经启程了，好想快点来到你身边。|#173177");
	    		        keywords.put("keyword1", info.getStr("order_num") );
	    		        keywords.put("keyword2", info.getStr("express_name") );
	    		        keywords.put("keyword3", info.getStr("express_num") );
	    		        keywords.put("remark","点击查看完整的物流信息 。如有问题请致电或直接在微信里留言");
	
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.mpPush(info.getStr("wx_template_id"), keywords, openIds, formMap, url);
	            	}else if(info.getStr("service_type_info").equals("0")){
	                    String page ="pages/Personal/Personal";
	                    FormMap formMap = new FormMap();
	                    formMap.put("appid",info.getStr("authorizer_app_id"));
	                    E keywords = new E(); 
	                    keywords.put("keyword1", info.getStr("product_name"));
	                    keywords.put("keyword2", info.getStr("order_num"));
	                    keywords.put("keyword3", info.getStr("express_name"));
	                    keywords.put("keyword4", info.getStr("express_num"));
	                    
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.maPush(info.getStr("wx_template_id"),keywords,openIds,formMap,page,"");
	            	}
	        		logger.info("=======订单发货消息通知返回数据："+ruturnStr);
            	} catch (Exception e) {
            		logger.info("=======订单发货消息通知异常："+e.getMessage());
				}
	        }
		} catch (Exception e) {
			e.printStackTrace();
			result.addErrorMessage("订单发货操作成功！");
//			throw new Exception("orders->发货出错.....");
		}
		return result;
	}
	
	
	/**
	 * 订单管理》 加星订单查询
	 */
    @RequestMapping("/starOrderList")
    public UIview starOrderList() {
    	logger.info("进入 OrderController-starOrderList,加星订单"); 
    	FormMap formMap = getFormMap();
    	formMap.put("star_state", 1);
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List list = ordersService.selectList(formMap);
		UIview result=UIView("/center/order/starOrderList",false);
		result.addObject("pageInfo", new PageInfo<E>(list));
		result.addObject("queryParam", formMap); 
		result.addObject("expressList", null);
		return result;
    }
    

	/**
	 * 订单管理》 订单评价查询
	 */
    @RequestMapping("/evaluateOrderList")
    public UIview evaluateOrderList() {
    	logger.info("进入 OrderController-evaluateOrderList,评价订单"); 
    	FormMap formMap = getFormMap();
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> list = ordersService.selectOrderEvaluateList(formMap);
		for (E info : list) {
			String imgs=info.getStr("evaluate_imgs");
			String[] imgArr=imgs.split(";");
			info.put("imgArr", imgArr);
		}
		UIview result=UIView("/center/order/evaluateOrderList",false);
		result.addObject("pageInfo", new PageInfo<E>(list));
		result.addObject("queryParam", formMap); 
    	return result;
    }
    
	/**
	 * 订单管理》 订单评价  回复  和  状态 修改
	 */
    @RequestMapping("/evaluateEdit")
    public UIview evaluateEdit() {
    	logger.info("进入 OrderController-evaluateOrderEdit,评价订单修改"); 
    	FormMap formMap = getFormMap();
		ordersService.editOrderEvaluate(formMap); 
		UIview result=UIView("evaluateOrderList",true);
		result.addPNotifyMessage("订单评价操作成功！");
    	return result;
    }
    
	/**
	 * 订单管理》  订单设置 界面  
	 */
    @RequestMapping("/orderSet")
    public UIview orderSet() {
    	logger.info("进入 OrderController-orderSet,订单设置");
    	FormMap formMap = getFormMap();
    	formMap.put("item_code", "ORDERSET");
    	UIview result=UIView("/center/order/orderSet",false);
    	List<E> list=parameterService.selectList(formMap);
    	for (E info : list) {
    		formMap.set(info.getStr("item_name"), info.get("item_value"));
    		formMap.set(info.getStr("item_name")+"_ID", info.get("id"));
		}
		result.addObject("queryParam", formMap); 
    	return result;
    }
    
	/**
	 * 订单管理》  订单设置 保存 
	 */
    @RequestMapping("/orderSetSave")
    public UIview orderSetSave() {
    	logger.info("进入 OrderController-orderSetSave,订单保存");
    	FormMap formMap = getFormMap();
    	UIview result=UIView("orderSet",true);
    	
    	List<FormMap> list=new ArrayList<FormMap>();
    	
    	FormMap messageInfo = new FormMap();
    	messageInfo.put("validate_id", formMap.get("MESSAGE_ID"));
    	messageInfo.put("item_value", formMap.get("MESSAGE"));
    	messageInfo.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("MESSAGE_ID").equals("")){
			messageInfo.put("item_code", "ORDERSET");
			messageInfo.put("item_name", "MESSAGE"); 
			messageInfo.put("item_desc", "下单成功通知。1短信提醒，0不提醒"); 
			messageInfo.put("state", 0); 
		}
		
		FormMap refundInfo = new FormMap();
		refundInfo.put("validate_id", formMap.get("REFUND_ID"));
		refundInfo.put("item_value", formMap.get("REFUND"));
		refundInfo.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("REFUND_ID").equals("")){
			refundInfo.put("item_code", "ORDERSET");
			refundInfo.put("item_name", "REFUND"); 
			refundInfo.put("item_desc", "维权订单通知.1短信提醒，0不提醒"); 
			refundInfo.put("state", 0); 
		}
		
		FormMap expiratTimeInfo = new FormMap();
		expiratTimeInfo.put("validate_id", formMap.get("EXPIRATIONTIME_ID"));
		expiratTimeInfo.put("item_value", formMap.get("EXPIRATIONTIME"));
		expiratTimeInfo.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("EXPIRATIONTIME_ID").equals("")){
			expiratTimeInfo.put("item_code", "ORDERSET");
			expiratTimeInfo.put("item_name", "EXPIRATIONTIME"); 
			expiratTimeInfo.put("item_desc", "订单过期时间"); 
			expiratTimeInfo.put("state", 0); 
		}
		
		FormMap orderTimeInfo = new FormMap();
		orderTimeInfo.put("validate_id", formMap.get("ORDERTIME_ID"));
		orderTimeInfo.put("item_value", formMap.get("ORDERTIME"));
		orderTimeInfo.put("shop_id", formMap.get("shop_id"));
		if(formMap.getStr("ORDERTIME_ID").equals("")){
			orderTimeInfo.put("item_code", "ORDERSET");
			orderTimeInfo.put("item_name", "ORDERTIME"); 
			orderTimeInfo.put("item_desc", "自动收货时间:"); 
			orderTimeInfo.put("state", 0); 
		}
		
		list.add(messageInfo);
		list.add(refundInfo);
		list.add(expiratTimeInfo);
		list.add(orderTimeInfo);
		
    	parameterService.editBatch(list); 
		result.addPNotifyMessage("订单设置操作成功！");
    	return result;
    }
    
}