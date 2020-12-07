package com.weiit.web.admin.weixin.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.admin.weixin.service.WeixinPublicReplyService;
import com.weiit.web.base.AdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * 微信公众号自动回复控制器
 * @author bill.ouyang
 * qq:137075251 半个鼠标
 * email:google555@126.com
 * team:weiyunshidai.com
 */
@Controller
@RequestMapping("/weixin/weixinReply")
public class WeixinPublicReplyController extends AdminController { 
	@Resource
	private WeixinPublicReplyService publicReplyService;  
	
	/**
	 * grid页面展示
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public ModelAndView list() throws Exception { 
		//获取请求参数
    	FormMap formMap=getFormMap();
    	String type = formMap.getStr("action_type");
    	String page_list="";
    	if(type.equals("1")){
    		page_list="/center/weixin/weixin_public_reply_att";
    	}else if(type.equals("2")){ 
    		page_list="/center/weixin/weixin_public_reply";
    	}else{ 
    		formMap.set("action_type", 3);
    		page_list="/center/weixin/weixin_public_reply_keyword";
    	}
        //返回到list页面
        ModelAndView result = UIView(page_list,false);

		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
    		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
	    	//查询展示数量
	    	E e=publicReplyService.selectById(formMap);
	        //绑定分页返回
	        result.addObject("reply", e);
	        //绑定上一次参数
	        result.addObject("queryParam", formMap);
    	}else{
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	}
        return result;	 
	}
	
	@RequestMapping("updateState")
	public String updateState()throws Exception
	{
		FormMap param=getFormMap();
		try {
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
			param.set("authorizer_id", publicInfo.getStr("authorizer_id"));
	        if(param.get("reply_type_id")==null || param.getStr("reply_type_id").equals("")){
	        	publicReplyService.insertReplyType(param);
	        }else{	
	        	publicReplyService.editReplyType(param);
	        }
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:list?action_type="+param.getStr("action_type");
	}
	 
	/**
	 * 根据id查询
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("editReplyKey")
	public String editReplyKey() throws Exception {
		try {
			FormMap param=getFormMap();
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
			param.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			E e = publicReplyService.selectOne(param);
			return toJsonAPI(e);
		} catch (Exception e) {
			e.printStackTrace();
			return toJsonAPI("","出错误那"+e.getMessage(),"-1");
		}
	}
	
	/**
	 * 保存
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("save")
	public String save()throws Exception
	{
		FormMap param=getFormMap();
		try {
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
			param.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			
			String type = param.getStr("reply_type");
	    	if(type.equals("1")){
	    		param.set("reply_content",param.get("content22"));
	    	}else if(type.equals("2")){ 
	    		param.set("reply_content",param.get("content11"));
	    	}else{ 
	    		param.set("reply_content",param.get("content33"));
	    	}
	        if(param.get("reply_id")==null || param.getStr("reply_id").equals("")){
	        	publicReplyService.insert(param);
	        }else{	
	        	publicReplyService.edit(param); 
	        }
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:list?action_type="+param.getStr("action_type");
	}
	
 
	
	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("remove")
	public String remove() throws Exception {
		FormMap param=getFormMap();
		try {
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
			param.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			publicReplyService.remove(param);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return "redirect:list?action_type="+param.getStr("action_type");
	}
	
	/**
	 * 根据id查询
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("imageModal")
	public ModelAndView imageModal() throws Exception {  
        ModelAndView result = UIView("/center/weixin/imageModal",false);
        FormMap formMap=getFormMap();
        E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
		
		PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=publicReplyService.selectImage(formMap);
    	
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
		return result;
	}
	
	/**
	 * 根据id查询
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("imageTextModal")
	public ModelAndView imageTextModal() throws Exception {
		ModelAndView result = UIView("/center/weixin/imageTextModal",false);
        FormMap formMap=getFormMap();

		E publicInfo=(E)this.getSession().getAttribute("publicInfo");
		formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
		PageHelper.startPage(formMap.getPage(), 20);
    	List<E> list=publicReplyService.selectImageText(formMap);
    	
        result.addObject("pageInfo", new PageInfo<E>(list));
        result.addObject("queryParam", formMap);
		return result;
	}
	
}
