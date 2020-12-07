package com.weiit.web.admin.weixin.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinPublicMapper;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;


/**
 * 微信自定义菜单管理实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class WeixinPublicServiceImpl extends AbstractService implements WeixinPublicService {

    @Resource
    private WeixinPublicMapper weixinPublicMapper;

    @Override
	public BaseMapper setMapper() {
		return weixinPublicMapper;
	}

	@Override
	public E selectMerchantByShopId(FormMap forMap) {
		return weixinPublicMapper.selectMerchantByShopId(forMap);
	}

	@Override
	public List<E> selectIntroPageList(FormMap formMap) {
		return weixinPublicMapper.selectIntroPageList(formMap);
	}

	@Override
	public void introSave(FormMap formMap) {
		weixinPublicMapper.introSave(formMap);
	}

	@Override
	public void introDefault(FormMap formMap) {
		weixinPublicMapper.clearIntroDefault(formMap);
		weixinPublicMapper.introDefault(formMap);
	}

	@Override
	public void introRemove(FormMap formMap) {
		weixinPublicMapper.introRemove(formMap);
	}

}
