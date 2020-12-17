package com.weiit.web.admin.weixin.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 *  
 * @类描述: 群发接口管理  
 */
public interface WeixinPublicBatchSendingMapper extends BaseMapper {
  
	/** 
	 * 添加群发记录
	 * @param conditionMap
	 */
	int addPublicBatchSendingLog(FormMap conditionMap);
	
	/**
	 * 查询所有用户信息
	 * @param conditionMap
	 * @return
	 */
	List<E> selectUsersList(FormMap conditionMap);
 
	/**
	 * 查询群发用户记录
	 * @param conditionMap
	 * @return
	 */
	List<E> selectBatchSendingUsersLogList(FormMap conditionMap);

	/**
	 * 添加群发用户记录
	 * @param map
	 */
	void addPublicBatchSendingUsersLog(List list);
	
	/**
	 * 回写群发用户消息记录状态
	 * @param map
	 */
	void updatePublicBatchSendingUsersLog(FormMap map);
  
	/**
	 * 删除
	 * @param map
	 */
	void removeMasssendUser(FormMap map);
}
