package com.weiit.web.admin.user.service.impl;


import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.user.mapper.UserCashMapper;
import com.weiit.web.admin.user.mapper.UserMapper;
import com.weiit.web.admin.user.mapper.UserSignMapper;
import com.weiit.web.admin.user.service.UserCashService;
import com.weiit.web.admin.user.service.UserSignService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


/**
 * 会员标签组管理实现类
 * @author：半个鼠标
 * @date：2018年2月6日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("userSignService")
public class UserSignServiceImpl extends AbstractService implements UserSignService {

	@Resource
	private UserSignMapper userSignMapper;
	
	@Override
	public BaseMapper setMapper() {
		return userSignMapper;
	}

	@Override
	public void insertSignLog(FormMap formMap) {
		userSignMapper.insertSignLog(formMap);
	}

	@Override
	public List<E> selectSignNameListByUserId(FormMap formMap) {
		return userSignMapper.selectSignNameListByUserId(formMap);
	}

	@Override
	public List<E> selectUserListBySignIds(FormMap formMap) {
		return userSignMapper.selectUserListBySignIds(formMap);
	}

	
	  
}
