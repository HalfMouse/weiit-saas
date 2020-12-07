package com.weiit.web.admin.init.service.impl;


import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.smallProgramMapper;
import com.weiit.web.admin.init.service.smallProgramService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 *服务协议相关业务
 * @author 唐
 *  @date：2017年6月30日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */

@Service
@Transactional(readOnly=false)
public class smallProgramServiceImpl extends AbstractService implements smallProgramService {

    @Resource
    private smallProgramMapper smallProgramMapper;

    @Override
    public BaseMapper setMapper() {
        return smallProgramMapper;
    }


}
