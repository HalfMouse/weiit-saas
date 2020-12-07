package com.weiit.web.admin.init.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2018-07-03.
 */
public interface notifyMapper extends BaseMapper{

    List<E> selectType(FormMap formMap);
}
