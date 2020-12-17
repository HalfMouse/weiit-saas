package com.weiit.web.admin.init.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;
 
/**
 * 收费服务项目Mapper
 * @author hzy
 * @date：2017-8-15 下午3:52:46
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface ServiceMapper extends BaseMapper{
  
	/**
	 *  查询当前最大排序数值
	 * @param formMap
	 * @return
	 */
	E selectMaxSortNum(FormMap formMap);
	
	/**
	 * 查询所有的订购时长信息
	 * @param formMap
	 * @return
	 */
	List<E> selectOrderTimeList(FormMap formMap);
	/**
	 * 查询订购时长信息
	 * @param formMap
	 * @return
	 */
	E selectOrderTimeConfigByName(FormMap formMap);
	
	/**
	 * 更新订购时长信息
	 * @param formMap
	 */
	void editOrderTimeConfig(FormMap formMap);
	
	/**
	 * 查询版本配置
	 * @param formMap
	 * @return
	 */
	List<E> selectVersionList(FormMap formMap);
	
	/**
	 * 查询版本配置单个
	 * @param formMap
	 * @return
	 */
	E selectVersionOne(FormMap formMap);
	
	/**
	 * 新增版本配置
	 * @param formMap
	 */
	void insertVersion(FormMap formMap);
	
	/**
	 * 修改版本配置
	 * @param formMap
	 */
	void editVersion(FormMap formMap);
	
	/**
	 * 查询版本下的服务信息
	 * @param formMap
	 * @return
	 */
	List<E> selectVersionServiceList(FormMap formMap);
	
	/**
	 * 插入服务信息到版本中
	 * @param formMap
	 */
	void insertVersionService(FormMap formMap);
	
	/**
	 * 删除版本下的服务信息
	 * @param formMap
	 */
	void removeVersionService(FormMap formMap);
	
}
