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
public interface IntegralMapper extends BaseMapper{
	
	List<E> selectIntegralProductList(FormMap formMap);

	List<E> selectIntegralLogList(FormMap formMap);


	List<E> selectShopParamList(FormMap formMap);


	int selectHasBuyCount(FormMap formMap);

	E selectByOrderNum(FormMap formMap);


	E selectOrderByOrderNum(FormMap formMap);


	E selectPayInfoByOrderNum(FormMap formMap);


	E getMchKeyByOrderNum(FormMap formMap);

	E selectShopParamByCode(FormMap formMap);


	void updateIntegralById(FormMap formMap);

}