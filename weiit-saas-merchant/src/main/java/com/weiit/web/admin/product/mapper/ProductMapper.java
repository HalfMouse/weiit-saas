package com.weiit.web.admin.product.mapper;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 商品管理Mapper
 * @author hzy
 * @date：2017-8-15 下午3:52:46
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface ProductMapper extends BaseMapper {

	/**
	 * 查询商品分类集合
	 * @return 商品分类集合
	 */
	List<E> selectCateList(FormMap param);
 
	/**
	 * 查询商品属性集合
	 * @return 商品属性集合
	 */
	List<E> selectAttrList(FormMap param);
	
	/**
	 * 插入商品属性
	 */
	void insertAttr(FormMap param);
	
	/**
	 * 删除商品属性
	 */
	void removeAttr(FormMap param);
 
	/**
	 * 查询商品规格集合
	 * @return 商品的规格集合
	 */
	List<E> selectItemList(FormMap param);
	
	/**
	 * 插入商品规格
	 */
	void insertItem(FormMap param);

	void editItem(FormMap param);

	/**
	 * 删除商品规格
	 */
	void removeItem(FormMap param);
	
	/**
	 * 查询商品图片集合
	 * @return 商品图片集合
	 */
	List<E> selectImagesList(FormMap param);
	
	/**
	 * 插入商品图片
	 */
	void insertImages(FormMap param);
	
	/**
	 * 删除商品图片 
	 */
	void removeImages(FormMap param);
	 
	/**
	 * 查询商品描述集合
	 * @return 商品描述集合
	 */
	List<E> selectProductDescList(FormMap param);
	
	/**
	 * 插入商品描述
	 */
	void insertProductDesc(FormMap param);
	
	/**
	 * 删除商品描述
	 */
	void removeProductDesc(FormMap param);
	
	/**
	 * 查询商品上下架列表
	 */
	List<E> selectProductList(FormMap param);
 
	List<E> selectShopList(FormMap param);

	List<E> productListForPage(FormMap param);

	int productCountForPage(FormMap param);

	List<E> getProductListByIds(FormMap param);

	List<E> autoGetProduct(FormMap param);

	List<E> getSpecCustomByIds(FormMap param);

	E getItemById(FormMap param);



	E selectItemByProductIdAndSpec(FormMap formMap);

	E selectIsJoinBargain(FormMap formMap);

	E selectIsJoinGroupon(FormMap formMap);

	E selectProductById(FormMap formMap);



}
