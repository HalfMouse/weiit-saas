package com.weiit.web.admin.shopdesign.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/4/27.
 */
public interface PageMapper extends BaseMapper {
    public List<E> selectTargetList(FormMap formmap);

    public E selectTargetOne(FormMap formmap);

    public int insertTarget(FormMap formmap);

    public int editTarget(FormMap formmap);

    public int removeTarget(FormMap formmap);

    public void pageDefault(FormMap formmap);

    public void clearDefault(FormMap formmap);

    public int pageView(E param);

    List<E> selectTemplateCate(FormMap formMap);

    List<E> selectTemplatePage(FormMap formMap);

    List<E> selectNavInfoByShopId(FormMap formMap);

    E getTemplatePageJson(Integer templateId);

}
