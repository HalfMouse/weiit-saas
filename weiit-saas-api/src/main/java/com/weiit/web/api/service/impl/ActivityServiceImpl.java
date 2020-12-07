package com.weiit.web.api.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.api.mapper.ActivityMapper;
import com.weiit.web.api.service.ActivityService;
import com.weiit.web.api.service.OrderService;
import com.weiit.web.api.service.ProductService;
import com.weiit.web.util.DateUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


/**
 * 订单接口实现类
 * @author：半个鼠标
 * @date：2018年3月14日
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class ActivityServiceImpl extends AbstractService implements ActivityService {
	
	@Resource
	private ActivityMapper activityMapper;

	@Resource
	OrderService orderService;

	@Resource
	ProductService productService;
	
	@Override
	public BaseMapper setMapper() {
		return activityMapper;
	}

	@Override
	public List<E> couponList(FormMap formMap) {
		List<E> couponList =  activityMapper.couponList(formMap);
		
		List<E> list = new ArrayList<E>();

		
		for (E coupon : couponList) {
			E result = new E();
			result.put("coupon_name", coupon.getStr("coupon_name"));
			//判断优惠券是金额券、打折券、金额券（固定）
			if(coupon.getInt("type")==1){//金额券（固定）
				result.put("coupon_price", coupon.getStr("coupon_price"));
			}else if(coupon.getInt("type")==2){//打折券
				result.put("coupon_price", coupon.getStr("coupon_discount"));
			}else{//金额券（随机）
				result.put("coupon_price", coupon.getStr("random_min_price")+"-"+coupon.getStr("random_max_price"));
			}
			//判断优惠券限制条件内容
			if(coupon.getInt("is_condition")==-1){
				result.put("condition", "不限制");
			}else{
				result.put("condition", "满"+coupon.getStr("condition_price"));
			}
			//判断优惠券使用时间
			if(coupon.getInt("use_type")==2){
				result.put("time", "领取后"+coupon.getStr("from_day")+"天生效,生效"+coupon.getStr("to_day")+"天");
			}else{
				result.put("time",coupon.getStr("start_time")+"-"+coupon.getStr("end_time"));
			}
			//判断优惠券适用商品 //所有商品通用
			if(coupon.getStr("product_range_type").equals("1")){
				result.put("product", "全部商品可用");
			}else{//表示部分商品适用
				result.put("product", "部分商品可用");
			}
			result.put("type", coupon.getInt("type"));
			result.put("state", coupon.getInt("state"));
			result.put("coupon_desc", coupon.getStr("coupon_desc"));
			result.put("coupon_id", coupon.getStr("coupon_id"));
			list.add(result);
			
			
		}
		
		/*后端优化优惠券的返回  ，结束*/
		return list;
	}

	/**
	 * 查询用户可用优惠券
	 * */
	@Override
	public List<E> getUserCouponListForCart(FormMap formMap) {
		//购物车列表
		List<E> cartList;
		if (formMap.get("cartList") != null) {
			cartList = (List<E>) formMap.get("cartList");
		} else {
			cartList = orderService.selectUserCartList(formMap);
		}

		//消费金额
		double payPrice = 0.0;
//		if (cartList == null) {
//			return toJsonAPI("", "创建订单失败，购物车为空", "1006");
//		}
		for (E cart : cartList) {
			payPrice = payPrice + cart.getDouble("sale_price") * cart.getInt("count");
		}


		//优惠券结果list
		List<E> resultCouponList = new ArrayList<E>();
		//查询用户已有的未使用优惠券
		List<E> couponList = productService.selectUserCouponList(formMap);
		for (E coupon : couponList) {

			E result = new E();
			result.put("coupon_name", coupon.getStr("coupon_name"));
			result.put("id", coupon.getStr("id"));

			//金额券（固定）
			if (coupon.getInt("type") == 1) {
				result.put("coupon_content", coupon.getStr("coupon_price"));
			//打折券
			} else if (coupon.getInt("type") == 2) {
				result.put("coupon_content", coupon.getStr("coupon_discount"));
			}

			result.put("type", coupon.getInt("type"));
			//优惠券使用时间

			result.put("time", coupon.getStr("startTime")+"~"+coupon.getStr("endTime"));
//			if (coupon.getInt("use_type") == 2) {
//				result.put("time", "领取后" + coupon.getStr("from_day") + "天生效,生效" + coupon.getStr("to_day") + "天");
//			} else {
//				result.put("time", coupon.getStr("start_time")+"-"+coupon.getStr("end_time"));
////				result.put("time", "2017-12-12~2018-03-31");
//			}

			//判断优惠券限制条件内容
			//是否可用
			boolean is_usable_price =true;
			if (coupon.getInt("is_condition") == -1) {
				result.put("condition", "无限制");
			} else {
				result.put("condition", "满" + coupon.getStr("condition_price"));
				//不满足消费金额
				if(coupon.getDouble("condition_price").compareTo(payPrice)>0){
					is_usable_price= false;
					result.put("reason","未满足使用门槛");
				}
			}

			//判断优惠券适用商品
			//2 表示部分商品适用
			//商品是是否 指定可用
			boolean is_usable_appoint =true;
			if (coupon.getStr("product_range_type").equals("2")) {
				result.put("product", "部分商品");
				result.put("product_ids", coupon.getStr("product_ids"));
				List<String> productIds = Arrays.asList(coupon.getStr("product_ids").split(","));
				boolean lookFlag = false;
				for (String productId:productIds){
					for (E cart : cartList) {
						if (cart.getStr("product_id").equals(productId)){
							lookFlag=true;
							break;
						}
					}
					if (lookFlag){
						break;
					}
				}
				//若购物车商品中没有优惠券指定商品
				if (!lookFlag){
					is_usable_appoint= false;
					result.put("reason","订单中无商品适用");
				}
			} else {//所有商品通用
				result.put("product", "全部商品");
			}
			result.put("state", coupon.getInt("state"));
			result.put("coupon_desc", coupon.getStr("coupon_desc"));
			result.put("coupon_id", coupon.getInt("coupon_id"));
			result.put("is_useable", is_usable_appoint&&is_usable_price);
			result.put("product_range_type", coupon.getStr("product_range_type"));
			result.put("product_ids",coupon.getStr("product_ids"));
			resultCouponList.add(result);
		}

		return resultCouponList;
	}

	@Override
	public List<E> couponListByIds(FormMap formMap) {
		return activityMapper.couponListByIds(formMap);
	}


	@Override
	public void couponGet(FormMap formMap) {
		if (formMap.getInt("use_type")==2){
			formMap.put("start_time", DateUtil.getBeginOfDay(DateUtil.addDate(5,new Date(),formMap.getInt("from_day"))));
			formMap.put("end_time", DateUtil.getEndOfDay(DateUtil.addDate(5,new Date(),formMap.getInt("from_day")+formMap.getInt("to_day"))));
			formMap.put("state",-2);
		}
		activityMapper.couponGet(formMap);

		//todo 扣除优惠券数量
	}

	@Override
	public E couponNumber(FormMap formMap) {
		return activityMapper.couponNumber(formMap);
	}

	@Override
	public E userCouponReceiveNum(FormMap formMap) {
		return activityMapper.userCouponReceiveNum(formMap);
	}



	
	
	


	
}
