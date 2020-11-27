package com.weiit.web.admin.user.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 用户模块接口
 * @author zhouliang
 * @date 2017年8月15日 上午11:55:25
 * @version 1.0
 * @company http://www.wei-it.com 
 */
public interface UserCardService extends BaseService {
	
	E selectShopInfo(FormMap formMap);
	
	List<E> selectHaveCardUserList(FormMap formMap);
 
	List<E> selectNoCardUserList(FormMap formMap);
	
	String insertUserCardTrans(FormMap formMap);
	
	int removeUserCard(FormMap formMap);
	
	List<E> selectUserCardPictureSourceList(FormMap formMap);
}
