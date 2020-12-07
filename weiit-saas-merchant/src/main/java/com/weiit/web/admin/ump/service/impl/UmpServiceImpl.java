package com.weiit.web.admin.ump.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.ump.mapper.UmpMapper;
import com.weiit.web.admin.ump.service.UmpService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/**
 * 营销Service实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("umpService")
public class UmpServiceImpl extends AbstractService implements UmpService {

	@Resource
	private UmpMapper umpMapper;
	
	@Override
	public BaseMapper setMapper() {
		return umpMapper;
	}

	@Override
	public List<E> selectServiceList(FormMap formMap) {
		return umpMapper.selectServiceList(formMap);
	}

	@Override
	public E selectServiceByServiceNum(FormMap formMap) {
		return umpMapper.selectServiceByServiceNum(formMap);
	}

	@Override
	public List<E> selectOrderTimeList(FormMap formMap) {
		return umpMapper.selectOrderTimeList(formMap);
	}

	@Override
	public E selectOrderTimeConfigByName(FormMap formMap) {
		return umpMapper.selectOrderTimeConfigByName(formMap);
	}
	
}
