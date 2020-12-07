package com.weiit.web.admin.task.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/7.
 */
public interface OrderConfirmService  extends BaseService{
 
  void processEndOrder(E order);
  List<E> selectOrderUnpaidList(FormMap formMap);
}
