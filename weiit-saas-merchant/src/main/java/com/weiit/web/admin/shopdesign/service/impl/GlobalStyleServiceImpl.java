package com.weiit.web.admin.shopdesign.service.impl;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.shopdesign.mapper.GlobalStyleMapper;
import com.weiit.web.admin.shopdesign.service.GlobalStyleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


/** 
 * Title: CustomGlobalServiceImpl.java
 * Description: 装修，全店风格页面
 * Company: 微邦互联 
 * @author hzy
 * @date 2017年12月7日
 */
@Service("PageGlobalService")
public class GlobalStyleServiceImpl extends AbstractService implements GlobalStyleService {

	@Resource
	private GlobalStyleMapper globalStyleMapper;
	@Override
	public BaseMapper setMapper() {
		return globalStyleMapper;
	} 
	  
}
