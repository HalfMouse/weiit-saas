package com.weiit.web.admin.init.service;
 
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;



/**
 * 数据初始化Service
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface InitService extends BaseService{
 
	 void insertInit(FormMap formMap);
	 
}
