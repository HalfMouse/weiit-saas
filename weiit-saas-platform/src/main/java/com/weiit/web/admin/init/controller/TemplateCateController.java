package com.weiit.web.admin.init.controller;
   
import java.util.List; 

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.init.service.TemplateCateService;
import com.weiit.web.common.AdminController;

/**
 * 模板分类
 * @author hzy 
 * @date 2017年7月7日
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/templateCate")
public class TemplateCateController extends AdminController {
	
	public static Logger logger=Logger.getLogger(TemplateCateController.class);
	
	@Resource
	private TemplateCateService templateCateService;
 
    /**
     * 模板分类查询 
     */
    @RequestMapping("/list")
    public UIview list() {
    	logger.info("进入TemplateCateController-list,模板分类列表"); 
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=templateCateService.selectList(formMap);
    	
    	UIview result = UIView("/center/init/templateCateList",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap); 
    	return result;
    }
 
    /**
     *  新增 
     */
	@RequestMapping("/add")
	public String add() throws Exception { 
		return "/center/init/templateCateEdit";
	}
	
    /**
     * 编辑 
     */
	@RequestMapping("/edit")
	public UIview edit() throws Exception {
		UIview result=UIView("/center/init/templateCateEdit",false);
		try {
			FormMap formMap=getFormMap(); 
			E infoMap=templateCateService.selectOne(formMap);
	    	result.addObject("infoMap", infoMap); 
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
    	logger.info("进入TemplateCateController-save,模板分类保存"); 
    	try { 
	        FormMap formMap=getFormMap();  
			if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){
				formMap.set("parent_id", -1);
				templateCateService.insert(formMap);
			}else{
				templateCateService.edit(formMap);
			}    
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦..."+e.getMessage());
		}
		result.addPNotifyMessage("模板分类保存成功！");
        return result;
    }
    
    /**
     * 删除 
     */
    @RequestMapping("/remove")
    public UIview remove() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入TemplateCateController-remove,模板分类删除");
    	try { 
    		FormMap formMap=getFormMap(); 
            templateCateService.remove(formMap);//删除此分类      
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦..."+e.getMessage());
		}
		result.addPNotifyMessage("模板分类删除成功！");
        return result;
    }
     
}