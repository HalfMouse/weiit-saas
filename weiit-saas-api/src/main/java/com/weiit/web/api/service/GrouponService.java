package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 拼团 接口类
 * Title: DiscountService.java
 * Description: 
 * Company: 微云时代
 * @author lhq
 * @date 2018年5月15日
 */
public interface GrouponService extends BaseService {

	/**
	 * 查询活动页面的拼团商品信息
	 * @param formMap
	 * @return 返回活动页面的拼团商品信息
	 * */
	List<E> grouponListByIds(FormMap formMap);

	/**
	 * 查询某个拼团活动正在拼团的的信息
	 * @param formMap
	 * @return 拼团活动正在拼团的的信息
	 * */
	List<E> inProcessGroupon(FormMap formMap);

	/**
	 * 查询某个拼团活动某个团的用户的信息
	 * @param formMap
	 * @return 拼团活动某个团的用户的信息
	 * */
	List<E> getJoinGrouponInfo(FormMap formMap);


	/**
	 * 查询用户的拼团活动
	 * @param formMap
	 * @return 用户的拼团活动
	 * */
	List<E> getMyGroupon(FormMap formMap);
	/**
	 * 查询店铺下所有拼团商品
	 * @param formMap
	 * @return 店铺下所有拼团商品
	 * */
	List<E> getShopAllGroupon(FormMap formMap);


	/**
	 * 拼团的扩展信息
	 * @param formMap
	 * @return 拼团的扩展信息
	 * */
	 E inProcessGrouponExt(FormMap formMap);



	/**
	 * 插入拼团订单信息  可用于发起支付的对象 及以后统计该活动带来的销量增益  weiit_ump_groupon_detail
	 * @param formMap
	 * @return 返回活动页面的拼团orderID
	 * */
	int insertGrouponOrder(FormMap formMap);

	/**
	 * 更新拼团订单信息
	 * @param formMap
	 *
	 * */
	void updateGrouponOrderByOrderNum(FormMap formMap);

	/**
	 * 根据Id  获取拼团订单信息
	 * @param formMap
	 * @return 拼团订单信息
	 * */
	E getGrouponOrderById(FormMap formMap);
	/**
	 * 更新该拼团订单下的所有进行中的用户订单状态为拼团成功 id ,parent_id为detail_id(前端约定传值) 的
	 * @param formMap
	 * */
	 void updateAllGrouponOrderById(FormMap formMap);


	/**
	 * 根据product_Id  spec_custom  获取拼团价
	 * @param formMap
	 * @return  获取拼团价
	 * */
	E productSpecCheck(FormMap formMap);

	/**
	 * orderNo    获取商户key
	 * @param
	 * @return   获取商户key
	 * */
	E getMchKeyByGrouponOrderNo(String orderNo);


	/**
	 * orderNo    获取商户key
	 * @param
	 * @return   获取商户key
	 * */
	E getProductInfoByGOrderId(FormMap orderNo);


	/**
	 * orderNo    是否已参与拼团
	 * @param
	 * @return   获取商户key
	 * */
	int isJoinGrouponByOrderId(FormMap orderNo);

	/**
	 * 已拼团人数
	 *@param formMap
	 * @return
	 * */
	int hasGrouponCount(FormMap formMap);



	/**
	 * 返回用户的参团信息
	 *@param formMap
	 * @return
	 * */
	E getUserGrouponInfoByGOrderId(FormMap formMap);




	/**
	 * 返回开团通知所需信息
	 * @param formMap
	 * @return
	 * */
	E selectStartGrouponMsgInfo(FormMap formMap);


	/**
	 * 根据参团单号查询团长信息
	 * @param formMap
	 * */
	 E selectMrsWuByJoinOrderNum(FormMap formMap);


	 /**
	  * 查询用户所属的
	  *
	  * */

	 E selectAuthorizerAppIdByUserId(FormMap formMap);





}

