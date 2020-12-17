package com.weiit.web.admin.init.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 商户管理Mapper
 * @author 半个鼠标
 * @date：2017-7-5 上午11:39:00
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface ShopMapper extends BaseMapper{
	
	/**
	 * 新增认证信息
	 * @param formMap
	 * @return
	 */
	int insertCert(FormMap formMap);
	
	/**
	 * 编辑商户认证信息
	 * @param formMap
	 * @return
	 */
	int editCert(FormMap formMap);
	
	/**
	 * 商户认证信息审核或驳回
	 * @param formMap
	 */
	void editShopCertificationState(FormMap formMap);
	
	/**
	 * 根据商户账户查询商户信息
	 * @param formMap
	 * @return
	 */
	E selectMerchantByAccount(FormMap formMap);
	
	/**
	 * 查询商户信息  单条
	 * @param formMap
	 * @return
	 */
	E selectMerchantOne(FormMap formMap);
	
	/**
	 * 新增商户
	 * @param formMap
	 * @return
	 */
	int insertMerchant(FormMap formMap);
	
	/**
	 * 启用商户登录或者禁用商户登录
	 * @param formMap
	 * @return
	 */
	int editMerchantLocked(FormMap formMap);
	
	/**
	 * 查询用户提交的建议记录
	 * @param formMap
	 * @return
	 */
	List<E> selectSuggestList(FormMap formMap);
	
	/**
	 * 删除建议
	 * @param formMap
	 */
	void removeSuggest(FormMap formMap); 
	
	/**
	 * 查询公司运营部的通知电话号码
	 * @param formMap
	 * @return
	 */
	E selectNotifyPhoneByBusinessType(FormMap formMap);
}
