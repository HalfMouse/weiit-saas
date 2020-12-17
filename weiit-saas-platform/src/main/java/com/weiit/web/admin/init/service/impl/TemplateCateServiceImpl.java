package com.weiit.web.admin.init.service.impl;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.TemplateCateMapper;
import com.weiit.web.admin.init.service.TemplateCateService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 模板分类Mapper
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("TemplateCateService")
public class TemplateCateServiceImpl extends AbstractService implements TemplateCateService {

    @Resource
    private TemplateCateMapper templateCateMapper;

    @Override
	public BaseMapper setMapper() {
		return templateCateMapper;
	}
}
