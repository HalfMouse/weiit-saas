package com.weiit.web.admin.publics.mapper;
 
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
public interface ParameterMapper extends BaseMapper{

    public E selectShopParamByName(FormMap formMap);
	 
}
