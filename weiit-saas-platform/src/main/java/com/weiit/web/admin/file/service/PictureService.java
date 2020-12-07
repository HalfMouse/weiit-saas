package com.weiit.web.admin.file.service;
 
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/**
 * 图片空间接口定义
 * @author 半个鼠标
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
public interface PictureService extends BaseService{
    int uploadFile(E param);

    List<E>  getFileForPage(FormMap formMap);
}

