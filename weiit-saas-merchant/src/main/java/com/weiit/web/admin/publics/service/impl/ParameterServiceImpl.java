package com.weiit.web.admin.publics.service.impl;

 
import java.util.List; 
import javax.annotation.Resource;
 
import org.springframework.stereotype.Service; 
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService; 
import com.weiit.web.admin.publics.mapper.ParameterMapper;
import com.weiit.web.admin.publics.mapper.PublicsMapper;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.publics.service.PublicsService;

/**
 * 公共服务接口实现类
 * @author 半个鼠标
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service("parameterService")
public class ParameterServiceImpl extends AbstractService  implements ParameterService{
	
	@Resource
	private ParameterMapper parameterMapper;

	@Override
	public BaseMapper setMapper() { 
		return parameterMapper;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public int editBatch(List<FormMap> list){
		for (FormMap info : list) {
			if(info.getStr("validate_id").equals("")){
				parameterMapper.insert(info);
			}else{
				parameterMapper.edit(info);
			}
		}
        return 1;
    }

	@Override
	public E selectShopParamByName(FormMap formMap) {
		return parameterMapper.selectShopParamByName(formMap);
	}

}
