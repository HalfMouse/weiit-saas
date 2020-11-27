package com.weiit.web.admin.user.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 会员卡Mapper
 * @author：半个鼠标
 * @date：2018年2月7日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface UserCardMapper extends BaseMapper {
	
	/**
     * 查询店铺信息
     * @param param 
     * @return 返回店铺信息
     */
	E selectShopInfo(FormMap formMap);
 
	/**
     * 查询已拥有此卡的所有会员
     * @param param 
     * @return 返回拥有此卡的会员集合
     */
	List<E> selectHaveCardUserList(FormMap formMap);
 
	/**
     * 查询此卡没拥有的会员
     * @param param 
     * @return 返回无此卡的会员集合
     */
	List<E> selectNoCardUserList(FormMap formMap);
	
	/**
     * 会员绑定卡片
     * @param param 
     * @return 
     */
	int insertUserCard(FormMap formMap);
	
	/**
     * 会员卡片删除
     * @param param 
     * @return 
     */
	int removeUserCard(FormMap formMap);
	
	/**
     * 查询会员卡图片素材
     * @param param 
     * @return 
     */
	List<E> selectUserCardPictureSourceList(FormMap formMap);
}
