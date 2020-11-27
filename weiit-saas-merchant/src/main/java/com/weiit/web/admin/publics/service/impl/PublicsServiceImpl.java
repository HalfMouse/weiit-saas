package com.weiit.web.admin.publics.service.impl;

 
import java.util.List; 
import javax.annotation.Resource;

import org.springframework.stereotype.Service; 

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService; 
import com.weiit.web.admin.publics.mapper.PublicsMapper;
import com.weiit.web.admin.publics.service.PublicsService;

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

	public List<E> productList(FormMap param){
		return publicsMapper.productList(param);
	}

	public List<E> selectOrdersExpress(FormMap param){
		return publicsMapper.selectOrdersExpress(param);
	}
	
	public List<E> selectWeixinLink(FormMap param){
		return publicsMapper.selectWeixinLink(param);
	}
}
