package com.weiit.web.admin.task.service.impl;

import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.task.mapper.MerchantMapper;
import com.weiit.web.admin.task.service.MerchantService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
@Service
public class MerchantServiceImpl extends AbstractService implements MerchantService {

    @Resource
    MerchantMapper merchantMapper;
 

    @Override
    public BaseMapper setMapper() {
        return merchantMapper;
    }
 
	@Override
	public void editMerchantService(FormMap formMap) {
		merchantMapper.editMerchantService(formMap);
	}
	
}
