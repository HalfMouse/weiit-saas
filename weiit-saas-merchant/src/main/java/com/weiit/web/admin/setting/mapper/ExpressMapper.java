package com.weiit.web.admin.setting.mapper;
 
import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
 
/**
 * 快递mapper
 * @author：半个鼠标
 * @date：2018年6月5日 下午2:58:33
 * @version 2.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface ExpressMapper extends BaseMapper{ 
	
	/**
	 * 查询所有的快递公司
	 * @param formMap
	 * @return
	 */
	List<E> selectAllExpressList(FormMap formMap);
	
	/**
	 * 根据express_id查询物流公司信息
	 * @param formMap
	 * @return
	 */
	E selectExpressAliByExpressId(FormMap formMap);
}
