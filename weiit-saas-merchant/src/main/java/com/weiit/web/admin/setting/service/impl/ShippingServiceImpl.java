package com.weiit.web.admin.setting.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.DateUtil;
import com.weiit.web.admin.setting.mapper.ShippingMapper;
import com.weiit.web.admin.setting.service.ShippingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
/**
 * 商品横幅活动实现类
 * Title: ShipmentsServiceImpl.java
 * Description: 
 * Company: 微云时代
 * @author lichengmeng
 * @date 2016年6月6日
 */
@Service("shippingService")
public class ShippingServiceImpl  extends AbstractService  implements  ShippingService{

	@Resource
	private ShippingMapper shippingMapper;
	@Override
	public BaseMapper setMapper() {
		return shippingMapper;
	} 
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int insert(FormMap map)
    {
		map.put("status",1);
		shippingMapper.insert(map);
		int shipping_id=map.getInt("shipping_id");
		
		int areasIdsCount=map.getInt("areasIdsCount");
		int num=0;
		for (int i = 0; i < areasIdsCount ; i++) {
			FormMap detail=new FormMap();
			if(map.get("areasIdslist"+i)!=null && !map.get("areasIdslist"+i).toString().equals("")){
				detail.put("shipping_id", shipping_id);
				detail.put("areas_ids", map.get("areasIdslist"+i) );
				detail.put("areas_names", map.get("areasNameslist"+i) );
				detail.put("start_standard", map.get("startStandardlist"+i) );
				detail.put("start_fee", map.get("startFeelist"+i));
				detail.put("add_standard", map.get("addStandardlist"+i));
				detail.put("add_fee", map.get("addFeelist"+i));
				detail.put("sort_num", num); 
				detail.put("shop_id", map.get("shop_id"));
				detail.put("app_id", map.get("app_id"));
				shippingMapper.insertShipmentsDetail(detail);
				num++;
			}
		}
        return 1;
    }

	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public int edit(FormMap map)
    {
		shippingMapper.edit(map);
			if(map.getStr("eivt")==null || !map.getStr("eivt").equals("status")){
			
			int shipping_id=map.getInt("shipping_id");
			
			shippingMapper.removeShipmentsDetail(map);
			int areasIdsCount=map.getInt("areasIdsCount");;
			int num=0;
			for (int i = 0; i < areasIdsCount ; i++) {
				FormMap detail=new FormMap();
				if(map.get("areasIdslist"+i)!=null && !map.get("areasIdslist"+i).toString().equals("")){
					detail.put("shipping_id", shipping_id);
					detail.put("areas_ids", map.get("areasIdslist"+i) );
					detail.put("areas_names", map.get("areasNameslist"+i) );
					detail.put("start_standard", map.get("startStandardlist"+i) );
					detail.put("start_fee", map.get("startFeelist"+i));
					detail.put("add_standard", map.get("addStandardlist"+i));
					detail.put("add_fee", map.get("addFeelist"+i));
					detail.put("sort_num", num); 
					detail.put("shop_id", map.get("shop_id"));
					detail.put("app_id", map.get("app_id"));
					shippingMapper.insertShipmentsDetail(detail);
					num++;
				}
			}
		}
        return 1;
    }
    
	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
	public int insertShipmentsCopy(FormMap map){
		String date= DateUtil.dateToString(new Date(), DateUtil.patternF);
		
		E shipMap=shippingMapper.selectOne(map);
		List<E> detaList=shippingMapper.selectShipmentsDetail(map);
	 
		map.put("shipping_name", shipMap.get("shipping_name")+date);
		map.put("shipping_config", shipMap.get("shipping_config")); 
		shippingMapper.insert(map);
		
		Integer shipping_id=map.getInt("shipping_id");
		
		for (int i = 0; i < detaList.size(); i++) {
			FormMap detail=new FormMap();
			E info=detaList.get(i);
			detail.putAll(info);
			detail.put("shipping_id", shipping_id);
			detail.put("sort_num", i);
			detail.put("shop_id", map.get("shop_id"));
			detail.put("app_id", map.get("app_id"));
			shippingMapper.insertShipmentsDetail(detail);
		}
		return 1;
	}
	
	@Override
	public List<E> selectShipmentsDetail(FormMap param) {
		return shippingMapper.selectShipmentsDetail(param);
	}

	@Override
	public int insertShipmentsDetail(FormMap param) {
		return shippingMapper.insertShipmentsDetail(param);
	}

	@Override
	public int removeShipmentsDetail(FormMap param) {
		return shippingMapper.removeShipmentsDetail(param);
	}
}
