package com.weiit.web.admin.setting.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by Administrator on 2018-04-27.
 */
public interface SettingService extends BaseService{

	E selectShopInfoByDomainPrex(FormMap formMap);
	
    E selectCertificationOne(FormMap formMap);

    void insertCertification(FormMap formMap);
    
    void updateCertification(FormMap formMap);
    
    List<E> selectShopPaymentList(FormMap formmap);

    int editShopPayment(FormMap formmap);

    int insertShopPayment(FormMap formmap);

    void editShopPaymentState(FormMap formMap);

    FormMap getQrCodeUrl(FormMap formMap);

    void editShopSomeInfo(FormMap formMap);
}
