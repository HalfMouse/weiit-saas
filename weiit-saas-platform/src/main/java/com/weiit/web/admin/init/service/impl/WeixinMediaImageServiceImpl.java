package com.weiit.web.admin.init.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.init.mapper.WeixinMediaImageMapper;
import com.weiit.web.admin.init.service.WeixinMediaImageService;
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
public class WeixinMediaImageServiceImpl extends AbstractService implements WeixinMediaImageService {

    @Resource
    private WeixinMediaImageMapper weixinMediaImageMapper;

    @Override
    public BaseMapper setMapper() {
        return weixinMediaImageMapper;
    }


    @Override
    public E selectSort(FormMap formMap) {
        return weixinMediaImageMapper.selectSort(formMap);
    }

    @Override
    public List<E> selectImageCateList(FormMap formMap) {
        return weixinMediaImageMapper.selectImageCateList(formMap);
    }

    @Override
    public List<E> selectImageList(FormMap formMap) {
        return weixinMediaImageMapper.selectImageList(formMap);
    }

    @Override
    public void insertImage(FormMap formMap) {
        weixinMediaImageMapper.insertImage(formMap);
    }
}
