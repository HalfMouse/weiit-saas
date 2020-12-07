package com.weiit.web.weixinopen.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;


/**
 * 微信第三方平台配置
 * @author 半个鼠标
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface WeixinOpenMapper extends BaseMapper{

	/**
	 * 查询第三方配置信息
	 * @return
	 */
	E selectWeixinOpenInfo(FormMap formMap);


	E selectWxPublicInfo(FormMap formMap);

	/**
	 * 修改微信第三方平台的配置信息-verify_ticket字段
	 * @param formMap
	 */
	void editWeixinOpenInfoVerifyTicket(FormMap formMap);

	void updateMiniAudit(FormMap formMap);
	
	E selectReplyOne(FormMap formMap);
	E selectReplyImageText(FormMap formMap);


	List<E> selectNavInfoByShopId(FormMap formMap);


	void updateMiniAuth(FormMap formMap);

	void addMiniAuth(FormMap formMap);

	void updateVersion(FormMap formMap);

	E selectMiniVersionInfo(FormMap formMap);

	E selectMiniAuthInfo(FormMap formMap);

	List<E> seleclMiniList(FormMap formMap);

}