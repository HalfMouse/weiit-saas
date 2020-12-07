package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/5/9.
 */
public interface ProductGroupService extends BaseService {



    /**
     * 查询分组下的商品
     * @param param
     * @return 分组下的商品
     * */
    List<E> getProductByGroupId(FormMap param);
}
