package com.weiit.web.admin.shopdesign.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/4/27.
 */
public interface PageService extends BaseService{


    /**
     * 设置店铺主页
     * */
    void pageDefault(FormMap formMap);


    /**
     * 统计微页面的访问次数
     * @param param
     * @return
     * */
    int pageView(E param);


    /**
     * 查询微页面模板分类
     * @param formMap
     * @return
     */
    List<E> selectTemplateCate(FormMap formMap);

    /**
     * 查询微页面模板
     * @param formMap
     * @return
     */
    List<E> selectTemplatePage(FormMap formMap);

    E getTemplatePageJson(Integer templateId);
}
