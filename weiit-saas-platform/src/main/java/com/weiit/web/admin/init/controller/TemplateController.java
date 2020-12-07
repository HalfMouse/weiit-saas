package com.weiit.web.admin.init.controller;
 
import java.util.List;

import javax.annotation.Resource; 

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo; 
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap; 
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.TemplateCateService;
import com.weiit.web.admin.init.service.TemplateService;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;
 
/**
 *  模板管理
 * @author  hzy
 * @date：2018年4月24日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/template")
public class TemplateController extends AdminController{
	
	public static Logger logger=Logger.getLogger(TemplateController.class);
	@Resource
	private TemplateService templateService;
	@Resource
	private TemplateCateService templateCateService;
	 
	
	 /**
     * 模板管理
     */
    @RequestMapping("/templateList")
    public ModelAndView templateList() {
    	logger.info("进入 TemplateController-templateList, 模板列表");
    	
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(),16);
    	List<E> list=templateService.selectList(formMap);
    	 //返回到list页面
    	ModelAndView result=UIView("/center/init/templateList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        
        List<E> cateList=templateCateService.selectList(formMap);
    	result.addObject("cateList", cateList);

    	result.addObject("queryParam", formMap);
    	return result;
    }
    
    /**
     * 模板创建
     */
    @RequestMapping("/templateCreate")
    public ModelAndView templateCreate() {
    	logger.info("进入 TemplateController-shopCreate,模板创建");
    	
    	ModelAndView result=UIView("/center/init/templateCreate",false);
    	
    	FormMap formMap=getFormMap();
    	
    	List<E> cateList=templateCateService.selectList(formMap);
    	result.addObject("cateList", cateList);
    	result.addObject("tltle", "模板创建");
    	if(!StringUtils.isEmpty(formMap.get("validate_id"))){
	    	//如果是编辑跳转过来的，查询站点信息
	    	E template=templateService.selectOne(formMap);
	    	result.addObject("template", template);
	    	result.addObject("tltle", "模板编辑");
    	}
    	return result;
    }
    
    /**
     * 模板 提交
     */
    @RequestMapping("/templateCreateSave")
    public UIview templateCreateSave() throws Exception{
    	logger.info("进入 TemplateController-templateCreateSave,模板-提交"); 
    	UIview result=UIView("templateList", true); 
    	FormMap formMap=getFormMap(); 
    	try {
	        // 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();   
	        MultipartFile mFile = multipartRequest.getFile("file1");  
	        if( !mFile.isEmpty()){
		        String pictureName=WeiitUtil.uploadFile(mFile);
		        formMap.put("template_img", pictureName);
	        }  

	    	if(StringUtils.isEmpty(formMap.get("validate_id"))){//创建新增站点
	    		templateService.insert(formMap);
	    	}else{
	    		templateService.edit(formMap);
	    	}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦..."+e.getMessage());
		}
    	result.addPNotifyMessage("模板保存成功！");
    	return result;
    }
	
    /**
     * 模板删除 
     */
    @RequestMapping("/templateRemove")
    public UIview templateRemove() throws Exception{
    	UIview result=UIView("templateList",true);
    	logger.info("进入TemplateController-remove,模板删除");
    	try { 
    		FormMap formMap=getFormMap(); 
    		templateService.remove(formMap);
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦..."+e.getMessage());
		}
		result.addPNotifyMessage("模板删除成功！");
        return result;
    }
 
    
    /**
     *  状态 保存 
     */
    @RequestMapping("/templateState")
    public UIview templateState() throws Exception{
    	UIview result=UIView("templateList",true);
    	logger.info("进入TemplateController-templateState,模板状态修改"); 
    	try { 
	        FormMap formMap=getFormMap();  
	        templateService.editState(formMap);
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦..."+e.getMessage());
		}
		result.addPNotifyMessage("模板状态修改成功！");
        return result;
    }
}