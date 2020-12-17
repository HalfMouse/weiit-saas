package com.weiit.web.admin.init.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.DateUtil;
import com.weiit.web.admin.init.service.OrderService;
import com.weiit.web.common.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *订单相关业务
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController extends AdminController{ 
	public static Logger logger=Logger.getLogger(OrderController.class); 
	
	@Resource
	private OrderService orderService; 
	
    /**
     * 订单列表
     */
    @RequestMapping("/orderList")
    public UIview orderList() {
    	logger.info("进入 UserController-orderList,订单列表");
    	
    	UIview view=UIView("/center/shop/orderList",false);
    	FormMap formMap = getFormMap();
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> orderList = orderService.selectOrderList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(orderList));
		view.addObject("queryParam", formMap);
    	return view;
    }
    
    
    /**
     *  数据统计
     */
    @RequestMapping("/dashboard")
    public UIview dashboard() { 
    	logger.info("进入 DashBoardController-shopIndex,店铺概况 页面");
    	UIview result=UIView("/center/shop/dashboard",false); 
    	FormMap param=getFormMap();
    	
    	//订单概况  待付款，待发货
		E orderInfo=orderService.selectShopOrderCount(param); 
		
    	//10日折线图
		Calendar cale = Calendar.getInstance();
		cale.add(Calendar.DATE, -10);
		param.put("startTime", DateUtil.dateToString(cale.getTime(), "yyyy-MM-dd"));
		param.put("endTime", DateUtil.getCurrentDate("yyyy-MM-dd"));
    	  
		List<E> list=orderService.selectOrderSurveyList(param);
		
		List<String> times = new ArrayList<String>();  
    	List<String> countDatas = new ArrayList<String>();
    	List<String> sumDatas = new ArrayList<String>();

    	for (int j = 0; j < 10; j++) {
    		times.add( DateUtil.dateToString(cale.getTime(), "yyyyMMdd") );
    		int flag=0;
    		for(int i = 0 ;  i < list.size() ; i ++){
             	E e = list.get(i);
             	if(DateUtil.dateToString(cale.getTime(), "yyyyMMdd").equals(e.getStr("months"))){
             		countDatas.add(e.getStr("payCount"));
                 	sumDatas.add(e.getStr("paySum"));
                 	flag=1;
                 	break;
        		}
             }
    		 if(flag==0){
    			 countDatas.add("0");
    			 sumDatas.add("0");
    		 }
    		cale.add(Calendar.DATE, 1);
		}
    	 
        //绑定分页返回
		result.addObject("countMap", orderInfo); 
    	this.getRequest().setAttribute("times", times);
    	this.getRequest().setAttribute("countDatas", countDatas);
    	this.getRequest().setAttribute("sumDatas", sumDatas);
    	
		Calendar cale11 = Calendar.getInstance();
		cale11.add(Calendar.DATE, -30);
		param.put("startTime", DateUtil.dateToString(cale11.getTime(), "yyyy-MM-dd"));
		param.put("endTime", DateUtil.getCurrentDate("yyyy-MM-dd"));
		
    	//查询展示数量
    	List<E> shopList=orderService.selectShopOrderList(param);
    	this.getRequest().setAttribute("shopList", shopList);
    	
    	return result;
    }
}