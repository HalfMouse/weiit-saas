package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.InitMapper;
import com.weiit.web.admin.init.service.InitService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

/**
 *  数据初始化 Mapper
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("initService")
public class InitServiceImpl extends AbstractService implements InitService {

    @Resource
    private InitMapper initMapper;

    @Override
	public BaseMapper setMapper() {
		return initMapper;
	}
    
    @Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public void insertInit(FormMap formMap){
    	int shop_id=formMap.getInt("shop_id");
    	//查询初始化微页面
    	List<E> pageList = initMapper.selectPageList(formMap);
    	if(pageList!=null && pageList.size()>0){
        	FormMap paramMap=new FormMap();
        	paramMap.put("pageList", pageList);
        	paramMap.put("shop_id", shop_id);
        	initMapper.insertPage(paramMap);
    	}
    	//插入默认余额支付
    	initMapper.insertShopPayment(formMap);
    	
    	//查询初始化店铺协议
    	List<E> protocolList = initMapper.selectProtocolList(formMap);
    	if(protocolList!=null && protocolList.size()>0){
        	FormMap paramMap=new FormMap();
        	paramMap.put("protocolList", protocolList);
        	paramMap.put("shop_id", shop_id);
        	initMapper.insertProtocol(paramMap);
    	}
    	//查询初始化底部菜单表
    	List<E> bottomList = initMapper.selectPageBottomList(formMap);
    	if(bottomList!=null && bottomList.size()>0){
        	FormMap paramMap=new FormMap();
        	paramMap.put("bottomList", bottomList);
        	paramMap.put("shop_id", shop_id);
        	initMapper.insertPageBottom(paramMap);
    	}
    	//查询初始化全店风格表
    	List<E> globalList = initMapper.selectPageGlobalList(formMap);
    	if(globalList!=null && globalList.size()>0){
        	FormMap paramMap=new FormMap();
        	paramMap.put("globalList", globalList);
        	paramMap.put("shop_id", shop_id);
        	initMapper.insertPageGlobal(paramMap);
    	}
    	//查询初始化菜单导航
    	List<E> navsList = initMapper.selectPageNavsList(formMap);
    	if(navsList!=null && navsList.size()>0){
        	FormMap paramMap=new FormMap();
        	paramMap.put("navsList", navsList);
        	paramMap.put("shop_id", shop_id);
        	initMapper.insertPageNavs(paramMap);
    	}
    	//查询初始化商品属性与规格表
    	List<E> customList = initMapper.selectProductCustomList(formMap);
    	for (E customMap : customList) { 
    		customMap.put("shop_id", shop_id);
    		if(customMap.getStr("parent_id").equals("")){
    			initMapper.insertProductCustom(customMap);
    		}
    	}
    	for (E customMap : customList) { 
    		customMap.put("shop_id", shop_id);
    		if(!customMap.getStr("parent_id").equals("")){
    			for (E info : customList) {
					if(customMap.getStr("parent_id").equals(info.getStr("old_key_id"))){
						customMap.set("parent_id", info.getStr("key_id"));
						break;
					}
				}
    			initMapper.insertProductCustom(customMap);
    		}
    	}
    	//查询初始化商品
    	List<E> productList = initMapper.selectProductList(formMap);
    	for (E product : productList) { 
    		Integer old_product_id = product.getInt("old_product_id");
    		product.set("shop_id", shop_id);
    		Random rom=new Random();
    		String productNum= Calendar.getInstance().getTimeInMillis()+String.valueOf(rom.nextInt(100000)*100000).substring(0,5);
    		product.put("product_num", productNum);
    		// 插入商品数据
    		initMapper.insertProduct(product);
    		Integer product_id = product.getInt("product_id");
    		
    		formMap.set("product_id", old_product_id);
    		//查询初始化商品描述
    		E descMap = initMapper.selectProductDescOne(formMap);
        	if(descMap!=null && !descMap.getStr("id").equals("")){
            	descMap.put("shop_id", shop_id);
            	descMap.put("product_id", product_id);
            	initMapper.insertProductDesc(descMap);
        	}
        	//查询初始化商品图片
        	List<E> imagesList = initMapper.selectProductImagesList(formMap);
        	if(imagesList!=null && imagesList.size()>0){
            	FormMap paramMap=new FormMap();
            	paramMap.put("imagesList", imagesList);
            	paramMap.put("shop_id", shop_id);
            	paramMap.put("product_id", product_id);
            	initMapper.insertProductImages(paramMap);
        	}
        	//查询初始化商品规格
        	List<E> itemList = initMapper.selectProductItemList(formMap);
        	for (E item : itemList) {
        		item.put("shop_id", shop_id);
        		item.put("product_id", product_id);
            	initMapper.insertProductItem(item);
			}
        	//查询初始化商品营销活动  砍价
        	List<E> bargainList = initMapper.selectUmpBargainList(formMap);
        	if(bargainList!=null && bargainList.size()>0){
        		for (E bargain : bargainList) {
            		for (E item : itemList) {
    					if(item.getStr("old_item_id").equals(bargain.getStr("item_id"))){
    						bargain.put("item_id", item.getStr("item_id"));
    					}
    				}
            		bargain.put("shop_id", shop_id);
            		bargain.put("product_id", product_id);
                	initMapper.insertUmpBargain(bargain);
    			}
        	}
        	//查询初始化商品营销活动 拼团
        	List<E> grouponList = initMapper.selectUmpGrouponList(formMap);
        	for (E groupon : grouponList) {
        		groupon.put("shop_id", shop_id);
        		groupon.put("product_id", product_id);
            	initMapper.insertUmpGroupon(groupon);
			}
		}

    	//查询初始化 优惠券
    	List<E> couponList = initMapper.selectUmpCouponList(formMap);
    	for (E coupon : couponList) {
    		coupon.put("shop_id", shop_id);
        	initMapper.insertUmpCoupon(coupon);
		}
    	//查询初始化商家物流 
    	List<E> expressList = initMapper.selectShopExpressList(formMap);
    	if(expressList!=null && expressList.size()>0){
        	FormMap paramMap=new FormMap();
        	paramMap.put("expressList", expressList);
        	paramMap.put("shop_id", shop_id);
        	initMapper.insertShopExpress(paramMap);
    	}
    	
    }
    
    
    
}
