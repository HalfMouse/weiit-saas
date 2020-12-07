package com.weiit.web.admin.weixin.controller;


import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.weixin.service.WeixinMediaArticleService;
import com.weiit.web.admin.weixin.service.WeixinMediaImagesService;
import com.weiit.web.admin.weixin.service.WeixinPublicMenuService;
import com.weiit.web.admin.weixin.service.WeixinPublicReplyService;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.weixinopen.service.WeixinOpenService;

import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.bean.menu.WxMenu;
import me.chanjar.weixin.common.bean.menu.WxMenuButton;
import me.chanjar.weixin.open.api.WxOpenConfigStorage;
import me.chanjar.weixin.open.api.WxOpenService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 微信菜单控制器
 * @author bill.ouyang
 * qq:137075251 半个鼠标
 * email:google555@126.com
 * team:weiyunshidai.com
 */
@Controller
@RequestMapping("/weixin/menu")
public class WeixinPublicMenuController extends AdminController {
	@Resource
	private WeixinPublicMenuService weixinPublicMenuService;
	
	@Resource
	private WeixinMediaArticleService weixinMediaArticleService;
	
	@Resource
	private WeixinMediaImagesService weixinMediaImagesService;
	
	@Resource
	private WeixinOpenService weixinOpenService;
	
	@RequestMapping("weixinMenu")
	public UIview weixinMenu() throws Exception {
		
		FormMap formMap=getFormMap();
		
		UIview result = UIView("/center/weixin/weixinMenu",false);
		
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
        	//查询图文
        	List<E> articleList=weixinMediaArticleService.selectWeixinMediaArticleList(formMap);
            result.addObject("articleList", articleList);
            
            //查询图片
        	List<E> pictureList=weixinMediaImagesService.selectWeixinMediaImageList(formMap);
            result.addObject("pictureList", pictureList);
            
            //查询链接列表
            List<E> linkList=weixinPublicMenuService.selectLinkList(null);
            result.addObject("linkList", linkList); 
            
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("createMenu")
	public String createMenu() throws Exception {
		FormMap formMap=getFormMap();
		FormMap param=new FormMap();
		FormMap childParam=new FormMap();
		
		List<Map> list=JSON.parseObject(formMap.getStr("menu"),List.class); 
		
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		if(publicInfo!=null){
			
			
			param.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			weixinPublicMenuService.removePublicMenuByAuthorizerId(param);//先删除所有的菜单
    		for (Map parentMap : list) {
    			param.clear();
    			childParam.clear();
    			param.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    			childParam.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    			
    			param.set("menu_name", parentMap.get("name").toString());
    			param.set("action_type", parentMap.get("type").toString());
    			
    			Map body=(Map)parentMap.get("body");
    			param.set("target_type", body.get("content_type").toString());
    			if(parentMap.get("type").toString().equals("1")){//表示发送消息
    				
    				if(body.get("content_type").toString().equals("1")){//图文
    					Map pic_file=(Map)body.get("pic_file");
    					param.set("target_content",pic_file.get("media_id").toString());//当为图文的时候，target_content存储的是图文的media_id
    					param.set("link_url", pic_file.get("url").toString());
    					param.set("title", pic_file.get("title").toString());
    				}else if(body.get("content_type").toString().equals("2")){//文字
    					Map text=(Map)body.get("text");
    					param.set("target_content",text.get("content").toString());//当为图文的时候，target_content存储的是图文的media_id
    					param.set("link_url","");//当为文字的时候，link_url可以为空
    					param.set("title", "");
    				}else if(body.get("content_type").toString().equals("3")){//图片
    					Map pic=(Map)body.get("pic");
    					param.set("target_content",pic.get("media_id").toString());//当为图片的时候，target_content存储的是图片的media_id
    					param.set("link_url",pic.get("url").toString());//当为文字的时候，link_url可以为空
    					param.set("title", pic.get("title").toString());
    				}else{
    					this.logger.info("菜单结构有误");
    				}
    				
    			}else if(parentMap.get("type").toString().equals("2")){//表示绑定的是链接
    				Map link=(Map)body.get("link");
    				param.set("target_content", link.get("page").toString());
    				param.set("link_url", link.get("url").toString());
    				param.set("title", link.get("title").toString());
    			}else if(parentMap.get("type").toString().equals("3")){//表示文章
    				Map custome_content=(Map)body.get("custome_content");
    				param.set("title", "自定义文章");
    				param.set("content", custome_content.get("content").toString());
    				param.set("shop_id", formMap.getStr("shop_id"));
    				weixinPublicMenuService.insertBlog(param);//先创建文章
    				param.set("target_content",custome_content.get("content").toString());//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
    				param.set("link_url",param.getStr("id"));//当为文章的时候，该文章需要把内容展示到一个已经做好实现的h5页面去
    				param.set("title","");
    			}else if(parentMap.get("type").toString().equals("4")){//小程序
    				Map mini=(Map)body.get("mini");
    				param.set("target_content",mini.get("content").toString());//当为图文的时候，target_content存储的是图文的media_id
					param.set("link_url","");//当为文字的时候，link_url可以为空
					param.set("title", "");
    			}else{
    				logger.info("菜单结构不合法");
    			}
    			
    			
    			param.set("parent_id", "-1");
    			System.out.println(param); 
    			weixinPublicMenuService.insertPublicMenu(param);//插入父菜单
    			
    			List<Map> cList=(List<Map>)parentMap.get("childs");
    			for (Map childMap : cList) {
					
					  childParam.set("menu_name", childMap.get("name").toString()); 
					  childParam.set("action_type", childMap.get("type").toString());
					  
					  Map childBody=(Map)childMap.get("body");//子菜单的body
					  childParam.set("target_type", childBody.get("content_type").toString());
    				  if(childMap.get("type").toString().equals("1")){//表示发送消息
        				
        				if(childBody.get("content_type").toString().equals("1")){//图文
        					Map pic_file=(Map)childBody.get("pic_file");
        					childParam.set("target_content",pic_file.get("media_id").toString());//当为图文的时候，target_content存储的是图文的media_id
        					childParam.set("link_url", pic_file.get("url").toString());
        					childParam.set("title", pic_file.get("title").toString());
        				}else if(childBody.get("content_type").toString().equals("2")){//文字
        					Map text=(Map)childBody.get("text");
        					childParam.set("target_content",text.get("content").toString());//当为图文的时候，target_content存储的是图文的media_id
        					childParam.set("link_url","");//当为文字的时候，link_url可以为空
        					childParam.set("title", "");
        				}else if(childBody.get("content_type").toString().equals("3")){//图片
        					Map pic=(Map)childBody.get("pic");
        					childParam.set("target_content",pic.get("media_id").toString());//当为图片的时候，target_content存储的是图片的media_id
        					childParam.set("link_url",pic.get("url").toString());//当为文字的时候，link_url可以为空
        					childParam.set("title", pic.get("title").toString());
        				}else{
        					this.logger.info("菜单结构有误");
        				}
        				
        			}else if(childMap.get("type").toString().equals("2")){//表示绑定的是链接
        				Map link=(Map)childBody.get("link");
        				childParam.set("target_content", link.get("page").toString());
        				childParam.set("link_url", link.get("url").toString()); 
        				childParam.set("title", link.get("title").toString());
        			}else if(childMap.get("type").toString().equals("3")){//表示文章
        				Map custome_content=(Map)childBody.get("custome_content");
        				childParam.set("title", "自定义文章");
        				childParam.set("content", custome_content.get("content").toString());
        				childParam.set("shop_id", formMap.getStr("shop_id"));
        				weixinPublicMenuService.insertBlog(childParam);//先创建文章
        				childParam.set("target_content",custome_content.get("content").toString());//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
        				childParam.set("link_url",childParam.getStr("id"));//当为文章的时候，该文章需要把内容展示到一个已经做好实现的h5页面去
        				childParam.set("title","");
        			}else if(childMap.get("type").toString().equals("4")){//表示绑定的是链接
        				Map mini=(Map)childBody.get("mini");
        				childParam.set("target_content", mini.get("content").toString());
        				childParam.set("link_url",""); 
        				childParam.set("title","");
        			}else{
        				this.logger.info("菜单结构有误");
        			}
    				childParam.set("parent_id",param.getStr("menu_id"));
    				System.out.println(childParam);
    				weixinPublicMenuService.insertPublicMenu(childParam);//插入子菜单
				}
    		}
    		List<E> menuList=weixinPublicMenuService.selectMenuList(param);
			return toJsonAPI(menuList);
    		
		}else{
			return toJsonAPI("","对不起，公众号还没有绑定授权，请先绑定授权。","10001");
		}
		
		
	}
	
	/**
	 * 获取菜单结构
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("getMenuJson")
	public String getMenuJson() throws Exception {
		
		FormMap formMap=getFormMap();
		
		
		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		if(publicInfo!=null){
			formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			
			List<E> menuList=weixinPublicMenuService.selectMenuList(formMap);
			return toJsonAPI(menuList);
    		
		}else{
			return toJsonAPI("","对不起，公众号还没有绑定授权，请先绑定授权。","10001");
		}
		
		
	}
	
	/**
	 * 同步菜单到公众号
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/sendMenuToWeixinPublic")
	public String sendMenuToWeixinPublic() throws Exception {
		
		FormMap formMap=getFormMap();
		
		try {
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
	    	if(publicInfo!=null){
				formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

	    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
	    		
	    		List<E> menuList=weixinPublicMenuService.selectParentMenuList(formMap);
	    		WxMenu wxMenu=new WxMenu();
	    		
	    		List<WxMenuButton> parentMenuList=new ArrayList<WxMenuButton>();
	    		for (E parent : menuList) {
					
	    			WxMenuButton button=new WxMenuButton();//一级菜单对象
	    			
	    			
					formMap.set("parent_id", parent.getStr("menu_id"));
					List<E> childList=weixinPublicMenuService.selectChildMenuList(formMap);
					List<WxMenuButton> childButtonList=new ArrayList<WxMenuButton>();
					if(childList.size()>0){//表示有子菜单
						for (E child : childList) {
							WxMenuButton childButton=new WxMenuButton();
							childButton.setName(child.getStr("menu_name"));
							if(child.getInt("action_type")==1){//表示发送消息
								if(child.getInt("target_type")==1){//表示图文
									childButton.setType(WxConsts.MenuButtonType.MEDIA_ID);
									childButton.setMediaId(child.getStr("target_content"));
									
								}else if(child.getInt("target_type")==2){//表示文字
									childButton.setType(WxConsts.MenuButtonType.CLICK);
									childButton.setKey(child.getStr("target_content"));
									
								}else if(child.getInt("target_type")==3){//表示图片
									childButton.setType(WxConsts.MenuButtonType.MEDIA_ID);
									childButton.setMediaId(child.getStr("target_content"));
									
								}
							}else if(child.getInt("action_type")==2){//表示跳转链接
								if(child.getStr("target_content").equals("zidingyi")){//表示自定义
									childButton.setType(WxConsts.MenuButtonType.VIEW);
									childButton.setUrl(child.getStr("link_url"));
								}else{
									childButton.setType(WxConsts.MenuButtonType.VIEW);
									if(child.getStr("target_content").equals("index")){//微首页
										childButton.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/"+child.getStr("link_url"));
									}else if(child.getStr("target_content").equals("productGroup")){//商品组
										childButton.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/productGroup?group_ids="+child.getStr("link_url"));
									}else if(child.getStr("target_content").equals("detail")){//商品组
										childButton.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/detail?product_id="+child.getStr("link_url"));
									}else{
										if(child.getStr("target_content").equals("zidingyi")){
											childButton.setUrl(child.getStr("link_url"));
										}else{
											childButton.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/"+child.getStr("target_content"));
										}
									}
									
								}
							}else if(child.getInt("action_type")==3){//表示文章
								childButton.setType(WxConsts.MenuButtonType.VIEW);
								childButton.setUrl("https://api.ustore.wang/api/blog/"+child.getStr("link_url")+".html");
							}else if(child.getInt("action_type")==4){
								childButton.setType(WxConsts.MenuButtonType.MINIPROGRAM);
								childButton.setName(child.getStr("menu_name"));
								childButton.setAppId(child.getStr("target_content"));
								childButton.setPagePath("pages/index/index"); 
								childButton.setUrl("http://mp.weixin.qq.com");
							}
							childButtonList.add(childButton);
						}
						button.setSubButtons(childButtonList);
						button.setName(parent.getStr("menu_name"));
					}else{//没有子菜单
						button.setName(parent.getStr("menu_name"));
						if(parent.getInt("action_type")==1){//表示发送消息
							if(parent.getInt("target_type")==1){//表示图文
								button.setType(WxConsts.MenuButtonType.MEDIA_ID);
								button.setMediaId(parent.getStr("target_content"));
								
							}else if(parent.getInt("target_type")==2){//表示文字
								button.setType(WxConsts.MenuButtonType.CLICK);
								button.setKey(parent.getStr("target_content"));
								
							}else if(parent.getInt("target_type")==3){//表示图片 
								button.setType(WxConsts.MenuButtonType.MEDIA_ID);
								button.setMediaId(parent.getStr("target_content"));
								
							}
						}else if(parent.getInt("action_type")==2){//表示跳转链接
							if(parent.getStr("target_content").equals("zidingyi")){//表示自定义
								button.setType(WxConsts.MenuButtonType.VIEW);
								button.setUrl(parent.getStr("link_url"));
								//button.setType(WxConsts.MenuButtonType.MINIPROGRAM);
								//button.setName("小程序");
								//button.setAppId("wxdde6d44348f138ca");
								//button.setPagePath("pages/index/index"); 
								//button.setUrl("http://mp.weixin.qq.com");
							}else{
								button.setType(WxConsts.MenuButtonType.VIEW);
								if(parent.getStr("target_content").equals("index")){//微首页
									button.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/"+parent.getStr("link_url"));
								}else if(parent.getStr("target_content").equals("productGroup")){//商品组
									button.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/productGroup?group_ids="+parent.getStr("link_url"));
								}else if(parent.getStr("target_content").equals("detail")){//商品组
									button.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/detail?product_id="+parent.getStr("link_url"));
								}else{
									if(parent.getStr("target_content").equals("zidingyi")){
										button.setUrl(parent.getStr("link_url"));
									}else{
										button.setUrl("http://"+publicInfo.getStr("authorizer_app_id")+".wx.ustore.wang/"+parent.getStr("target_content"));
									}
								}
							}
						}else if(parent.getInt("action_type")==3){//表示文章
							button.setType(WxConsts.MenuButtonType.VIEW);
							button.setUrl("https://api.ustore.wang/api/blog/"+parent.getStr("link_url")+".html");
						}else if(parent.getInt("action_type")==4){
							button.setType(WxConsts.MenuButtonType.MINIPROGRAM);
							button.setName(parent.getStr("menu_name"));
							button.setAppId(parent.getStr("target_content"));
							button.setPagePath("pages/index/index"); 
							button.setUrl("http://mp.weixin.qq.com");
						}
						
					}
					
					parentMenuList.add(button);
				}
	    		
	    		if (parentMenuList.size()<1){
					return toJsonAPI("","请先保存再点击发布。","0");
				}
	    		
	    		wxMenu.setButtons(parentMenuList);
	    		String result=weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id")).getMenuService().menuCreate(wxMenu);
	    		if(result==null){
	    			return toJsonAPI("","公众号菜单已经同步，最长可能需要30分钟才会更新。","0");
	    		}else{
	    			return toJsonAPI("",result,"0");
	    		}
	    		
	    		
	            
	    	}else{
	    		return toJsonAPI("","对不起，公众号还没有绑定授权，请先绑定授权。","10001");
	    	}
		} catch (Exception e) {
			e.printStackTrace();
			
			return toJsonAPI("","推送失败，菜单结构不满足微信要求。"+e.getMessage(),"10001");
		}
		
		
		
	}

}
