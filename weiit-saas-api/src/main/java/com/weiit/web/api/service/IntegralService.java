package com.weiit.web.api.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/9/19.
 */
public interface IntegralService  extends BaseService{


    String selectIntegralProductList(FormMap formMap);


    String updateUserPhoneInfo(FormMap formMap);

    String shareSuccess(FormMap formMap);


    String selectIntegralLogList(FormMap formMap);


    String integralProductDetail(FormMap formMap);

    String integralOrderList(FormMap formMap);


    String integralOrder(FormMap formMap);

    String integralPay(FormMap formMap);

    void notifyPay(HttpServletRequest request, HttpServletResponse response);

    E selectShopParamByCode(FormMap formMap);

    List<E> selectShopParamList(FormMap formMap);
}
