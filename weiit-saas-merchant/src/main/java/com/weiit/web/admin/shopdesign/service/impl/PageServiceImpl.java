package com.weiit.web.admin.shopdesign.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.shopdesign.mapper.PageMapper;
import com.weiit.web.admin.shopdesign.service.PageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/** 
 * Title: PageServiceImpl.java
 * Description:  微页面装修
 * Company: 微邦互联 
 * @author hzy
 * @date 2018年4月27日
 */
@Service("PageService")
public class PageServiceImpl extends AbstractService implements PageService{

	@Resource
	PageMapper pageMapper;

	@Override
	public BaseMapper setMapper() {
		return pageMapper;
	}


	@Override
	public void pageDefault(FormMap formMap) {
		if (StringUtils.isEmpty(formMap.getStr("shop_id"))){
			return;
		}
		pageMapper.clearDefault(formMap);
		pageMapper.pageDefault(formMap);
	}

	@Override
	public int pageView(E param) {
		return pageMapper.pageView(param);
	}

	@Override
	public List<E> selectTemplateCate(FormMap formMap) {
		return pageMapper.selectTemplateCate(formMap);
	}
	@Override
	public List<E> selectTemplatePage(FormMap formMap) {
		return pageMapper.selectTemplatePage(formMap);
	}

	@Override
	public E getTemplatePageJson(Integer templateId) {
		return pageMapper.getTemplatePageJson(templateId);
	}
}
