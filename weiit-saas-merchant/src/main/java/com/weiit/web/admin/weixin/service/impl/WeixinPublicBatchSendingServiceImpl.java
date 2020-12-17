package com.weiit.web.admin.weixin.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinPublicBatchSendingMapper;
import com.weiit.web.admin.weixin.service.WeixinPublicBatchSendingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/** 
 * @类描述: 群发接口管理  
 */
@Service("weixinPublicBatchSendingService")
public class WeixinPublicBatchSendingServiceImpl extends AbstractService implements WeixinPublicBatchSendingService {
	@Resource
	private WeixinPublicBatchSendingMapper weixinPublicBatchSendingMapper;

	 @Override
	public BaseMapper setMapper() {
		// TODO Auto-generated method stub
		return weixinPublicBatchSendingMapper;
	}
	  
	@Override
	public int addPublicBatchSendingLog(FormMap conditionMap) {
		// TODO Auto-generated method stub
		return weixinPublicBatchSendingMapper.addPublicBatchSendingLog(conditionMap);
	}

	@Override
	public List<E> selectUsersList(FormMap conditionMap) {
		// TODO Auto-generated method stub
		return weixinPublicBatchSendingMapper.selectUsersList(conditionMap);
	}


	@Override
	public List<E> selectBatchSendingUsersLogList(FormMap conditionMap) {
		// TODO Auto-generated method stub
		return weixinPublicBatchSendingMapper.selectBatchSendingUsersLogList(conditionMap);
	}
 
	@Override
	public void addPublicBatchSendingUsersLog(List list) {
		// TODO Auto-generated method stub
		weixinPublicBatchSendingMapper.addPublicBatchSendingUsersLog(list);
	}
 
	@Override
	public void updatePublicBatchSendingUsersLog(FormMap map) {
		// TODO Auto-generated method stub
		weixinPublicBatchSendingMapper.updatePublicBatchSendingUsersLog(map);
	} 
	
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int remove(FormMap map) { 
		weixinPublicBatchSendingMapper.remove(map);
		weixinPublicBatchSendingMapper.removeMasssendUser(map);
		return 1;
	} 
}
