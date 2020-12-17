package com.weiit.web.admin.weixin.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.weixin.service.WeixinMediaImagesService;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.mp.bean.material.WxMpMaterial;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialCountResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialFileBatchGetResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialFileBatchGetResult.WxMaterialFileBatchGetNewsItem;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialUploadResult;
import me.chanjar.weixin.open.api.WxOpenService;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.net.URL;
import java.util.List;

/**
 * 微信公众号图片素材控制器
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping("/weixin/weixinMediaImages/")
public class WeixinMediaImagesController extends AdminController {

	@Resource
	private WeixinMediaImagesService weixinMediaImagesService;
	
	@Resource
	private WeixinPublicService weixinPublicService;
	
	@Resource
	private WeixinOpenService weixinOpenService;

	/**
	 * 圖片查询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public ModelAndView list() throws Exception {
		
		//返回到list页面
        ModelAndView result = UIView("/center/weixin/weixinMediaImages",false);
        
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 12);
    	
    	E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
        	//查询展示数量
        	List<E> list=weixinMediaImagesService.selectWeixinMediaImageList(formMap);
            //绑定分页返回
            result.addObject("pageInfo", new PageInfo<E>(list));
            //绑定上一次参数
            result.addObject("queryParam", formMap);
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}

        return result;
	}
	
	/**
	 * 同步公众号图文
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("syncImage")
	public UIview syncImage() throws Exception {
		
		UIview view=UIView("list", true);
		
		FormMap formMap=getFormMap();
		
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));

		formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

		WxOpenService openService = weixinOpenService.getInstance(formMap);
		WxMpMaterialCountResult result=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialCount();
		
		if(result!=null){
			int count=result.getImageCount();
			WxMpMaterialFileBatchGetResult fileResults=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialFileBatchGet("image", 0, count);
			List<WxMaterialFileBatchGetNewsItem> list=fileResults.getItems();
			int isInsertCount=0;
			for (WxMaterialFileBatchGetNewsItem item : list) {
				formMap.set("media_id", item.getMediaId());
				
				if(weixinMediaImagesService.selectWeixinMediaImageByMediaId(formMap)==null){//不存在则同步下来
					formMap.set("image_url",item.getUrl());
					weixinMediaImagesService.insertWeixinMediaImage(formMap);
					count++;
				}
			}
			view.addFlashAttribute("info", "公众号图片总共:"+count+"张图，本次同步更新完成:"+isInsertCount+"张图.刷新当前页面查看最新更新");
		}else{
			view.addFlashAttribute("error", "检测到公众号绑定配置异常，请更新授权后再试.");
		}
		
		return view;
	}
	
	/**
	 * 上传图片
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("uploadImage")
	public UIview uploadImage() throws Exception{
		UIview result=UIView("list", true);
		
		 try {
			 	// 转型为MultipartHttpRequest：
	            MultipartHttpServletRequest multipartHttpRequest = (MultipartHttpServletRequest)this.getRequest();
	            //获得文件
	            MultipartFile mFile=multipartHttpRequest.getFile("file");
	            
	            FormMap formMap=getFormMap();
	            if(!mFile.isEmpty()){
	            	 // 获取文件名
		            String fileName = mFile.getOriginalFilename();
		            // 获取文件后缀
		            String prefix=fileName.substring(fileName.lastIndexOf("."));
		            final File file = File.createTempFile(System.currentTimeMillis()+"", prefix);
			        // MultipartFile to File
		            mFile.transferTo(file);
		            
		            E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		            if(publicInfo!=null){//公众号存在，把上传的图片同步到公众上面去.
	            		
		            	//创建WxMPmaterial对象
	            		WxMpMaterial wxMpMaterial = new WxMpMaterial();
	            		wxMpMaterial.setFile(file);
	            		wxMpMaterial.setName(fileName);

						formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

						WxOpenService openService = weixinOpenService.getInstance(formMap);
	            		WxMpMaterialUploadResult rs=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialFileUpload("image", wxMpMaterial);//上传文件到微信
	            		
	            		if(rs!=null&&!rs.getMediaId().equals("")){//上传到公众号的图片是成功的
	            			//插入数据库中缓存
		            		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
		            		formMap.set("image_url", rs.getUrl());
		            		formMap.set("media_id", rs.getMediaId());
		            		weixinMediaImagesService.insertWeixinMediaImage(formMap);
	            		}else{//失败的，告诉失败原因
	            			result.addObject("error", "网络异常，上传失败，请稍后再试。");
	            		}
	            		
	            		 //程序结束时，删除临时文件
	    		        deleteFile(file);
	            	}
	            }
	            
	      }catch (Exception e){
	            e.printStackTrace();
	            throw new Exception("出错啦...");
	      }
		return result;
	}
	
	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("remove")
	public UIview delete() throws Exception {
		
		UIview result=UIView("list", true);
		
		FormMap formMap=getFormMap();
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		
		if(publicInfo!=null){
			formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

			WxOpenService openService = weixinOpenService.getInstance(formMap);
			boolean flag=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialDelete(formMap.getStr("media_id"));
			if(flag){
				formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
				weixinMediaImagesService.removeWeixinMediaImage(formMap);
			}
		}
		
		return result;
	}
	
	/**
	 * 官方图片下载（蜗店上传的公共图片）
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("wstoreCommonImages")
	public UIview wstoreCommonImages() throws Exception {
		
		UIview result=UIView("/center/weixin/weixinCommonImages", false);
		
		List<E> imageCateList=weixinMediaImagesService.selectAllCommonImageCateList(null);
		
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 12);
    	
    	List<E> imageList=weixinMediaImagesService.selectAllCommonImageList(formMap);
    	
    	result.addObject("imageCateList", imageCateList);
    	result.addObject("pageInfo", new PageInfo<E>(imageList));
    	result.addObject("queryParam", formMap);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("download")
	public String download() throws Exception {
		FormMap formMap=getFormMap();
		E imageInfo=weixinMediaImagesService.selectCommonImageByImageId(formMap);
		
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		
		if(publicInfo!=null){
			if(imageInfo!=null){
				
				String path = this.getRequest().getSession().getServletContext().getRealPath("");
			    //  创建临时文件夹到当前项目的根目录
			    File temp = new File(path+"/temp");
			    if(!temp.exists()){
			    	 temp.mkdirs();
			    	
			    }
			       
			    File file=new File(path+"/temp/"+System.currentTimeMillis()+".jpg");
			    
			    URL url=new URL(WeiitUtil.getFileDomain()+imageInfo.getStr("image_url"));
			    FileUtils.copyURLToFile(url, file);
			    
				//创建WxMPmaterial对象
		    	WxMpMaterial wxMpMaterial = new WxMpMaterial();
		    	wxMpMaterial.setFile(file);
		    	wxMpMaterial.setName(file.getName());
				formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

				WxOpenService openService = weixinOpenService.getInstance(formMap);
		    	WxMpMaterialUploadResult rs=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialFileUpload("image", wxMpMaterial);//上传文件到微信
		    	
		    	if(rs!=null&&!rs.getMediaId().equals("")){//上传到公众号的图片是成功的
        			//插入数据库中缓存
            		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
            		formMap.set("image_url", rs.getUrl());
            		formMap.set("media_id", rs.getMediaId());
            		weixinMediaImagesService.insertWeixinMediaImage(formMap);
        		}
		    	
		    	deleteFile(file);//删除临时文件.
		    	
	    		return toJsonAPI("","恭喜你，图片下载完成.","0");
			}else{
				return toJsonAPI("","该图片已经下架，不允许下载.","1000");
			}
		}else{
			return toJsonAPI("","检测到公众号绑定配置异常，请更新授权后再试.","1000");
		}
		
		
	
	}


	/**  
     * 删除  
     *   
     * @param files  
     */  
    private void deleteFile(File... files) {  
        for (File file : files) {  
            if (file.exists()) {  
                file.delete();  
            }  
        }  
    }

	
	
}
