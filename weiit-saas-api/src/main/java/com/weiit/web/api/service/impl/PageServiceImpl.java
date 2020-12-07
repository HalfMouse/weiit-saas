package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.PageMapper;
import com.weiit.web.api.service.PageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 订单接口实现类
 * @author：lhq
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class PageServiceImpl extends AbstractService implements PageService {


    @Resource
    PageMapper pageMapper;

    @Override
    public BaseMapper setMapper() {
        return pageMapper;
    }

    @Override
    public List<E> selectPageBottomMenuByShopId(FormMap formMap) {
        return pageMapper.selectPageBottomMenuByShopId(formMap);
    }

    @Override
    public List<E> selectNavInfoByShopId(FormMap formMap) {
        return pageMapper.selectNavInfoByShopId(formMap);
    }

    @Override
    public E selectGlobalStyle(FormMap formMap) {
        return pageMapper.selectGlobalStyle(formMap);
    }
}
