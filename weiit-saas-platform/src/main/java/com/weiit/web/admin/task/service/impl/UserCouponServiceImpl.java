package com.weiit.web.admin.task.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.task.core.log.TaskLogger;
import com.weiit.web.admin.init.service.OrderService;
import com.weiit.web.admin.task.mapper.GrouponMapper;
import com.weiit.web.admin.task.mapper.UserCouponMapper;
import com.weiit.web.admin.task.service.GrouponService;
import com.weiit.web.admin.task.service.UserCouponService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

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
