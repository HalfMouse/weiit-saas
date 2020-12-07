package com.weiit.web.api.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 活动相关Mapper
 * @author：tangjian
 * @date：2018年5月8日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
public interface BargainMapper extends BaseMapper{

    List<E> selectBargainList(FormMap formMap);

    List<E> getProductByBargainIds(FormMap formMap);

    int  insertBargainLog(FormMap formMap);

    int  insertBargainOrder(FormMap formMap);

    E  hasBargainCount(FormMap formMap);

    int  hasBargainByLogId(FormMap formMap);

    E selectUserBargainLog(FormMap formMap);

    E selectBargainInfo(FormMap formMap);

    List<E> SelectBargainLogList(FormMap formMap);

    E getBargainSumPrice(FormMap formMap);

    List<E> SelectUserBargain(FormMap formMap);

    List<E> bargainMessage(FormMap formMap);

    E selectLastBargain(FormMap formMap);

    E selectBargainLogOne(FormMap formMap);

    E getBargainOrderById(FormMap formMap);

    E getMchKeyBybargainOrderNo(String orderNO);

    E selectOpenIdbyBOrderId(String b_order_id);

    void updateBargainOrderById(FormMap formMap);

}
