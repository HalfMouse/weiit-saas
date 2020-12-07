package com.weiit.web.admin.publics.mapper;


import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

/**
 * 公共服务mapper
 * @author 半个鼠标
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface PublicsMapper extends BaseMapper{
	
	
	/**
	 * 获取区域信息集合 
	 */
	List<E> selectRegionList(FormMap formMap);
	
	/**
	 * 根据id获取区域信息
	 */
	E selectRegionById(FormMap formMap);
 
	/**
	 * 查询 所有 商品
	 */
	List<E> productList(FormMap param);
	
	/**
	 * 查询 物流公司
	 */
	List<E> selectOrdersExpress(FormMap param);
	
	List<E> selectWeixinLink(FormMap param);
}
