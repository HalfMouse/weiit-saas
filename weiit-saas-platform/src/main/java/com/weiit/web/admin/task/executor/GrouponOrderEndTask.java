package com.weiit.web.admin.task.executor;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.task.core.biz.model.ReturnT;
import com.weiit.task.core.handler.Task;
import com.weiit.task.core.handler.annotation.TaskHandler;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.task.service.GrouponService;
import com.weiit.web.admin.util.DateUtil;
import com.weiit.web.weixinopen.service.MessageService;

import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by luo on 2018/7/9.
 *
 * 拼团订单时间到期
 */

@TaskHandler(value = "GrouponOrderEndTask")
@Component
public class GrouponOrderEndTask extends Task{
    @Resource
    GrouponService grouponService;
    @Resource
    MessageService messageService;

    @Override
    public ReturnT<String> execute(String s) throws Exception {
        TaskLogger.log("XXL-JOB, GrouponOrderEndTask.进行中拼团结束任务");
        //查询进行中  时间过期的发起者拼团订单
        FormMap selectMap = new FormMap();
        selectMap.put("state",1);
        selectMap.put("end_time",new Date());
        selectMap.put("parent_id",-1);

        List<E> orderList= grouponService.selectGrouponOrderList(selectMap);

        for (E order:orderList){
            //查询拼团活动信息
            E groupon = grouponService.selectGrouponById(order.getStr("groupon_id"));
            //查出整个拼团的订单

            selectMap.clear();
            selectMap.put("state",1);
            selectMap.put("g_order_id",order.get("g_order_id"));

            List<E> grouponOrderList = grouponService.selectGrouponOrderList(selectMap);
            grouponService.processEndGroupon(groupon,grouponOrderList);
             
            //若未开启模拟成团，推送拼团失败消息；若已开启模拟成团，发送拼团成功消息
            if (groupon.getInt("virtual_groupon") == 1) {
            	try {
                	String ruturnStr="";
            		selectMap.put("business_type",12);
            		selectMap.put("template_type", order.get("service_type_info"));
            		selectMap.put("authorizer_id", order.get("authorizer_id"));
                    E info = grouponService.selectTemplateOne(selectMap);
                    if(info!=null && !info.getStr("template_msg_id").equals("")){ 
	                	// 2为公众号，0为小程序
	            		if(order.getStr("service_type_info").equals("2")){  
	        		        String url ="http://"+order.getStr("authorizer_app_id")+".wx.ustore.wang";
	        		        FormMap formMap = new FormMap();
	        		        formMap.put("appid",order.getStr("authorizer_app_id"));
	
	        		        E keywords = new E(); 
	        		        //key  对应模板占位符  value   值 or 值|颜色值
	        		        keywords.put("first","恭喜您拼团成功！我们将尽快为您发货。");
	        		        keywords.put("keyword1",order.getStr("order_num"));
	        		        keywords.put("keyword2", order.getStr("product_name") );
	        		        keywords.put("remark","点击查看详情");
	
	                		List<String> openIds = new ArrayList<String>();
	                        for (E grouponOrder : grouponOrderList) {
	                        	openIds.add(grouponOrder.getStr("wx_open_id"));
	                        }
	                        ruturnStr=messageService.mpPush(info.getStr("wx_template_id"), keywords, openIds, formMap, url);
	                	}else if(order.getStr("service_type_info").equals("0")){
	                        String page ="pages/Personal/Personal";
	                        FormMap formMap = new FormMap();
	                        formMap.put("appid",order.getStr("authorizer_app_id"));
	                        E keywords = new E(); 
	                        keywords.put("keyword1", order.getStr("product_name"));
	                        keywords.put("keyword2", order.getStr("pay_price"));
	                        keywords.put("keyword3", order.getStr("order_num"));
	                        keywords.put("keyword4", DateUtil.format( order.getDate("pay_time") ,"yyyy-MM-dd HH:mm:ss"));
	                        
	                		List<String> openIds = new ArrayList<String>();                        
	                		for (E grouponOrder : grouponOrderList) {
	                			openIds.add(grouponOrder.getStr("wx_open_id"));
	                        }
	                		ruturnStr=messageService.maPush(info.getStr("wx_template_id"),keywords,openIds,formMap,page,"");
	                	}
                    }
            		TaskLogger.log("=======定时任务拼团成功消息通知返回数据："+ruturnStr);	
            	} catch (Exception e) {
					TaskLogger.log("=======定时任务拼团成功消息通知异常："+e.getMessage());
				}
            }else{
        		try {
        			String ruturnStr="";
            		selectMap.put("business_type",13);
            		selectMap.put("template_type", order.get("service_type_info"));
            		selectMap.put("authorizer_id", order.get("authorizer_id"));
            		E info = grouponService.selectTemplateOne(selectMap);
                    if(info!=null && !info.getStr("template_msg_id").equals("")){ 
	        			// 2为公众号，0为小程序
		        		if(order.getStr("service_type_info").equals("2")){  
		    		        String url ="http://"+order.getStr("authorizer_app_id")+".wx.ustore.wang";
		    		        FormMap formMap = new FormMap();
		    		        formMap.put("appid",order.getStr("authorizer_app_id"));
		
		    		        E keywords = new E(); 
		    		        //key  对应模板占位符  value   值 or 值|颜色值
		    		        keywords.put("first","您好，您参加的拼团由于团已过期，拼团失败。");
		    		        keywords.put("keyword1",order.getStr("order_num"));
		    		        keywords.put("keyword2", order.getStr("product_name") );
		    		        keywords.put("keyword3", order.getStr("pay_price") );
		    		        keywords.put("remark","点击查看详情");
		
		            		List<String> openIds = new ArrayList<String>();
		                    for (E grouponOrder : grouponOrderList) {
		                    	openIds.add(grouponOrder.getStr("wx_open_id"));
		                    }
		                    ruturnStr=messageService.mpPush(info.getStr("wx_template_id"), keywords, openIds, formMap, url);
		            	}else if(order.getStr("service_type_info").equals("0")){
		                    String page ="pages/Personal/Personal";
		                    FormMap formMap = new FormMap();
		                    formMap.put("appid",order.getStr("authorizer_app_id"));
		                    E keywords = new E(); 
		                    keywords.put("keyword1", order.getStr("product_name"));
		                    keywords.put("keyword2", order.getStr("pay_price"));
		                    keywords.put("keyword3", order.getStr("order_num"));
		                    keywords.put("keyword4", "24小时内未凑满参团人数");
		                    keywords.put("keyword5", "拼团失败，退款中");
		                    
		            		List<String> openIds = new ArrayList<String>();                        
		            		for (E grouponOrder : grouponOrderList) {
		                    	openIds.add(grouponOrder.getStr("wx_open_id"));
		                    }
		            		ruturnStr=messageService.maPush(info.getStr("wx_template_id"),keywords,openIds,formMap,page,"");
		            	}
		        		TaskLogger.log("=======定时任务拼团失败消息通知返回数据："+ruturnStr);
		    		}
        		} catch (Exception e) {
					TaskLogger.log("=======定时任务拼团失败消息通知异常："+e.getMessage());
				}
            }
        }
        return SUCCESS;
    }
}
