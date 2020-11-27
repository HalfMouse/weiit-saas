package com.weiit.web.admin.setting.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2018-04-27.
 */
public interface SettingMapper extends BaseMapper{

	E selectShopInfoByDomainPrex(FormMap formMap);
	
    E selectCertificationOne(FormMap formMap);

    void insertCertification(FormMap formMap);
    
    void updateCertification(FormMap formMap);
    
    List<E> selectShopPaymentList(FormMap formmap);

    int editShopPayment(FormMap formMap);

    int insertShopPayment(FormMap formMap);
    
    void editShopPaymentState(FormMap formMap);

    void updateShopInfo(FormMap formMap);

    void editShopSomeInfo(FormMap formMap);
}
