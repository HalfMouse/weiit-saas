package com.weiit.web.admin.analyse.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 报表统计Service
 * @author 半个鼠标
 * @date：2017-7-5 上午11:45:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface AnalyseService extends BaseService {
	
	E selectBaseReportTotal(FormMap formMap);
	
	List<E> selectSaleTotalByProductType(FormMap formMap);
	
	List<E> selectMonthRegisterUserList(FormMap formMap);
	
	List<E> selectMonthOrderSaleTatalList(FormMap formMap);
	
	List<E> selectHotProductList(FormMap formMap);
	
	List<E> selectHotShopList(FormMap formMap);
	
	E selectOrderBaseReportTotal(FormMap formMap);
	
	List<E> selectSaleTotalByProductCateId(FormMap formMap);
	
	List<E> selectDayOrderSaleTotal(FormMap formMap);
	
	List<E> selectQuarterSaleTotal(FormMap formMap);
}
