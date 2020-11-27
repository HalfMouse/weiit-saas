package com.weiit.web.admin.weixin.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;


/**
 * 微信自定义菜单管理Mapper
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinPublicMapper extends BaseMapper{
	
	/**
	 * 根据店铺id查询商户信息
	 * @param forMap
	 * @return
	 */
	E selectMerchantByShopId(FormMap forMap);


	List<E> selectIntroPageList(FormMap formMap);

	void introSave(FormMap formMap);

	void clearIntroDefault(FormMap formMap);

	void introDefault(FormMap formMap);

	void introRemove(FormMap formMap);
}
