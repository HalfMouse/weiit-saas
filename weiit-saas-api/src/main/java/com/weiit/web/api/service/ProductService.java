package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 商品相关Service
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface ProductService extends BaseService {


	/**
	 * 根据请求参数搜索商品
	 * @param formMap 请求参数
	 * @return 返回符合要求的商品
	 * */
	List<E> selectProductSearch(FormMap formMap);


	/**
	 * 根据商品搜索商品
	 * @param formMap 请求参数
	 * @return 返回符合要求的商品
	 * */
	E selectProductById(FormMap formMap);


	/**
	 * 查询商品基本信息
	 * @param formMap 请求参数
	 * @return 返回符合要求的商品
	 * */
	E selectProductInfoById(FormMap formMap);

	/**
	 * 商品详情  （富文本单独存放）
	 * @param formMap 请求参数
	 * @return 返回商品详情
	 * */
	E productDetail(FormMap formMap);

	/**
	 * 商品图
	 * @param formMap 请求参数
	 * @return 返回商品图
	 * */
	List<E> selectProductImgs(FormMap formMap);

	/**
	 * 商品属性
	 * @param formMap 请求参数
	 * @return 返回商品属性
	 * */
	List<E> selectSpecList(FormMap formMap);

	/**
	 * 一个商品  可能存在多个规格  小米手机  有 黑色4G内存/金色4G内存（规格有统一规格/多规格）多规格是  所存的市场价/销售价 均为多规格商品的最低价
	 * @param formMap 请求参数
	 * @return 返回商品 多规格 列表
	 * */
	List<E> selectItemSpecList(FormMap formMap);

	/**
	 * 根据所选自定义规格的ID  (spec_custom)  返回这个商品的 市场价 销售价  库存（）
	 * @param formMap 请求参数
	 * @return 返回这个商品的 市场价 销售价  库存（）
	 * */
	E selectItemSpec(FormMap formMap);


	/**
	 * 根据规格ID  (spec_custom)
	 * @param formMap 请求参数
	 * @return 返回这个商品的 市场价 销售价  库存（）
	 * */
	E selectProductItemByItemId(FormMap formMap);


	/**
	 * 根据商品Id/规格ID/用户Id 查询购物车中商品信息
	 * @param formMap 请求参数
	 * @return 返回购物车信息
	 * */
	E selectUserCartByProductIdAndItemId(FormMap formMap);

	/**
	 * 添加到购物车
	 * @param formmap 请求参数
	 * @return 返回购物车信息
	 * */
	void insertUserCart(FormMap formmap);

	/**
	 * 编辑购物车
	 * @param formmap 请求参数
	 * */
	void editUserCart(FormMap formmap);


	/**
	 * 查询购物车中商品
	 * @param formMap 请求参数
	 * @return 返回购物车信息
	 * */
	List<E> selectUserCartList(FormMap formMap);

	/**
	 * 查询用户地址信息
	 * @param formMap 请求参数
	 * @return 返回户地址信息
	 * */
	E selectUserAddressDefault(FormMap formMap);

	/**
	 * 查询用户拥有的优惠券信息
	 * @param formMap 请求参数
	 * @return 返回用户拥有的优惠券列表
	 * */
	List<E> selectUserCouponList(FormMap formMap);

	/**
	 * 更新用户购物车的购买数量
	 * @param formMap 请求参数
	 * @return
	 * */
	void editUserCartCount(FormMap formMap);

	/**
	 * 删除户购物车中的商品
	 * @param formMap 请求参数
	 * @return
	 * */
	void deleteUserCartById(FormMap formMap);
	/**
	 * 收藏商品
	 * @param formMap 请求参数
	 * @return
	 * */
	void insertProductcollection(FormMap formMap);

	/**
	 * 更新商品 和 商品item 的库存
	 * @param formMap
	 * */
	void updateProductAndItemStock(FormMap formMap);

	/**
	 * 根据商品IDs列表 查询商品
	 * @param formMap 请求参数
	 * @return
	 * */
	List<E> getProductListByIds(FormMap formMap);

	/**
	 * 自动查询商品
	 * @param formMap 请求参数
	 * @return
	 * */
	List<E> autoGetProduct(FormMap formMap);


	/**
	 * 查询商品Item 信息
	 * @param formMap
	 * @return
	 * */
	E getProductItemById(FormMap formMap);

	/**
	 * 根据specIDs 查询SKU  信息
	 * @param formMap 请求参数
	 * @return
	 * */
	List<E> getSpecInfoByIds(FormMap formMap);


	/**
	 * 根据cart_id 查询购物车的商品信息
	 * @param formMap
	 * @return
	 * */
	E selectCartInfoById(FormMap formMap);


	/**
	 * 计算活动的商品邮费
	 * @param formMap
	 * @return
	 * */
	E calcExpressPriceForActivity(FormMap formMap);




}
