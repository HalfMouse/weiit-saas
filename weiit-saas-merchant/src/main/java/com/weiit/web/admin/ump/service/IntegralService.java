package com.weiit.web.admin.ump.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by Administrator on 2018-09-19.
 */
public interface IntegralService extends BaseService{


    List<E> selectProductList(FormMap formMap);

    void updateIntegralProductState(FormMap formMap);

    List<E> selectOrderList(FormMap formMap);

    E selectOrderDetail(FormMap formMap);
}
