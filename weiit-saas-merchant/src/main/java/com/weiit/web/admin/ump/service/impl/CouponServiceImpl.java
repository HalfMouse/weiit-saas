package com.weiit.web.admin.ump.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.ump.mapper.CouponMapper;
import com.weiit.web.admin.ump.service.CouponService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;


/**
 * 优惠券实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("couponService")
@Transactional(readOnly=false)
public class CouponServiceImpl extends AbstractService implements CouponService {

	@Resource
	private CouponMapper couponMapper;
	
	@Override
	public BaseMapper setMapper() {
		return couponMapper;
	} 
	
	/**
	 * 查询没有领取优惠券的会员
	 */
	public List<E> selectNoCouponUserList(FormMap formMap){
		return couponMapper.selectNoCouponUserList(formMap);
	}
	
	/**
	 * 查询没有领取优惠券的会员或者领取没有达到限制的会员
	 */
	public List<E> selectCouponUserList(FormMap formMap){
		return couponMapper.selectCouponUserList(formMap);
	}

	@Override
	public List<E> couponListByIds(FormMap formMap) {
		return couponMapper.couponListByIds(formMap);
	}

	/**
	 * 优惠券 派发用户列表
	 */
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public String insertCouponUserTrans(FormMap formMap){
		int type=formMap.getInt("type");
		
		if(type==0){//单个派送
			//判断优惠券库存是否足够
			E e=couponMapper.selectOne(formMap);
			List<E> haveCouponUserList = couponMapper.selectCouponUserList(formMap);
			if(e.getInt("number")<haveCouponUserList.size()){
				return "派送优惠券失败,原因优惠券库存不足";
			}
			formMap.put("state", "0");//设置优惠券未使用
			couponMapper.insertCouponUser(formMap);
		}
		else if(type==1){//批量派送
			String userId[] = formMap.getStr("userIds").split(",");
			if(userId.length> 0){
				//判断优惠券库存是否足够
				E e=couponMapper.selectOne(formMap);
				List<E> haveCouponUserList = couponMapper.selectCouponUserList(formMap);
				int count=haveCouponUserList.size()+userId.length;//已经拥有优惠券的会员+待发放的会员的总和
				if(e.getInt("number")<count){
					return "批量派送优惠券失败,原因优惠券库存不足";
				}
				for(int i=0;i< userId.length;i++){
					formMap.put("user_id", userId[i]);
					formMap.put("state", "0");//设置优惠券未使用
					couponMapper.insertCouponUser(formMap);
				}
			}
		}
		else if(type==2){//全部派送
			FormMap param = formMap ;
			param.remove("pageNo");
			param.remove("pageSize");
			List<E> usersList = couponMapper.selectNoCouponUserList(param);
			if(usersList.size() > 0){
				//判断优惠券库存是否足够
				E e=couponMapper.selectOne(formMap);
				List<E> haveCouponUserList = couponMapper.selectCouponUserList(formMap);
				int count=haveCouponUserList.size()+usersList.size();//已经拥有优惠券的会员+待发放的会员的总和
				if(e.getInt("number")<count){
					return "全部派送优惠券失败,原因优惠券库存不足";
				}
				for(int i=0 ;i < usersList.size(); i++){
					E user = (E) usersList.get(i);
					formMap.put("user_id", user.get("user_id"));
					formMap.put("state", "0");//设置优惠券未使用
					couponMapper.insertCouponUser(formMap);
				}
			}
		}
		return null;
	}
	
	/**
	 * 回收会员优惠券
	 */
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public String  removeCouponUserTrans(FormMap formMap){
		int type=formMap.getInt("type");
		formMap.put("state", "0");
		if(type==0){//单个回收优惠券
			//查询用户是否已经使用过该优惠券，已使用的优惠券不可以回收
			formMap.set("state", 1);
			List<E> userUseList=couponMapper.selectCouponUserList(formMap);
			if(userUseList.size()>0){
				return "该优惠券已被使用，不可回收。";
			}
			couponMapper.removeCouponUser(formMap);
		}
		else if(type==1){//批量回收优惠券
			String userId[] = formMap.getStr("ids").split(",");
			if(userId.length> 0){
				for(int i=0;i< userId.length;i++){
					formMap.put("id", userId[i]);
					//查询用户是否已经使用过该优惠券，已使用的优惠券不可以回收
					formMap.set("state", 1);
					List<E> userUseList=couponMapper.selectCouponUserList(formMap);
					if(userUseList.size()>0){
						return "批量回收优惠券时失败,不能选择已经使用过优惠券的用户进行回收.";
					}
					couponMapper.removeCouponUser(formMap);
				}
			}
		}
		else if(type==2){//全部回收优惠券
			FormMap param = formMap ;
			param.remove("pageNo");
			param.remove("pageSize");
			formMap.set("state", 1);
			List<E> usersList = couponMapper.selectCouponUserList(param);
			if(usersList.size()>0){
				return "全部回收优惠券时失败,已有用户使用过此优惠券。";
			}
			//全部删除,选择所有此优惠券的用户
			FormMap newParam=new FormMap();
			newParam.set("validate_id", formMap.getStr("validate_id"));
			List<E> needDeleteUser = couponMapper.selectCouponUserList(newParam);
			if(needDeleteUser.size() > 0){
				for(int i=0 ;i < needDeleteUser.size(); i++){
					E user = (E) needDeleteUser.get(i);
					newParam.put("id", user.get("id"));
					couponMapper.removeCouponUser(newParam);
				}
			}
		}
		return null;
	}
	
	/**
	 * 查询优惠券信息，并且查询优惠券绑定的商品
	 */
	@Override
	public E selectCoupon(FormMap formMap) {
		//查询优惠券
		E coupon=couponMapper.selectOne(formMap);
		if(!StringUtils.isEmpty(coupon.getStr("product_ids"))){
			formMap.set("product_ids", coupon.getStr("product_ids"));
			List<E> couponProductList=couponMapper.selectCouponProductList(formMap);
			coupon.set("couponProductList", couponProductList);
		}
		return coupon;
	}
}
