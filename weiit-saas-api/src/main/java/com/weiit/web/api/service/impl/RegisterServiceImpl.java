package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.RegisterMapper;
import com.weiit.web.api.service.RegisterService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 罗鸿强 on 2018/8/15.
 */
@Service
public class RegisterServiceImpl extends AbstractService implements RegisterService {
    @Resource
    RegisterMapper registerMapper;

    @Override
    public BaseMapper setMapper() {
        return registerMapper;
    }

    @Override
    public E selectMerchantByAccount(FormMap formMap) {
        return registerMapper.selectMerchantByAccount(formMap);
    }
    @Override
    public void insetMerch(FormMap formMap) {
         registerMapper.insetMerch(formMap);
    }

    @Override
    public E selectNotifyPhoneByBusinessType(FormMap formMap) {
        return registerMapper.selectNotifyPhoneByBusinessType(formMap);
    }
}
