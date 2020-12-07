package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.api.mapper.ProductMapper;
import com.weiit.web.api.service.OrderService;
import com.weiit.web.api.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;


/**
 * 商品接口实现类
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class ProductServiceImpl extends AbstractService implements ProductService {

	@Resource
	private ProductMapper productMapper;

	@Autowired
	OrderService orderService;

	@Autowired
	RedisUtil redisUtil;

	@Override
	public BaseMapper setMapper() {
		return productMapper;
	}

	@Override
	public List<E> selectProductSearch(FormMap formMap) {
		return productMapper.selectProductSearch(formMap);
	}

	@Override
	public E selectProductById(FormMap formMap) {
		return productMapper.selectProductById(formMap);
	}
	@Override
	public E selectProductInfoById(FormMap formMap) {
		return productMapper.selectProductInfoById(formMap);
	}

	@Override
	public List<E> selectProductImgs(FormMap formMap) {
		return productMapper.selectProductImgs(formMap);
	}
	
	@Override
	public List<E> selectSpecList(FormMap formMap){
		return productMapper.selectSpecList(formMap);
	}

	@Override
	public List<E> selectItemSpecList(FormMap formMap){
		return productMapper.selectItemSpecList(formMap);
	}
	
	@Override
	public List<E> selectUserCartList(FormMap formMap){
		return productMapper.selectUserCartList(formMap);
	}

	@Override
	public void editUserCart(FormMap formMap){
		 productMapper.editUserCart(formMap);
	}

	@Override
	public void editUserCartCount(FormMap formMap){
		productMapper.editUserCartCount(formMap);
	}

	@Override
	public void deleteUserCartById(FormMap formMap){
		productMapper.deleteUserCartById(formMap);
	}

	@Override
	public E selectItemSpec(FormMap formMap) {
		return productMapper.selectItemSpec(formMap);
	}

	@Override
	public E selectProductItemByItemId(FormMap formMap) {
		return productMapper.selectProductItemByItemId(formMap);
	}

	@Override
	public E selectUserCartByProductIdAndItemId(FormMap formMap) {
		return productMapper.selectUserCartByProductIdAndItemId(formMap);
	}

	@Override
	public void insertUserCart(FormMap formMap) {
		productMapper.insertUserCart(formMap);
	}

	@Override
	public E selectUserAddressDefault(FormMap formMap) {
		return productMapper.selectUserAddressDefault(formMap);
	}
	@Override
	public E getProductItemById(FormMap formMap) {
		return productMapper.getProductItemById(formMap);
	}

	@Override
	public List<E> selectUserCouponList(FormMap formMap) {
		return productMapper.selectUserCouponList(formMap);
	}

	@Override
	public void insertProductcollection(FormMap formMap) {
		productMapper.insertProductcollection(formMap);
	}

	@Override
	public void updateProductAndItemStock(FormMap formMap) {

		//product_id /item_id  count
		//添加已售数量
		productMapper.updateProductStock(formMap);

		productMapper.updateItemStock(formMap);


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
	public List<E> getSpecInfoByIds(FormMap param) {
		return productMapper.getSpecInfoByIds(param);
	}

	@Override
	public E selectCartInfoById(FormMap formMap) {
		return productMapper.selectCartInfoById(formMap);
	}


	@Override
	public  E productDetail(FormMap formMap){


		//查询商品基本信息
		E productInfo=selectProductById(formMap);
		//查询商品图片
		List<E> productImgs=selectProductImgs(formMap);
		//得到属性信息
		ArrayList<E> attributeInfo=new ArrayList<E>();

		//自定义属性
		String attribute_custome=productInfo.getStr("attribute_custom");
		if(!attribute_custome.equals("")){
			String []  content=attribute_custome.split("\\|");
			for (int i = 0; i < content.length; i++) {
				String [] ab=content[i].split(":");
				if(ab!=null){
					E attribute=new E();
					attribute.put("attribute_name", ab[1]);
					attribute.put("attribute_value", ab[2]);
					attributeInfo.add(attribute);
				}
			}
		}

		// 查询商品规格信息
		if (productInfo.getInt("spec_config") == 1) {// 表示商品有多规格
			formMap.set("spec_custom",productInfo.getStr("spec_custom").replace(";", ","));
			// 商品所有的商品规格
			List<E> specList = selectSpecList(formMap);

			// 查询存在库存与价格的商品规格
			List<E> itemSpecList = selectItemSpecList(formMap);
			// 过滤不存在的商品规格
			List<E> specResultList = new ArrayList<E>();
			for (E spec : specList) {
				int count = 0;
				for (E spec_custom : itemSpecList) {
					if (spec_custom.getStr("spec_custom").contains(spec.getStr("spec_value_id"))) {
						count++;
					}
				}
				if (count > 0) {
					specResultList.add(spec);
				}
			}
			// 对过滤后的list转化为map结构
			List specInfo = parseListToMap(specResultList);
			productInfo.set("spec_info", specInfo);
		}else{
			//若是单规格
			productInfo.set("item_id", getItemInfoByProductId(formMap).getStr("item_id"));

		}

		//运费计算方式

		//统一计算
		if (productInfo.getInt("express_config")==-1){
			if (productInfo.getDouble("express_money").compareTo(0.0)>0){
				productInfo.put("expressInfo",productInfo.getDouble("express_money")+"元");
			}else {
				productInfo.put("expressInfo","包邮");
			}
		}else {
			if (productInfo.getDouble("weight").compareTo(0.0)>0){
				productInfo.put("expressInfo","按重量");
			}else if (productInfo.getDouble("weight").compareTo(0.0)>0){
				productInfo.put("expressInfo","按体积");
			}else {
				productInfo.put("expressInfo","按件数");
			}
		}
		//组装数据返回
		E result=new E();
		productInfo.set("product_imgs", productImgs);
		productInfo.set("attribute_info", attributeInfo);
		//获取商品标签信息
		productInfo.set("tag_info",getProductTagById(formMap));
		result.put("product_info", productInfo);



		return result;
	}



	public List<E> getProductTagById(FormMap formMap){
		return productMapper.getProductTagById(formMap);
	}

	public E getItemInfoByProductId(FormMap formMap){
		E result = productMapper.getItemInfoByProductId(formMap);
		return result;
	}


	// 将商品规格转化成map
	public List parseListToMap(List<E> list) {
		LinkedHashMap<String, String> tempMap = new LinkedHashMap<String, String>();
		for (E spec : list) {
			tempMap.put(spec.getStr("spec_id"), spec.getStr("spec_name"));
		}
		//LinkedHashMap<String, Object> specResultMap = new LinkedHashMap<String, Object>();
		List resultList=new ArrayList<E>();
		for (String key : tempMap.keySet()) {
			LinkedHashMap<String, Object> specResultMap = new LinkedHashMap<String, Object>();
			List<E> specValueList = new ArrayList<E>();
			for (E specValue : list) {
				if (key.equals(specValue.getStr("spec_id"))) {
					specValue.remove("spec_id");
					specValue.remove("spec_name");
					specValueList.add(specValue);
				}
			}
			specResultMap.put("spec_name", tempMap.get(key));
			specResultMap.put("values", specValueList);
			resultList.add(specResultMap);
		}
		return resultList;
	}

	@Override
	public E calcExpressPriceForActivity(FormMap formMap) {
		E result = new E();
		E productInfo = selectProductInfoById(formMap);
		List<E> postageList = new ArrayList<E>();
		//购买数量
		productInfo.set("count",formMap.get("count"));
		E calcInfo =orderService.calcProduct(productInfo,formMap);
		postageList.add(calcInfo);
		result.put("expressPrice",orderService.calcPrice(postageList));
		result.put("express_template_id",productInfo.getStr("express_template_id"));
		return result;
	}
}
