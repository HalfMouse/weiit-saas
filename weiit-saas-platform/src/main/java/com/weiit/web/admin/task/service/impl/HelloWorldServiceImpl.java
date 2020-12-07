package com.weiit.web.admin.task.service.impl;



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.publics.mapper.LogMapper;
import com.weiit.web.admin.publics.service.LogService;
import com.weiit.web.admin.task.mapper.HelloWorldMapper;
import com.weiit.web.admin.task.service.HelloWorldService;


@Service
public class HelloWorldServiceImpl extends AbstractService implements HelloWorldService {

    @Resource
    private HelloWorldMapper helloWorldMapper;

	@Override
	public BaseMapper setMapper() {
		return helloWorldMapper;
	}
}
