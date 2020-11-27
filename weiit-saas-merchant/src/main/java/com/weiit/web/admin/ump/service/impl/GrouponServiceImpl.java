package com.weiit.web.admin.ump.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.ump.mapper.GrouponMapper;
import com.weiit.web.admin.ump.service.GrouponService;
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
@Service("grouponService")
public class GrouponServiceImpl extends AbstractService implements  GrouponService{

	@Resource
	private GrouponMapper grouponMapper;
	@Override
	public BaseMapper setMapper() {
		return grouponMapper;
	}

	public List<E> selectGrouponDetailList(FormMap formmap) {
		return grouponMapper.selectGrouponDetailList(formmap);
	}
	
	public List<E> selectGrouponNancyList(FormMap formmap) {
		return grouponMapper.selectGrouponNancyList(formmap);
	}

	@Override
	public List<E> selectProductList(FormMap formMap) {
		// TODO Auto-generated method stub
		return grouponMapper.selectProductList(formMap);
	}


	@Override
	public List<E> grouponListByIds(FormMap formMap) {
		return grouponMapper.grouponListByIds(formMap);
	}

	@Override
	public List<E> grouponItemById(FormMap formMap) {
		return grouponMapper.grouponItemById(formMap);
	}

	@Override
	public void insertGrouponItem(E param) {
		grouponMapper.insertGrouponItem(param);
	}

	@Override
	public void updateGrouponItem(E param) {
		grouponMapper.updateGrouponItem(param);
	}

	@Override
	public int selectGrouponCount(FormMap formMap) {
		return grouponMapper.selectGrouponCount(formMap);
	}


}
