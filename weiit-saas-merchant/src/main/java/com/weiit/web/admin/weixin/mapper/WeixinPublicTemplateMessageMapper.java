package com.weiit.web.admin.weixin.mapper;

import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;


/**
 * 微信模板消息mapper
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinPublicTemplateMessageMapper extends BaseMapper{
	
	/**
	 * 查询所有的可配置的模板消息
	 * @param formMap
	 * @return
	 */
	List<E> selectAllTemplateTypeList(FormMap formMap);
	
	/**
	 * 查询我的模板消息
	 * @param formMap
	 * @return
	 */
	List<E> selectMyTemplateList(FormMap formMap);
	
	/**
	 * 新增模板消息
	 * @param formMap
	 */
	void insertTemplateMsg(FormMap formMap);
	
	/**
	 * 修改模板消息状态，开启或者关闭
	 * @param formMap
	 */
	void editTemplateMsgState(FormMap formMap);
	
	/**
	 * 删除模板消息，根据公众号删除所有
	 * @param formMap
	 */
	void removeTemplateMsg(FormMap formMap);
	
}
