package com.weiit.web.api.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 商品分组管理Mapper
 * @author hzy
 * @date：2017-8-15 下午3:52:46
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface ProductGroupMapper extends BaseMapper {
 


	List<E> getProductByGroupId(FormMap param);


	/**
	 * 插入 
	 */
	void insertDetail(FormMap param);
	
	/**
	 * 删除 
	 */ 
	void removeDetail(FormMap param);
  
}
