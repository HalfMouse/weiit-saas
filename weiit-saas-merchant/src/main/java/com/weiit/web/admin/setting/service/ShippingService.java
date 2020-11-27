package com.weiit.web.admin.setting.service;

import java.util.List; 
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;


/**
 * 商品横幅活动接口类
 * Title: productBannerService.java
 * Description: 
 * Company: 微云时代
 * @author lichengmeng
 * @date 2016年6月6日
 */
public interface ShippingService extends BaseService{


	int insertShipmentsCopy(FormMap map);
	
	List<E> selectShipmentsDetail(FormMap param);

	int insertShipmentsDetail(FormMap param);

	int removeShipmentsDetail(FormMap param);
}

