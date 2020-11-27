package com.weiit.web.admin.dashboard.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.dashboard.mapper.DashBoardMapper;
import com.weiit.web.admin.dashboard.service.DashBoardService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 数据--概况实现类
 * @author zhouliang
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("dashBoardService")
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class DashBoardServiceImpl extends AbstractService implements DashBoardService{
	
	@Resource
	private DashBoardMapper dashBoardMapper;

	@Override
	public BaseMapper setMapper() {
		return dashBoardMapper;
	}
	 
	@Override
	public List<E> selectBrowseList(FormMap formmap){
		return dashBoardMapper.selectBrowseList(formmap);
	}
	
	
	@Override
	public List<E> selectBrowseCountList(FormMap formmap){
		return dashBoardMapper.selectBrowseCountList(formmap);
	}
	
	@Override
	public E selectPageCount(FormMap formmap){
		return dashBoardMapper.selectPageCount(formmap);
	}
	
	@Override
	public E selectProductCount(FormMap formmap){
		return dashBoardMapper.selectProductCount(formmap);
	}
	
	@Override
	public E selectOrderSurveyCount(FormMap param){
		return dashBoardMapper.selectOrderSurveyCount(param);
	}
	@Override
	public List<E> selectOrderSurveyList(FormMap param){
		return dashBoardMapper.selectOrderSurveyList(param);
	}
	
	@Override
	public E selectUserCount(FormMap param){
		return dashBoardMapper.selectUserCount(param);
	}
	
	@Override
	public List<E> selectUserCountList(FormMap param){
		return dashBoardMapper.selectUserCountList(param);
	}
}
