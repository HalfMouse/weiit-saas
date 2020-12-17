package com.weiit.web.admin.init.service.impl;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.ServiceMapper;
import com.weiit.web.admin.init.service.ServiceService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 收费服务项目Mapper
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("serviceService")
public class ServiceServiceImpl extends AbstractService implements ServiceService {

    @Resource
    private ServiceMapper serviceMapper;

    @Override
	public BaseMapper setMapper() {
		return serviceMapper;
	}

	@Override
	public E selectOrderTimeConfigByName(FormMap formMap) {
		return serviceMapper.selectOrderTimeConfigByName(formMap);
	}

	@Override
	public void editOrderTimeConfig(FormMap formMap) {
		serviceMapper.editOrderTimeConfig(formMap);
	}

	@Override
	public List<E> selectVersionList(FormMap formMap) {
		List<E> versionList=serviceMapper.selectVersionList(formMap);
		FormMap param=new FormMap();
		for (E version : versionList) {
			param.clear();
			param.set("version_num", version.getStr("version_num"));
			List<E> versionServiceList=serviceMapper.selectVersionServiceList(param);
			version.put("versionServiceList", versionServiceList);
		}
		return versionList;
	}

	@Override
	public E selectVersionOne(FormMap formMap) {
		return serviceMapper.selectVersionOne(formMap);
	}

	@Override
	public void insertVersion(FormMap formMap) {
		serviceMapper.insertVersion(formMap);
	}

	@Override
	public void editVersion(FormMap formMap) {
		serviceMapper.editVersion(formMap);
	}

	@Override
	public E selectMaxSortNum(FormMap formMap) {
		return serviceMapper.selectMaxSortNum(formMap);
	}
	
	/**
	 * 给版本添加服务信息，先删除原来的服务，再新增
	 */
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public void insertVersionServiceTrans(FormMap formMap){
		//先按照版本编号删除原有服务,按照version_num删除
		serviceMapper.removeVersionService(formMap);
		
		//给版本添加新服务列表
		String [] service_nums=(String [])formMap.get("service_num");
		FormMap param=new FormMap();
		for (int i = 0; i < service_nums.length; i++) {
			param.clear();
			param.set("service_num", service_nums[i]);
			param.set("version_num", formMap.getStr("version_num"));
			serviceMapper.insertVersionService(param);
		}
		
	}

	@Override
	public List<E> selectOrderTimeList(FormMap formMap) {
		// TODO Auto-generated method stub
		return serviceMapper.selectOrderTimeList(formMap);
	}
	
}
