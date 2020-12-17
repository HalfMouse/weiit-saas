package com.weiit.web.admin.task.executor;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.OrderConfirmService;
import com.weiit.web.admin.util.DateUtil;
import com.weiit.web.weixinopen.service.MessageService;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * hzy on 2018/8/10.
 *
 *   订单 7天未 付款 关闭订单 
 */
@TaskHandler("orderUnpaidEndTask")
@Component
public class OrderUnpaidEndTask extends Task {
	@Resource
	OrderConfirmService orderConfirmService;
    @Resource
    MessageService messageService;
    
    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("订单 7天未 付款 关闭订单 ");

        FormMap selectMap = new FormMap(); 
        selectMap.put("create_time", DateUtils.addDays(new Date(), -7));
        selectMap.put("business_type","2");
        //查询数据
        List<E> infoList =orderConfirmService.selectOrderUnpaidList(selectMap);
        //关闭订单
        selectMap.put("state",0);
        selectMap.put("update_state",-1);
        orderConfirmService.edit(selectMap); 
        if(infoList!=null && infoList.size()>0){
            for (E info : infoList) {
            	try {
            		String ruturnStr="";
	        		// 2为公众号，0为小程序
	        		if(info.getStr("service_type_info").equals("2")){  
	    		        String url ="http://"+info.getStr("authorizer_app_id")+".wx.ustore.wang";
	    		        FormMap formMap = new FormMap();
	    		        formMap.put("appid",info.getStr("authorizer_app_id"));
	
	    		        E keywords = new E(); 
	    		        //key  对应模板占位符  value   值 or 值|颜色值
	    		        keywords.put("first","客官，您好！您的订单未支付，即将关闭。");
	    		        keywords.put("ordertape",DateUtil.format( info.getDate("create_time") ,"yyyy-MM-dd HH:mm:ss"));
	    		        keywords.put("ordeID", info.getStr("order_num") );
	    		        keywords.put("remark","点击查看详情");
	
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
	                    keywords.put("keyword3", info.getStr("total_price"));
	                    keywords.put("keyword4", DateUtil.format( info.getDate("create_time") ,"yyyy-MM-dd HH:mm:ss"));
	                    
	            		List<String> openIds = new ArrayList<String>();
	            		openIds.add(info.getStr("wx_open_id"));
	            		ruturnStr=messageService.maPush(info.getStr("wx_template_id"),keywords,openIds,formMap,page,"");
	            	}
	            	TaskLogger.log("=======定时任务订单未支付消息通知返回数据："+ruturnStr);
            	} catch (Exception e) {
					TaskLogger.log("=======定时任务订单未支付消息通知异常："+e.getMessage());
				}
    		}
        }
        return SUCCESS;
    }
}
