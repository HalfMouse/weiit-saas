package com.weiit.web.admin.init.service.impl;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.core.utils.MD5Util;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.file.mapper.PictureMapper;
import com.weiit.web.admin.init.mapper.ShopMapper;
import com.weiit.web.admin.init.service.ShopService;
import com.weiit.web.admin.login.mapper.LoginMapper;

/**
 * 商户管理Service实现类
 * @author 半个鼠标
 * @date：2017-7-5 上午11:46:17
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Service
@Transactional(readOnly=false)
public class ShopServiceImpl extends AbstractService implements ShopService{

	@Resource
	private ShopMapper shopMapper;

	@Resource
	private LoginMapper loginMapper;
	
	@Resource
	private PictureMapper pictureMapper;
	
	@Override
	public BaseMapper setMapper() {
		return shopMapper;
	}
	
	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public int insertCert(FormMap formMap){
		Random rom=new Random();
		String num= Calendar.getInstance().getTimeInMillis()+String.valueOf(rom.nextInt(100000)*100000).substring(0,5);
		formMap.put("shop_num", num);
		
		//1新增店铺信息，weiit_shop表数据
		shopMapper.insert(formMap);
		//2新增店铺认证信息,weiit_shop_cerification
		shopMapper.insertCert(formMap);
		
		 //3、商户初始化基础数据,1、公共图片不需要初始化，现在是共享的公共图片；2、初始化一个“我的图片”给商户，方便今后管理商户自己新建的文件夹或者图片等文件。3、初始化商品相关的数据，4、初始化店铺装修的数据，5、初始化营销相关的数据
    	/*FormMap pic=new FormMap();
    	pic.set("file_name", "我的图片");
    	pic.set("file_url", "");
    	pic.set("parent_id", "-1");
    	pic.set("type", "1");//文件夹
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);//新增我的图片根目录
    	
    	String parent_id=pic.getStr("id");
    	
    	pic.set("file_name", "Banner图片");
    	pic.set("file_url", "");
    	pic.set("parent_id",parent_id);
    	pic.set("type", "1");//文件夹
    	pic.set("business_type", "1");//表示banner
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);//新增banner图片目录
    	
    	pic.set("file_name", "图标图片");
    	pic.set("file_url", "");
    	pic.set("parent_id",parent_id);
    	pic.set("type", "1");//文件夹
    	pic.set("business_type", "2");//表示图标
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);
    	
    	pic.set("file_name", "会员卡图片");
    	pic.set("file_url", "");
    	pic.set("parent_id",parent_id);
    	pic.set("type", "1");//文件夹
    	pic.set("business_type", "3");//表示会员卡
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);
    	
    	pic.set("file_name", "微信图片");
    	pic.set("file_url", "");
    	pic.set("parent_id",parent_id);
    	pic.set("type", "1");//文件夹
    	pic.set("business_type", "5");//表示微信相关图片
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);
    	
    	pic.set("file_name", "商品图片");
    	pic.set("file_url", "");
    	pic.set("parent_id",parent_id);
    	pic.set("type", "1");//文件夹
    	pic.set("business_type", "6");//表示商品图片
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);
    	
    	pic.set("file_name", "背景图片");
    	pic.set("file_url", "");
    	pic.set("parent_id",parent_id);
    	pic.set("type", "1");//文件夹
    	pic.set("business_type", "4");//表示背景图
    	pic.set("shop_id", formMap.getStr("shop_id"));
    	pictureMapper.insert(pic);*/
    	return 1;
	}
	
	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor=Exception.class)//事务可写，记住方法中不能捕获异常，捕获异常不会回滚事务，trycatch也不能用
	public int editCert(FormMap formMap){
		shopMapper.edit(formMap);
		return shopMapper.editCert(formMap);
	}

	@Override
	public E selectMerchantOne(FormMap formMap){
		return shopMapper.selectMerchantOne(formMap);
	}
	
	
	@Override
	public int editMerchantLocked(FormMap formMap){
		return shopMapper.editMerchantLocked(formMap);
	}
	
	@Override
	public void editShopCertificationState(FormMap formMap) {
		shopMapper.editShopCertificationState(formMap); 
	}

	@Override
	public E selectMerchantByAccount(FormMap formMap) {
		return shopMapper.selectMerchantByAccount(formMap);
	}

	@Override
	public int insertMerchantTrans(FormMap formMap,E orderTimeInfo,E versionInfo,E balanceInfo,double total) {
		//1、通过订购时长转成有效时间
 		formMap.set("day", orderTimeInfo.getInt("day"));//在数据库中计算
 		formMap.set("type", "0");//渠道系统开通的
 		formMap.set("password", MD5Util.MD5Encode("123456", "utf-8"));//渠道初始的密码都为123456
 		//创建商户信息。
 		shopMapper.insertMerchant(formMap);
	   		
	   	//2、短信通知商户已经注册成功，密码发送到商户手机去.
 		int code=123456;
 		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
 		Calendar c = Calendar.getInstance();
 		c.add(Calendar.DAY_OF_MONTH, orderTimeInfo.getInt("day"));
 		
	   	String [] msg={code+"",versionInfo.getStr("version_name"),sf.format(c.getTime())};
	   	WeiitUtil.sendMobileMessage(formMap.getStr("account"), "146806", msg);
	   		
 		//3、给渠道商新增消费记录
		FormMap param=new FormMap();
		String num="XF"+System.currentTimeMillis();
    	param.set("num", num);
    	param.set("balance", total);
    	param.set("last_balance", balanceInfo.getDouble("last_balance")-total);
    	param.set("remark", "商户开通扣费,扣费金额:"+total+"元,开通的商户账户为:"+formMap.getStr("account"));
    	param.set("type", 2);
    	param.set("state", -1);
    	param.set("validate_id", formMap.getStr("manager_id"));
    		
    	loginMapper.insertManagerBalance(param); 
    	
    	//发送短信给渠道商，通知他知情,渠道除非账户是使用手机号码注册 的才行
    	
    	//4、通知公司运营中心注意此事
    	FormMap canshu=new FormMap();
    	canshu.set("business_type", "1");//渠道开通商户通知运营中心为1
    	E notifyPhone=shopMapper.selectNotifyPhoneByBusinessType(canshu);
    			
    	String [] notifyMsg={"渠道商商户开通扣费,扣费金额:"+total+"元,开通的商户账户为:"+formMap.getStr("account")};
    	WeiitUtil.sendMobileMessage(notifyPhone.getStr("notify_phone"), "147671", notifyMsg);//147671为自定义模板，模板内容[运营中心请注意：请相关工作人员跟进业务“{1}”，回T退订]
    	return 1;
    	
	}

	@Override
	public List<E> selectSuggestList(FormMap formMap) {
		return shopMapper.selectSuggestList(formMap);
	}

	@Override
	public void removeSuggest(FormMap formMap) {
		shopMapper.removeSuggest(formMap);
	}

	@Override
	public E selectNotifyPhoneByBusinessType(FormMap formMap) {
		return shopMapper.selectNotifyPhoneByBusinessType(formMap);
	}
}

