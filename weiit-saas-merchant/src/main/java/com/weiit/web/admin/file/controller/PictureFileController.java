package com.weiit.web.admin.file.controller;
 
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.weiit.web.admin.util.DesUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;


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
	
	private String page_source = "/center/files/source";



//	@RequestMapping("/url")
//	public void test(HttpServletRequest request, HttpServletResponse response) throws Exception {
//
//		System.out.println(request.getPathTranslated());
//		System.out.println(request.getPathInfo());
//		System.out.println(request.getRequestURI());
//		System.out.println(request.getRequestURL());//http://smokeman.55555.io:15235/center/file/picture/url
//		System.out.println(request.getRemoteHost());
//		URL urls=new URL(request.getRequestURL().toString());
//		String shop_domain=urls.getHost();
//		String shop_domain_prex=shop_domain.split("\\.")[0];
//		System.out.printf(shop_domain_prex);
//	}
//
//	public static void main(String[] args) throws MalformedURLException {
////		System.out.println(request.getRequestURL());
//		String url ="http://smokeman.55555.io:15235/center/file/picture/url";
////		String shop_domain_prex=url.split("\\.")[0].replace("http://","").replace("https://","");
//
//
//
//
//
//
//		URL urls=new URL(url);
//		String shop_domain=urls.getHost();
//		String shop_domain_prex=shop_domain.split("\\.")[0];
//		System.out.printf(shop_domain_prex);
//
//	}


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
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=pictureService.selectList(formMap);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
        
        //查询当前目录
        formMap.set("id", formMap.getStr("parent_id"));
        E mulu=pictureService.selectOne(formMap);
        result.addObject("mulu", mulu);
		return result;
	}
	
	/**
	 *  图片空间 》创建文件夹 
	 */
	@RequestMapping("/saveFloder")
	public ModelAndView saveFloder() throws Exception {
		logger.info("进入PictureFileController-saveFloder,创建文件夹");
		
		FormMap formMap=getFormMap(true); 
		try {
			if(formMap.getStr("id")==null || formMap.getStr("id").equals("")){ 
				formMap.put("type", "1");
				formMap.put("business_type", "0");
				pictureService.insert(formMap);
			}else{ 
				formMap.put("business_type", "0");
				pictureService.edit(formMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		UIview result=UIView("list?parent_id="+formMap.getStr("parent_id"), true);
		result.addPNotifyMessage("文件夹创建成功.");
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
	        //查询id所对应的business_type
	        formMap.set("id", formMap.getStr("parent_id"));
	        E mulu=pictureService.selectOne(formMap);
	        // 获得文件：   
	        List<MultipartFile> files = multipartRequest.getFiles("files");  
	        for (MultipartFile file : files) {
	        	if(!file.isEmpty()){
	 		        String pictureName=WeiitUtil.uploadFile(file);
	 		        formMap.put("file_name", file.getOriginalFilename());
	 		        formMap.put("file_url", pictureName);
	 		        formMap.put("type", "0");//上传图片类型
	 		        formMap.put("business_type", mulu.getStr("business_type"));
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
	/**
	 *  图片空间》资源加载
	 */
	@RequestMapping("/source")
	public ModelAndView source() throws Exception { 
		logger.info("进入PictureFileController-source,资源加载");
		
		UIview result = UIView(page_source,false);
    	FormMap formMap=getFormMap(true);
    	if(StringUtils.isBlank(formMap.getStr("parent_id"))){
    		formMap.put("parent_id", "-1");
    	}
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=pictureService.selectList(formMap);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
        
        //查询当前目录
        formMap.set("id", formMap.getStr("parent_id"));
        E mulu=pictureService.selectOne(formMap);
        result.addObject("mulu", mulu);
		return result;
	}


	/**
	 *
	 * 装修页面，查看图片空间
	 * @author hzy
	 * @date 2017年7月7日
	 *
	 * business_type=2, page=1, rows=18
	 * */

	@RequestMapping(value = "/pictureSpace",method = RequestMethod.GET)
	@ResponseBody
	public E pictureSpace(@RequestParam String token,Integer page,Integer rows,Integer business_type,String file_name) {
		logger.info("PictureFileController-pictureSpace,查看图片空间");
		FormMap formMap=new FormMap();
		E result = new E();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			result.put("pictureSpace",null);
			return result;
		}

		if (!StringUtils.isEmpty(file_name)){
			formMap.put("file_name", "%"+file_name+"%");
		}
		formMap.put("page",page);
		formMap.put("rows", rows);
		PageHelper.startPage(formMap.getPage(),formMap.getRows());
		formMap.put("business_type",business_type);
		List<E> list = pictureService.getFileForPage(formMap);
		result.put("pictureSpace",new PageInfo<E>(list));
		return result;
	}


	@RequestMapping(value = "/videoList")
	@ResponseBody
	public E videoList(@RequestParam String token,Integer page,Integer rows,Integer file_type){
		FormMap formMap=new FormMap();
		E result = new E();
		try {
			formMap.put("shop_id", DesUtil.decrypt(token));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("token 解密失败");
			result.put("pictureSpace",null);
			return result;
		}
		formMap.put("page",page);
		formMap.put("rows", rows);
		formMap.put("type", file_type);
		PageHelper.startPage(formMap.getPage(),formMap.getRows());
		List<E> list = pictureService.getVideoList(formMap);
		result.put("pictureSpace",new PageInfo<E>(list));
		return result;

	}


	/**
	 * 上传物流logo
	 *
	 * */
	@ResponseBody
	@RequestMapping(value = "/uploadLogo",method = RequestMethod.POST)
	public String uploadLogo() {
		logger.info("【异步】接口调用创建计划,PlatformController-uploadLogo");
		FormMap formMap = getFormMap();
		List<E> imgList = new ArrayList<E>();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
			System.out.println(fileMap);
			if (fileMap != null && !fileMap.isEmpty()) {
				for (Iterator iterator = fileMap.keySet().iterator(); iterator.hasNext(); ) {
					String key = iterator.next().toString();
					MultipartFile mFile = fileMap.get(key);
					if (!mFile.isEmpty()) {
						String img_url = WeiitUtil.uploadFile(mFile);

						formMap.put("express_url", img_url);

						//	插入数据库
						pictureService.insertExpress(formMap);


					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return toJsonAPI(imgList);

	}
}
