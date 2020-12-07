package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.ArticleMapper;
import com.weiit.web.admin.init.service.ArticleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-07-12.
 */
@Service
public class ArticleServiceImpl extends AbstractService implements ArticleService {

    @Resource
    private ArticleMapper articleMapper;

    @Override
    public BaseMapper setMapper() {
        return articleMapper;
    }

    @Override
    public List<E> selectSortList(FormMap formMap) {
        return articleMapper.selectSortList(formMap);
    }

    @Override
    public E selectArticleInfo(FormMap formMap) {
        return articleMapper.selectArticleInfo(formMap);
    }
}
