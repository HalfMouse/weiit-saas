package com.weiit.web.admin.shopdesign.service.impl;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.publics.mapper.ParameterMapper;
import com.weiit.web.admin.shopdesign.mapper.PageNavMapper;
import com.weiit.web.admin.shopdesign.service.PageNavService;
import com.weiit.web.admin.util.JsonUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/** 
 * Title: CustomUserServiceImpl.java
 * Description: 装修，会员主页
 * Company: 微邦互联 
 * @author hzy
 * @date 2017年12月7日
 */
@Service("pageNavService")
public class PageNavServiceImpl extends AbstractService implements PageNavService {

	@Resource
	private PageNavMapper pageNavMapper; 	
	@Resource
	private ParameterMapper parameterMapper;
	
	@Override
	public BaseMapper setMapper() {
		return pageNavMapper;
	} 
	
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public int edit(FormMap formmap){
		//修改页面主信息
		pageNavMapper.edit(formmap);
		Integer nav_id=formmap.getInt("validate_id");
		//删除所有标签
		pageNavMapper.removeItem(formmap);
		//微信公众号自定义菜单样式
		if(formmap.getStr("nav_type").equals("1")){
			if(formmap.getInt("time_one_count")>0){
				for (int i = 1; i <= formmap.getInt("time_one_count") ; i++) {
					if(!formmap.getStr("time_one_name"+i).equals("")){
						FormMap param=new FormMap();
						param.put("shop_id", formmap.get("shop_id")); 
						param.put("parent_id", -1);
						param.put("nav_id", nav_id);
						param.put("item_name", formmap.getStr("time_one_name"+i));
						param.put("item_target_type", formmap.getStr("time_one_target"+i));
						param.put("item_target_id", formmap.getStr("time_one_targetId"+i));
						param.put("item_target_url", formmap.getStr("time_one_targetUrl"+i));
						param.put("sort_num", 0);
						// 插入 一级菜单 
						pageNavMapper.insertItem(param); 
						// 插入 二级菜单 
						int sort_num=0;
						if(formmap.getInt("time_one_count"+i)>0){
							Integer item_id=param.getInt("item_id");
							for (int j = 1; j <= formmap.getInt("time_one_count")+i ; j++) {
								if(!formmap.getStr("time_one_name"+i+"_"+j).equals("")){
									sort_num++;
									FormMap item=new FormMap();
									item.put("shop_id", formmap.get("shop_id")); 
									item.put("parent_id", item_id);
									item.put("nav_id", nav_id);
									item.put("item_name", formmap.getStr("time_one_name"+i+"_"+j));
									item.put("item_target_type", formmap.getStr("time_one_target"+i+"_"+j));
									item.put("item_target_id", formmap.getStr("time_one_targetId"+i+"_"+j));
									item.put("item_target_url", formmap.getStr("time_one_targetUrl"+i+"_"+j));
									item.put("sort_num", sort_num);
									pageNavMapper.insertItem(item); 
								}
							}
						}
					}
				}
			}
		}
		if(formmap.getStr("nav_type").equals("2")){
			if(formmap.getInt("time_two_count")>0){
				for (int i = 1; i <= formmap.getInt("time_two_count") ; i++) {
					if(!formmap.getStr("imgfileitem"+i).equals("")){
						FormMap param=new FormMap();
						param.put("shop_id", formmap.get("shop_id")); 
						param.put("parent_id", -1);
						param.put("nav_id", nav_id);
						param.put("item_name", "");
						param.put("item_img1", formmap.getStr("imgfileitem"+i));
						param.put("item_img2", formmap.getStr("imgfileitem"+i+"_1"));
						param.put("item_target_type", formmap.getStr("time_one_target"+i));
						param.put("item_target_id", formmap.getStr("time_one_targetId"+i));
						param.put("item_target_url", formmap.getStr("time_one_targetUrl"+i));
						param.put("sort_num", 0);
						// 插入 
						pageNavMapper.insertItem(param);  
					}
				}
			}
		}
		return 1;
	}
	
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
    public int remove(FormMap formmap){
		pageNavMapper.removeItem(formmap);
		pageNavMapper.remove(formmap);
		return 1;
	}
	 
	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
   	public int editState(FormMap formmap){
		Integer validate_id=formmap.getInt("validate_id");
		formmap.set("state", "0");
		formmap.set("validate_id", "");
		pageNavMapper.editState(formmap);
		if(formmap.getStr("mystate").equals("1")){
			formmap.set("state", "1");
			formmap.set("validate_id", validate_id);
		}
		pageNavMapper.editState(formmap);
		return 1;
	} 
   	
	@Override
    public List<E> selectItemList(FormMap formmap){
		return pageNavMapper.selectItemList(formmap);
	} 
       
	@Override
   	public int insertItem(FormMap formmap){
		return pageNavMapper.insertItem(formmap);
	} 

	@Override
    public int removeItem(FormMap formmap){
		return pageNavMapper.removeItem(formmap);
	} 
   	
	@Override
    public List<E> selectButtonList(FormMap formmap){
		return pageNavMapper.selectButtonList(formmap);
	} 
	@Override
    public List<E> navIconList(FormMap formmap){
		return pageNavMapper.navIconList(formmap);
	}

	@Override
    public void saveNav(FormMap formmap){
    	//先删除原先的
		pageNavMapper.delNav(formmap);

		String nav = formmap.getStr("nav");

		List<Map> list = JsonUtil.convertValue(nav,List.class);

		for(Map param :list){
			param.put("nav_url",param.get("url"));
			param.put("shop_id",formmap.get("shop_id"));
			pageNavMapper.saveNav(param);
		}



	}

	@Override
    public List<E> navInfo(FormMap formmap){
		return pageNavMapper.navInfo(formmap);
	}

	@Override
    public List<E> navOptionalUrl(FormMap formmap){
		return pageNavMapper.navOptionalUrl(formmap);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,readOnly=false,rollbackFor=Exception.class)
   	public int insertButton(FormMap formmap){

    	//自定义菜单颜色去掉 2018 07 04 luo
//		formmap.put("item_code", "CUSTOM");
//		formmap.put("item_name", "BOTTOMNAV");
//    	List<E> list=parameterMapper.selectList(formmap);
//    	if(list!=null && list.size()>0){
//    		E info=list.get(0);
//    		FormMap info11 = new FormMap();
//    		info11.put("validate_id", info.get("id"));
//			info11.put("shop_id", formmap.get("shop_id"));
//			info11.put("item_value", formmap.get("bottomColor"));
//			parameterMapper.edit(formmap);
//		}else{
//			FormMap info11 = new FormMap();
//			info11.put("item_code", "CUSTOM");
//			info11.put("item_name", "BOTTOMNAV");
//			info11.put("item_value", formmap.get("bottomColor"));
//			info11.put("shop_id", formmap.get("shop_id"));
//			info11.put("state", 0);
//			info11.put("item_desc", "自定义底部菜单背景颜色");
//			parameterMapper.insert(info11);
//		}

		pageNavMapper.removeButton(formmap); 
		if(formmap.getInt("bottom_count")>0){
			for (int i = 1; i <= formmap.getInt("bottom_count") ; i++) {
				if(!formmap.getStr("name"+i).equals("")){
					FormMap param=new FormMap();
					param.put("shop_id", formmap.get("shop_id"));  
					param.put("nav_name", formmap.getStr("name"+i));
					param.put("target_type", formmap.getStr("target"+i));
					param.put("target_id", formmap.getStr("targetId"+i));
					param.put("target_url", formmap.getStr("targetUrl"+i));
					param.put("state", formmap.getStr("state"+i)); 
					pageNavMapper.insertButton(param);
				}
			}
		}
		return 1;
	} 

	@Override
    public int removeButton(FormMap formmap){
		return pageNavMapper.removeButton(formmap);
	} 
}
