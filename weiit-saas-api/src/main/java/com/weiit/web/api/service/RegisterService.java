package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;

/**
 * Created by 罗鸿强 on 2018/8/15.
 */
public interface RegisterService {

    E selectMerchantByAccount(FormMap formMap);

    void insetMerch(FormMap formMap);

    /**
     * 查询公司运营部的通知电话号码
     * @param formMap
     * @return
     */
    E selectNotifyPhoneByBusinessType(FormMap formMap);
}
