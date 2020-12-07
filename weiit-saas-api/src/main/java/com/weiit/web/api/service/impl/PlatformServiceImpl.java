package com.weiit.web.api.service.impl;


import com.github.binarywang.wxpay.bean.order.WxPayMpOrderResult;
import com.github.binarywang.wxpay.bean.request.WxPayUnifiedOrderRequest;
import com.github.binarywang.wxpay.exception.WxPayException;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.api.mapper.PlatformMapper;
import com.weiit.web.api.service.PlatformService;
import com.weiit.web.api.service.UserService;
import com.weiit.web.common.RedisKey;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional(readOnly=false)//需要事务操作必须加入此注解
public class PlatformServiceImpl extends AbstractService implements PlatformService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private PlatformMapper platformMapper;

	@Resource
	RedisUtil redisUtil;

	@Resource
	WeixinOpenService weixinOpenService;

	@Resource
	UserService userService;
	
	@Override
	public BaseMapper setMapper() {
		return platformMapper;
	}

	@Override
	public boolean sendMobileMsg(FormMap formMap) {
		
		//int code=RandomUtils.nextInt(1000000);
		int code=123456;
		//发送短信内容
		String [] msg={code+"","5分钟"};
		
		//把手机号与验证码放入缓存中
		redisUtil.set(RedisKey.USERACCOUNT+formMap.getStr("user_account"),code,60*5);
		boolean sendState= WeiitUtil.sendMobileMessage(formMap.getStr("user_account"), "119614", msg);
		
		this.logger.info("短信验证码:{}",code);
		return sendState;
	}
	
	@Override
	public E login(FormMap formMap) {
		return platformMapper.login(formMap);
	}

	@Override
	public E weixinLogin(FormMap formMap) {
		return platformMapper.weixinLogin(formMap);
	}
	
	@Override
	public void register(FormMap formMap) {
		platformMapper.register(formMap);
	}

	@Override
	public E selectShopInfoByShopDomainPrex(FormMap formMap) {
		return platformMapper.selectShopInfoByShopDomainPrex(formMap);
	}

	@Override
	public E selectWeixinPublicInfoByShopId(FormMap formMap) {
		return platformMapper.selectWeixinPublicInfoByShopId(formMap);
	}

	@Override
	public E selectWeixinPublicInfoByAppId(FormMap formMap) {
		return platformMapper.selectWeixinPublicInfoByAppId(formMap);
	}

	@Override
	public E getPayInfoByOpenId(FormMap formMap) {

		return platformMapper.getPayInfoByOpenId(formMap);
	}


	@Override
	public int insertExpress(FormMap formMap) {

		WeiitUtil.getFileDomain();
		return platformMapper.insertExpress(formMap);
	}

	@Override
	public List<E> getArea(FormMap formMap) {
		return platformMapper.getArea(formMap);
	}

	@Override
	public E selectBlogInfoById(FormMap formMap) {
		return platformMapper.selectBlogInfoById(formMap);
	}


	@Override
	public E selectShopTemplateMsg(FormMap formMap) {
		return platformMapper.selectShopTemplateMsg(formMap);
	}

	@Override
	public E selectShopInfoById(FormMap formMap) {
		return platformMapper.selectShopInfoById(formMap);
	}

	@Override
	public E selectUserAndAuthInfoByUserId(FormMap formMap) {
		return platformMapper.selectUserAndAuthInfoByUserId(formMap);
	}

	@Override
	public E selectShopIntroPage(FormMap formMap) {
		return platformMapper.selectShopIntroPage(formMap);
	}

	@Override
	public void saveIntroPage(FormMap formMap) {
		platformMapper.saveIntroPage(formMap);
	}

	@Override
	public WxPayMpOrderResult wxPay(E param) {

		WxPayUnifiedOrderRequest payInfo = WxPayUnifiedOrderRequest.newBuilder()
				.openid(param.getStr("wx_open_id"))
				.outTradeNo(param.getStr("out_trade_no"))
				.totalFee(param.getInt("total_fee"))
				.body(param.getStr("body"))
				.tradeType(param.getStr("trade_type"))
				.spbillCreateIp(param.getStr("spbill_create_ip"))
				.notifyUrl(param.getStr("notifyUrl"))
				.build();
		try {
			WxPayMpOrderResult orderResult = weixinOpenService.getLocalInstancePay(param).createOrder(payInfo);
			return orderResult;
		} catch (WxPayException e) {
			e.printStackTrace();
			logger.error("微信支付异常  异常单号为{},open_id {}",param.getStr("out_trade_no"),param.getStr("wx_open_id"));
			return null;
		}
	}




}
