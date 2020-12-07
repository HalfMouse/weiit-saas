package com.weiit.web.admin.task.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.task.mapper.CouponMapper;
import com.weiit.web.admin.task.service.CouponService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/9.
 */
@Service
public class CouponServiceImpl extends AbstractService implements CouponService{
    @Resource
    CouponMapper couponMapper;

    @Override
    public BaseMapper setMapper() {
        return couponMapper;
    }

    @Override
    public List<E> selectCouponList(FormMap formMap) {
        return couponMapper.selectCouponList(formMap);
    }

    @Override
    public void updateCouponState(FormMap formMap) {
        couponMapper.updateCouponState(formMap);
    }
}
