package com.weiit.web.admin.init.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by Administrator on 2018-07-03.
 */
public interface NotifyService extends BaseService {

    List<E> selectType(FormMap formMap);
}
