package com.weiit.web.admin.weixin.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 微信公众号图片素材Service
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinMediaImagesService extends BaseService {
	
	/**
	 * 根据公众号查询图片素材
	 * @param formMap
	 * @return
	 */
	List<E> selectWeixinMediaImageList(FormMap formMap);
	
	/**
	 * 新增图片素材
	 * @param formMap
	 */
	void insertWeixinMediaImage(FormMap formMap);
	
	/**
	 * 删除图片素材
	 * @param formMap
	 */
	void removeWeixinMediaImage(FormMap formMap);
	
	/**
	 * 根据media_id查询图片，media_id是唯一的
	 * @param formMap
	 * @return
	 */
	E selectWeixinMediaImageByMediaId(FormMap formMap);
	
	/**
	 * 查询所有的公共图片分类
	 * @param formMap
	 * @return
	 */
	List<E> selectAllCommonImageCateList(FormMap formMap);
	
	/**
	 * 查询所有的公共图片，支持按照分类进行筛选
	 * @param formMap
	 * @return
	 */
	List<E> selectAllCommonImageList(FormMap formMap);
	
	/**
	 * 查询图片
	 * @param formMap
	 * @return
	 */
	E selectCommonImageByImageId(FormMap formMap);
}
