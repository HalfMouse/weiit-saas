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
public interface WeixinPublicMenuMapper  extends BaseMapper{
	
	/**
	 * 查询所有的链接列表
	 * @param formMap
	 * @return
	 */
	List<E> selectLinkList(FormMap formMap);
	
	/**
	 * 删除公众号的所有菜单
	 * @param formMap
	 */
	void removePublicMenuByAuthorizerId(FormMap formMap);
	
	/**
	 * 插入菜单
	 * @param formMap
	 */
	void insertPublicMenu(FormMap formMap);
	
	/**
	 * 查询一级菜单
	 * @param formMap
	 * @return
	 */
	List<E> selectParentMenuList(FormMap formMap);
	
	/**
	 * 查询一级菜单下的二级菜单
	 * @param formMap
	 * @return
	 */
	List<E> selectChildMenuList(FormMap formMap);
	
	/**
	 * 新增文章
	 * @param formMap
	 */
	void insertBlog(FormMap formMap);
}
