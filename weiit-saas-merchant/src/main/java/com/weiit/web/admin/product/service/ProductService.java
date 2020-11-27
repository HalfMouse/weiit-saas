package com.weiit.web.admin.product.service;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * 商品管理Service
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface ProductService  extends BaseService {
	
	List<E> selectCateList(FormMap param);
	
	void editStatus(FormMap param);
	 
	List<E> selectAttrList(FormMap param);

	List<E> productListForPage(FormMap param);

	int productCountForPage(FormMap param);

	void insertAttr(FormMap param);
	
	void removeAttr(FormMap param);
 	
	void insertAttrVal(FormMap param);
	
	void removeAttrVal(FormMap param);
	
	List<E> selectItemList(FormMap param);
	
	void insertItem(FormMap param);
	
	void removeItem(FormMap param);
	
	List<E> selectImagesList(FormMap param);
	
	void insertImages(FormMap param);
	
	void removeImages(FormMap param);
	
	List<E> selectProductDescList(FormMap param);
	
	void insertProductDesc(FormMap param);
	
	void removeProductDesc(FormMap param);
 
	List<E> selectShopList(FormMap param);

	List<E> getProductListByIds(FormMap param);

	List<E> autoGetProduct(FormMap param);


	List<E> getSpecCustomByIds(FormMap formMap);


	E getItemById(FormMap formMap);

	E isJoinActivity(FormMap formMap);

	E selectProductById(FormMap formMap);

}
