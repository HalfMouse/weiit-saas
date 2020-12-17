package com.weiit.web.admin.weixin.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 微信公众号图文素材接口
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface WeixinMediaArticleService extends BaseService {

	/**
	 * 查询所有图文，按照公众号id查询
	 * @param formMap
	 * @return
	 */
	List<E> selectWeixinMediaArticleList(FormMap formMap);
	
	/**
	 * 根据id查询图文信息
	 * @param formMap
	 * @return
	 */
	List<E> selectWeixinMediaArticleListByIds(FormMap formMap);
	
	/**
	 * 新增图文
	 * @param formMap
	 */
	void insertWeixinMediaArtile(FormMap formMap);
	
	/**
	 *  根据mediaid查询图文信息
	 * @param formMap
	 * @return
	 */
	E selectWeixinMediaArticleByMediaId(FormMap formMap);
	
	/**
	 * 修改图文
	 * @param formMap
	 */
	void editWeixinMediaArticle(FormMap formMap);
	
	/**
	 * 根据mediaId删除图文
	 * @param formMap
	 */
	void removeWeixinMediaArticle(FormMap formMap);
}
