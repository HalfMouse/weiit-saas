package com.weiit.web.admin.dashboard.controller;


import com.github.pagehelper.PageHelper;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.DateUtil;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.admin.dashboard.service.DashBoardService;
import com.weiit.web.admin.order.service.OrdersService;
import com.weiit.web.admin.setting.service.SettingService;
import com.weiit.web.base.AdminController;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * 报表统计》概况
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/dashboard")
public class DashBoardController extends AdminController {
	
	public static Logger logger= Logger.getLogger(DashBoardController.class);
	@Resource
	private DashBoardService dashBoardService;
	@Resource
	private SettingService settingService;
	@Resource
	private OrdersService ordersService;

	@Resource
	RedisUtil redisUtil;
	
	private String dashboard_page = "/center/dashboard/dashboard";
	
    /**
     * 控制面板页面
     */
    @RequestMapping("/dashboard")
	public UIview dashboard() {
		logger.info("进入 DashBoardController-dashboard,控制面板页面");

		FormMap formMap = getFormMap();
		E shop = settingService.selectOne(formMap);

		E orderMap=ordersService.selectOrderDashBoard(formMap);
		if (StringUtils.isEmpty(shop.getStr("shop_qr_code")) && !StringUtils.isEmpty(shop.getStr("shop_domain_prex"))){
			formMap.putAll(shop);
			settingService.getQrCodeUrl(formMap);
			shop.put("shop_qr_code",formMap.get("shop_qr_code"));
		}
		Object dashboard = redisUtil.get(String.format("introPage_%s_%s",formMap.getStr("shop_id"),"dashboard"));
		if (dashboard!=null){
			this.getSession().setAttribute("page_dashboard","dashboard");
		}

		UIview result=UIView(dashboard_page,false);
		result.addObject("shopMap", shop);
		result.addObject("orderMap", orderMap);
		return result;
	}



	@RequestMapping("/editor")
	public UIview editor() {
		logger.info("进入 DashBoardController-editor,控制面板页面");



		UIview result=UIView("/center/ueditor/demo",false);
		return result;
	}
    
    /**
     *  数据--店铺概况
     */
    @RequestMapping("/shopIndex")
    public UIview shopIndex() {
    	logger.info("进入 DashBoardController-shopIndex,店铺概况 页面");
    	UIview result=UIView("/center/dashboard/shopIndex",false);
    	FormMap param=getFormMap();
    	
    	//昨日日期。。查询昨日浏览量，访客量
		Calendar cale = Calendar.getInstance();
		cale.add(Calendar.DATE, -1);
		//+" 00:00:00"
		param.put("startTime", DateUtil.dateToString(cale.getTime(), "yyyy-MM-dd"));
		//+" 59:59:59"
		param.put("endTime", DateUtil.getCurrentDate("yyyy-MM-dd"));
    	//浏览统计
		List<E> browse=dashBoardService.selectBrowseCountList(param);
		if(browse!=null && !browse.isEmpty()){
			result.addObject("browseMap", browse.get(0));
		}
		//0店铺主页，1会员主页，2表示微页面，3表示商品，4表示商品分组
		param.put("page_type", 3);
		List<E> browseUser=dashBoardService.selectBrowseCountList(param);
		if(browseUser!=null && !browseUser.isEmpty()){
			result.addObject("browseUserMap", browseUser.get(0));
		}
		
		param.remove("page_type");
		
		E pageCount=dashBoardService.selectPageCount(param);
		E productCount=dashBoardService.selectProductCount(param);
		result.addObject("pageCount", pageCount==null?0:pageCount.get("mCount"));
		result.addObject("productCount", productCount==null?0:productCount.get("mCount"));
		
		
		cale = Calendar.getInstance();
		cale.add(Calendar.DATE, -10);
		param.put("startTime", DateUtil.dateToString(cale.getTime(), "yyyy-MM-dd"));
		param.put("endTime", DateUtil.getCurrentDate("yyyy-MM-dd"));
    	
		List<E> browseList=dashBoardService.selectBrowseCountList(param);
		
		List<String> times = new ArrayList<String>();  
    	List<String> allDatas = new ArrayList<String>();
    	List<String> userDatas = new ArrayList<String>();

    	for (int j = 0; j < 10; j++) {
    		times.add( DateUtil.dateToString(cale.getTime(), "yyyyMMdd") );
    		int flag=0;
    		for(int i = 0 ;  i < browseList.size() ; i ++){
             	E e = browseList.get(i);
             	if(DateUtil.dateToString(cale.getTime(), "yyyyMMdd").equals(e.getStr("months"))){
             		allDatas.add(e.getStr("browseCount"));
                 	userDatas.add(e.getStr("userCount"));
                 	flag=1;
                 	break;
        		}
             }
    		 if(flag==0){
    			allDatas.add("0");
              	userDatas.add("0");
    		 }
    		cale.add(Calendar.DATE, 1);
		}
         //绑定分页返回
    	this.getRequest().setAttribute("times", times);
    	this.getRequest().setAttribute("allDatas", allDatas);
    	this.getRequest().setAttribute("userDatas", userDatas);

    	param.put("page_type", 3);
    	List<E> productList=dashBoardService.selectBrowseCountList(param);

		cale.add(Calendar.DATE, -10);
    	List<String> allProductDatas = new ArrayList<String>();
    	List<String> userProductDatas = new ArrayList<String>();
    	for (int j = 0; j < 10; j++) {
    		int flag=0;
				for (E e : productList){
					if(DateUtil.dateToString(cale.getTime(), "yyyyMMdd").equals(e.getStr("months"))){
						allProductDatas.add(e.getStr("browseCount"));
						userProductDatas.add(e.getStr("userCount"));
						flag=1;
						break;
					}
				}
    		 if(flag==0){
    			 allProductDatas.add("0");
    			 userProductDatas.add("0");
    		 }
    		cale.add(Calendar.DATE, 1);
		}
    	this.getRequest().setAttribute("allProductDatas", allProductDatas);
    	this.getRequest().setAttribute("userProductDatas", userProductDatas);
    	
    	PageHelper.startPage(param.getPage(), param.getRows());
    	//查询展示数量
    	List<E> pageList=dashBoardService.selectBrowseList(param);
    	this.getRequest().setAttribute("pageList", pageList);
    	
    	return result;
    }
    
    
    /**
     *  数据--店铺概况
     */
    @RequestMapping("/orderIndex")
    public UIview orderIndex() {
    	logger.info("进入 DashBoardController-orderIndex,订单概况 页面");
    	UIview result=UIView("/center/dashboard/orderIndex",false);
    	FormMap param=getFormMap();
    	
    	//订单概况  待付款，待发货
		E orderInfo=dashBoardService.selectOrderSurveyCount(param);
		
    	//10日折线图
		Calendar cale = Calendar.getInstance();
		cale.add(Calendar.DATE, -10);
		param.put("startTime", DateUtil.dateToString(cale.getTime(), "yyyy-MM-dd"));
		param.put("endTime", DateUtil.getCurrentDate("yyyy-MM-dd"));
    	  
		List<E> list=dashBoardService.selectOrderSurveyList(param);
		
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
		result.addObject("orderInfo", orderInfo); 
    	this.getRequest().setAttribute("times", times);
    	this.getRequest().setAttribute("countDatas", countDatas);
    	this.getRequest().setAttribute("sumDatas", sumDatas);
    	
    	return result;
    }
 
    /**
     *  数据--用户分析 
     */
    @RequestMapping("/userIndex")
    public UIview userIndex() {
    	logger.info("进入 DashBoardController-orderIndex,用户分析 页面");
    	UIview result=UIView("/center/dashboard/userIndex",false);
    	FormMap param=getFormMap();
		Calendar cale = Calendar.getInstance();
		cale.add(Calendar.DATE, -1);
		if(param.getStr("startTime").equals("")){
			param.put("startTime", DateUtil.dateToString(cale.getTime(), "yyyy-MM-dd"));
		}
		if(param.getStr("endTime").equals("")){
			param.put("endTime", DateUtil.dateToString(cale.getTime(), "yyyy-MM-dd"));
		}

    	//订单概况  待付款，待发货
		E userInfo=dashBoardService.selectUserCount(param);
		
    	//24小时时段分布 
		List<E> list=dashBoardService.selectUserCountList(param);
		
		List<String> times = new ArrayList<String>();  
    	List<String> allDatas = new ArrayList<String>();
    	List<String> userDatas = new ArrayList<String>();

    	for (int j = 0; j < 24; j++) {
    		times.add(j+"");
    		int flag=0;
    		for (E e : list){
				if( j == e.getInt("hours") ){
					allDatas.add(e.getStr("browseCount"));
					userDatas.add(e.getStr("userCount"));
					flag=1;
					break;
				}
			}

//    		for(int i = 0 ;  i < list.size() ; i ++){
//             	E e = list.get(i);
//             	if( j == e.getInt("hours") ){
//             		allDatas.add(e.getStr("browseCount"));
//             		userDatas.add(e.getStr("userCount"));
//                 	flag=1;
//                 	break;
//        		}
//             }
    		 if(flag==0){
    			 allDatas.add("0");
    			 userDatas.add("0");
    		 }
		}
    	 
         //绑定分页返回
		result.addObject("queryParam", param); 
		result.addObject("userInfo", userInfo); 
    	this.getRequest().setAttribute("times", times);
    	this.getRequest().setAttribute("allDatas", allDatas);
    	this.getRequest().setAttribute("userDatas", userDatas);
    	
    	return result;
    }



    @RequestMapping("notHintNext")
	@ResponseBody
	public void notHintNext(String path){
    	FormMap formMap = getFormMap();
		String page = path.substring(path.lastIndexOf("/")+1);
		redisUtil.set(String.format("introPage_%s_%s",formMap.getStr("shop_id"),page),page);
	}


    @RequestMapping("sessionHint")
	@ResponseBody
	public void sessionHint(String path){
		String page = path.substring(path.lastIndexOf("/")+1);
		this.getSession().setAttribute(String.format("page_%s",page),page);
	}


}