package com.weiit.web.admin.task.executor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Component;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.OrderConfirmService;
import com.weiit.web.admin.util.DateUtil;
import com.weiit.web.weixinopen.service.MessageService;

/**
 * Created by 罗鸿强 on 2018/7/11.
 *
 * 收货15天未确认的   ，，（收钱未发货的）
 */

@TaskHandler("orderConfirmTask")
@Component
public class OrderConfirmTask extends Task {
	@Resource
	OrderConfirmService orderConfirmService;
    @Resource
    MessageService messageService;
	
    @Override
    public ReturnT<String> execute(String s) throws Exception {
    	TaskLogger.log("XXL-JOB, OrderConfirmTask.订单发货15天未确认收货，订单付款15天未发货，结束任务");
        //修改  订单发货15天未确认收货
        FormMap selectMap = new FormMap();
        selectMap.put("state",2);
        selectMap.put("update_state",3);
        selectMap.put("deliver_time", DateUtils.addDays(new Date(), -15));
        
        orderConfirmService.edit(selectMap);
         
        selectMap.put("state",1);
        selectMap.put("pay_time", DateUtils.addDays(new Date(), -15));
        selectMap.put("business_type","7");
        //查询进行 订单付款15天未发货
        List<E> infoList= orderConfirmService.selectList(selectMap);

        for (E order:infoList){
            orderConfirmService.processEndOrder(order);
        }
        for (E info : infoList) {
        	try {
        		String ruturnStr="";
        		if(!info.getStr("wx_template_id").equals("")){
	        		// 2为公众号，0为小程序
	        		if(info.getStr("service_type_info").equals("2")){  
	    		        String url ="http://"+info.getStr("authorizer_app_id")+".wx.ustore.wang";
	    		        FormMap formMap = new FormMap();
	    		        formMap.put("appid",info.getStr("authorizer_app_id"));
	
	    		        E keywords = new E(); 
	    		        //key  对应模板占位符  value   值 or 值|颜色值

	    		        keywords.put("first","您好，您有一笔交易因商家长期未发货，已进行自动退款中。");
	    		        keywords.put("keyword1", info.getStr("order_num") );
	    		        keywords.put("keyword2",DateUtil.format( info.getDate("create_time") ,"yyyy-MM-dd HH:mm:ss"));
	    		        keywords.put("keyword3", "商家长期未发货，自动退款中" );
	    		        keywords.put("keyword4", DateUtil.format( new Date(),"yyyy-MM-dd HH:mm:ss"));

	    		        keywords.put("remark","感谢您的选择，请及时查看");
	
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.mpPush(info.getStr("wx_template_id"), keywords, openIds, formMap, url);
	            	}else if(info.getStr("service_type_info").equals("0")){
	                    String page ="pages/Personal/Personal";
	                    FormMap formMap = new FormMap();
	                    formMap.put("appid",info.getStr("authorizer_app_id"));
	                    E keywords = new E(); 
	                    keywords.put("keyword1", info.getStr("product_name"));
	                    keywords.put("keyword2", info.getStr("total_price"));
	                    keywords.put("keyword3", info.getStr("order_num"));
	                    keywords.put("keyword4", DateUtil.format( info.getDate("create_time") ,"yyyy-MM-dd HH:mm:ss"));
	                    
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.maPush(info.getStr("wx_template_id"),keywords,openIds,formMap,page,"");
	            	}
            	}
            	TaskLogger.log("=======定时任务订单付款长期未发货消息通知返回数据："+ruturnStr);
        	} catch (Exception e) {
				TaskLogger.log("=======定时任务订单付款长期未发货消息通知异常："+e.getMessage());
			}
		}
        return SUCCESS;
    }
    
}
