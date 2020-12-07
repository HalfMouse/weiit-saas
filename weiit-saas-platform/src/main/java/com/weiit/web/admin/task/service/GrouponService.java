package com.weiit.web.admin.task.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
public interface GrouponService  extends BaseService{



  List<E> selectGrouponList(FormMap formMap);

  E selectGrouponById(String groupon_id);

  List<E> selectGrouponOrderList(FormMap formMap);

  void updateGrouponState(FormMap formMap);

  void updateGrouponOrderState(FormMap formMap);


  void complateOrder(E groponOrder);

  void processEndGroupon(E groupon,List<E> grouponOrderList);
  E selectTemplateOne(FormMap formMap);
}
