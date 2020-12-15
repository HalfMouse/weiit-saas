package com.weiit.web.admin.weixin.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.fabric.xmlrpc.base.Array;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.user.service.UserService;
import com.weiit.web.admin.user.service.UserSignService;
import com.weiit.web.admin.weixin.service.WeixinMediaArticleService;
import com.weiit.web.admin.weixin.service.WeixinMediaImagesService;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixinopen.service.WeixinOpenService;

import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.bean.result.WxMediaUploadResult;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.impl.WxMpServiceImpl;
import me.chanjar.weixin.mp.bean.WxMpMassNews;
import me.chanjar.weixin.mp.bean.WxMpMassNews.WxMpMassNewsArticle;
import me.chanjar.weixin.mp.bean.WxMpMassOpenIdsMessage;
import me.chanjar.weixin.mp.bean.material.WxMediaImgUploadResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterial;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialCountResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialFileBatchGetResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialFileBatchGetResult.WxMaterialFileBatchGetNewsItem;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialNews;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialNews.WxMpMaterialNewsArticle;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialUploadResult;
import me.chanjar.weixin.mp.bean.result.WxMpMassUploadResult;
import me.chanjar.weixin.open.api.WxOpenConfigStorage;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.api.impl.WxOpenInMemoryConfigStorage;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 微信公众号图片素材控制器
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Controller
@RequestMapping("/weixin/weixinMediaArticle/")
public class WeixinMediaArticleController extends AdminController {

	@Resource
	private WeixinMediaArticleService weixinMediaArticleService;
	
	@Resource
	private WeixinPublicService weixinPublicService;
	
	@Resource
	private WeixinOpenService weixinOpenService;
	
	@Resource
	private UserService userService;
	
	@Resource
	private UserSignService userSignService;

	/**
	 * 圖片查询
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public ModelAndView list() throws Exception {
		
		//返回到list页面
        ModelAndView result = UIView("/center/weixin/weixinMediaArticle",false);
        
		//获取请求参数
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), 12);
    	
    	E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
        	//查询展示数量
        	List<E> list=weixinMediaArticleService.selectWeixinMediaArticleList(formMap);
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
	 * 新增图文
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("add")
	public ModelAndView add() throws Exception {
		
        ModelAndView result = UIView("/center/weixin/weixinMediaArticleAdd",false);
        return result;
	}
	
	/**
	 * 编辑图文
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("edit")
	public ModelAndView edit() throws Exception {
		
        ModelAndView result = UIView("/center/weixin/weixinMediaArticleAdd",false);
        FormMap formMap=getFormMap();
        E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		 formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    		 E article=weixinMediaArticleService.selectWeixinMediaArticleByMediaId(formMap);
    	     result.addObject("article", article);
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}
       
        return result;
	}
	
	/**
	 * 新增或者修改提交
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveOrEdit")
	public UIview saveOrEdit() throws Exception {
		
        UIview result = UIView("list",true);
        FormMap formMap=getFormMap();
        E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
			formMap.put("appid",publicInfo.getStr("authorizer_app_id"));
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    		WxOpenService wxOpenService =weixinOpenService.getInstance(formMap);
    		try {
    		 	// 转型为MultipartHttpRequest：
                MultipartHttpServletRequest multipartHttpRequest = (MultipartHttpServletRequest)this.getRequest();
                //获得文件
                MultipartFile mFile=multipartHttpRequest.getFile("file_cover_img");
                
              
                if(!mFile.isEmpty()){
                	String pictureName=WeiitUtil.uploadFile(mFile);
                	formMap.set("cover_img", pictureName);
                	 // 获取文件名
		            String fileName = mFile.getOriginalFilename();
		            // 获取文件后缀
		            String prefix=fileName.substring(fileName.lastIndexOf("."));
		            final File file = File.createTempFile(System.currentTimeMillis()+"", prefix);
			        // MultipartFile to File
		            mFile.transferTo(file);
		            
		          //创建WxMPmaterial对象
            		WxMpMaterial wxMpMaterial = new WxMpMaterial();
            		wxMpMaterial.setFile(file);
            		wxMpMaterial.setName(fileName);
            		
            		
            		WxMpMaterialUploadResult rs=wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialFileUpload("image", wxMpMaterial);//上传文件到微信
            		
            		this.logger.info("图文上传时先上传图片，得到mediaId");
            		
            		if(rs!=null&&!rs.getMediaId().equals("")){//上传到公众号的图片是成功的
            			//插入数据库中缓存
	            		formMap.set("cover_media_id", rs.getMediaId());
	            		formMap.set("cover_img", rs.getUrl());
            		}
            		 //程序结束时，删除临时文件
    		        deleteFile(file);
	            	
                	
                }
                //创建WxMPmaterial对象
            	WxMpMaterialNews news = new WxMpMaterialNews();
            	WxMpMaterialNewsArticle artile=new WxMpMaterialNewsArticle();
            	artile.setAuthor(formMap.getStr("author"));
            	artile.setTitle(formMap.getStr("title"));
            	artile.setContent(formMap.getStr("editorValue"));
            	artile.setDigest(formMap.getStr("model"));//摘要
            	//artile.setContentSourceUrl("http://www.baidu.com");
            	artile.setThumbMediaId(formMap.getStr("cover_media_id"));//设置图文主图的media_id
            	artile.setThumbUrl(formMap.getStr("cover_img"));
            	if(formMap.getInt("is_open_comment")==1){
            		artile.setNeedOpenComment(true);
            	}else{
            		artile.setNeedOpenComment(false);
            	}
            	if(formMap.getInt("is_only_fans_comment")==1){
            		artile.setOnlyFansCanComment(true);
            	}else{
            		artile.setOnlyFansCanComment(false);
            	}
            	artile.setShowCoverPic(false);
            	
            	news.addArticle(artile);
            	
            	if(StringUtils.isEmpty(formMap.getStr("validate_id"))){//新增
            		WxMpMaterialUploadResult r=wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialNewsUpload(news);//新增图文
            		if(r!=null&&!r.getMediaId().equals("")){
            			formMap.set("media_id", r.getMediaId());//用图文的media_id覆盖原来图片的media_id
            			formMap.set("url", r.getUrl());//
            			weixinMediaArticleService.insertWeixinMediaArtile(formMap);
            			
            			this.logger.info("图文上传结果:"+r);
	                	result.addPNotifyMessage("图文新增成功");
            		}
                	
                }else{
                	WxMpMaterialUploadResult r=wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialNewsUpload(news);//更新图文
            		if(r!=null&&!r.getMediaId().equals("")){
            			formMap.set("media_id", r.getMediaId());//用图文的media_id覆盖原来图片的media_id
            			weixinMediaArticleService.editWeixinMediaArticle(formMap);
            			
            			this.logger.info("图文上传结果:"+r);
	                	result.addPNotifyMessage("图文编辑成功");
            		}
                	
                }
                
                
            }catch (Exception e){
            	e.printStackTrace();
            }
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}
        
        return result;
	}
	
	/**
	 * 发送多图文
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sendMulti")
	public ModelAndView send() throws Exception {
		FormMap formMap=getFormMap();
        ModelAndView result = UIView("/center/weixin/weixinMediaArticleSend",false);
        E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
        	//查询展示数量
        	List<E> list=weixinMediaArticleService.selectWeixinMediaArticleList(formMap);
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
	 * 推送图文
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectUser")
	public ModelAndView selectUser() throws Exception {
		
		FormMap formMap=getFormMap();
		ModelAndView result = UIView("/center/weixin/weixinMediaArticleSelectUser",false);
		 
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    		//查询图文
        	List<E> list=weixinMediaArticleService.selectWeixinMediaArticleListByIds(formMap);
            result.addObject("list", list);
            
            //查询当前公众号的所有用户 
            formMap.set("open_id_type", "1");//表示公众号
            List<E> userList=userService.selectList(formMap);
            
            //查询所有的标签组
            List<E> signList=userSignService.selectList(formMap);
            
            result.addObject("userList", userList);
            result.addObject("signList", signList);
            
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}
       
        return result;
	}
	
	/**
	 * 推送图文给微信用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sendToWeixin")
	public UIview sendToWeixin() throws Exception {
		
		FormMap formMap=getFormMap();
		formMap.set("open_id_type", "1");//表示公众号
		UIview result = UIView("list",true);
		 
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    		formMap.set("appid", publicInfo.getStr("authorizer_app_id"));
    		List<E> userList=null;
    		if(formMap.getInt("type")==1){//按照选择的用户进行推送
    			userList=userService.selectListByUserIds(formMap);
    		}else if(formMap.getInt("type")==2){//按照标签组进行推送
    			userList=userSignService.selectUserListBySignIds(formMap);
    		}else if(formMap.getInt("type")==3){//全部推送
    			userList=userService.selectList(formMap);
    		}
    		
    		WxOpenService openService=weixinOpenService.getInstance(formMap);
    		
    		
    		//查询图文
    		List<E> articleList=weixinMediaArticleService.selectWeixinMediaArticleListByIds(formMap);
    		String media_id=null;
			//表示多图文推送，多图文推送，首先需要将多个图文组合，然后推送，这个过程，实际是多个单图文，然后重新组合一个新的多图文，然后先上传到微信去，得到一个新的media_id，然后推送
    		if(articleList.size()>1){
    			WxMpMaterialNews news = new WxMpMaterialNews();
        		for (E article : articleList) {
        			WxMpMaterialNewsArticle art = new WxMpMaterialNewsArticle();
        			art.setTitle(article.getStr("title"));
        			art.setContent(article.getStr("main_body"));
        			art.setThumbMediaId(article.getStr("cover_media_id"));
        			art.setAuthor(article.getStr("author"));
        			art.setDigest(article.getStr("model"));
        			art.setContentSourceUrl(article.getStr("original_link"));
        			if(article.getInt("is_open_comment")==1){
        				art.setNeedOpenComment(true);
        			}else{
        				art.setOnlyFansCanComment(false);
        			}
        			if(article.getInt("is_only_fans_comment")==1){
        				art.setOnlyFansCanComment(true);
        			}else{
        				art.setOnlyFansCanComment(false);
        			}
        			art.setThumbUrl(article.getStr("cover_img"));
        			art.setShowCoverPic(false);
        			news.addArticle(art);
    			}
				//新增图文
            	WxMpMaterialUploadResult r=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialNewsUpload(news);
            	if(r!=null&&!r.getMediaId().equals("")){
            		media_id=r.getMediaId();
            	}
    		}else{//是单图文推送，直接取查询出来的数据，然后进行推送
    			media_id=articleList.get(0).getStr("media_id");
    		}
    		
    		List<String> toUsers=new ArrayList<String>();
        	for (E user : userList) {
            	toUsers.add(user.getStr("wx_open_id"));
    		}
        	if(toUsers.size()>1){
        		WxMpMassOpenIdsMessage massMessage = new WxMpMassOpenIdsMessage();
            	massMessage.setMsgType(WxConsts.MassMsgType.MPNEWS);
            	massMessage.setMediaId(media_id);
            	massMessage.setToUsers(toUsers);
            		
        		openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMassMessageService().massOpenIdsMessageSend(massMessage);
        	}else{
        		result=UIView("selectUser?ids="+formMap.getStr("ids"),true);
        		result.addFlashAttribute("info", "检测到你要推送的用户数不足2人，要求必须满足2人以上才能推送.");
        	}
        		
        	
        	
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}
       
        return result;
	}
	
	/**
	 * 删除图文
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("remove")
	public UIview remove() throws Exception {
		
		FormMap formMap=getFormMap();
		UIview result = UIView("list",true);
		 
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");

    	if(publicInfo!=null){
			formMap.put("appid",publicInfo.getStr("authorizer_app_id"));
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    		boolean removeState=weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMaterialService().materialDelete(formMap.getStr("media_id"));//先删除微信上的图文
    		if(removeState){//再删除存储表
    			weixinMediaArticleService.removeWeixinMediaArticle(formMap);
    			result.addPNotifyMessage("图文删除成功");
    		}else{
    			result.addErrorMessage("图文删除失败");
    		}
            
    	}else{
    		result.addPNotifyMessage("对不起，公众号还没有绑定授权，请先绑定授权");
    	}
       
        return result;
	}
	
	/**
	 * 获取最新的wxopenService
	 * @return
	 */
//	public WxOpenService freshWeixinOpenService(){
//		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
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
