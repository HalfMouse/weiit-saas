package com.weiit.web.admin.task.service.impl;

import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.task.mapper.UserCouponMapper;
import com.weiit.web.admin.task.service.UserCouponService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
@Service
public class UserCouponServiceImpl extends AbstractService implements UserCouponService {

    @Resource
    UserCouponMapper userCouponMapper;
 

    @Override
    public BaseMapper setMapper() {
        return userCouponMapper;
    }
 
}
