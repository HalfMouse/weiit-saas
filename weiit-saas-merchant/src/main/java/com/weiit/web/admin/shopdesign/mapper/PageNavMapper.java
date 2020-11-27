package com.weiit.web.admin.shopdesign.mapper;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * 商品横幅活动接口类
 * Title: productBannerMapper.java
 * Description:
 * Company: 微云时代
 * @author lichengmeng
 * @date 2016年6月6日
 */
public interface PageNavMapper extends BaseMapper {

   public int editState(FormMap formmap);

   public List<E> selectItemList(FormMap formmap);

   public int insertItem(FormMap formmap);

   public int removeItem(FormMap formmap);

   public List<E> selectButtonList(FormMap formmap);

   public List<E> navIconList(FormMap formmap);

   public void saveNav(Map param);

   public void delNav(FormMap formmap);

   public List<E> navInfo(FormMap formmap);

   public List<E> navOptionalUrl(FormMap formmap);

   public int insertButton(FormMap formmap);

   public int removeButton(FormMap formmap);

}
