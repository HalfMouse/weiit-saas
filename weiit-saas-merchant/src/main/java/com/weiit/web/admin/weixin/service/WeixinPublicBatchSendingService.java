package com.weiit.web.admin.weixin.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 *  
 * @类描述: 群发接口管理  
 */
public interface WeixinPublicBatchSendingService extends BaseService {
 
	/** 
	 * 添加群发记录
	 * @param conditionFormMap
	 */
	int addPublicBatchSendingLog(FormMap conditionFormMap);
	
	/**
	 * 添加群发用户记录
	 * @param FormMap
	 */
	void addPublicBatchSendingUsersLog(List list);
	/**
	 * 回写群发用户消息记录状态
	 * @param FormMap
	 */
	void updatePublicBatchSendingUsersLog(FormMap FormMap);
	
	/**
	 * 查询所有用户信息
	 * @param conditionFormMap
	 * @return
	 */
	List<E> selectUsersList(FormMap conditionFormMap);
	
	/**
	 * 查询群发用户记录
	 * @param conditionFormMap
	 * @return
	 */
	List<E> selectBatchSendingUsersLogList(FormMap conditionFormMap);
 
}
