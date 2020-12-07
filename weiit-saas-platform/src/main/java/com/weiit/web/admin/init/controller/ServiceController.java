package com.weiit.web.admin.init.controller;
   
import java.util.List; 

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.ServiceService;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;

/**
 * 收费服务项目
 * @author hzy 
 * @date 2017年7月7日
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/service")
public class ServiceController extends AdminController {
	
	public static Logger logger=Logger.getLogger(ServiceController.class);
	
	@Resource
	private ServiceService serviceService;
 
    /**
     * 收费服务项目 查询 
     */
    @RequestMapping("/list")
    public ModelAndView list() {
    	logger.info("进入ProductTagController-list,收费服务项目列表"); 
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=serviceService.selectList(formMap);
    	
    	UIview result = UIView("/center/init/serviceList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap); 
    	return result;
    }
 
    /**
     *  新增 
     */
	@RequestMapping("/add")
	public UIview add() throws Exception { 
		UIview result=UIView("/center/init/serviceEdit",false);
		//查询版本配置集合
    	List<E> versionList=serviceService.selectVersionList(null);
    	result.addObject("versionList", versionList); 
		return result;
	}
	
    /**
     * 编辑 
     */
	@RequestMapping("/edit")
	public UIview edit() throws Exception {
		UIview result=UIView("/center/init/serviceEdit",false);
		try {
			FormMap formMap=getFormMap(); 
			E infoMap=serviceService.selectOne(formMap);
	    	result.addObject("infoMap", infoMap); 
	    	
	    	//查询版本配置集合
	    	List<E> versionList=serviceService.selectVersionList(null);
	    	result.addObject("versionList", versionList); 
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return result;
	}
	
    /**
     *  新增，编辑保存 
     */
    @RequestMapping("/save")
    public UIview save() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入ProductTagController-save,收费服务项目保存"); 
    	try { 
    		// 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartHttpRequest = (MultipartHttpServletRequest)this.getRequest();
            //获得文件
            MultipartFile mFile=multipartHttpRequest.getFile("file_service_icon");
            MultipartFile mFile2=multipartHttpRequest.getFile("file_service_logo");
            FormMap formMap = getFormMap();
            if(!mFile.isEmpty()) {
                String pictureName=WeiitUtil.uploadFile(mFile);
                formMap.put("service_icon",pictureName);
            }
            if(!mFile2.isEmpty()) {
                String pictureName=WeiitUtil.uploadFile(mFile2);
                formMap.put("service_logo",pictureName);
            }
            
			if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){
				serviceService.insert(formMap);
			}else{
				serviceService.edit(formMap);
			}    
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("收费服务项目保存成功！");
        return result;
    }
    
    /**
     *  状态 保存 
     */
    @RequestMapping("/state")
    public UIview state() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入ProductTagController-save,收费服务项目状态修改"); 
    	try { 
	        FormMap formMap=getFormMap();  
			serviceService.edit(formMap);
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("服务项目状态保存成功！");
        return result;
    }
    
    @RequestMapping("/editSortNum")
    public UIview editSortNum() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入ProductTagController-editSortNum,收费服务项目置顶"); 
    	try { 
	        FormMap formMap=getFormMap();
	        E info=serviceService.selectMaxSortNum(formMap);
	        if(info!=null){
	        	formMap.set("sort_num", info.getInt("sort_num")+1);
	        	serviceService.edit(formMap);
	        }
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
        return result;
    }
    
    /**
     * 删除 
     */
    @RequestMapping("/remove")
    public UIview remove() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入ProductTagController-remove,收费服务项目删除");
    	try { 
    		FormMap formMap=getFormMap(); 
            serviceService.remove(formMap);//删除此分类      
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("收费服务项目删除成功！");
        return result;
    }
    
	/***********************************************订购时长配置************************************************************************/
	/**
	 * 配置订购时长查询
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping("/orderTimeConfig")
	 public UIview orderTimeConfig() throws Exception{
	    UIview result=UIView("/center/init/orderTimeConfig",false);
	    
	    FormMap formMap = new FormMap();
	    //查询7天套餐
	    formMap.set("order_time_name", "7_day");
	    E day7=serviceService.selectOrderTimeConfigByName(formMap);
	    //查询1个月套餐
	    formMap.clear();
	    formMap.set("order_time_name", "1_month");
	    E month1=serviceService.selectOrderTimeConfigByName(formMap);
	    //查询6个月套餐
	    formMap.clear();
	    formMap.set("order_time_name", "6_month");
	    E month6=serviceService.selectOrderTimeConfigByName(formMap);
	    //查询12个月套餐
	    formMap.clear();
	    formMap.set("order_time_name", "12_month");
	    E month12=serviceService.selectOrderTimeConfigByName(formMap);
	    //查询24个月套餐
	    formMap.clear();
	    formMap.set("order_time_name", "24_month");
	    E month24=serviceService.selectOrderTimeConfigByName(formMap);
	    //查询36个月套餐
	    formMap.clear();
	    formMap.set("order_time_name", "36_month");
	    E month36=serviceService.selectOrderTimeConfigByName(formMap);
	    
	    result.addObject("day7", day7);
	    result.addObject("month1", month1);
	    result.addObject("month6", month6);
	    result.addObject("month12", month12);
	    result.addObject("month24", month24);
	    result.addObject("month36", month36);
	    return result;
	 }
	 
	 /**
	  * 配置订购时长更新
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping("/orderTimeConfigEdit")
	 public UIview packageConfigEdit() throws Exception{
	    UIview result=UIView("orderTimeConfig",true);
	    
	    FormMap formMap = getFormMap();
	    
	    FormMap param = new FormMap();
	    
	    //更新7天套餐
	    param.set("order_time_discount", formMap.getStr("7_day_order_time_discount"));
	    param.set("state", formMap.getStr("7_day_order_time_state"));
	    param.set("order_time_name", "7_day");
	    serviceService.editOrderTimeConfig(param);
	    
	    //更新1个月套餐
	    param.clear();
	    param.set("order_time_discount", formMap.getStr("1_month_order_time_discount"));
	    param.set("state", formMap.getStr("1_month_order_time_state"));
	    param.set("order_time_name", "1_month");
	    serviceService.editOrderTimeConfig(param);
	    
	    //更新6个月套餐
	    param.clear();
	    param.set("order_time_discount", formMap.getStr("6_month_order_time_discount"));
	    param.set("state", formMap.getStr("6_month_order_time_state"));
	    param.set("order_time_name", "6_month");
	    serviceService.editOrderTimeConfig(param);
	     
	    //更新12个月套餐
	    param.clear();
	    param.set("order_time_discount", formMap.getStr("12_month_order_time_discount"));
	    param.set("state", formMap.getStr("12_month_order_time_state"));
	    param.set("order_time_name", "12_month");
	    serviceService.editOrderTimeConfig(param);
	    
	    //更新24个月套餐
	    param.clear();
	    param.set("order_time_discount", formMap.getStr("24_month_order_time_discount"));
	    param.set("state", formMap.getStr("24_month_order_time_state"));
	    param.set("order_time_name", "24_month");
	    serviceService.editOrderTimeConfig(param);
	    
	    //更新36个月套餐
	    param.clear();
	    param.set("order_time_discount", formMap.getStr("36_month_order_time_discount"));
	    param.set("state", formMap.getStr("36_month_order_time_state"));
	    param.set("order_time_name", "36_month");
	    serviceService.editOrderTimeConfig(param);
	    
	    return result;
	 }
	 
	/******************************************** 版本配置 **************************/

	/**
	 * 版本配置查询列表
	 */
	@RequestMapping("/versionList")
	public ModelAndView versionList() {
		logger.info("进入ProductTagController-versionList,版本配置查询列表");
		FormMap formMap = getFormMap();
		// 开启分页
		PageHelper.startPage(formMap.getPage(), formMap.getRows());
		List<E> list = serviceService.selectVersionList(formMap);

		UIview result = UIView("/center/init/versionList", false);
		result.addObject("pageInfo", new PageInfo<E>(list));
		
		//查询所有的服务列表
		List<E> serviceList=serviceService.selectList(null);
		result.addObject("serviceList", serviceList);
		// 绑定上一次参数
		result.addObject("queryParam", formMap);
		return result;
	}

	/**
	 * 新增版本配置
	 */
	@RequestMapping("/versionAdd")
	public String versionAdd() throws Exception {
		return "/center/init/versionEdit";
	}

	/**
	 * 编辑版本配置
	 */
	@RequestMapping("/editVersion")
	public UIview editVersion() throws Exception {
		UIview result = UIView("/center/init/versionEdit", false);
		try {
			FormMap formMap = getFormMap();
			E infoMap = serviceService.selectVersionOne(formMap);
			result.addObject("infoMap", infoMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 版本新增，编辑保存
	 */
	@RequestMapping("/versionSave")
	public UIview versionSave() throws Exception {
		UIview result = UIView("versionList", true);
		logger.info("进入ProductTagController-versionSave");
		try {
			// 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartHttpRequest = (MultipartHttpServletRequest)this.getRequest();
            //获得文件
            MultipartFile mFile=multipartHttpRequest.getFile("file_version_logo");
            FormMap formMap = getFormMap();
            if(!mFile.isEmpty()) {
                String pictureName=WeiitUtil.uploadFile(mFile);
                formMap.put("version_logo",pictureName);
            }
            
			if (formMap.get("validate_id") == null
					|| formMap.get("validate_id").equals("")) {
				serviceService.insertVersion(formMap);
			} else {
				serviceService.editVersion(formMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("版本配置保存成功！");
		return result;
	}
	
	@RequestMapping("/addVersionService")
	public UIview addVersionService() throws Exception {
		UIview result = UIView("versionList", true);
		logger.info("进入ProductTagController-addVersionService");
		try {
			FormMap formMap = getFormMap();
			serviceService.insertVersionServiceTrans(formMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return result;
	}

	/**
	 * 状态 保存
	 */
	@RequestMapping("/versionState")
	public UIview versionState() throws Exception {
		UIview result = UIView("versionList", true);
		logger.info("进入ProductTagController-versionState,版本配置状态修改");
		try {
			FormMap formMap = getFormMap();
			serviceService.editVersion(formMap);;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("版本配置状态保存成功！");
		return result;
	}

	/**
	 * 检查版本配置是否存在
	 */
	@ResponseBody
	@RequestMapping("/selectVersionNumCheck")
	public String selectVersionNumCheck() throws Exception {
		logger.info("进入 ServiceController-selectVersionNumCheck,检查版本配置是否存在");
		try {
			FormMap formMap = getFormMap();
			E info = serviceService.selectVersionOne(formMap);
			if (info != null && !info.getStr("service_id").equals("")) {
				return toJsonAPI("", "该版本编号已存在，请使用其他编号", "-1");
			} else {
				return toJsonAPI("true");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return toJsonAPI("", "操作异常：" + e.getMessage(), "-1");
		}
	}

}