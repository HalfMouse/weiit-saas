package com.weiit.web.admin.init.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 *服务协议相关业务
 * @author 唐
 *  @date：2017年6月30日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface AgreementService extends BaseService {

    /**
     * 查询所有协议
     * @param formMap
     * @return
     */
    List<E> selectAgreementList(FormMap formMap);
}
