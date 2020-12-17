package com.weiit.web.admin.publics.service;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 公共服务Service
 * @author 半个鼠标
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface PublicsService  extends BaseService{

	List<E> selectRegionList(FormMap formMap);
	
	E selectRegionById(FormMap formMap);
	
	List<E> productList(FormMap param);
	
	List<E> selectOrdersExpress(FormMap param);
	
	List<E> selectWeixinLink(FormMap param);
}
