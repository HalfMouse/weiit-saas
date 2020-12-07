package com.weiit.web.admin.init.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 *服务协议相关业务
 * @author 唐
 *  @date：2017年6月30日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface WeixinMediaImageService extends BaseService {

    /**
     * 置顶
     * @param formMap
     * @return
     */
    E selectSort(FormMap formMap);


    /**
     * 图片分类查询
     * @param formMap
     * @return
     */
    List<E> selectImageCateList(FormMap formMap);


    /**
     * 图片查询
     * @param formMap
     * @return
     */
    List<E> selectImageList(FormMap formMap);

   void insertImage(FormMap formMap);

}
