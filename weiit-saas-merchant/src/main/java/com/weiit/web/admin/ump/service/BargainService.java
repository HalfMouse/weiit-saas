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
public interface BargainService extends BaseService {

	List<E> selectBargainDetailList(FormMap formmap);

	List<E> selectBargainNancyList(FormMap formmap);

	List<E> selectProductList(FormMap formmap);

	List<E> getProductByBargainIds(FormMap formmap);



}

