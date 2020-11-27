package com.weiit.web.admin.setting.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service; 
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;  
import com.weiit.web.admin.setting.mapper.AddressMapper;
import com.weiit.web.admin.setting.mapper.ProtocolMapper;
import com.weiit.web.admin.setting.service.AddressService;
import com.weiit.web.admin.setting.service.ProtocolService;


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
