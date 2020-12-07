package com.weiit.web.admin.init.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by Administrator on 2018-07-07.
 */
public interface ArticleCateService extends BaseService{

    List<E> selectCateList(FormMap formMap);

    E selectSort(FormMap formMap);

    void editSort(FormMap formMap);

}
