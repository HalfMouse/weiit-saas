package com.weiit.web.admin.ump.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 *  限时折扣 接口类
 * Title: productBannerMapper.java
 * Description:
 * Company: 微云时代
 * @author hzy
 * @date 2017年12月26日
 */
public interface BargainMapper extends BaseMapper {
   List<E> selectBargainDetailList(FormMap formmap);
   List<E> selectBargainNancyList(FormMap formmap);
   List<E> selectProductList(FormMap formmap);
   List<E> getProductByBargainIds(FormMap formmap);
}
