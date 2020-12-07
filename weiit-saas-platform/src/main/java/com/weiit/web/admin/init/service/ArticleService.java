package com.weiit.web.admin.init.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by Administrator on 2018-07-12.
 */
public interface ArticleService extends BaseService{

   List<E> selectSortList(FormMap formMap);

   E selectArticleInfo(FormMap formMap);
}
