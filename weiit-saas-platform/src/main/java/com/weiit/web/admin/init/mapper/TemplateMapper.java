package com.weiit.web.admin.init.mapper;
 
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

/**
 * 模板管理Mapper
 * @author 半个鼠标
 * @date：2017-7-5 上午11:39:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface TemplateMapper extends BaseMapper{
	int editState(FormMap formmap);
}
