package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 订单相关Service
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface OrderService extends BaseService {

	/**
	 * 根据状态state  和用户ID 查询订单列表
	 * @param formMap
	 * @return 订单列表
	 * */
	List<E> selectOrderList(FormMap formMap);

	/**
	 * 根据OrderID 查询订单详情
	 * @param formMap
	 * @return 订单详情
	 * */
	E selectOrderOne(FormMap formMap);

	/**
	 * 根据OrderID 查询订单及退换货信息
	 * @param formMap
	 * @return 订单及退换货信息
	 * */
	List<E> selectOrderDetails(FormMap formMap);

	/**
	 * 更新用户的订单状态
	 * @param formMap
	 * */
	void updateOrderState(FormMap formMap);

	/**
	 * 插入退换货记录
	 * @param formMap
	 * */
	void insertOrderRefund(FormMap formMap);

	/**
	 * 查询退换货记录
	 * @param formMap
	 * @return 退换货记录
	 * */
	List<E> selectOrderRefundList(FormMap formMap);

	/**
	 * 查询退换货记录总数
	 * @param formMap
	 * @return 退换货记录
	 * */
	int selectOrderRefundCount(FormMap formMap);

	/**
	 * 查询售后订单详情信息
	 * @param formMap
	 * @return 退换货记录
	 * */
	E selectOrderRefundDetail(FormMap formMap);

	/**
	 * 查询店铺配置的物流支持
	 * @param formMap
	 * @return 退换货记录
	 * */
	List<E> selectExpressCompanyList(FormMap formMap);

	/**
	 * 填写售后-物流
	 * @param formMap
	 * */
	void updateOrderRefundExpress(FormMap formMap);
	/**
	 * 更新售后状态 0表示等待卖家同意，1表示等待买家补充，2表示等待卖家退换，3表示退换完成，4表示退换驳回，-1表示退换关闭'
	 * @param formMap
	 * */
	void updateOrderRefundState(FormMap formMap);
	
	/**
	 * 创建订单相关操作
	 * @param formMap
	 * */
	void insertOrder(FormMap formMap);
	/**
	 *	根据ID  查询用户收货地址
	 *	@param formMap
	 *  @return 用户收货地址
	 * */
	E selectUserAddressById(FormMap formMap);


	/**
	 * 添加订单详情记录
	 * @param formMap
	 *
	 * */
	void insertOrderItem(FormMap formMap);

	/**
	 * 查询用户购物车列表
	 * @param formMap
	 * @return
	 * */
	List<E> selectUserCartList(FormMap formMap);


	/**
	 * 清理购物车
	 * @param  formMap
	 *
	 * */
	void clearUserCart(FormMap formMap);


	/**
	 * 根据订单编号查询订单信息
	 * @param  orderNum
	 *
	 * */
	E getOrderInfoByOrderNum(String orderNum);

	/**
	 * 根据订单号查询订单详细
	 * @param order_num
	 * @return
	 * */
	List<E> getOrderItemByOrderNum(String order_num);

	/***
	 * 根据订单号获取商户信息
	 * @param orderNum
	 * @return
	 * */
	E getMchkeyByOrderNum(String orderNum);


	/**
	 * 根据cart_ids计算邮费
	 * @param formMap
	 * @return
	 * */
	FormMap calcPostage(FormMap formMap);

	/**
	 * 根据用户优惠券主键ID 查询
	 *
	 * */
	E selectUserCouponById (FormMap formMap);

    /**
     * 根据用户优惠券主键ID 查询
     *
     * */
    void updateUserCouponById(FormMap formMap);

    /**
	 * 查询订单item基本信息
	 * @param formMap
	 * @return
	 * */
    E selectOrderItemOne(FormMap formMap);

    /**
	 * 根据订单号 查询用户优惠券使用情况
	 * */
    E selectUserCouponInfoByOrderNum(FormMap formMap);


    /**
	 * 根据物流code  查询物流信息
	 * */
    E selectExpressInfoByCode(FormMap formMap);

    /**
	 * 查询订单中商品的数量
	 * */
    int selectOrderProductCount(FormMap formMap);

    /**
	 * 计算商品运费（砍价 拼团）
	 * @param formMap product
	 * @return
	 * */
     E calcProduct(E product,FormMap formMap);

     /**
	  * 计算商品运费
	  * */
	double calcPrice(List<E> list);

	/**
	 * 查询是否申请过售后
	 * */
	E selectOrderRefundOne (FormMap formMap);


	/**
	 * 查询支付方式
	 * */
	E selectPaymentTypeInfo(FormMap formMap);



	/**
	 * 根据订单号查询订单信息
	 * */

	E selectOrderInfoByOrderNum(FormMap formMap);


	/**
	 * 发送卖家发货信息
	 *
	 * */
	void sendBossMessage(FormMap formMap);

}
