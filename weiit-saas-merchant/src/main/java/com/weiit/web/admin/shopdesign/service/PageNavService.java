package com.weiit.web.admin.shopdesign.service;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.service.BaseService;

import java.util.List;


/** 
 * Title: CustomUserServiceImpl.java
 * Description: 装修，会员主页
 * Company: 微邦互联 
 * @author hzy
 * @date 2017年12月7日
 */
public interface PageNavService extends BaseService {
	 
		public int editState(FormMap formmap);
		
	    public List<E> selectItemList(FormMap formmap);
	    
		public int insertItem(FormMap formmap);

	    public int removeItem(FormMap formmap);
	    
	    public List<E> selectButtonList(FormMap formmap);

	    public List<E> navIconList(FormMap formmap);

	    public void saveNav(FormMap formmap);

	    public List<E> navInfo(FormMap formmap);

	    public List<E> navOptionalUrl(FormMap formmap);

		public int insertButton(FormMap formmap);

	    public int removeButton(FormMap formmap);

}

