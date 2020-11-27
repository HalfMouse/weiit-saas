package com.weiit.web.admin.setting.controller;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.admin.setting.service.SettingService;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;

import java.util.List;

/**
 * Created by Administrator on 2018-04-27.
 */
@Controller
@RequestMapping(value = "/setting")
public class SettingController extends AdminController{

    public static Logger logger = Logger.getLogger(SettingController.class);



    @Resource
    private PublicsService publicsService;

    @Resource
    private SettingService settingService;


    /**
     * 店铺设置，店铺信息页面
     */
    @RequestMapping("/shopInfo")
    public UIview shopInfo() {
        logger.info("进入 SettingController-shopInfo,店铺信息");
        
        UIview result=UIView("/center/setting/shopInfo",false);
        FormMap formMap = getFormMap();
        E shopInfo = settingService.selectOne(formMap);
        formMap.set("parent_id", "-1");
        List<E> provinces=publicsService.selectRegionList(formMap);
        formMap.set("parent_id", shopInfo.getInt("province_id"));
        List<E> citys=publicsService.selectRegionList(formMap);
        formMap.set("parent_id", shopInfo.getInt("city_id"));
        List<E> districts=publicsService.selectRegionList(formMap);
        result.addObject("queryParam", formMap);
        result.addObject("shopInfo", shopInfo);
        result.addObject("provinces", provinces);
        result.addObject("citys", citys);
        result.addObject("districts", districts);
        return result;
    }

    /**
     * 检查域名合法性
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkShopDomain")
    public String checkShopDomain() {
        logger.info("进入 SettingController-checkShopDomain,店铺域名检查");
       
        //不允许使用的域名
        String [] disable_domain={"m","www","bbs","product","open","o2o","platform","my","tejia","temai","video","partner","partners"};
    	boolean is_able=true;
    	
        FormMap formMap = getFormMap();
        if(StringUtils.isEmpty(formMap.getStr("shop_domain_prex"))){
        	 formMap.set("shop_domain_prex", formMap.getStr("fieldValue"));
        }
        if(StringUtils.isEmpty(formMap.getStr("shop_domain_prex"))){
        	Object [] info={formMap.getStr("fieldId"),false,"店铺域名不能为空"};
    		return toJson(info);
        }
        E shopInfo=settingService.selectShopInfoByDomainPrex(formMap);
        if(shopInfo==null){
        	for (int i = 0; i < disable_domain.length; i++) {
				if(formMap.getStr("shop_domain_prex").equalsIgnoreCase(disable_domain[i])){
					is_able=false;
					break;
				}
			}
        	if(is_able){
        		Object [] info={formMap.getStr("fieldId"),true,""};
        		return toJson(info);
        	}else{
        		Object [] info={formMap.getStr("fieldId"),false,"店铺域名存在关键字，不允许使用"};
        		return toJson(info);
        	}
        }else{
        	if(!shopInfo.getStr("shop_id").equals(formMap.getStr("shop_id"))){
        		Object [] info={formMap.getStr("fieldId"),false,"该店铺域名已被注册，换其他试试"};
        		return toJson(info);
        	}else{
            	for (int i = 0; i < disable_domain.length; i++) {
    				if(shopInfo.getStr("shop_domain_prex").equalsIgnoreCase(disable_domain[i])){
    					is_able=false;
    					break;
    				}
    			}
            	if(is_able){
            		Object [] info={formMap.getStr("fieldId"),true,""};
            		return toJson(info);
            	}else{
            		Object [] info={formMap.getStr("fieldId"),false,"店铺现有域名存在关键字，请更换"};
            		return toJson(info);
            	}
        		
        	}
        	
        }
    }
    /**
     * 店铺信息保存，修改
     */
    @RequestMapping("/shopInfoSave")
    public UIview shopInfoSave() throws Exception{
        logger.info("进入 SettingController-shopInfoSave,店铺信息保存");
		FormMap formMap = getFormMap();
        UIview result=UIView("shopInfo",true);
		E oldShopInfo=settingService.selectOne(formMap);
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartHttpRequest = (MultipartHttpServletRequest)this.getRequest();
            //获得文件
            MultipartFile mFile=multipartHttpRequest.getFile("file_logo");
			boolean updateQrcode =false;
			//如果logo  更换
            if(!mFile.isEmpty()) {
                String pictureName=WeiitUtil.uploadFile(mFile);
                formMap.put("shop_logo",pictureName);
                updateQrcode = true;
            }
            settingService.edit(formMap);

//            //如果域名修改
//            if (!StringUtils.equals(oldShopInfo.getStr("shop_domain_prex"),formMap.getStr("shop_domain_prex"))){
//				updateQrcode = true;
//			}
			if (updateQrcode){
				FormMap updateForMap = new FormMap();
				updateForMap.set("shop_id",formMap.get("shop_id"));
//				updateForMap.set("shop_url",String.format(SHOP_URL_FORMAT,formMap.getStr("shop_domain_prex")));
				updateForMap.set("shop_logo",formMap.getStr("shop_logo"));
				settingService.getQrCodeUrl(updateForMap);
			}

        }catch (Exception e){
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return result;
    }



    /**
     * 店铺设置，认证信息页面
     */
    @RequestMapping("/shopCertification")
    public UIview shopCertification() {
        logger.info("进入 SettingController-shopCertification,认证信息查询");
        
        UIview result=UIView("/center/setting/shopCertification",false);
        FormMap formMap = getFormMap();
        E info = settingService.selectCertificationOne(formMap);
        result.addObject("infoMap", info);
        result.addObject("queryParam", formMap);
        return result;
    }

    /**
     * 店铺设置，认证信息保存
     */
    @RequestMapping("/shopCertificationSave")
    public UIview shopCertificationSave()  throws Exception {
    	logger.info("进入 SettingController-shopCertificationSave,认证信息保存");  
    	
    	UIview result=UIView("shopCertification",true); 
    	FormMap formMap=getFormMap(); 
    	try {  
	    	// 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();   
	        // 获得文件：   
	        MultipartFile file_business_img = multipartRequest.getFile("file_business_img");  //公司营业执照
	        MultipartFile file_idcard_front_img = multipartRequest.getFile("file_idcard_front_img");//身份证正面
	        MultipartFile file_idcard_back_img = multipartRequest.getFile("file_idcard_back_img");//身份证反面
    		 
	        if( !file_business_img.isEmpty()){
		        String file_business_img_url=WeiitUtil.uploadFile(file_business_img);
		        formMap.put("business_img", file_business_img_url);
	        }
	        if( !file_idcard_front_img.isEmpty()){
		        String file_idcard_front_img_url=WeiitUtil.uploadFile(file_idcard_front_img);
		        formMap.put("idcard_front_img", file_idcard_front_img_url);
	        } 
	        if( !file_idcard_back_img.isEmpty()){
		        String file_idcard_back_img_url=WeiitUtil.uploadFile(file_idcard_back_img);
		        formMap.put("idcard_back_img", file_idcard_back_img_url);
	        } 
	        if(formMap.getInt("auth_type")==2){//表示公司认证
	        	formMap.put("name", formMap.getStr("name_company"));
	        	formMap.put("auth_no", formMap.getStr("auth_no_company"));
	        }
	        E certifiCation=settingService.selectCertificationOne(formMap);
	        if(certifiCation==null){
	        	settingService.insertCertification(formMap);  
	        }else{
	        	settingService.updateCertification(formMap);
	        }
			
       	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		} 
    	return result;
    }




    /**
     * 支付交易 页面
     */
    @RequestMapping("/payment")
    public UIview payment() {
        logger.info("进入 SettingController-payment,支付/交易");
        
        FormMap formMap = getFormMap();
        UIview result=UIView("/center/setting/payment",false);
        List<E> list=settingService.selectShopPaymentList(formMap);
        
        E ma_weixin_pay = new E();
        E mp_weixin_pay = new E();
        E balance_pay = new E();
        for (E e : list) {
			if(e.getInt("type")==0){//表示小程序微信支付
				ma_weixin_pay=e;
			}else if(e.getInt("type")==1){//表示公众号微信支付
				mp_weixin_pay=e;
			}else if(e.getInt("type")==2){//表示余额支付
				balance_pay=e;
			}
		}
        result.addObject("ma_weixin_pay", ma_weixin_pay);
        result.addObject("mp_weixin_pay", mp_weixin_pay);
        result.addObject("balance_pay", balance_pay);
        return result;
    }
 



    /**
     * 支付交易 页面
     */
    @RequestMapping("/paymentSave")
    public UIview paymentSave()  throws Exception {
        logger.info("进入 SettingController-paymentSave,支付/交易保存与更新");
        
        UIview result=UIView("payment",true);
        FormMap formMap = getFormMap();
        try {  
	    	// 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();   
	        // 获得文件：   
	        MultipartFile client_cert = multipartRequest.getFile("client_cert");  //公司营业执照
	        MultipartFile client_key = multipartRequest.getFile("client_key");//身份证正面
	        MultipartFile ca_cert = multipartRequest.getFile("ca_cert");//身份证反面
    		 
	        if( !client_cert.isEmpty()){
		        String client_cert_url=WeiitUtil.uploadFile(client_cert);
		        formMap.put("client_cert", client_cert_url);
	        }
	        if( !client_key.isEmpty()){
		        String client_key_url=WeiitUtil.uploadFile(client_key);
		        formMap.put("client_key", client_key_url);
	        } 
	        if( !ca_cert.isEmpty()){
		        String ca_cert_url=WeiitUtil.uploadFile(ca_cert);
		        formMap.put("ca_cert", ca_cert_url);
	        }
	        if(StringUtils.isEmpty(formMap.getStr("validate_id"))){//新增支付配置
	        	settingService.insertShopPayment(formMap);
			}else{//修改支付配置
				settingService.editShopPayment(formMap);
			}
			
       	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		} 
        return result;
    }

    @ResponseBody
    @RequestMapping("/paymentUpdateState")
    public String paymentUpdateState()  throws Exception {
        logger.info("进入 SettingController-paymentUpdateState,支付/交易保存");
        
        FormMap formMap = getFormMap();
        try {

        	settingService.editShopPaymentState(formMap);
			return toJsonAPI("");
       	} catch (Exception e) {

			e.printStackTrace();
			return toJsonAPI("", "更新失败，请检查配置", "1000");
		} 
    }



}




































