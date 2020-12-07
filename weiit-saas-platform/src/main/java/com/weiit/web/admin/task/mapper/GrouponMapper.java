package com.weiit.web.admin.task.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
public interface GrouponMapper extends BaseMapper {

    List<E> selectGrouponList(FormMap formMap);

    E selectGrouponById(String formMap);

    void updateGrouponState(FormMap formMap);

    void updateGrouponOrderState(FormMap formMap);

    List<E> selectGrouponOrderList(FormMap formMap);
    E selectTemplateOne(FormMap formMap);
}
