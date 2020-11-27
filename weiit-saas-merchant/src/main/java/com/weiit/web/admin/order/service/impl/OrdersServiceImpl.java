package com.weiit.web.admin.order.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.order.mapper.OrdersMapper;
import com.weiit.web.admin.order.service.OrdersService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 订单管理接口实现类
 * @author zhouliang
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class OrdersServiceImpl extends AbstractService implements OrdersService{
	
	@Resource
	private OrdersMapper ordersMapper;

	@Override
	public BaseMapper setMapper() {
		return ordersMapper;
	}
	
	@Override
	public E queryAddressById(FormMap map) {
		return ordersMapper.queryAddressById(map);
	}

	@Override
	public List<E> queryOrdersDetail(FormMap map) {
		return ordersMapper.queryOrdersDetail(map);
	}

	@Override
	public E queryOrderCount(FormMap map){
		return ordersMapper.queryOrderCount(map);
	}

	@Override
	public E queryOrderPayCount(FormMap map){
		return ordersMapper.queryOrderPayCount(map);
	}

	@Override
	public E queryUserLogsCount(FormMap map){
		return ordersMapper.queryUserLogsCount(map);
	}

	@Override
	public  List<E>  queryMonthOrders(FormMap map){
		return ordersMapper.queryMonthOrders(map);
	}
    
	@Override
	public int updateStatus(FormMap formMap) {
		return ordersMapper.updateStatus(formMap);
	}
	
	/**
	 * 查询所有订单，以及每个订单下的订单详情记录信息
	 */
	@Override
	public List<E> selectList(FormMap map){
	 List<E> ordersList = ordersMapper.selectList(map);
	    if(!ordersList.isEmpty() && ordersList.size()>0){
			for (int i = 0; i < ordersList.size(); i++) {
				E orderMap=(E)ordersList.get(i);
				map.put("order_id", Integer.valueOf( orderMap.get("order_id").toString() ) );
				List<E> ordersDetailList = ordersMapper.queryOrdersDetail(map);
				orderMap.put("ordersDetailList", ordersDetailList);
			}
		}
		return ordersList;
	}
	
	/**
	 * 修改商品库存，1、先查询商品详情。2修改商品详情的库存。3修改商品总库存
	 */
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED,rollbackFor=Exception.class)
	public void updateStockTrans(FormMap formMap) {
	   //根据orderid查询detail的数据
       List<E> list= ordersMapper.selectOrderDetailByOrderId(formMap);
       //遍历List集合
        for (int i = 0; i < list.size(); i++) {
			E ordermap=list.get(i);
			int product_id=ordermap.getInt("product_id");
			int item_id=ordermap.getInt("item_id");
			formMap.set("product_id", product_id);
			formMap.set("item_id", item_id);
			formMap.set("count", ordermap.getInt("count"));
			   //修改商品item表库存
			ordersMapper.updateProductItemStockByItemId(formMap);
			ordersMapper.updateProductStockByProductId(formMap);
		}
        // 修改订单状态
        ordersMapper.updateStatus(formMap);
				
	}
	
	/**
     * 评论查询
     * @return
     */
	@Override
	public List<E> selectOrderEvaluateList(FormMap formMap){
		return ordersMapper.selectOrderEvaluateList(formMap);
	}
	
	/**
     * 修改评论
     * @return
     */
	@Override
	public int editOrderEvaluate(FormMap formMap){
		return ordersMapper.editOrderEvaluate(formMap);
	}

	public E selectOrderDashBoard(FormMap formMap){
		return ordersMapper.selectOrderDashBoard(formMap);
	}
	
	/**
     * 订单发货，退货审核模板消息发送数据查询
     * @return
     */
	@Override
	public E selectOrderTimplateOne(FormMap formMap){
		return ordersMapper.selectOrderTimplateOne(formMap);
	}
}
