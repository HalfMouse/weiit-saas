package com.weiit.web.admin.login.controller;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.login.service.LoginService;
import com.weiit.web.base.AdminController;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * 相关静态页面控制器
 * @author 半个鼠标
 * @date：2017年2月14日 上午2:01:43
 * @version 1.0
 * @company http://www.wei-it.com
 */
@Controller
public class PageController extends AdminController{
	 
	
	@Resource
	private LoginService loginService;
	
    /**
     * 服务中心后台登录视图
     */
    @RequestMapping("/login")
    public String login() {
    	 Subject subject = SecurityUtils.getSubject();
         // 已登陆则 跳到首页
         if (subject.isAuthenticated()) {
         	 return "redirect:/" ;
         }else{
        	 return "/center/login";
         }
    }
    
    /**
     * 注册页面
     * @return
     */
    @RequestMapping("/register")
    public String loginInit() {
    	return "/center/register";
    }
    
    /**
     * 后台主页
     * @param
     * @return
     */
    @RequestMapping("/index")
    public String index() {
    	if(this.getSession().getAttribute("merchant")!=null){//刷新商户信息
    		E merchant=(E)this.getSession().getAttribute("merchant");
    		FormMap param=new FormMap();
    		param.set("mrch_id", merchant.getStr("mrch_id"));
    		merchant=loginService.selectByMrchId(param);
    		this.getSession().setAttribute("merchant", merchant);
    	}
    	
        return "/center/index";
    }


    /**
     * 后台布局-左视图
     */
    @RequestMapping("/left")
    public String left() {
        return "/center/left";
    }
    
    /**
     * 后台布局-右视图
     */
    @RequestMapping("/right")
    public String right() {
        return "/center/right";
    }
    
    /**
     * 后台布局-顶部视图
     */
    @RequestMapping("/top")
    public String top() {
        return "/center/top";
    }
    
    /**
     * 后台欢迎视图
     */
    @RequestMapping(value="/welcomePage")
    public String welcomePage(){
    	return "/center/welcome";
    }
    
    /**
     * 控制面板视图
     */
    @RequestMapping("/dashboard")
    public String dashboard() {
        return "/center/dashboard";
    }
    
    /**
     * 404视图
     */
    @RequestMapping("/404")
    public String error404() {
        return "/center/404";
    }

    /**
     * 500视图
     */
    @RequestMapping("/500")
    public String error500() {
        return "/center/500";
    }

   
}