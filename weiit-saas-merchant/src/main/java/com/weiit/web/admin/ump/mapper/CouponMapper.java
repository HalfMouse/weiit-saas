package com.weiit.web.admin.ump.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 优惠券mapper
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface CouponMapper extends BaseMapper {
	
	/**
     * 查询优惠券指定的商品列表
     * @param formMap
     * @return 返回优惠券指定的商品列表
     */
	List<E> selectCouponProductList(FormMap formMap);
	
	/**
     * 查询没有领取优惠券的用户列表
     * @param formMap
     * @return 返回没有领取优惠券的用户列表
     */
	List<E> selectNoCouponUserList(FormMap formMap);
	
	/**
     * 查询领取过领取优惠券的用户列表
     * @param formMap
     * @return 返回领取过领取优惠券的用户列表
     */
	List<E> selectCouponUserList(FormMap formMap);


	List<E> couponListByIds(FormMap formMap);

	/**
     * 添加用户优惠券
     * @param formMap
     * @return 
     */
	int insertCouponUser(FormMap formMap);
	
	/**
     * 删除用户优惠券
     * @param formMap
     * @return 
     */
	int removeCouponUser(FormMap formMap);
	
	
}
