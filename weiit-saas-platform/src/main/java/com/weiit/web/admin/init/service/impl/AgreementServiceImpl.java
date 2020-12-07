package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.AgreementMapper;
import com.weiit.web.admin.init.service.AgreementService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.List;

/**
 *服务协议相关业务
 * @author 唐
 *  @date：2017年6月30日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */

@Service
@Transactional(readOnly=false)
public class AgreementServiceImpl extends AbstractService implements AgreementService {

    @Resource
    private AgreementMapper agreementMapper;

    @Override
    public BaseMapper setMapper() {
        return agreementMapper;
    }

    public List<E> selectAgreementList(FormMap formMap){
        return agreementMapper.selectAgreementList(formMap);
    }
}
