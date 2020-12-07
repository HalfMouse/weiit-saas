

package com.weiit.web.admin.init.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

public interface WeixinMediaImageMapper extends BaseMapper {

    E selectSort(FormMap formMap);

    List<E> selectImageCateList(FormMap formMap);

    List<E> selectImageList(FormMap formMap);

    void insertImage(FormMap formMap);
}