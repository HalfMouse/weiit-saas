package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.ArticleCateMapper;
import com.weiit.web.admin.init.service.ArticleCateService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-07-07.
 */
@Service
public class ArticleCateServiceImpl extends AbstractService implements ArticleCateService {
    @Resource
    private ArticleCateMapper articleCateMapper;

    @Override
    public BaseMapper setMapper() {
        return articleCateMapper;
    }

    public List<E> selectCateList(FormMap formMap){
        return articleCateMapper.selectCateList(formMap);
    }

    @Override
    public E selectSort(FormMap formMap) {
        return articleCateMapper.selectSort(formMap);
    }

    @Override
    public void editSort(FormMap formMap) {
        articleCateMapper.editSort(formMap);
    }
}
