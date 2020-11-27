package com.weiit.web.admin.analyse.service.impl;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.analyse.mapper.AnalyseMapper;
import com.weiit.web.admin.analyse.service.AnalyseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 报表统计Service实现类
 * @author 半个鼠标
 * @date：2017-7-5 上午11:46:17
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
@Transactional(readOnly=false)
public class AnalyseServiceImpl extends AbstractService implements AnalyseService {

	@Resource
	private AnalyseMapper reportMapper;

	@Override
	public BaseMapper setMapper() {
		return reportMapper;
	}
	
	@Override
	public E selectBaseReportTotal(FormMap formMap) {
		return reportMapper.selectBaseReportTotal(formMap);
	}

	@Override
	public List<E> selectSaleTotalByProductType(FormMap formMap) {
		return reportMapper.selectSaleTotalByProductType(formMap);
	}

	@Override
	public List<E> selectMonthRegisterUserList(FormMap formMap) {
		return reportMapper.selectMonthRegisterUserList(formMap);
	}

	@Override
	public List<E> selectMonthOrderSaleTatalList(FormMap formMap) {
		return reportMapper.selectMonthOrderSaleTatalList(formMap);
	}

	@Override
	public List<E> selectHotProductList(FormMap formMap) {
		return reportMapper.selectHotProductList(formMap);
	}

	@Override
	public List<E> selectHotShopList(FormMap formMap) {
		return reportMapper.selectHotShopList(formMap);
	}

	@Override
	public E selectOrderBaseReportTotal(FormMap formMap) {
		return reportMapper.selectOrderBaseReportTotal(formMap);
	}
	
	@Override
	public List<E> selectSaleTotalByProductCateId(FormMap formMap) {
		return reportMapper.selectSaleTotalByProductCateId(formMap);
	}

	@Override
	public List<E> selectDayOrderSaleTotal(FormMap formMap) {
		return reportMapper.selectDayOrderSaleTotal(formMap);
	}

	@Override
	public List<E> selectQuarterSaleTotal(FormMap formMap) {
		return reportMapper.selectQuarterSaleTotal(formMap);
	}

}

