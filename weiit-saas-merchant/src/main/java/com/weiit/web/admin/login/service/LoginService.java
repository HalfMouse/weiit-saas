package com.weiit.web.admin.login.service;


import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

/**
 * 
 * @author 半个鼠标
 * @date：2017-8-20 下午6:31:50
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface LoginService extends BaseService{
	
	/**
	 * 根据mrch_id查询商户信息
	 * @param formMap
	 * @return
	 */
	E selectByMrchId(FormMap formMap);
	
	/**
	 * 查询店铺信息
	 * @param formMap
	 * @return
	 */
	E selectShopByMrchId(FormMap formMap);
	
	/**
	 * 查询商户所有的服务，并且是有效的服务(即没过期的服务)
	 * @param formMap
	 * @return
	 */
	List<E> selectMerchantAllServiceNumsList(FormMap formMap);
	
	/**
	 * 根据服务编码查询该服务信息，包括价格
	 * @param formMap
	 * @return
	 */
	E selectServiceByServiceNum(FormMap formMap);
	
	/**
	 * 查询商户已有的服务,包括到期时间
	 * @param formmap
	 * @return
	 */
	E selectMerchantServiceByServiceNum(FormMap formmap);
	
	/**
	 * 查询订单时长，查询所有
	 * @param formMap
	 * @return
	 */
	List<E> selectOrderTimeList(FormMap formMap);
	
	/**
	 * 查询订购时长配置,查询单个配置
	 * @param formMap
	 * @return
	 */
	E selectOrderTimeConfigByName(FormMap formMap);
	
	/**
	 * 查询所有版本信息
	 * @param formMap
	 * @return
	 */
	List<E> selectVersionList(FormMap formMap);
	
	/**
	 * 查询单个版本信息
	 * @param formMap
	 * @return
	 */
	E selectVersionOne(FormMap formMap);
	
	/**
	 * 商户自主付费完成后的事务
	 * @param formMap
	 * @return
	 */
	int payFinishVersionTrans(FormMap payOrderInfo);
	
	/**
	 * 商户自主付费营销服务的事务
	 * @param payOrderInfo
	 * @return
	 */
	int payFinishServiceTrans(FormMap payOrderInfo);


	/**
	 * 查询旧密码
	 *
	 *
	 *
	 * */

	E selectOldPwdById(FormMap formMap);
}
