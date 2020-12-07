package com.weiit.web.weixinopen.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;


/**
 * 微信服务Mapper
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinOpenMapper extends BaseMapper{
	
	/**
	 * 查询微信第三方平台配置信息
	 * @param formMap
	 * @return
	 */
	E selectWeixinOpenInfo(FormMap formMap);

	E selectWxPublicInfo(FormMap formMap);

	/**
	 * 修改微信第三方平台的配置信息-verify_ticket字段
	 * @param formMap
	 */
	void editWeixinOpenInfoVerifyTicket(FormMap formMap);

	/**
	 * 查询公众号支付信息
	 * @param formMap
	 * @return
	 * */
	E getPayParamByShopIdAndType(E formMap);

}