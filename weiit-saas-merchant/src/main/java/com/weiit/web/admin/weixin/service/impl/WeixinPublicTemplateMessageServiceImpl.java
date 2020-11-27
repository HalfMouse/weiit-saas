package com.weiit.web.admin.weixin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinPublicMapper;
import com.weiit.web.admin.weixin.mapper.WeixinPublicTemplateMessageMapper;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.admin.weixin.service.WeixinPublicTemplateMessageService;



/**
 * 微信模板消息实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class WeixinPublicTemplateMessageServiceImpl extends AbstractService implements WeixinPublicTemplateMessageService {

	@Resource
	private WeixinPublicTemplateMessageMapper templateMapper;
	
	
	@Override
	public BaseMapper setMapper() {
		return templateMapper;
	}
	
	@Override
	public List<E> selectAllTemplateTypeList(FormMap formMap) {
		return templateMapper.selectAllTemplateTypeList(formMap);
	}

	@Override
	public List<E> selectMyTemplateList(FormMap formMap) {
		return templateMapper.selectMyTemplateList(formMap);
	}

	@Override
	public void insertTemplateMsg(FormMap formMap) {
		templateMapper.insertTemplateMsg(formMap);
	}

	@Override
	public void editTemplateMsgState(FormMap formMap) {
		templateMapper.editTemplateMsgState(formMap);
	}

	@Override
	public void removeTemplateMsg(FormMap formMap) {
		templateMapper.removeTemplateMsg(formMap);
	}

	

   
    
}
