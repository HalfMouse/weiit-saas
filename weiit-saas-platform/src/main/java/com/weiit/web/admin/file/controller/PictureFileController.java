package com.weiit.web.admin.file.controller;
 
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest; 
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap; 
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.file.service.PictureService;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;


/**
 * 图片空间》图片空间
 * @author 半个鼠标
 * @date 2017年2月14日 上午2:12:48
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/file/picture")
public class PictureFileController  extends AdminController {
	
	public static Logger logger = Logger.getLogger(PictureFileController.class);
	
	@Resource
	private PictureService pictureService;
	
	private String page_picture = "/center/files/picture";

	private String page_upload = "/center/files/upload";
	






	/**
	 *  图片空间》文件展示 
	 */
	@RequestMapping("/list")
	public UIview list() throws Exception { 
		logger.info("进入PictureFileController-list,文件列表展示");
		
		UIview result = UIView(page_picture,false);
    	FormMap formMap=getFormMap(true);
    	if(StringUtils.isBlank(formMap.getStr("parent_id"))){
    		formMap.put("parent_id", "-1");
    	}
    	formMap.set("shop_id", "-1");
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=pictureService.selectList(formMap);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
		return result;
	}
	
	
	/**
	 *  图片空间》图片 删除 
	 */
	@RequestMapping("/remove")
	public ModelAndView remove() throws Exception {
		logger.info("进入PictureFileController-remove,图片 删除 ");
		
		FormMap formMap=getFormMap(true); 
		try {
			formMap.set("shop_id", "-1");
			pictureService.remove(formMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		
		UIview result=UIView("list?parent_id="+formMap.getStr("parent_id"), true);
		result.addPNotifyMessage("图片删除成功.");
		return result;
	}
	
	/**
	 *  图片空间》批量 删除 
	 */
	@RequestMapping("/removeBatch")
	public ModelAndView removeBatch() throws Exception {
		logger.info("进入PictureFileController-removeBatch,图片批量删除 ");
		
		FormMap formMap=getFormMap(true); 
		try {
			String[] validate_id=(String[])this.getRequest().getParameterValues("validate_id");
			String validate_ids=StringUtils.join(validate_id,",");
			formMap.set("validate_ids", validate_ids);
			formMap.set("shop_id", "-1");
			pictureService.removeBatch(formMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		
		UIview result=UIView("list?parent_id="+formMap.getStr("parent_id"), true);
		result.addPNotifyMessage("批量删除成功。");
		return result;
	}
	/**
	 *  文件上传 页面加载
	 */
	@RequestMapping("/upload")
	public ModelAndView upload() throws Exception {
		logger.info("进入PictureFileController-upload,文件上传 页面加载 ");
		
		UIview result = UIView(page_upload,false);
		FormMap formMap=getFormMap(true);
		return result;
	}
	
	/**
	 *  文件上传执行
	 */
	@RequestMapping("/uploadExec")
	public ModelAndView uploadExec() throws Exception {
		logger.info("进入PictureFileController-uploadExec,文件上传提交");
		
		FormMap formMap=getFormMap(true); 
		try {
			// 转型为MultipartHttpRequest：   
	        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();   
	        // 获得文件：   
	        List<MultipartFile> files = multipartRequest.getFiles("files");  
	        for (MultipartFile file : files) {
	        	if(!file.isEmpty()){
	 		        String pictureName=WeiitUtil.uploadFile(file);
	 		        formMap.put("file_name", file.getOriginalFilename());
	 		        formMap.put("file_url", pictureName);
	 		        formMap.put("type", "0");//上传图片类型
	 		        formMap.set("shop_id", "-1");
	 		        pictureService.insert(formMap);
		        } 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		UIview result=UIView("list?parent_id="+formMap.getStr("parent_id"), true);
		result.addPNotifyMessage("上传图片成功。");
		return result;
	}
	

	
}
