package com.weiit.web.admin.product.service;

import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 商品导入接口类
 * Title: ProductImportService.java
 * Description: 
 * Company: http://www.wei-it.com
 * @author hzy
 * @date 2016年6月6日
 */
public interface ProductImportService extends BaseService {
	int insertProductImport(List<FormMap> csvList);
}

