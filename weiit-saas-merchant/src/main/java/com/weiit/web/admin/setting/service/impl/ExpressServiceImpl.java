package com.weiit.web.admin.setting.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.setting.mapper.ExpressMapper;
import com.weiit.web.admin.setting.service.ExpressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/**
 * 快递mapper
 * @author：半个鼠标
 * @date：2018年6月5日 下午2:58:33
 * @version 2.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("expressService")
public class ExpressServiceImpl  extends AbstractService  implements  ExpressService{

	@Resource
	private ExpressMapper expressMapper;

	@Override
	public BaseMapper setMapper() {
		return expressMapper;
	}

	@Override
	public List<E> selectAllExpressList(FormMap formMap) {
		return expressMapper.selectAllExpressList(formMap);
	}

	@Override
	public E selectExpressAliByExpressId(FormMap formMap) {
		return expressMapper.selectExpressAliByExpressId(formMap);
	}  
}
