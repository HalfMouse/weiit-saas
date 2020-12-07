package com.weiit.web.api.mapper;

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

   List<E> grouponListByIds(FormMap formMap);

   List<E> inProcessGroupon(FormMap formMap);

   List<E> getJoinGrouponInfo(FormMap formMap);

   List<E> getMyGroupon(FormMap formMap);
   List<E> getShopAllGroupon(FormMap formMap);

   E inProcessGrouponExt(FormMap formMap);

   E getGrouponOrderById(FormMap formMap);

   E productSpecCheck(FormMap formMap);

   E getProductInfoByGOrderId(FormMap formMap);

   E getUserGrouponInfoByGOrderId(FormMap formMap);

   E selectStartGrouponMsgInfo(FormMap formMap);

   E selectMrsWuByJoinOrderNum(FormMap formMap);

   E selectAuthorizerAppIdByUserId(FormMap formMap);

   E getMchKeyByGrouponOrderNo(String formMap);

   int isJoinGrouponByOrderId(FormMap formMap);

   int hasGrouponCount(FormMap formMap);

   void startGroupon(FormMap formMap);

   int insertGrouponOrder(FormMap formMap);

   int joinGroupon(FormMap formMap);

   void updateGrouponOrderByOrderNum(FormMap formMap);

   void updateAllGrouponOrderById(FormMap formMap);
}
