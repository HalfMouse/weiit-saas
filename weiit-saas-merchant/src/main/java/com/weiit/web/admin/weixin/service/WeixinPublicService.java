package com.weiit.web.admin.weixin.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 微信自定义菜单管理service
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinPublicService extends BaseService{
	
	/**
	 * 根据店铺id查询商户信息
	 * @param forMap
	 * @return
	 */
	E selectMerchantByShopId(FormMap forMap);

	/**
	* 查询店铺的小程序引导页
	*
	* */
	List<E>  selectIntroPageList(FormMap formMap);

	/**
	 * 新增引导页
	 * */
	void introSave(FormMap formMap);
	/***
	 * 设置默认引导页
	 * */
	void introDefault(FormMap formMap);


	/**
	 *删除引导页
	 *
	 * */
	void introRemove(FormMap formMap);

}
