package com.weiit.web.admin.setting.mapper;
 
import java.util.List;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
 /**
  * 商品横幅活动接口类
  * Title: productBannerMapper.java
  * Description: 
  * Company: 微云时代
  * @author lichengmeng
  * @date 2016年6月6日
  */
public interface ShippingMapper extends BaseMapper{


	List<E> selectShipmentsDetail(FormMap param);

	int insertShipmentsDetail(FormMap param);

	int removeShipmentsDetail(FormMap param);
}
