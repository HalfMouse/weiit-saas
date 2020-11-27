package com.weiit.web.admin.ump.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.ump.mapper.IntegralMapper;
import com.weiit.web.admin.ump.service.IntegralService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-09-19.
 */
@Service("integralService")
public class IntegralServiceImpl extends AbstractService implements IntegralService {

    @Resource
    private IntegralMapper integralMapper;

    @Override
    public BaseMapper setMapper() {
        return integralMapper;
    }


    @Override
    public List<E> selectProductList(FormMap formMap){
        return integralMapper.selectProductList(formMap);
    }

    @Override
    public void updateIntegralProductState(FormMap formMap) {

        integralMapper.updateIntegralProductState(formMap);
    }

    @Override
    public List<E> selectOrderList(FormMap formMap) {

        return integralMapper.selectOrderList(formMap);
    }

    @Override
    public E selectOrderDetail(FormMap formMap) {

        return integralMapper.selectOrderDetail(formMap);
    }

}
