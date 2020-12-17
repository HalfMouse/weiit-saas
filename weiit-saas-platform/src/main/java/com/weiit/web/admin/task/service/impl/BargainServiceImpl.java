package com.weiit.web.admin.task.service.impl;

import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.task.mapper.BargainMapper;
import com.weiit.web.admin.task.service.BargainService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
@Service
public class BargainServiceImpl extends AbstractService implements BargainService {

    @Resource
    BargainMapper bargainMapper;
 

    @Override
    public BaseMapper setMapper() {
        return bargainMapper;
    }

	@Override
	public void editBargainOrder(FormMap formMap) {
		bargainMapper.editBargainOrder(formMap);
	}
 
    
}
