package com.weiit.web.admin.order.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.DateUtil;
import com.weiit.web.admin.order.service.OrdersRefundService;
import com.weiit.web.admin.order.service.OrdersService;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixinopen.service.MessageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 
* @ClassName: OrdersRefundController 
* @Description: 订单退换货视图控制器
* @author lcm
* @date 2017年3月9日 上午10:45:50 
*
 */
@Controller
@RequestMapping("/order")
public class OrdersRefundController  extends AdminController {
 
	@Resource
	private OrdersService ordersService;
	@Resource
	private OrdersRefundService ordersRefunService;
    @Resource
    MessageService messageService;
	
	/**
	 * 
	* @Title: ordersRefund 
	* @Description: 查询退换货列表
	* @param @return
	* @param @throws Exception    设定文件 
	* @return String    返回类型 
	* @throws
	 */
	 @RequestMapping("/refundOrderList")
	 public UIview refundOrderList() throws Exception {
	    logger.info("进入 OrdersRefundController-refundList,维权订单");
	    	 
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	//查询展示数量
    	List<E> list=ordersRefunService.selectList(formMap);
    	
    	System.out.println(list.size()+"发现查询的集合并不是所有，而是按照数量查询出来展示，所以不影响性能!");
        //返回到list页面
    	UIview result=UIView("/center/order/refundOrderList",false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
	}
	 
	/**
	 * 订单管理》查询订单详情
	 */
	@RequestMapping("/refundOrderDetail")
	public UIview refundOrderDetail() throws Exception {
		logger.info("进入 OrderController-refundOrderDetail, 订单管理》查询订单详情");
		
		FormMap formMap = getFormMap();
		// 查询一个退款订单
		E order = ordersRefunService.selectOne(formMap);
		String imgs=order.getStr("refund_imgs");
		if(!imgs.equals("")){
			String[] imgArr=imgs.split("\\|");
			order.put("imgArr", imgArr);
		}
		
		// 查询一个订单
		FormMap form = new FormMap();
			form.put("shop_id", formMap.get("shop_id"));
			form.put("validate_id", formMap.get("order_id"));
		E infoMap = ordersService.selectOne(form);
		// 返回到list页面
		UIview result = UIView("/center/order/refundOrderDetail",false);
		result.addObject("order", order);
		result.addObject("infoMap", infoMap);
		// 绑定上一次参数
		result.addObject("queryParam", formMap);
		return result;
	}

	/**
	 * 审核
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("refundOrderCheck")
	public UIview orderRefunCheck() throws Exception {
		UIview result = UIView("refundOrderList",true);
		try {
	    	FormMap formMap=getFormMap();
			//退货退款或者退款,没有记录或者说退款后我的金额里面没有增加金额.
	    	if (formMap.getInt("state")==3){
				E refunOrder =ordersRefunService.selectRefunOne(formMap);
				FormMap balanceLogInfo= new FormMap();
				balanceLogInfo.put("user_id",refunOrder.get("user_id"));
				balanceLogInfo.put("user_name",refunOrder.get("user_name"));
				balanceLogInfo.put("balance",refunOrder.getDouble("refund_money"));
				balanceLogInfo.put("last_balance",refunOrder.getDouble("refund_money")+refunOrder.getDouble("balance"));
				balanceLogInfo.put("remark","退货退款(退款)");
				balanceLogInfo.put("type","3");
				balanceLogInfo.put("state","0");
				balanceLogInfo.put("origin_id",refunOrder.get("order_num"));
				balanceLogInfo.put("shop_id",formMap.get("shop_id"));
				ordersRefunService.insertBalanceLog(balanceLogInfo);
				ordersRefunService.updateUserPrice(balanceLogInfo);
			}
	    	
			ordersRefunService.edit(formMap);
			result.addPNotifyMessage("订单操作成功！");
			
	    	// 审核 消息模板发送
	    	formMap.put("business_type", 9);
			E info= ordersRefunService.selectOrderTimplateOne(formMap);
	        if(info!=null && !info.getStr("refund_id").equals("")){
            	try {
            		String ruturnStr="";
            		String state="";
            		String remark="";
            		if(info.getStr("state").equals("4")){
            			state="审核拒绝";
            			remark=info.getStr("refusal_reason");
            		}else if(info.getStr("state").equals("1")){
            			state="审核通过";
            			remark="您好，订单审核已通过，请尽快处理退货！";
            		}else if(info.getStr("state").equals("3")){
            			state="审核通过";
            			remark="订单退款完成，请注意查收！";
            		}
	        		// 2为公众号，0为小程序
	        		if(info.getStr("service_type_info").equals("2")){  
	    		        String url ="http://"+info.getStr("authorizer_app_id")+".wx.ustore.wang";
	    		        FormMap wxMap = new FormMap();
	    		        wxMap.put("appid",info.getStr("authorizer_app_id"));
	
	    		        E keywords = new E(); 
	    		        //key  对应模板占位符  value   值 or 值|颜色值
	    		        keywords.put("first","你好，您的订单售后申请已审核。|#173177");
	    		        keywords.put("keyword1", state);
	    		        keywords.put("keyword2", info.getStr("product_name") );
	    		        keywords.put("keyword3", info.getStr("refund_money") );
	    		        keywords.put("keyword4", remark );
	                    keywords.put("keyword5", DateUtil.dateToString( info.getDate("update_time") ,"yyyy-MM-dd HH:mm:ss"));
	    		        keywords.put("remark","点击查看订单详细信息 。如有问题请致电或直接在微信里留言");
	    		        
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.mpPush(info.getStr("wx_template_id"), keywords, openIds, wxMap, url);
	            	}else if(info.getStr("service_type_info").equals("0")){
	                    String page ="pages/Personal/Personal";
	                    FormMap wxMap = new FormMap();
	                    wxMap.put("appid",info.getStr("authorizer_app_id"));
	                    E keywords = new E(); 
	                    keywords.put("keyword1", info.getStr("product_name"));
	                    keywords.put("keyword2", info.getStr("order_num"));
	    		        keywords.put("keyword3", info.getStr("refund_money") );
	    		        keywords.put("keyword4", DateUtil.dateToString( info.getDate("update_time") ,"yyyy-MM-dd HH:mm:ss"));
	    		        keywords.put("keyword5", state);
	                    
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.maPush(info.getStr("wx_template_id"),keywords,openIds,wxMap,page,"");
	            	}
	        		logger.info("=======订单退货审核通知消息通知返回数据："+ruturnStr);
            	} catch (Exception e) {
            		logger.info("=======订单退货审核通知消息通知异常："+e.getMessage());
				}
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
}