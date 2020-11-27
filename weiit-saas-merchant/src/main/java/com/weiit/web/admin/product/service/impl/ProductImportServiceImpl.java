package com.weiit.web.admin.product.service.impl;

import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.product.mapper.ProductImportMapper;
import com.weiit.web.admin.product.service.ProductImportService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;


/**
 * 商品导入实现类
 * Title: ProductImportServiceImpl.java
 * Description: 
 * Company: http://www.wei-it.com
 * @author hzy
 * @date 2016年6月6日
 */
@Service("productImportService")
public class ProductImportServiceImpl  extends AbstractService implements ProductImportService {

	@Resource
	private ProductImportMapper productImportMapper;
	@Override
	public BaseMapper setMapper() {
		return productImportMapper;
	} 
	
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int insertProductImport(List<FormMap> csvList){
		int num=0;
		for (FormMap formMap : csvList) {
			num=num+productImportMapper.insert(formMap);
		} 
		return num;
	}
	
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int remove(FormMap param){
		String productid=param.getStr("ids").trim();
		String [] prodarr=productid.split(",");
		int num=0;
		for (int i = 0; i < prodarr.length; i++) {
			param.put("product_id", prodarr[i] );
			num=num+productImportMapper.remove(param);
		}
		return num;
	} 
	
}
