package com.weiit.web.admin.shopdesign.service.impl;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.shopdesign.mapper.PageUserMapper;
import com.weiit.web.admin.shopdesign.service.PageUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


/** 
 * Title: CustomUserServiceImpl.java
 * Description: 装修，会员主页
 * Company: 微邦互联 
 * @author hzy
 * @date 2017年12月7日
 */
@Service("pageUserService")
public class PageUserServiceImpl extends AbstractService implements PageUserService {

	@Resource
	private PageUserMapper pageUserMapper;
	@Override
	public BaseMapper setMapper() {
		return pageUserMapper;
	} 
	  
}
