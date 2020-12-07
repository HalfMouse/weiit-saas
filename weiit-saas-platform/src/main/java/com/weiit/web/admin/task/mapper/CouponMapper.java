package com.weiit.web.admin.task.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/9.
 */
public interface CouponMapper extends BaseMapper {
    List<E> selectCouponList(FormMap formMap);

    void updateCouponState(FormMap formMap);
}
