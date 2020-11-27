package com.weiit.web.admin.setting.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.WeiitQrCodeUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.setting.mapper.SettingMapper;
import com.weiit.web.admin.setting.service.SettingService;
import com.weiit.web.common.Constants;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

import java.util.List;

/**
 * Created by Administrator on 2018-04-27.
 */
@Service
@Transactional(readOnly = false)
public class SettingServiceImpl extends AbstractService implements SettingService {

    @Resource
    private SettingMapper settingMapper;

    @Resource
    WeiitQrCodeUtil qrCodeUtil;

    @Override
    public BaseMapper setMapper() {
        return settingMapper;
    }

    @Override
    public E selectShopInfoByDomainPrex(FormMap formMap) {
        return settingMapper.selectShopInfoByDomainPrex(formMap);
    }

    @Override
    public E selectCertificationOne(FormMap formMap) {
        return settingMapper.selectCertificationOne(formMap);
    }

    @Override
    public void insertCertification(FormMap formMap) {
        settingMapper.insertCertification(formMap);
    }

    @Override
    public void updateCertification(FormMap formMap) {
        settingMapper.updateCertification(formMap);
    }

    @Override
    public List<E> selectShopPaymentList(FormMap formmap) {
        return settingMapper.selectShopPaymentList(formmap);
    }

    @Override
    public int editShopPayment(FormMap formmap) {
        return settingMapper.editShopPayment(formmap);
    }

    @Override
    public int insertShopPayment(FormMap formmap) {
        return settingMapper.insertShopPayment(formmap);
    }

    @Override
    public void editShopPaymentState(FormMap formMap) {
        settingMapper.editShopPaymentState(formMap);
    }

    @Override
    public FormMap getQrCodeUrl(FormMap formMap) {

        String qrCodeUrl = qrCodeUtil.createQRCodeAndUploadQcloud(String.format(Constants.SHOP_URL_FORMAT,formMap.getStr("shop_domain_prex")));
        formMap.put("shop_qr_code", qrCodeUrl);
        updateShopInfo(formMap);
        return formMap;
    }

    @Override
    public void editShopSomeInfo(FormMap formMap) {
        settingMapper.editShopSomeInfo(formMap);
    }

    public void updateShopInfo(FormMap formMap) {
        settingMapper.updateShopInfo(formMap);
    }

}
