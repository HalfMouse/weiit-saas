package com.weiit.web.admin.ump.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.ump.mapper.BargainMapper;
import com.weiit.web.admin.ump.service.BargainService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/**
 *  秒杀 实现类
 * Title: CouponServiceImpl.java
 * Description: 
 * Company: 微云时代
 * @author hzy
 * @date 2017年12月26日
 */
@Service("bargainService")
public class BargainServiceImpl extends AbstractService implements BargainService {

	@Resource
	private BargainMapper bargainMapper;
	@Override
	public BaseMapper setMapper() {
		return bargainMapper;
	}

	@Override
	public List<E> selectBargainDetailList(FormMap formmap) {
		return bargainMapper.selectBargainDetailList(formmap);
	}

	@Override
	public List<E> selectBargainNancyList(FormMap formmap) {
		return bargainMapper.selectBargainNancyList(formmap);
	}

	@Override
	public List<E> selectProductList(FormMap formmap) {
		// TODO Auto-generated method stub
		return bargainMapper.selectProductList(formmap);
	}

	@Override
	public List<E> getProductByBargainIds(FormMap formmap) {
		return bargainMapper.getProductByBargainIds(formmap);
	}
}
