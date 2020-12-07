package com.weiit.web.admin.setting.service.impl;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.setting.mapper.ProtocolMapper;
import com.weiit.web.admin.setting.service.ProtocolService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


/**
 * 商品横幅活动实现类
 * Title: ProductBannerServiceImpl.java
 * Description: 
 * Company: 微云时代
 * @author lichengmeng
 * @date 2016年6月6日
 */
@Service("protocolService")
public class ProtocolServiceImpl  extends AbstractService  implements  ProtocolService{

	@Resource
	private ProtocolMapper protocolMapper;
	
	@Override
	public BaseMapper setMapper() {
		return protocolMapper;
	} 
}
