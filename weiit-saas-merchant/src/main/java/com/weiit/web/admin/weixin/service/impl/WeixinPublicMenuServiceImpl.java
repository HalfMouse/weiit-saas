package com.weiit.web.admin.weixin.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.weixin.mapper.WeixinPublicMenuMapper;
import com.weiit.web.admin.weixin.service.WeixinPublicMenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 微信自定义菜单管理实现类
 * @author：半个鼠标
 * @date：2018年2月5日 下午2:58:33
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@Service("weixinPublicMenuService")
public class WeixinPublicMenuServiceImpl extends AbstractService implements WeixinPublicMenuService{

	@Resource
	private WeixinPublicMenuMapper weixinPublicMenuMapper;
	
	@Override
	public BaseMapper setMapper() {
		return weixinPublicMenuMapper; 
	}
	
	@Override
	public List<E> selectLinkList(FormMap formMap) {
		return weixinPublicMenuMapper.selectLinkList(formMap);
	}

	@Override
	public void removePublicMenuByAuthorizerId(FormMap formMap) {
		weixinPublicMenuMapper.removePublicMenuByAuthorizerId(formMap);
	}

	@Override
	public void insertPublicMenu(FormMap formMap) {
		weixinPublicMenuMapper.insertPublicMenu(formMap);
	}

	@Override
	public List<E> selectMenuList(FormMap formMap) {
		List<E> menuList=new ArrayList<E>();
		List<E> parentMenuList=weixinPublicMenuMapper.selectParentMenuList(formMap);
		
		
		for (E parent : parentMenuList) {
			E temp=new E();
			E body=new E();
			E pic_file=new E();
				pic_file.set("url", "");
				pic_file.set("media_id", "");
				pic_file.set("title", "");
			E text=new E();
				text.set("content", "");
			E pic=new E();
				pic.set("url", "");
				pic.set("media_id", "");
				pic.set("title", "");
			E link=new E();
				link.set("url", "");
				link.set("title","");
				link.set("page","");
			E custome_content=new E();
				custome_content.set("content","");//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
			E mini=new E();
				mini.set("content", "");
			temp.set("name", parent.getStr("menu_name"));
			temp.set("type", parent.getStr("action_type"));
			
			
			if(parent.getStr("action_type").equals("1")){//表示发送消息
				if(parent.getStr("target_type").equals("1")){//表示图文
					pic_file.set("url", parent.getStr("link_url"));
					pic_file.set("media_id", parent.getStr("target_content"));
					pic_file.set("title", parent.getStr("title"));
				}else if(parent.getStr("target_type").equals("2")){//表示文字
					text.set("content", parent.getStr("target_content"));
				}else if(parent.getStr("target_type").equals("3")){//表示图片
					pic.set("url", parent.getStr("link_url"));
					pic.set("media_id", parent.getStr("target_content"));
					pic.set("title", parent.getStr("title"));
				}
			}else if(parent.getStr("action_type").equals("2")){//表示跳转页面
				link.set("url", parent.getStr("link_url"));
				link.set("title",  parent.getStr("title"));
				link.set("page", parent.getStr("target_content"));
				
			}else if(parent.getStr("action_type").equals("3")){//表示文章
				custome_content.set("content",parent.getStr("target_content"));//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
			}else if(parent.getStr("action_type").equals("4")){//表示文章
				mini.set("content",parent.getStr("target_content"));//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
			}
			body.set("content_type", parent.getStr("target_type"));
			body.set("pic_file", pic_file);
			body.set("text", text);
			body.set("pic", pic);
			body.set("link", link);
			body.set("custome_content", custome_content);
			body.set("mini", mini);
			temp.set("body", body);
			temp.set("is_select", 0);
			
			formMap.set("parent_id", parent.getStr("menu_id"));
			List<E> resultChildMenuList=new ArrayList<E>();
			List<E> childMenuList=weixinPublicMenuMapper.selectChildMenuList(formMap);
			for (E child : childMenuList) {
				
				E childTemp=new E();
				E childBody=new E();
				E childPic_file=new E();
					childPic_file.set("url", "");
					childPic_file.set("media_id", "");
					childPic_file.set("title", "");
				E childText=new E();
					childText.set("content", "");
				E childPic=new E();
					childPic.set("url", "");
					childPic.set("media_id", "");
					childPic.set("title", "");
				E childLink=new E();
					childLink.set("url", "");
					childLink.set("title","");
					childLink.set("page","");
				E childCustome_content=new E();
					childCustome_content.set("content","");//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
				E childMini=new E();
					childMini.set("content", "");
					childTemp.set("name", child.getStr("menu_name"));
					childTemp.set("type", child.getStr("action_type"));
				
				if(child.getStr("action_type").equals("1")){//表示发送消息
					
					if(child.getStr("target_type").equals("1")){//表示图文
						childPic_file.set("url", child.getStr("link_url"));
						childPic_file.set("media_id", child.getStr("target_content"));
						childPic_file.set("title", child.getStr("title"));
					}else if(child.getStr("target_type").equals("2")){//表示文字
						childText.set("content", child.getStr("target_content"));
					}else if(child.getStr("target_type").equals("3")){//表示图片
						childPic.set("url", child.getStr("link_url"));
						childPic.set("media_id", child.getStr("target_content"));
						childPic.set("title", child.getStr("title"));
					}
				}else if(child.getStr("action_type").equals("2")){//表示跳转页面 
					childLink.set("url", child.getStr("link_url"));
					childLink.set("title",  child.getStr("title"));
					childLink.set("page", child.getStr("target_content"));
					
				}else if(child.getStr("action_type").equals("3")){//表示文章
					childCustome_content.set("content",child.getStr("target_content"));//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
				}else if(child.getStr("action_type").equals("4")){//表示文章
					childMini.set("content",child.getStr("target_content"));//当为图文的时候, 该文章需要把内容展示到一个已经做好实现的h5页面去
				}
				childBody.set("content_type", child.getStr("target_type")); 
				childBody.set("pic_file", childPic_file);
				childBody.set("text", childText);
				childBody.set("pic", childPic);
				childBody.set("link", childLink);
				childBody.set("custome_content", childCustome_content);
				childBody.set("mini", childMini);
				childTemp.set("body", childBody);
				childTemp.set("is_select", 0);
				resultChildMenuList.add(childTemp);
			}
			temp.set("childs", resultChildMenuList);
			
			menuList.add(temp);
			
		}
		return menuList;
		
	}

	@Override
	public List<E> selectParentMenuList(FormMap formMap) {
		return weixinPublicMenuMapper.selectParentMenuList(formMap);
	}

	@Override
	public List<E> selectChildMenuList(FormMap formMap) {
		return weixinPublicMenuMapper.selectChildMenuList(formMap);
	}

	@Override
	public void insertBlog(FormMap formMap) {
		weixinPublicMenuMapper.insertBlog(formMap); 
	}


}
