package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/5/8.
 */
public interface PageService extends BaseService {

    /**
     * 查询店铺的底部菜单设置
     * */
    List<E> selectPageBottomMenuByShopId(FormMap formMap);

    /**
     * 查询店铺的底部菜单设置
     * */
    List<E> selectNavInfoByShopId(FormMap formMap);

    E selectGlobalStyle(FormMap formMap);

}
