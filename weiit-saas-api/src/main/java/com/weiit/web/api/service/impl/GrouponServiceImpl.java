package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.GrouponMapper;
import com.weiit.web.api.service.GrouponService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import javax.annotation.Resource;
import java.util.List;


/**
 *  拼团 实现类
 * Title: GrouponServiceImpl.java
 * Description: 
 * Company: 微邦互联
 * @author lhq
 * @date 2018年5月10日
 */
@Service("grouponService")
@Transactional(readOnly = false)
public class GrouponServiceImpl extends AbstractService implements GrouponService {

	@Resource
	private GrouponMapper grouponMapper;
	@Override
	public BaseMapper setMapper() {
		return grouponMapper;
	}


	@Override
	public List<E> grouponListByIds(FormMap formMap) {
		return grouponMapper.grouponListByIds(formMap);
	}

	@Override
	public List<E> inProcessGroupon(FormMap formMap) {
		return grouponMapper.inProcessGroupon(formMap);
	}

	@Override
	public List<E> getJoinGrouponInfo(FormMap formMap) {
		return grouponMapper.getJoinGrouponInfo(formMap);
	}

	@Override
	public List<E> getMyGroupon(FormMap formMap) {
		return grouponMapper.getMyGroupon(formMap);
	}
	@Override
	public List<E> getShopAllGroupon(FormMap formMap) {
		return grouponMapper.getShopAllGroupon(formMap);
	}

	@Override
	public E inProcessGrouponExt(FormMap formMap) {
		return grouponMapper.inProcessGrouponExt(formMap);
	}


	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public int insertGrouponOrder(FormMap formMap) {
		return grouponMapper.insertGrouponOrder(formMap);
	}

	@Override
	public void updateGrouponOrderByOrderNum(FormMap formMap) {
		grouponMapper.updateGrouponOrderByOrderNum(formMap);
	}

	@Override
	public void updateAllGrouponOrderById(FormMap formMap) {
		grouponMapper.updateAllGrouponOrderById(formMap);
	}



	@Override
	public  E getGrouponOrderById(FormMap formMap) {
		return grouponMapper.getGrouponOrderById(formMap);
	}
	@Override
	public  E productSpecCheck(FormMap formMap) {
		return grouponMapper.productSpecCheck(formMap);
	}
	@Override
	public  E getProductInfoByGOrderId(FormMap formMap) {
		return grouponMapper.getProductInfoByGOrderId(formMap);
	}
	@Override
	public  E getUserGrouponInfoByGOrderId(FormMap formMap) {
		return grouponMapper.getUserGrouponInfoByGOrderId(formMap);
	}

	@Override
	public  E selectStartGrouponMsgInfo(FormMap formMap) {
		return grouponMapper.selectStartGrouponMsgInfo(formMap);
	}

	@Override
	public  E selectMrsWuByJoinOrderNum(FormMap formMap) {
		return grouponMapper.selectMrsWuByJoinOrderNum(formMap);
	}
	@Override
	public  E selectAuthorizerAppIdByUserId(FormMap formMap) {
		return grouponMapper.selectAuthorizerAppIdByUserId(formMap);
	}
	@Override
	public  E getMchKeyByGrouponOrderNo(String formMap) {
		return grouponMapper.getMchKeyByGrouponOrderNo(formMap);
	}
	@Override
	public  int isJoinGrouponByOrderId(FormMap formMap) {
		return grouponMapper.isJoinGrouponByOrderId(formMap);
	}
	@Override
	public  int hasGrouponCount(FormMap formMap) {
		return grouponMapper.hasGrouponCount(formMap);
	}


}
