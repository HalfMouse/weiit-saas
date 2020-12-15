package com.weiit.web.admin.analyse.controller;


import com.github.pagehelper.PageHelper;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.analyse.service.AnalyseService;
import com.weiit.web.base.AdminController;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

import java.util.List;

/**
 * 设计页面
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/analyse")
public class AnalyseController extends AdminController {
	
	public static Logger logger= Logger.getLogger(AnalyseController.class);
	
	@Resource
	private AnalyseService reportService;
	
	@RequestMapping("/dashboard")
    public UIview dashboard() {
    	logger.info("进入 AnalyseController-dashboard,综合统计");
    	
    	UIview result=UIView("/center/analyse/dashboard",false);
    	FormMap formMap=getFormMap();
    	//1查询基本数据统计
    	E baseReport=reportService.selectBaseReportTotal(formMap);

    	//3查询注册用户数与销售总额
    	List<E> registerUserList=reportService.selectMonthRegisterUserList(formMap);
    	List<E> saleTotalList=reportService.selectMonthOrderSaleTatalList(formMap);
    	
    	int [] registerUserArray={0,0,0,0,0,0,0,0,0,0,0,0};
    	for (E user : registerUserList) {
    		registerUserArray[user.getInt("month")-1]=user.getInt("sale_total");
		}
    	int [] saleTotalArray={0,0,0,0,0,0,0,0,0,0,0,0};
    	for (E sale : saleTotalList) {
    		saleTotalArray[sale.getInt("month")-1]=sale.getDouble("sale_total").intValue();
		}	
    	
    	// 开启分页
    	PageHelper.startPage(formMap.getPage(), 7);
    	//4查询商品销售排名榜
    	List<E> hotProductList=reportService.selectHotProductList(formMap);

    	
    	result.addObject("baseReport", baseReport);
    	result.addObject("registerUserArray", registerUserArray);
    	result.addObject("saleTotalArray", saleTotalArray);
    	result.addObject("hotProductList", hotProductList);
    	return result;
    }
	



}