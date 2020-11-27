package com.weiit.web.admin.user.service.impl;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.user.mapper.UserCashMapper;
import com.weiit.web.admin.user.mapper.UserMapper;
import com.weiit.web.admin.user.service.UserCashService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


/**
 * 商品横幅活动实现类
 * Title: ProductBannerServiceImpl.java
 * Description: 
 * Company: 微云时代
 * @author lichengmeng
 * @date 2016年6月6日
 */
@Service("userCashService")
public class UserCashServiceImpl extends AbstractService implements UserCashService {

	@Resource
	private UserCashMapper userCashMapper;
	@Resource
	private UserMapper userMapper;
	
	@Override
	public BaseMapper setMapper() {
		return userCashMapper;
	} 
	
	/**
	 * 提现， 审批通过返回余额，通过改状态
	 */
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public int edit(FormMap formMap) {
		userCashMapper.edit(formMap);
		if(formMap.getInt("state")==-1){//返还提现余额，并记录余额记录
			E cashInfo=userCashMapper.selectOne(formMap);
			
			formMap.put("type", 1);
			formMap.put("validate_id", cashInfo.get("user_id"));
			//修改余额
			userMapper.updateBalanceOrIntegral(formMap);
			//查询重新查询用户
			E user=userMapper.selectById(formMap);
				
			FormMap param=new FormMap();
			param.put("user_id", user.get("user_id"));
			param.put("user_name", user.get("user_name"));
			param.put("shop_id", formMap.get("shop_id"));
		
			param.put("balance", formMap.get("balance"));
			param.put("last_balance", user.get("balance"));//保存当时充值后的最后余额
			param.put("remark", "提现余额失败返还金额:"+formMap.get("balance"));
			param.put("type", 2);//表示后台充值业务
			if(formMap.getStr("balance").indexOf("-")==-1){
				param.put("state", 0);
			}else{
				param.put("state", -1);
			}
			userMapper.insertBalanceLog(param);
		}
		return 1;
	}
	  
}
