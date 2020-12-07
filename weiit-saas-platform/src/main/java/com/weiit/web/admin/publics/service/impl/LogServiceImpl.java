package com.weiit.web.admin.publics.service.impl;



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.publics.mapper.LogMapper;
import com.weiit.web.admin.publics.service.LogService;
/**
 * 日志管理实现类
 * @author 半个鼠标
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
public class LogServiceImpl extends AbstractService implements LogService {

    @Resource
    private LogMapper logMapper;

	@Override
	public BaseMapper setMapper() {
		// TODO Auto-generated method stub
		return logMapper;
	}
}
