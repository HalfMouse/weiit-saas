package com.weiit.web.admin.publics.controller;


 
import java.util.List;
 







import javax.annotation.Resource; 

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody; 
import org.springframework.web.servlet.ModelAndView;
 







import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo; 
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap; 
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.common.AdminController;
import com.weiit.web.common.UIview;
 
/**
 * 公共服务控制器
 * @author hezhiying
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping("/publics/publics")
public class PublicsController  extends AdminController {
	
	public static Logger logger=Logger.getLogger(PublicsController.class);
	
	@Resource
	private PublicsService publicsService;
  
	/**
	 * 查询省市区域集合
	 */
	@ResponseBody
	@RequestMapping("/selectRegionList")
	public String selectRegionList() throws Exception {
		logger.info("进入 PublicsController-selectRegionList,查询省市区域集合");
		
		try {
	    	List<E> list=publicsService.selectRegionList(getFormMap());
	    	return toJsonAPI(list);
		} catch (Exception e) {
			e.printStackTrace();
			return toJsonAPI("","操作异常："+e.getMessage(),"-1");
		}
	}
	
}
