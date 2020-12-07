package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.BargainMapper;
import com.weiit.web.api.service.BargainService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


/**
 * 砍价接口实现类
 * @author：tangjian
 * @date：2018年5月8日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service
public class BargainServiceImpl extends AbstractService implements BargainService {

    @Resource
    private BargainMapper bargainMapper;

    @Override
    public BaseMapper setMapper() {
        return bargainMapper;
    }

    @Override
    public List<E> selectBargainList(FormMap formMap) {

        return bargainMapper.selectBargainList(formMap);
    }
    @Override
    public List<E> getProductByBargainIds(FormMap formMap) {

        return bargainMapper.getProductByBargainIds(formMap);
    }


    @Override
    public int insertBargainLog(FormMap formMap) {

        return bargainMapper.insertBargainLog(formMap);
    }

    @Override
    public int insertBargainOrder(FormMap formMap) {

        return bargainMapper.insertBargainOrder(formMap);
    }


    @Override
    public E selectUserBargainLog(FormMap formMap) {

        return bargainMapper.selectUserBargainLog(formMap);
    }


    @Override
    public E selectBargainInfo(FormMap formMap) {

        return bargainMapper.selectBargainInfo(formMap);
    }


    @Override
    public E getBargainSumPrice(FormMap formMap) {

        return bargainMapper.getBargainSumPrice(formMap);
    }

    @Override
    public List<E> SelectBargainLogList(FormMap formMap) {

        return bargainMapper.SelectBargainLogList(formMap);
    }

    @Override
    public List<E> SelectUserBargain(FormMap formMap) {

        return bargainMapper.SelectUserBargain(formMap);
    }

    @Override
    public List<E> bargainMessage(FormMap formMap) {

        return bargainMapper.bargainMessage(formMap);
    }


    @Override
    public E hasBargainCount(FormMap formMap) {

        return bargainMapper.hasBargainCount(formMap);
    }
    @Override
    public int hasBargainByLogId(FormMap formMap) {

        return bargainMapper.hasBargainByLogId(formMap);
    }




    @Override
    public E selectLastBargain(FormMap formMap) {

        return bargainMapper.selectLastBargain(formMap);
    }


    @Override
    public E selectBargainLogOne(FormMap formMap) {

        return bargainMapper.selectBargainLogOne(formMap);
    }


    @Override
    public E getBargainOrderById(FormMap formMap) {

        return bargainMapper.getBargainOrderById(formMap);
    }


    @Override
    public void updateBargainOrderById(FormMap formMap) {
        bargainMapper.updateBargainOrderById(formMap);
    }

    @Override
    public E getMchKeyBybargainOrderNo(String orderNo) {
        return bargainMapper.getMchKeyBybargainOrderNo(orderNo);
    }

    @Override
    public E selectOpenIdbyBOrderId(String orderNo) {
        return bargainMapper.selectOpenIdbyBOrderId(orderNo);
    }
}
