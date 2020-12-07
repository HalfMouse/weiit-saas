package com.weiit.web.api.mapper;

import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;


/**
 * 商品相关Mapper
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface ProductMapper extends BaseMapper{
	
	 /**
     * 商品搜索查询
     * @param formMap
     * @return 返回查询的商品结果
     */
	List<E> selectProductSearch(FormMap formMap);
	
	E selectProductById(FormMap formMap);

	E selectProductInfoById(FormMap formMap);

	List<E> selectProductImgs(FormMap formMap);
	
	List<E> selectSpecList(FormMap formMap);

	List<E> selectItemSpecList(FormMap formMap);
	
	E selectItemSpec(FormMap formMap);
	
	E selectProductItemByItemId(FormMap formMap);
	
	E selectUserCartByProductIdAndItemId(FormMap formMap);

	void insertUserCart(FormMap formmap);
	
	void editUserCart(FormMap formmap);
	
	List<E> selectUserCartList(FormMap formMap);
	
	E selectUserAddressDefault(FormMap formMap);

	E getProductItemById(FormMap formMap);

	E getItemInfoByProductId(FormMap formMap);

	List<E> selectUserCouponList(FormMap formMap);

	List<E> getProductTagById(FormMap formMap);

    void editUserCartCount(FormMap formMap);
    
    void deleteUserCartById(FormMap formMap);
    
    void insertProductcollection(FormMap formMap);

    void updateProductStock(FormMap formMap);

    void updateItemStock(FormMap formMap);

	List<E> getProductListByIds(FormMap param) ;

	List<E> autoGetProduct(FormMap param) ;


	List<E> getSpecInfoByIds(FormMap param) ;

	E selectCartInfoById(FormMap param) ;


}