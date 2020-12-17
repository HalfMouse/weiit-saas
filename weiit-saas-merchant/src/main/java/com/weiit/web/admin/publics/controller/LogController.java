package com.weiit.web.admin.publics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.web.admin.publics.service.LogService;
import com.weiit.web.base.AdminController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * 日志管理控制器
 * @author hezhiying
 * @date 2017年8月15日 下午3:20:16
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/publics/log")
public class LogController extends AdminController{

	public static Logger logger=Logger.getLogger(PublicsController.class);
	
	@Resource
	private LogService logService;
 
	/**
	 * 日志管理查询 
	 */
    @RequestMapping("/list")
    public UIview list(ModelAndView view) {
    	logger.info("进入 LogController-list,日志管理查询 ");
    	
    	FormMap formMap=getFormMap();
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	List<E> list=logService.selectList(formMap);
    	UIview result = UIView("/center/publics/log",false);
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
        return result;
    }
 
}
