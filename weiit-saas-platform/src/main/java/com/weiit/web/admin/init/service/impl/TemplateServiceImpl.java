package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.TemplateMapper;
import com.weiit.web.admin.init.service.TemplateService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 模板管理Service实现类
 * @author 半个鼠标
 * @date：2017-7-5 上午11:46:17
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
public class TemplateServiceImpl extends AbstractService implements TemplateService{

	@Resource
	private TemplateMapper templateMapper;

	@Override
	public BaseMapper setMapper() {
		return templateMapper;
	}
  
	@Override
	public int editState(FormMap formmap){
		return templateMapper.editState(formmap);
	}
	
}

