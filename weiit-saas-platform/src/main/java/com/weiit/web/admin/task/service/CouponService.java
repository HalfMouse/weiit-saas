package com.weiit.web.admin.task.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/9.
 */
public interface CouponService extends BaseService {

    List<E> selectCouponList(FormMap formMap);

    void updateCouponState(FormMap formMap);
}
