package com.weiit.web.admin.init.controller;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.ProductCateService;
import com.weiit.web.common.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * 商品分类
 * @author hzy 
 * @date 2017年7月7日
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/productCate")
public class ProductCateController extends AdminController {
	
	public static Logger logger=Logger.getLogger(ProductCateController.class);
	
	@Resource
	private ProductCateService productCateService;
 
    /**
     * 商品分类  》》 分类视图查询 
     */
    @RequestMapping("/list")
    public ModelAndView list() {
    	logger.info("进入ProductCateController-list,商品分类视图");
    	
    	FormMap formMap=getFormMap();
        ModelAndView result = UIView("/center/init/productCate",false);
		List<E> productMyCateList = productCateService.selectList(formMap);
		result.addObject("productMyCateList", productMyCateList);
        result.addObject("queryParam", formMap);
        return result;
    }
    
    /**
     * 商品分类  》》 分类编辑 数据查询展示
     */
    @ResponseBody
    @RequestMapping("/view")
    public String view() {
    	logger.info("【异步】进入ProductCateController-view,商品分类编辑数据加载");
    	
    	FormMap formMap=getFormMap();
    	E e=productCateService.selectOne(formMap);
    	
    	logger.info("【异步返回json】:"+toJsonAPI(e));
        return toJsonAPI(e);
    }
    
    
    /**
     * 商品分类  》》 分类新增，编辑保存 
     */
    @RequestMapping("/save")
    public UIview save() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入ProductCateController-save,商品分类保存");
    	try {
	    	// 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();   
	        
	        FormMap formMap=getFormMap(); 
	        // 获得文件：   
	        MultipartFile smallFile = multipartRequest.getFile("smallFile");  
	        if( !smallFile.isEmpty()){
	        	//图片上传云存储
		        String pictureName=WeiitUtil.uploadFile(smallFile);
		        formMap.put("cate_icon_img", pictureName);
	        } 
	    	String parent_id = (String) formMap.get("parent_id");
			if(null != parent_id && !"".equals(parent_id) && null != parent_id && !"".equals(parent_id))
			{
				formMap.put("parent_id", parent_id);
			}
			if(formMap.get("validate_id")==null || formMap.get("validate_id").equals("")){
				productCateService.insert(formMap);
			}else{
				productCateService.edit(formMap);
			}    
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		result.addPNotifyMessage("商品分类保存成功！");
        return result;
    }
    
    /**
     * 商品分类  》》 分类删除 
     */
    @RequestMapping("/remove")
    public UIview remove() throws Exception{
    	UIview result=UIView("list",true);
    	logger.info("进入ProductCateController-remove,商品分类删除");
    	try {
	    	FormMap formMap=getFormMap(); 
	        productCateService.remove(formMap);//删除此分类         
    	} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
        result.addPNotifyMessage("商品分类删除成功！");
        return result;
    }
}