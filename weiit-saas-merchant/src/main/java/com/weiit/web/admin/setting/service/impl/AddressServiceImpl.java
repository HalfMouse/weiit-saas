package com.weiit.web.admin.setting.service.impl;

import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.setting.mapper.AddressMapper;
import com.weiit.web.admin.setting.service.AddressService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2018-04-28.
 */
@Service
@Transactional(readOnly=false)
public class AddressServiceImpl extends AbstractService implements AddressService{

    @Resource
    private AddressMapper addressMapper;
    @Override
    public BaseMapper setMapper() {
        return addressMapper;
    }



    @Override
    @Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public int editType(FormMap formmap){
        FormMap map11=new FormMap();
        map11.putAll(formmap);
        map11.remove("address_id");
        if(!map11.getStr("shipping_type").isEmpty()){
            map11.put("shipping_type", "0");
            addressMapper.editType(map11);

            map11.put("shipping_type", "1");
            map11.put("address_id", formmap.get("address_id"));
            addressMapper.editType(map11);
        }else if(!map11.getStr("return_type").isEmpty()){
            map11.put("return_type", "0");
            addressMapper.editType(map11);

            map11.put("return_type", "1");
            map11.put("address_id", formmap.get("address_id"));
            addressMapper.editType(map11);
        }
        return 1;
    }
}
