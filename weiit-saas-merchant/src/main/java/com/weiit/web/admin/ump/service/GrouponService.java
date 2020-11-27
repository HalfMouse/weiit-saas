package com.weiit.web.admin.ump.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 秒杀 接口类
 * Title: DiscountService.java
 * Description: 
 * Company: 微云时代
 * @author hzy
 * @date 2017年12月26日
 */
public interface GrouponService extends BaseService {
	List<E> selectGrouponDetailList(FormMap formmap);
	List<E> selectGrouponNancyList(FormMap formmap);
	List<E> selectProductList(FormMap formMap);

	List<E> grouponListByIds(FormMap formMap);

	List<E> grouponItemById(FormMap formMap);


	void insertGrouponItem(E param);

	void updateGrouponItem (E param);

	/**
	 * 查询 拼团活动的开团数量
	 * @param formMap
	 * @return
	 * */
	int  selectGrouponCount(FormMap formMap);
}

