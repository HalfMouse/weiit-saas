package com.weiit.web.admin.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.user.mapper.UserMapper;
import com.weiit.web.admin.user.mapper.UserSignMapper;
import com.weiit.web.admin.user.service.UserService;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * 会员模块实现类
 * @author：半个鼠标
 * @date：2018年2月7日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("userService")
public class UserServiceImpl extends AbstractService implements UserService {

	@Resource
	private UserMapper userMapper;
	
	@Resource
	private UserSignMapper userSignMapper;

	@Override
	public BaseMapper setMapper() {
		return userMapper;
	}
 
	/**
	 * 查询会员地址
	 */
	@Override
	public List<E> selectAddressList(FormMap formMap) {
		List<E> adressList = userMapper.selectAddressList(formMap);
		return adressList;
	}
	
	/**
	 * 查询会员余额
	 */
	@Override
	public List<E> selectBalanceList(FormMap formMap) {
		List<E> balancelist = userMapper.selectBalanceList(formMap);
		return balancelist;
	}
	
	/**
	 * 查询积分记录
	 */
	@Override
	public List<E> selectIntegralList(FormMap formMap) {
		return userMapper.selectIntegralList(formMap);
	}

	/**
	 * 用户禁用与启用
	 */
	@Override
	public void forbiddenOrOpen(FormMap formMap) {
		userMapper.forbiddenOrOpen(formMap);
	}

	/**
	 * 批量禁用与启用
	 */
	@Override
	public void forbiddenOrOpenBatch(FormMap formMap) {
		userMapper.forbiddenOrOpenBatch(formMap);
	}



	/**
	 * 充值余额或赠送积分
	 */
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public void updateBalanceOrIntegralTrans(FormMap formMap) {
		//修改余额或者积分
		userMapper.updateBalanceOrIntegral(formMap);
		//查询重新查询用户
		E user=userMapper.selectById(formMap);

		FormMap param=new FormMap();
		param.put("user_id", user.get("user_id"));
		param.put("user_name", user.get("user_name"));
		param.put("shop_id", formMap.get("shop_id"));
		if(formMap.getInt("type")==1){//充值余额
			param.put("balance", formMap.get("balance"));
			param.put("last_balance", user.get("balance"));//保存当时充值后的最后余额
			param.put("remark", "后台充值金额");
			param.put("type", 2);//表示后台充值业务
			if(formMap.getStr("balance").indexOf("-")==-1){
				param.put("state", 0);
			}else{
				param.put("state", -1);
			}

			//先记录余额记录
			userMapper.insertBalanceLog(param);
		}
		if(formMap.getInt("type")==2){//赠送积分
			param.put("integral", formMap.get("integral"));
			param.put("last_integral", user.get("integral"));//保存当时赠送积分后的最后积分
			param.put("remark", "后台赠送积分:"+formMap.get("integral"));
			param.put("type", 2);//表示后台充值业务
			if(formMap.getStr("integral").indexOf("-")==-1){
				param.put("state", 0);
			}else{
				param.put("state", -1);
			}
			userMapper.insertIntegralLog(param);
		}
	}

	@Override
	public List<E> selectUserList(FormMap formMap) {
		
		List<E> userList=userMapper.selectList(formMap);
		for (E user : userList) {
			formMap.set("user_id", user.getStr("user_id"));
			List<E> signList=userSignMapper.selectSignNameListByUserId(formMap);
			user.set("signList", signList);
		}
		return userList;
	}

	@Override
	public List<E> selectListByUserIds(FormMap formMap) {
		return userMapper.selectListByUserIds(formMap);
	}
	
}
