package com.weiit.web.admin.analyse.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 报表统计Mapper
 * @author 半个鼠标
 * @date：2017-7-5 上午11:39:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface AnalyseMapper extends BaseMapper {
	
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
