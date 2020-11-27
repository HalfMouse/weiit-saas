package com.weiit.web.admin.weixin.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinMediaArticleMapper;
import com.weiit.web.admin.weixin.service.WeixinMediaArticleService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 微信公众号图文素材接口实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("weixinImagesTextService")
public class WeixinMediaArticleServiceImpl extends AbstractService implements WeixinMediaArticleService {
	@Resource
	private WeixinMediaArticleMapper weixinMediaArticleMapper;

	@Override
	public BaseMapper setMapper() {
		return weixinMediaArticleMapper;
	}

	@Override
	public List<E> selectWeixinMediaArticleList(FormMap formMap) {
		return weixinMediaArticleMapper.selectWeixinMediaArticleList(formMap);
	}

	@Override
	public void insertWeixinMediaArtile(FormMap formMap) {
		weixinMediaArticleMapper.insertWeixinMediaArtile(formMap);
	}

	@Override
	public E selectWeixinMediaArticleByMediaId(FormMap formMap) {
		return weixinMediaArticleMapper.selectWeixinMediaArticleByMediaId(formMap);
	}

	@Override
	public void removeWeixinMediaArticle(FormMap formMap) {
		weixinMediaArticleMapper.removeWeixinMediaArticle(formMap);
	}

	@Override
	public void editWeixinMediaArticle(FormMap formMap) {
		weixinMediaArticleMapper.editWeixinMediaArticle(formMap);
	}

	@Override
	public List<E> selectWeixinMediaArticleListByIds(FormMap formMap) {
		return weixinMediaArticleMapper.selectWeixinMediaArticleListByIds(formMap);
	}

}
