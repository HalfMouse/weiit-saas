package com.weiit.web.admin.ump.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 营销mapper
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface UmpMapper extends BaseMapper {
	
	/**
	 * 查询所有的营销活动
	 * @param formMap
	 * @return
	 */
	List<E> selectServiceList(FormMap formMap);
	
	/**
	 * 查询服务详情
	 * @param formMap
	 * @return
	 */
	E selectServiceByServiceNum(FormMap formMap);
	
	/**
	 * 查询订购时长
	 * @param formMap
	 * @return
	 */
	List<E> selectOrderTimeList(FormMap formMap);
	
	/**
	 * 根据名称查询订购时长信息，比如折扣
	 * @param formMap
	 * @return
	 */
	E selectOrderTimeConfigByName(FormMap formMap);
	
}
