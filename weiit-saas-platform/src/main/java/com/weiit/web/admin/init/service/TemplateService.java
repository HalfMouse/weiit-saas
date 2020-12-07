package com.weiit.web.admin.init.service;
 
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

/**
 * 模板管理Service
 * @author 半个鼠标
 * @date：2017-7-5 上午11:45:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface TemplateService extends BaseService{
	int editState(FormMap formmap);
}
