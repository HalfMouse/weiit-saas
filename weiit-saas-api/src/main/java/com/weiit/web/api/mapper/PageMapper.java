package com.weiit.web.api.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/4/27.
 */
public interface PageMapper extends BaseMapper {
    List<E>selectPageBottomMenuByShopId(FormMap formMap);

    List<E>selectNavInfoByShopId(FormMap formMap);

    E selectGlobalStyle(FormMap formMap);


}
