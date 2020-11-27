package com.weiit.web.admin.product.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.product.mapper.ProductGroupMapper;
import com.weiit.web.admin.product.service.ProductGroupService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 商品分组Mapper
 * @author hezhiying
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("productGroupService")
public class ProductGroupServiceImpl extends AbstractService implements ProductGroupService {

    @Resource
    private ProductGroupMapper productGroupMapper;

    @Override
	public BaseMapper setMapper() {
		return productGroupMapper;
	}
      
    @Override
    public int remove(FormMap param){
    	productGroupMapper.removeDetail(param);
    	productGroupMapper.remove(param); 
	    return 0;
    }
    
    @Override
    public  List<E> selectDetailList(FormMap param){
    	return productGroupMapper.selectDetailList(param);
    }

    @Override
    public  List<E> getProductByGroupId(FormMap param){
    	return productGroupMapper.getProductByGroupId(param);
    }

	/**
	 * 插入 
	 */
    @Override
    public void insertDetail(FormMap param){
    	productGroupMapper.insertDetail(param);
    }
	
	/**
	 * 删除 
	 */ 
    @Override
    public void removeDetail(FormMap param){
    	productGroupMapper.removeDetail(param);
    }

    @Override
    public List<E> productGroupList(FormMap param) {
        return null;
    }
}
