package com.weiit.web.admin.login.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * 
 * @author 半个鼠标
 * @date：2017-8-20 下午6:50:47
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface LoginMapper extends BaseMapper {
	
	
	E  selectShopByManagerId(FormMap formMap);
    /**
     * 根据管理员ID查询开发者
     * @return
     */
    E  selectDeveloperManagerByManagerId(FormMap formMap);
    
    E selectShopInfo(FormMap formMap);
    
    /**
     * 新增业务，查询管理员余额记录
     * @param formMap
     * @return
     */
    List<E> selectSystemManagerBalanceList(FormMap formMap);
    
    /**
     * 查询管理员最后余额
     * @param formMap
     * @return
     */
    E selectSystemManagerLastBalance(FormMap formMap);
    
    /**
     * 平台端根据validate_id查询余额
     * @param formMap
     * @return
     */
    E selectSystemManagerLastBalanceByValidateId(FormMap formMap);
    
    /**
     * 管理员预存余额
     * @param formMap
     */
    void insertManagerBalance(FormMap formMap);
}
