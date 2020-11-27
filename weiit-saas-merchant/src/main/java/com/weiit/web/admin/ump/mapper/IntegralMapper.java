package com.weiit.web.admin.ump.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2018-09-19.
 */
public interface IntegralMapper extends BaseMapper {

    List<E> selectProductList(FormMap formMap);

    void updateIntegralProductState(FormMap formMap);

    List<E> selectOrderList(FormMap formMap);

    E selectOrderDetail(FormMap formMap);
}
