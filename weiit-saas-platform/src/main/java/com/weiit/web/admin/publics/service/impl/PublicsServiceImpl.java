package com.weiit.web.admin.publics.service.impl;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.publics.mapper.PublicsMapper;
import com.weiit.web.admin.publics.service.PublicsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公共服务接口实现类
 * @author 半个鼠标
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("publicsService")
public class PublicsServiceImpl extends AbstractService  implements PublicsService{
	
	@Resource
	private PublicsMapper publicsMapper;
	
	@Override
	public BaseMapper setMapper() {
		return publicsMapper;
	}
	
	public List<E> selectRegionList(FormMap formMap){
		return publicsMapper.selectRegionList(formMap);
	}
	
	public E selectRegionById(FormMap formMap){
		return publicsMapper.selectRegionById(formMap);
	}

}
