package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.notifyMapper;
import com.weiit.web.admin.init.service.NotifyService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-07-03.
 */

@Service
@Transactional(readOnly=false)
public class NotifyServiceImpl extends AbstractService implements NotifyService{

    @Resource
    private notifyMapper notifyMapper;

    @Override
    public BaseMapper setMapper(){
        return notifyMapper;
    }

    public List<E> selectType(FormMap formMap){
        return notifyMapper.selectType(formMap);
    }

}
