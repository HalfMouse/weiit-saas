package com.weiit.web.admin.login.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.login.mapper.LoginMapper;
import com.weiit.web.admin.login.service.LoginService;

/**
 * 
 * @author 半个鼠标
 * @date：2017-8-20 下午6:46:40
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
public class LoginServiceImpl extends AbstractService implements LoginService {

	@Resource
	private LoginMapper loginMapper;
	
	@Override
	public BaseMapper setMapper() {
		return loginMapper;
	}

	@Override
	public E selectShopByMrchId(FormMap formMap) {
		return loginMapper.selectShopByMrchId(formMap);
	}

	@Override
	public List<E> selectOrderTimeList(FormMap formMap) {
		return loginMapper.selectOrderTimeList(formMap);
	}

	@Override
	public E selectOrderTimeConfigByName(FormMap formMap) {
		return loginMapper.selectOrderTimeConfigByName(formMap);
	}

	@Override
	public List<E> selectVersionList(FormMap formMap) {
		return loginMapper.selectVersionList(formMap);
	}

	@Override
	public E selectVersionOne(FormMap formMap) {
		return loginMapper.selectVersionOne(formMap);
	}

	/**
	 * //1、修改商户的系统版本，并设置版本开始时间与有效期//2、短信通知其已缴费的结果//3、、记录其缴费记录//4、通知公司运营中心注意此事
	 */
	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public int payFinishVersionTrans(FormMap payOrderInfo) {
		//1、修改商户的系统版本，并设置版本开始时间与有效期
		loginMapper.editMerchantVersion(payOrderInfo);
		
    	//2、短信通知其已缴费的结果
		String [] msg={payOrderInfo.getStr("product_name"),payOrderInfo.getStr("expire_time")};
		WeiitUtil.sendMobileMessage(payOrderInfo.getStr("account"), "147649", msg);
    	//3、、记录其缴费记录
		payOrderInfo.set("order_num", payOrderInfo.getStr("out_trade_no"));
		payOrderInfo.set("state", 1);//已生效
		loginMapper.insertMerchantService(payOrderInfo);
    	//4、通知公司运营中心注意此事
		FormMap param=new FormMap();
		param.set("business_type", "3");//商户自主充值，查询运营中心手机，方便发送通知给他们
		E notifyPhone=loginMapper.selectNotifyPhoneByBusinessType(param);
		
		String [] notifyMsg={"商户"+payOrderInfo.getStr("account")+"已自主开通系统订购服务,系统版本:"+payOrderInfo.getStr("product_name")+",服务到期时间:"+payOrderInfo.getStr("expire_time")};
		WeiitUtil.sendMobileMessage(notifyPhone.getStr("notify_phone"), "147671", notifyMsg);//147671为自定义模板，模板内容[运营中心请注意：请相关工作人员跟进业务“{1}”，回T退订]
		return 0;
	}

	/**
	 * 营销服务购买完成,1判断是否已有该服务，如果没有新增，如果有了，则修改到期时间.2短信通知商户已缴费成功的结果。3、通知公司运营中心组注意此事。
	 */
	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public int payFinishServiceTrans(FormMap payOrderInfo) {
		
		//1、、记录其缴费记录
		payOrderInfo.set("order_num", payOrderInfo.getStr("out_trade_no"));
		payOrderInfo.set("state", 1);//已生效
		loginMapper.insertMerchantService(payOrderInfo);
		
    	//2、短信通知其已缴费的结果
		String [] msg={payOrderInfo.getStr("product_name")};
		WeiitUtil.sendMobileMessage(payOrderInfo.getStr("account"), "147662", msg);
    	
    	//3、通知公司运营中心注意此事
		FormMap param=new FormMap();
		param.set("business_type", "4");//商户自主充值，查询运营中心手机，方便发送通知给他们
		E notifyPhone=loginMapper.selectNotifyPhoneByBusinessType(param);
		
		String [] notifyMsg={"商户"+payOrderInfo.getStr("account")+"已自主开通系统订购服务,系统版本:"+payOrderInfo.getStr("product_name")+",服务到期时间:"+payOrderInfo.getStr("expire_time")};
		WeiitUtil.sendMobileMessage(notifyPhone.getStr("notify_phone"), "147671", notifyMsg);//147671为自定义模板，模板内容[运营中心请注意：请相关工作人员跟进业务“{1}”，回T退订]
		return 0;
	}
	
	@Override
	public E selectByMrchId(FormMap formMap) {
		return loginMapper.selectByMrchId(formMap);
	}

	@Override
	public E selectOldPwdById(FormMap formMap) {
		return loginMapper.selectOldPwdById(formMap);
	}

	@Override
	public List<E> selectMerchantAllServiceNumsList(FormMap formMap) {
		return loginMapper.selectMerchantAllServiceNumsList(formMap);
	}

	@Override
	public E selectServiceByServiceNum(FormMap formMap) {
		return loginMapper.selectServiceByServiceNum(formMap);
	}

	@Override
	public E selectMerchantServiceByServiceNum(FormMap formmap) {
		return loginMapper.selectMerchantServiceByServiceNum(formmap);
	}
	
	

}
