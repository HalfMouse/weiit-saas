package com.weiit.web.api.service.impl;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.api.mapper.UserMapper;
import com.weiit.web.api.service.UserService;
import com.weiit.web.common.RedisKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class UserServiceImpl extends AbstractService implements UserService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Resource
	private UserMapper userMapper;

	@Resource
	RedisUtil redisUtil;
	
	@Override
	public BaseMapper setMapper() {
		return userMapper;
	}

	@Override
	public E userInfo(FormMap formMap) {
		return userMapper.userInfo(formMap);
	}

	@Override
	public E getShopInfo(FormMap formMap) {
		return userMapper.getShopInfo(formMap);
	}
	@Override
	public E selectUserInfoByOpenId(FormMap formMap) {
		return userMapper.selectUserInfoByOpenId(formMap);
	}

	@Override
	public void updateUserInfo(FormMap formMap) {
		userMapper.updateUserInfo(formMap);
	}

	
	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public void myAddressSaveTrans(FormMap formMap) {
		//如果添加地址时传递一定要设置为默认，则先把用户的其他的地址都修改非默认
		if(!StringUtils.isEmpty(formMap.getStr("is_default"))&&formMap.getInt("is_default")==0){
			//先把用户的地址都设置非默认
			FormMap param=new FormMap();
			param.put("user_id",formMap.getStr("user_id"));
			userMapper.myAddressCancelAllDefault(formMap);
		}
		formMap.put("user_id", formMap.getStr("user_id"));
		formMap.put("user_name",formMap.getStr("user_name"));
		userMapper.myAddressSave(formMap);
	}
	
	@Override
	public List<E> myAddressList(FormMap formMap) {
		return userMapper.myAddressList(formMap);
	}
	@Override
	public int myAddressCount(FormMap formMap) {
		return userMapper.myAddressCount(formMap);
	}

	@Override
	public void myAddressCancelAllDefault(FormMap formMap) {
		userMapper.myAddressCancelAllDefault(formMap);
	}
	
	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public void myAddressUpdateTrans(FormMap formMap) {
		//如果修改地址时传递一定要设置为默认，则先把用户的其他的地址都修改非默认
		if(!StringUtils.isEmpty(formMap.getStr("is_default"))&&formMap.getInt("is_default")==0){
			//先把用户的地址都设置非默认
			FormMap param=new FormMap();
			param.put("user_id",formMap.getStr("user_id"));
			myAddressCancelAllDefault(formMap);
		}
		userMapper.myAddressUpdate(formMap);
	}
	
	@Override
	public void myAddressDelete(FormMap formMap) {
		userMapper.myAddressDelete(formMap);
	}

	@Override
	public List<E> myCoupons(FormMap formMap) {
		List<E> coupons=userMapper.myCoupons(formMap);
		
		/*后端优化优惠券的返回  ，开始*/
		//优惠券集合
		List<E> list=new ArrayList<E>();
		for (E coupon : coupons) {
			
			E result=new E();
			result.put("coupon_name", coupon.getStr("coupon_name"));
			
			//判断优惠券是金额券、打折券、金额券（固定）
			if(coupon.getInt("type")==1){//金额券（固定）
				result.put("coupon_content", coupon.getStr("coupon_price"));
			}else if(coupon.getInt("type")==2){//打折券
				result.put("coupon_content", coupon.getStr("coupon_discount"));
			}else{//金额券（随机）
				result.put("coupon_content", coupon.getStr("random_min_price"));
			}
			result.put("type", coupon.getInt("type"));
			//优惠券使用时间
			result.put("time", coupon.getStr("startTime")+"~"+coupon.getStr("endTime"));
//
			//判断优惠券限制条件内容
			if(coupon.getInt("is_condition")==-1){
				result.put("condition", "无限制");
			}else{
				result.put("condition", "满"+coupon.getStr("condition_price"));
			}
			
			//判断优惠券适用商品
			if(coupon.getStr("product_range_type").equals("2")){//表示部分商品适用
				result.put("product", "部分商品");
			}else{//所有商品通用
				result.put("product", "全部商品");
			}
			result.put("state", coupon.getInt("state"));
			result.put("coupon_desc", coupon.getStr("coupon_desc"));
			
			list.add(result);
		}
		/*后端优化优惠券的返回  ，结束*/
		return list;
	}

	@Override
	public List<E> myCollectionList(FormMap formMap) {
		return userMapper.myCollectionList(formMap);
	}
	@Override
	public int myCollectionCount(FormMap formMap) {
		return userMapper.myCollectionCount(formMap);
	}

	@Override
	public void myCollectionDelete(FormMap formMap) {
		userMapper.myCollectionDelete(formMap);
	}

	@Override
	public void addSuggest(FormMap formMap) {
		userMapper.addSuggest(formMap);
	}

	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public void addBalanceAndLog(FormMap formMap) {
			//插入余额记录
			insertBalance(formMap);

			formMap.put("balance",formMap.getStr("last_balance"));
			//更新用户余额
			updateUserInfo(formMap);

	}

	@Override
	public List<E> myIntegralLog(FormMap formMap) {
		return userMapper.myIntegralLog(formMap);
	}

	@Override
	public List<E> myBalanceLog(FormMap formMap) {
		return userMapper.myBalanceLog(formMap);
	}

	@Override
	public void myBalanceExtract(FormMap formMap) {
		userMapper.myBalanceExtract(formMap);
	}

	@Override
	public void insertBalance(FormMap formMap) {
		userMapper.insertBalance(formMap);
	}
	@Override
	public int addCashLog(FormMap formMap) {
		return userMapper.addCashLog(formMap);
	}

	@Override
	public void addUserPageViewLog(FormMap formMap,boolean limit) {
		if (limit){
//			//判断  该用户  该页面类型  今天是否已访问
//			if (redisUtil.getExpire(RedisKey.USERVIEWLOG+formMap.getStr("wx_open_id")+"_"+formMap.getStr("page_type")+"_"+formMap.getStr("page_type"))>0){
//				return;
//			}
			userMapper.addUserPageViewLog(formMap);
//			redisUtil.set(RedisKey.USERVIEWLOG+formMap.getStr("wx_open_id")+"_"+formMap.getStr("page_type")+"_"+formMap.getStr("type_id"), DateUtil.getSurplusSecond());
		}

		userMapper.addUserPageViewLog(formMap);

	}

	@Override
	public void addUserShopViewLog(FormMap formMap) {
		logger.info("店铺访客记录 请求参数{}",formMap.toString());
		logger.info("店铺访客记录 请求参数{}",RedisKey.USERVIEWLOG+formMap.getStr("user_id"));
		//店铺访客记录  一个用户一天统计一次
//		Long time =redisUtil.getExpire(RedisKey.USERVIEWLOG+formMap.getStr("user_id"));
//		if (time.intValue()>0){
//			return;
//		}
		userMapper.addUserShopViewLog(formMap);
//		redisUtil.set(RedisKey.USERVIEWLOG+formMap.getStr("user_id"),formMap.getStr("user_id"), DateUtil.getSurplusSecond());
	}

	@Override
	public void updateUserIntegral(FormMap formMap) {
		userMapper.updateUserIntegral(formMap);
	}
	@Override
	public void updateUserPhone(FormMap formMap) {
		userMapper.updateUserPhone(formMap);
	}

	@Override
	public void addUserIntegralLog(FormMap formMap) {
		userMapper.addUserIntegralLog(formMap);
	}
	@Override
	public E selectMerchantInfoByShopId(FormMap formMap) {
		return userMapper.selectMerchantInfoByShopId(formMap);
	}


}
