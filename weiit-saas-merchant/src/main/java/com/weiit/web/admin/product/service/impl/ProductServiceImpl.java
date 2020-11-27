package com.weiit.web.admin.product.service.impl;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.product.mapper.ProductGroupMapper;
import com.weiit.web.admin.product.mapper.ProductImportMapper;
import com.weiit.web.admin.product.mapper.ProductMapper;
import com.weiit.web.admin.product.service.ProductService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;
import java.util.Random;
import java.util.UUID;

/**
 * 商品管理接口实现类
 * @author tangjian
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("productService")
public class ProductServiceImpl extends AbstractService implements ProductService {
	
	@Resource
	private ProductMapper productMapper;
	@Resource
	private ProductImportMapper productImportMapper;
	@Resource
	private ProductGroupMapper productGroupMapper;
 
	@Override
	public BaseMapper setMapper() {
		return productMapper;
	}
	
	/**
	 * 插入商品(事物)
	 */
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int insert(FormMap map) {
		Random rom=new Random();
		String productNum= Calendar.getInstance().getTimeInMillis()+String.valueOf(rom.nextInt(100000)*100000).substring(0,5);
		map.put("product_num", productNum);

		String skuCustom="";
		if(map.get("mitems")!=null){
			if( map.get("mitems").getClass().getName().equals("java.lang.String")){
				skuCustom=map.get("mitems").toString();
			}else if( map.get("mitems").getClass().isArray() ){
				String [] items = (String [])map.get("mitems");
				for (int i = 0; i < items.length; i++) {
					if(StringUtils.isNotEmpty(items[i])){
						if(skuCustom==""){
							skuCustom=items[i];
						}else{
							skuCustom=skuCustom+"|"+items[i];
						}
					}
				}
			}
		}
		map.put("attribute_custom", skuCustom);
		
		String originalImg="";
		if(map.get("imagesList")!=null){
			List imagesList = (List)map.get("imagesList");
			if(imagesList.size()>0){
				originalImg=imagesList.get(0).toString();
			}
		}
		
		if(map.get("spec_config")!=null && map.get("spec_config").toString().equals("1"))
		{ 
			Double smark=0.0;
			Double sale=0.0;
			int stock=0;
			int rowCount= Integer.parseInt( map.get("rowCount").toString() );
			for (int i = 0; i < rowCount ; i++) { 
				if(smark > map.getDouble("smarketPricelist"+i) || smark==0.0 ){
					smark=map.getDouble("smarketPricelist"+i);
				}
				if(sale > map.getDouble("salePricelist"+i) || sale==0.0 ){
					sale=map.getDouble("salePricelist"+i);
				}
				stock=stock+map.getInt("stocklist"+i);
			} 
			map.put("smarket_price", smark );
			map.put("sale_price", sale );
			map.put("stock", stock );
		}
		map.put("spec_custom", map.get("specAttributeIds") );
		map.put("product_img", originalImg ); 
		map.put("product_id", "");
		productMapper.insert(map);
		 
		productMapper.insertProductDesc(map);
 
		int productId=map.getInt("product_id");
		//插入 主图
		if(map.get("imagesList")!=null){
			List imagesList = (List)map.get("imagesList");
			for (int i = 0; i < imagesList.size(); i++) {
				String orImg=imagesList.get(i).toString();
				FormMap imageMap=new FormMap();
				imageMap.put("product_id", productId);
				imageMap.put("product_img", orImg ); 
				imageMap.put("type", i); 
				imageMap.put("shop_id", map.get("shop_id")); 
				imageMap.put("app_id", map.get("app_id")); 
				productMapper.insertImages(imageMap);
			}
		}
 
		if(map.get("spec_config")!=null && map.get("spec_config").toString().equals("1"))
		{
			int rowCount= Integer.parseInt( map.get("rowCount").toString() );
			for (int i = 0; i < rowCount ; i++) {
				FormMap sukMap=new FormMap();
				sukMap.put("product_id", productId);
				sukMap.put("item_num", map.get("itemNumlist"+i) ); 
				sukMap.put("spec_custom", map.get("attValArrlist"+i) );
				sukMap.put("smarket_price", map.get("smarketPricelist"+i));
				sukMap.put("sale_price", map.get("salePricelist"+i));
				sukMap.put("stock", map.get("stocklist"+i));
				sukMap.put("shop_id", map.get("shop_id")); 
				sukMap.put("app_id", map.get("app_id")); 
				productMapper.insertItem(sukMap);
			}
		}else{
			FormMap sukMap=new FormMap();
			sukMap.put("product_id", productId);
			sukMap.put("item_num", map.get("item_num")); 
			sukMap.put("spec_custom", "");
			sukMap.put("smarket_price", map.get("smarket_price"));
			sukMap.put("sale_price", map.get("sale_price"));
			sukMap.put("stock", map.get("stock"));
			sukMap.put("shop_id", map.get("shop_id"));
			sukMap.put("app_id", map.get("app_id"));
			productMapper.insertItem(sukMap);
		}
		
		String[] tag_id_str =null ;
		if(map.get("tag_id_str")!=null){
			if(map.get("tag_id_str") instanceof String[]){
				tag_id_str = (String[]) map.get("tag_id_str");
			}else{
				tag_id_str = new String[1];
				tag_id_str[0] = map.getStr("tag_id_str");
			}
			//循环插入多个分组
			for (int j = 0; j < tag_id_str.length; j++) {
				FormMap tagMap=new FormMap();
				tagMap.put("group_id", tag_id_str[j]);
				tagMap.put("product_id", productId);
				tagMap.put("shop_id", map.get("shop_id")); 
				productGroupMapper.insertDetail(tagMap);
			}
		}
		
		if(map.get("importProductId")!=null && !"".equals(map.get("importProductId").toString())){
			FormMap impMap=new FormMap();
			impMap.put("product_id", map.get("importProductId"));
			productImportMapper.remove(impMap);
		}
		return 1;
	}

	/**
	 * 修改商品(事物)
	 */
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int edit(FormMap map) {
		String skuCustom="";
		if(map.get("mitems")!=null){
			if( map.get("mitems").getClass().getName().equals("java.lang.String")){
				skuCustom=map.get("mitems").toString();
			}else if( map.get("mitems").getClass().isArray() ){
				String [] items = (String [])map.get("mitems");
				for (int i = 0; i < items.length; i++) {
					if(StringUtils.isNotEmpty(items[i])){
						if(skuCustom==""){
							skuCustom=items[i];
						}else{
							skuCustom=skuCustom+"|"+items[i];
						}
					}
				}
			}
		}
		map.put("attribute_custom", skuCustom);
		
		String originalImg="";
		if(map.get("imagesList")!=null){
			List imagesList = (List)map.get("imagesList");
			if(imagesList.size()>0){
				originalImg=imagesList.get(0).toString();
			}
		}
		
		if(map.get("spec_config")!=null && map.get("spec_config").toString().equals("1"))
		{ 
			Double smark=0.0;
			Double sale=0.0;
			int stock=0;
			int rowCount= Integer.parseInt( map.get("rowCount").toString() );
			for (int i = 0; i < rowCount ; i++) { 
				if(smark > map.getDouble("smarketPricelist"+i)  || smark==0.0 ){
					smark=map.getDouble("smarketPricelist"+i);
				}
				if(sale > map.getDouble("salePricelist"+i) || sale==0.0 ){
					sale=map.getDouble("salePricelist"+i);
				}
				stock=stock+map.getInt("stocklist"+i);
			} 
			map.put("smarket_price", smark );
			map.put("sale_price", sale );
			map.put("stock", stock );
		}
		map.put("spec_custom", map.get("specAttributeIds") );
		map.put("product_img", originalImg ); 
		productMapper.edit(map);
		
		productMapper.removeProductDesc(map);
		productMapper.insertProductDesc(map);
		

		
		int productId=map.getInt("product_id");
		//插入 主图
		productMapper.removeImages(map);
		if(map.get("imagesList")!=null){
			List imagesList = (List)map.get("imagesList");
			for (int i = 0; i < imagesList.size(); i++) {
				String orImg=imagesList.get(i).toString();
				FormMap imageMap=new FormMap();
				imageMap.put("product_id", productId);
				imageMap.put("product_img", orImg ); 
				imageMap.put("type", i); 
				imageMap.put("shop_id", map.get("shop_id")); 
				imageMap.put("app_id", map.get("app_id")); 
				productMapper.insertImages(imageMap);
			}
		}


		if(map.get("spec_config")!=null && map.get("spec_config").toString().equals("1")) {
			//先全部更新为删除状态
			removeItem(map);

			int rowCount= Integer.parseInt( map.get("rowCount").toString() );
			for (int i = 0; i < rowCount ; i++) {
				FormMap sukMap=new FormMap();
				sukMap.put("product_id", productId);
				sukMap.put("item_num", map.get("itemNumlist"+i) );
				sukMap.put("spec_custom", map.get("attValArrlist"+i) );
				sukMap.put("smarket_price", map.get("smarketPricelist"+i));
				sukMap.put("sale_price", map.get("salePricelist"+i));
				sukMap.put("stock", map.get("stocklist"+i));
				sukMap.put("shop_id", map.get("shop_id"));
				sukMap.put("app_id", map.get("app_id"));
				if (StringUtils.isEmpty(map.getStr("itemId"+i))){

					//判断商品的spec_custom   是否之前存在  存在就更新
					E itemInfo = productMapper.selectItemByProductIdAndSpec(sukMap);
					if (itemInfo!=null && StringUtils.isNotEmpty(itemInfo.getStr("item_id"))){
						sukMap.put("item_id", itemInfo.getStr("item_id"));
						sukMap.put("is_deleted", 0);
						productMapper.editItem(sukMap);
					}else {
						productMapper.insertItem(sukMap);
					}
				}else {
					sukMap.put("item_id", map.get("itemId"+i));
					sukMap.put("is_deleted", 0);
					productMapper.editItem(sukMap);
				}

			}
		}else{
			FormMap sukMap=new FormMap();
			sukMap.put("item_num", map.get("item_num"));
			sukMap.put("item_id", map.get("item_id"));
			sukMap.put("smarket_price", map.get("smarket_price"));
			sukMap.put("sale_price", map.get("sale_price"));
			sukMap.put("stock", map.get("stock"));
			sukMap.put("is_deleted", 0);
			productMapper.editItem(sukMap);
		}
		
		FormMap tagDel=new FormMap();
		tagDel.put("product_id", productId);
		productGroupMapper.removeDetail(tagDel);
		String[] tag_id_str =null ;
		if(map.get("tag_id_str")!=null){
			if(map.get("tag_id_str") instanceof String[]){
				tag_id_str = (String[]) map.get("tag_id_str");
			}else{
				tag_id_str = new String[1];
				tag_id_str[0] = map.getStr("tag_id_str");
			}
			//循环插入多个分组
			for (int j = 0; j < tag_id_str.length; j++) {
				FormMap tagMap=new FormMap();
				tagMap.put("group_id", tag_id_str[j]);
				tagMap.put("product_id", productId);
				tagMap.put("shop_id", map.get("shop_id")); 
				productGroupMapper.insertDetail(tagMap);
			}
		}
		return 1;
	}
	
	@Override
	public void editStatus(FormMap param) {
		productMapper.edit(param);
	}
	
	
	@Override
	public List<E> selectCateList(FormMap param) {
		return productMapper.selectCateList(param);
	}
	@Override
	public List<E> selectAttrList(FormMap param) {
		return productMapper.selectAttrList(param);
	}

	@Override
	public List<E> productListForPage(FormMap param) {
		return productMapper.productListForPage(param);
	}

	@Override
	public int productCountForPage(FormMap param) {
		return productMapper.productCountForPage(param);
	}

	/**
	 * 插入商品属性(事物)
	 */
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public void insertAttr(FormMap param) {
		UUID onlyKey = UUID.randomUUID();     
		param.put("token", onlyKey.toString());
		param.put("key_id", "");
		param.put("key_name", param.get("attributeName"));
		productMapper.insertAttr(param);
 
		FormMap param22 =new FormMap();
			param22.putAll(param);
		UUID onlyKey22 = UUID.randomUUID();     
		param22.put("token", onlyKey22.toString());
		param22.put("parent_id", param.get("key_id"));
		param22.put("key_name", param.get("attributeValueName"));
		productMapper.insertAttr(param22);
	}
	
	/**
	 * 删除商品属性(事物)
	 */
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public void removeAttr(FormMap param) {
		productMapper.removeAttr(param);
		param.put("parent_id", param.get("key_id"));
		param.remove("key_id");
		productMapper.removeAttr(param);
	}
 
	/**
	 * 插入商品属性token
	 */
	@Override
	public void insertAttrVal(FormMap param) {
		UUID onlyKey = UUID.randomUUID();     
		param.put("token", onlyKey.toString());
		productMapper.insertAttr(param);
	}
	
	@Override
	public void removeAttrVal(FormMap param) {
		productMapper.removeAttr(param);
	}
	
	@Override
	public List<E> selectItemList(FormMap param) {
		return productMapper.selectItemList(param);
	}
	
	@Override
	public void insertItem(FormMap param) {
		productMapper.insertItem(param);
	}
	
	@Override
	public void removeItem(FormMap param) {
		productMapper.removeItem(param);
	}
	
	@Override
	public List<E> selectImagesList(FormMap param) {
		return productMapper.selectImagesList(param);
	}
	
	@Override
	public void insertImages(FormMap param) {
		productMapper.insertImages(param);
	}
	
	@Override
	public void removeImages(FormMap param) {
		productMapper.removeImages(param);
	}
	
	@Override
	public  List<E> selectProductDescList(FormMap param){
		return productMapper.selectProductDescList(param);
	}
	
	@Override
	public  void insertProductDesc(FormMap param){
		productMapper.insertProductDesc(param);
	}
	
	@Override
	public void removeProductDesc(FormMap param){
		productMapper.removeProductDesc(param);
	}
 
	@Override
	public  List<E> selectShopList(FormMap param){
		return productMapper.selectShopList(param);
	}

	@Override
	public List<E> getProductListByIds(FormMap param) {
		return productMapper.getProductListByIds(param);
	}
	@Override
	public List<E> autoGetProduct(FormMap param) {
		return productMapper.autoGetProduct(param);
	}
	@Override
	public List<E> getSpecCustomByIds(FormMap param) {
		return productMapper.getSpecCustomByIds(param);
	}

	@Override
	public E getItemById(FormMap param) {
		return productMapper.getItemById(param);
	}

	@Override
	public E isJoinActivity(FormMap formMap) {
		E result = new E();
		E bargainInfo =productMapper.selectIsJoinBargain(formMap);
		if (bargainInfo!=null && StringUtils.isNotEmpty(bargainInfo.getStr("product_id"))){
			result.put("isJoinActivity",true);
			result.put("activityInfo","商品正在砍价活动中，活动结束或失效后才能修改商品规格");
			return result;
		}
		E grouponInfo =productMapper.selectIsJoinGroupon(formMap);
		if (grouponInfo!=null && StringUtils.isNotEmpty(grouponInfo.getStr("product_id"))){
			result.put("isJoinActivity",true);
			result.put("activityInfo","商品正在砍价活动中，活动结束或失效后才能修改商品规格");
			return result;
		}



		return null;
	}

	@Override
	public E selectProductById(FormMap formMap) {
		return productMapper.selectProductById(formMap);
	}

}
