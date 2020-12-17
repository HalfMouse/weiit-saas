package com.weiit.web.admin.init.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.InitService;
import com.weiit.web.admin.init.service.ServiceService;
import com.weiit.web.admin.init.service.ShopService;
import com.weiit.web.admin.login.service.LoginService;
import com.weiit.web.common.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * 商户管理 
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/shop")
public class ShopController extends AdminController{ 
	public static Logger logger=Logger.getLogger(ShopController.class); 
	
	@Resource
	private ShopService shopService; 
	
	@Resource
	private ServiceService serviceService;
	
	@Resource
	private LoginService loginService;
	@Resource
	private InitService initService;
	
    /**
     * 商户列表  查询 
     */
    @RequestMapping("/shopList")
    public ModelAndView shopList() {
    	logger.info("进入ShopController-shopList,收费服务项目列表"); 
    	FormMap formMap=getFormMap();
    	//开启分页
    	List<E> businessList=initService.selectList(formMap);
    	
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=shopService.selectList(formMap);
    	
    	UIview result = UIView("/center/shop/shopList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap); 
        result.addObject("businessList", businessList); 
    	return result;
    }
 
    /**
     *  新增 
     */
	@RequestMapping("/shopMerchantAdd")
	public String shopMerchantAdd() throws Exception { 
		this.getRequest().setAttribute("title", "商户账号创建");
		
		List<E> versionList=serviceService.selectVersionList(null);
		this.getRequest().setAttribute("versionList", versionList); 
        
		List<E> orderTimeList=serviceService.selectOrderTimeList(null);
		this.getRequest().setAttribute("orderTimeList", orderTimeList);
		return "/center/shop/shopMerchantAdd";
	}
	
    /**
     *  创建商户，很重要.现在的原则是，商户创建后必须有一个系统版本，版本约定的是后台与前端能不能访问进来。但是针对某一个服务，即可以是版本本身包含了该服务，也可以是今后自己购买的。weiit_init_version_service约定的是哪个版本拥有哪些服务功能，后面可以调整，如果用户没有购买过服务，今后他
     *  所拥有的系统版本本身 拥有该服务，他也就有该服务，如果他自身购买了版本，结果后面系统版本调整了包含关系，并不会直接影响。因为知道一个商户是否有哪些服务，应该先查询weiit_init_version_service中的版本拥有哪些服务+他自身购买了哪些服务，然后去重。
     */
    @RequestMapping("/shopMerchantSave")
    public UIview shopMerchantSave() throws Exception{
    	UIview result=UIView("shopList",true);
    	logger.info("进入ShopController-shopMerchantSave,商户账号创建提交"); 
    	FormMap formMap=getFormMap();
    	
    	//查询手机是否已经注册
    	E merchantInfo=shopService.selectMerchantByAccount(formMap);

    	if(merchantInfo==null){
    		//判断订购时长与系统版本的价格，对比渠道商自己的余额是否足够。
    		E versionInfo=serviceService.selectVersionOne(formMap);
    		
    		String [] order_times=formMap.getStr("order_time").split("-");
    		formMap.set("order_time_name", order_times[1]);
    		E orderTimeInfo=serviceService.selectOrderTimeConfigByName(formMap);
    		
    		double total=0.00;
    		if(versionInfo!=null&&orderTimeInfo!=null){
    			total=(versionInfo.getDouble("sale_price")*orderTimeInfo.getInt("day")/366)*orderTimeInfo.getDouble("order_time_discount")/10;//按照供应价x(每个订购时长对应的天数数/366)
    			
    			//查询最后余额
    			E balanceInfo=loginService.selectSystemManagerLastBalance(formMap);
     		    if(balanceInfo!=null){
     		    	if(balanceInfo.getDouble("last_balance")>total){
     		    		
     		    		shopService.insertMerchantTrans(formMap, orderTimeInfo, versionInfo, balanceInfo, total);
     		    		//刷新最后余额
	     		   	    double last_balance=0.00;
	     		   	    balanceInfo=loginService.selectSystemManagerLastBalance(formMap);
	     		   	    if(balanceInfo!=null){
	     		   	    	last_balance=balanceInfo.getDouble("last_balance");
	     		   	    }
	     		   	    getSession().setAttribute("last_balance", last_balance);
	     		   	    
     		    		result.addPNotifyMessage("商户账号创建成功！");
     		            return result;
     		    	}else{
     		    		result=UIView("shopMerchantAdd",true);
     		    		result.addErrorMessage("余额不足,请充值.");
     		    		return result;
     		    	}
     		    }else{
     		    	result=UIView("shopMerchantAdd",true);
 		    		result.addErrorMessage("余额不足,请充值.");
 		    		return result;
     		    }
    		}else{
    			result=UIView("shopMerchantAdd",true);
        		result.addErrorMessage("系统有异常，请联系客服人员");
        		return result;
    		}
    		
    		
    	}else{
    		result=UIView("shopMerchantAdd",true);
    		result.addErrorMessage("该手机号码已经是商户了，不能重复注册");
    		return result;
    	}
    	
	
    }
    
    /**
     *  状态 保存 
     */
    @RequestMapping("/shopState")
    public UIview shopState() throws Exception{
    	UIview result=UIView("shopList",true);
    	logger.info("进入ShopController-save,商户账号状态修改"); 
    	try { 
	        FormMap formMap=getFormMap();  
			shopService.editMerchantLocked(formMap);
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("商户账号状态保存成功！");
        return result;
    }
    
    /**
     * 商户 认证信息页面
     */
    @RequestMapping("/shopCreate")
    public UIview shopCreate() {
    	logger.info("进入 ShopController-shopCreate,认证信息查询");
    	UIview result=UIView("/center/shop/shopCreate",false);
    	FormMap formMap = getFormMap();
    	if(!formMap.getStr("shop_id").equals("")){
    		E info = shopService.selectOne(formMap); 
    		result.addObject("infoMap", info); 
    	}
		result.addObject("queryParam", formMap);
    	return result;
    }
    
    /**
     * 店铺设置，认证信息保存
     */
    @RequestMapping("/shopCreateSave")
    public UIview shopCreateSave()  throws Exception {
    	logger.info("进入 SettingController-shopCertificationSave,认证信息保存");  
    	
    	UIview result=UIView("shopList",true); 
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
	        if(formMap.get("shop_id")==null || formMap.get("shop_id").equals("")){
	        	shopService.insertCert(formMap);
			}else{
				shopService.editCert(formMap);
			}
			
       	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		} 
    	return result;
    }
    
    /**
     * 店铺设置，认证信息保存
     */
    @RequestMapping("/shopCertificationUpdate")
    public UIview shopCertificationUpdate()  throws Exception {
    	logger.info("进入 SettingController-shopCertificationUpdate,认证信息修改");  
    	
    	UIview result=UIView("shopList",true); 
    	FormMap formMap=getFormMap(); 
    	shopService.editShopCertificationState(formMap);
    	return result;
    }
   
    
    /**
     * 用户意见反馈查询  
     */
    @RequestMapping("/suggestList")
    public UIview suggestList() {
    	logger.info("进入 UserController-suggestList,会员列表");
    	
    	UIview view=UIView("/center/shop/suggestList",false);
    	FormMap formMap = getFormMap();
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> userList = shopService.selectSuggestList(formMap);
		
		view.addObject("pageInfo", new PageInfo<E>(userList));
		view.addObject("queryParam", formMap);
    	return view;
    }
    
    /**
     * 用户意见反馈删除 
     */
    @RequestMapping("/suggestRemove")
    public UIview suggestRemove() throws Exception{
    	UIview result=UIView("suggestList",true);
    	logger.info("进入UserController-suggestRemove,反馈删除");
    	try { 
    		FormMap formMap=getFormMap(); 
    		shopService.removeSuggest(formMap);
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("用户反馈删除成功！");
        return result;
    }
}