package com.weiit.web.admin.weixin.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinMediaImagesMapper;
import com.weiit.web.admin.weixin.service.WeixinMediaImagesService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 微信公众号图片素材实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("weixinImagesService")
public class WeixinMediaImagesServiceImpl extends AbstractService implements WeixinMediaImagesService {
	
	@Resource
	private WeixinMediaImagesMapper weixinMediaImagesMapper;

	@Override
	public BaseMapper setMapper() {
		return weixinMediaImagesMapper;
	}
	
	@Override
	public List<E> selectWeixinMediaImageList(FormMap formMap) {
		return weixinMediaImagesMapper.selectWeixinMediaImageList(formMap);
	}

	@Override
	public void insertWeixinMediaImage(FormMap formMap) {
		weixinMediaImagesMapper.insertWeixinMediaImage(formMap);
	}

	@Override
	public void removeWeixinMediaImage(FormMap formMap) {
		weixinMediaImagesMapper.removeWeixinMediaImage(formMap);
	}

	@Override
	public E selectWeixinMediaImageByMediaId(FormMap formMap) {
		return weixinMediaImagesMapper.selectWeixinMediaImageByMediaId(formMap);
	}

	@Override
	public List<E> selectAllCommonImageCateList(FormMap formMap) {
		return weixinMediaImagesMapper.selectAllCommonImageCateList(formMap);
	}

	@Override
	public List<E> selectAllCommonImageList(FormMap formMap) {
		return weixinMediaImagesMapper.selectAllCommonImageList(formMap);
	}

	@Override
	public E selectCommonImageByImageId(FormMap formMap) {
		return weixinMediaImagesMapper.selectCommonImageByImageId(formMap);
	}

}
