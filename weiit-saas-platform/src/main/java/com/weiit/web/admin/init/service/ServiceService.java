package com.weiit.web.admin.init.service;
 
import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;



/**
 * 收费服务项目Service
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface ServiceService extends BaseService{
	
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
	 * 给版本添加服务
	 */
	void insertVersionServiceTrans(FormMap formMap);
	
}
