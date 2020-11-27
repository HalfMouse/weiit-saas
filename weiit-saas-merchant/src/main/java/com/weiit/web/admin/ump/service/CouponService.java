package com.weiit.web.admin.ump.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 优惠券Service
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface CouponService extends BaseService {
	
	List<E> selectNoCouponUserList(FormMap formMap);
	
	List<E> selectCouponUserList(FormMap formMap);

	List<E> couponListByIds(FormMap formMap);

	String insertCouponUserTrans(FormMap formMap);
	
	String removeCouponUserTrans(FormMap formMap);
	
	E selectCoupon(FormMap formMap);
}

