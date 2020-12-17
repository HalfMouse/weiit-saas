package com.weiit.web.admin.user.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 会员信息Mapper
 * @author：半个鼠标
 * @date：2018年2月6日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface UserMapper extends BaseMapper {
	
	/**
	 * 根据userid查询用户列表
	 * @param formMap
	 * @return
	 */
	List<E> selectListByUserIds(FormMap formMap);
	
	 /**
     * 查询所有的会员余额信息
     * @param param 
     * @return 返回所有会员的余额信息
     */
	List<E> selectBalanceList(FormMap formMap);

	 /**
     * 查询所有的会员地址信息
     * @param param 
     * @return 返回所有会员的地址信息
     */
	List<E> selectAddressList(FormMap formMap);

	/**
     * 查询所有的会员积分记录
     * @param param 
     * @return 返回所有会员的积分记录
     */
	List<E> selectIntegralList(FormMap formMap);
	
	/**
     * 禁用与启用
     * @param param 
     * @return 
     */
	void forbiddenOrOpen(FormMap formMap);
	
	/**
     * 批量禁用与启用
     * @param param 
     * @return 
     */
	void forbiddenOrOpenBatch(FormMap formMap);


	/**
	 * 新增余额记录
	 * @param param
	 * @return
	 */
	void insertBalanceLog(FormMap formMap);

	/**
	 * 新增积分记录
	 * @param param
	 * @return
	 */
	void insertIntegralLog(FormMap formMap);


	/**
	 * 充值余额或赠送积分
	 * @param param
	 * @return
	 */
	void updateBalanceOrIntegral(FormMap formMap);
}
