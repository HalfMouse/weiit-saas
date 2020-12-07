package com.weiit.web.admin.init.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2018-07-07.
 */
public interface ArticleCateMapper extends BaseMapper{

    List<E> selectCateList(FormMap formMap);

    E selectSort(FormMap formMap);

    void editSort(FormMap formMap);
}
