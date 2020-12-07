package com.weiit.web.api.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;


/**
 * 活动相关Mapper
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface ActivityMapper extends BaseMapper{
	
	List<E> couponList(FormMap formMap);

	List<E> couponListByIds(FormMap formMap);

	void couponGet(FormMap formMap);
	
	E couponNumber(FormMap formMap);
	
	E userCouponReceiveNum(FormMap formMap);
}