package com.weiit.web.admin.login.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 
 * @author 半个鼠标
 * @date：2017-8-20 下午6:50:47
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface LoginMapper extends BaseMapper {
	
	/**
	 * 根据mrch_id查询商户信息
	 * @param formMap
	 * @return
	 */
	E selectByMrchId(FormMap formMap);

	E selectOldPwdById(FormMap formMap);
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
	 * 修改商户版本信息
	 * @param formMap
	 */
	void editMerchantVersion(FormMap formMap);
	
	/**
	 * 新增订单付款信息
	 * @param formMap
	 */
	void insertMerchantService(FormMap formMap);
	
	/**
	 * 查询待通知的运营中心的手机号
	 * @param formMap
	 * @return
	 */
	E selectNotifyPhoneByBusinessType(FormMap formMap);
}
