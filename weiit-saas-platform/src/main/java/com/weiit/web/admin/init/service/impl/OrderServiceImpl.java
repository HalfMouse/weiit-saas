package com.weiit.web.admin.init.service.impl;


import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.OrderMapper;
import com.weiit.web.admin.init.mapper.ShopMapper;
import com.weiit.web.admin.init.service.OrderService;
import com.weiit.web.admin.init.service.ShopService;

/**
 * 订单相关Service 实现类
 * @author 半个鼠标
 * @date：2017-7-5 上午11:39:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
@Transactional(readOnly=false)
public class OrderServiceImpl extends AbstractService implements OrderService{

	@Resource
	private OrderMapper orderMapper;

	@Override
	public BaseMapper setMapper() {
		return orderMapper;
	}

	@Override
	public List<E> selectOrderList(FormMap formMap) {
		return orderMapper.selectOrderList(formMap);
	}

	@Override
	public E selectShopOrderCount(FormMap formMap) {
		return orderMapper.selectShopOrderCount(formMap);
	}

	@Override
	public List<E> selectOrderSurveyList(FormMap formMap) {
		return orderMapper.selectOrderSurveyList(formMap);
	}

	@Override
	public List<E> selectShopOrderList(FormMap formMap) {
		return orderMapper.selectShopOrderList(formMap);
	}

	@Override
	public E selectUserAddressById(FormMap formMap) {
		return orderMapper.selectUserAddressById(formMap);
	}

	@Override
	public void insertOrder(FormMap formMap) {
		orderMapper.insertOrder(formMap);
	}

	@Override
	public void insertOrderItem(FormMap formMap) {
		orderMapper.insertOrderItem(formMap);
	}

	@Override
	public E getProductItemById(FormMap formMap) {
		return orderMapper.getProductItemById(formMap);
	}

	@Override
	public List<E> getSpecInfoByIds(FormMap formMap) {
		return orderMapper.getSpecInfoByIds(formMap);
	}

	@Override
	public void updateProductAndItemStock(FormMap formMap) {
		orderMapper.updateProductStock(formMap);
		orderMapper.updateItemStock(formMap);
	}

	@Override
	public E userInfo(FormMap formMap) {
		return orderMapper.userInfo(formMap);
	}

	@Override
	public void addBalanceAndLog(FormMap formMap) {
		//插入余额记录
		insertBalance(formMap);

		formMap.put("balance",formMap.getStr("last_balance"));
		//更新用户余额
		updateUserInfo(formMap);
	}

	public void insertBalance(FormMap formMap) {
		orderMapper.insertBalance(formMap);
	}

	public void updateUserInfo(FormMap formMap) {
		orderMapper.updateUserInfo(formMap);
	}
}

