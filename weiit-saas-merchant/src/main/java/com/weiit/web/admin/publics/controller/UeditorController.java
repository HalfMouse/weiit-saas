package com.weiit.web.admin.publics.controller;

import com.google.common.collect.Maps;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.material.WxMpMaterial;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialUploadResult;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Map;

/**
 * Created by 罗鸿强 on 2018/6/5.
 */
@RequestMapping(value = "ueditor")
@Controller
public class UeditorController {

	@Resource
	private WeixinOpenService weixinOpenService;

    /**
     * 加载config.json，初始化上传
     * */
    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    @ResponseBody
    public void upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if ("config".equals(action)) {
            OutputStream os = response.getOutputStream();
            IOUtils.copy(UeditorController.class.getClassLoader().getResourceAsStream("ueconfig.json"), os);
        }
        if("listimage".equals(action)){
        	String result="{\"state\":\"SUCCESS\",\"total\":\""+3+"\",\"start\":\""+0+"\",\"list\":[{\"state\":\"SUCCESS\",\"url\":\"http://localhost/weiit_saas_merchant/resource/images/logo_light.png\"},{\"state\":\"SUCCESS\",\"url\":\"http://localhost/weiit_saas_merchant/resource/images/logo_light.png\"}]}";
			response.getWriter().print(result);
			response.getWriter().flush();
			response.getWriter().close();
        }
    }

    /**
     *
     * 上传图片 、视频、 文件
     *
     * uploadimage，uploadvideo，uploadfile 三个来自于conf.json文件中的配置，统一上传接口  post请求。
     * */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> upload(HttpServletRequest request, @RequestParam CommonsMultipartFile upfile) throws IOException {

        request.getHeader("");

        Map<String, String> result = Maps.newHashMap();
        String path = getFilePath(upfile);
        File file = new File(path);
        String state = "SUCCESS";
        //返回类型
        result.put("url", path);
        result.put("size", String.valueOf(file.length()));
        result.put("state", state);
        return result;
    }

    /******************************微信图文上传，是个特例,如发现是微信图文上传时，图片直接上传到微信素材中心去*********************************/
    
    @RequestMapping(value = "/weixinUpload", method = RequestMethod.GET)
    @ResponseBody
    public void weixinUupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if ("config".equals(action)) {
            OutputStream os = response.getOutputStream();
            IOUtils.copy(UeditorController.class.getClassLoader().getResourceAsStream("ueconfig.json"), os);
        }
        if("listimage".equals(action)){
        	String result="{\"state\":\"SUCCESS\",\"total\":\""+3+"\",\"start\":\""+0+"\",\"list\":[{\"state\":\"SUCCESS\",\"url\":\"http://localhost/weiit_saas_merchant/resource/images/logo_light.png\"},{\"state\":\"SUCCESS\",\"url\":\"http://localhost/weiit_saas_merchant/resource/images/logo_light.png\"}]}";
			response.getWriter().print(result);
			response.getWriter().flush();
			response.getWriter().close();
        }
    }

    /**
     *
     * 上传图片 、视频、 文件
     *
     * uploadimage，uploadvideo，uploadfile 三个来自于conf.json文件中的配置，统一上传接口  post请求。
     * */
    @RequestMapping(value = "/weixinUpload", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> weixinUpload(HttpServletRequest request, @RequestParam CommonsMultipartFile upfile) throws IOException {
        Map<String, String> result = Maps.newHashMap();
        String path = null;

        E publicInfo=(E)request.getSession().getAttribute("publicInfo");
        //公众号存在，把上传的图片同步到公众上面去
        if(publicInfo!=null){
            FormMap formMap = new FormMap();
            formMap.put("appid",publicInfo.getStr("authorizer_app_id"));
        	// 获取文件名
            String fileName = upfile.getOriginalFilename();
            // 获取文件后缀
            String prefix=fileName.substring(fileName.lastIndexOf("."));
            final File file = File.createTempFile(System.currentTimeMillis()+"", prefix);
	        // MultipartFile to File
            upfile.transferTo(file);
            
        	//创建WxMPmaterial对象
    		WxMpMaterial wxMpMaterial = new WxMpMaterial();
    		wxMpMaterial.setFile(file);
    		wxMpMaterial.setName(file.getName());
    		
    		//上传文件到微信
    		try {
				WxMpMaterialUploadResult rs=weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialFileUpload("image", wxMpMaterial);
				path=rs.getUrl();
			} catch (WxErrorException e) {
				e.printStackTrace();
			}
    		 //程序结束时，删除临时文件
	        deleteFile(file);
    		
    	}
        String state = "SUCCESS";
        //返回类型
        result.put("url", path);
        result.put("size", upfile.getSize()+"");
        result.put("state", state);
        return result;
    }
    
    
    /**
     * 暂无使用
     *
     * */
    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public void show(String filePath, HttpServletResponse response) throws IOException {
        File file = getFile(filePath);
        response.setDateHeader("Expires", System.currentTimeMillis() + 1000 * 60 * 60 * 24);
        response.setHeader("Cache-Control", "max-age=60");
        OutputStream os = response.getOutputStream();
        FileInputStream is = null;
        try {
            is = new FileInputStream(file);
            IOUtils.copy(is, os);
        } catch (FileNotFoundException e) {
            response.setStatus(404);
            return;
        } finally {
            if (null != is) {
                is.close();
            }
            if (null != os) {
                os.flush();
                os.close();
            }
        }
    }


    /**
     * 上传到weiit
     * */
    protected String getFilePath(CommonsMultipartFile uploadFile) throws IOException {
        return WeiitUtil.getFileDomain()+WeiitUtil.uploadFile(uploadFile);
    }

    protected File getFile(String path){
        File file = new File(path);
        return file;
    }

    /**
     * 判断是否视频格式
     * */
    private boolean isVideoFormat(String suffix){
        String [] videoFormat={".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
                ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"};
        boolean flag=false;
        for(String v:videoFormat){
            if (v.toUpperCase().equals(suffix.toUpperCase())) {
                flag =true;
                break;
            }
        }

        return flag;
    }
    
    /**
	 * 获取最新的wxopenService
	 * @return
	 */
//	public WxOpenService freshWeixinOpenService(E publicInfo){
//
//		WxOpenConfigStorage openConfig=weixinOpenService.getOpenConfig().getWxOpenConfigStorage();
//		openConfig.setAuthorizerRefreshToken(publicInfo.getStr("authorizer_app_id"), publicInfo.getStr("authorizer_fresh_token"));
//
//		WxOpenService openService=weixinOpenService.getOpenConfig();
//		openService.setWxOpenConfigStorage(openConfig);
//		return openService;
//	}
	
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
