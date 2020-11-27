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
public interface GrouponMapper extends BaseMapper {
   List<E> selectGrouponDetailList(FormMap formmap);
   List<E> selectGrouponNancyList(FormMap formmap);
   List<E> selectProductList(FormMap formMap);
   List<E> selectProductList2(FormMap formMap);
   List<E> grouponListByIds(FormMap formMap);

   List<E> grouponItemById(FormMap formMap);

   void insertGrouponItem (E formMap);

   void updateGrouponItem (E formMap);

   int selectGrouponCount(FormMap formMap);
}
