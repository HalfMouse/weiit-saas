package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.ProductGroupMapper;
import com.weiit.web.api.service.ProductGroupService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/5/9.
 */
@Service
@Transactional(readOnly = false)
public class ProductGroupServiceImpl extends AbstractService implements ProductGroupService {
    @Resource
    ProductGroupMapper productGroupMapper;

    @Override
    public BaseMapper setMapper() {
        return productGroupMapper;
    }



    @Override
    public List<E> getProductByGroupId(FormMap param) {
        return productGroupMapper.getProductByGroupId(param);
    }
}
