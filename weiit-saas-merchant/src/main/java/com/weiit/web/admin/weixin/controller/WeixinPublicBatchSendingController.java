package com.weiit.web.admin.weixin.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap; 
import com.weiit.web.admin.user.service.UserSignService;
import com.weiit.web.admin.weixin.service.WeixinMediaImagesService;
import com.weiit.web.admin.weixin.service.WeixinMediaArticleService;
import com.weiit.web.admin.weixin.service.WeixinPublicBatchSendingService;
import com.weiit.web.admin.weixin.service.WeixinPublicReplyService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.weixinopen.service.WeixinOpenService;

import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.WxMpMassOpenIdsMessage; 
import me.chanjar.weixin.mp.bean.result.WxMpMassSendResult;
import me.chanjar.weixin.open.api.WxOpenConfigStorage;
import me.chanjar.weixin.open.api.WxOpenService; 

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @项目名称: org.weiyun.plugin.weixin.controller 
 * @类名: WeixinPublicBatchSendingController 
 * @类描述: 微信群发功能控制器 
 * @创建人: hzy
 * @date 2018年6月23日 下午4:48:15 
 * @version V1.0
 */
@Controller
@RequestMapping("/weixin/batchSending")
public class WeixinPublicBatchSendingController extends AdminController {   
	@Resource
	private WeixinPublicBatchSendingService publicBatchSendingService;	
	@Resource
	private UserSignService userSignService;
	@Resource
	private WeixinOpenService weixinOpenService; 
	
	/**
	 *群发消息 页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public ModelAndView list() throws Exception {
		//获取请求参数
    	FormMap formMap=getFormMap(); 
    	
		String page_list="/center/weixin/weixin_public_batchSending";
    	String type = formMap.getStr("type");
    	if(type.equals("1")){
    		page_list="/center/weixin/weixin_public_batchSended";
    	}
		ModelAndView result = UIView(page_list,false);
		
    	E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	if(publicInfo!=null){
	    	formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
	
			List<E> signList=userSignService.selectList(formMap);
			if(type.equals("1")){
	        	PageHelper.startPage(formMap.getPage(), formMap.getRows());
	        	List<E> list = publicBatchSendingService.selectList(formMap); 
	            //绑定分页返回
	        	result.addObject("pageInfo", new PageInfo<E>(list));
	    	}
	        result.addObject("signList", signList);
    	}else{
    		if(type.equals("1")){
	        	result.addObject("pageInfo", new PageInfo<E>(new ArrayList()));
	    	}
    		result.addObject("info", "对不起，公众号还没有绑定授权，请先绑定授权。");
    	} //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;
	}
	 
	/**
	 *群发消息  发送
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doBatchSending")
	public UIview doBatchSending() throws Exception {
		UIview result = UIView("list",true); 
		try {
			FormMap formMap=getFormMap(); 
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
			formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			
			String type = formMap.getStr("action_type");
	    	if(type.equals("1")){
	    		formMap.set("send_content",formMap.get("content22"));
	    	}else if(type.equals("2")){ 
	    		formMap.set("send_content",formMap.get("content11"));
	    	}else{ 
	    		formMap.set("send_content",formMap.get("content33"));
	    	}
	    	//拼接群发用户的精准条件
	    	String tag="";
	    	if(formMap.getStr("group_type").equals("1") && !formMap.getStr("sign_name").equals("")){
	    		tag="用户标签："+formMap.getStr("sign_name")+";";
	    	}else{
	    		tag="全部用户;";
	    		formMap.set("sign_id","");
	    	}
	    	if(formMap.getStr("sex").equals("1")){
	    		tag=tag+"性别：男;";
	    	}else if(formMap.getStr("sex").equals("2")){
	    		tag=tag+"性别：女;";
	    	}
	    	if(!formMap.getStr("region_name").equals("全部")){
	    		tag=tag+"地区："+formMap.getStr("region_name");
	    		if(!formMap.getStr("province_name").equals("全部")){
	    			tag=tag+"-"+formMap.getStr("province_name");
	    			if(!formMap.getStr("city_name").equals("全部")){
		    			tag=tag+"-"+formMap.getStr("city_name");
		    		}
	    		}
	    	}else{
	    		formMap.set("region_name","");
	    	}
	    	formMap.set("group_tag", tag);
	    	
	    	//查询满足条件的群发用户
	    	List<E> usersList = publicBatchSendingService.selectUsersList(formMap);
	    	
	    	if(usersList!=null && usersList.size()>1){ 
				if(formMap.getStr("time_type").equals("1")){
		    		Date date=new Date();
		    		if(formMap.getStr("day").equals("2")){ 
		    			date=DateUtils.addDays(date, 1);
		    			date=DateUtils.setHours(date, formMap.getInt("time"));
		    			date=DateUtils.setMinutes(date, formMap.getInt("minute"));
		    		}else{
		    			date=DateUtils.setHours(date, formMap.getInt("time"));
		    			date=DateUtils.setMinutes(date, formMap.getInt("minute"));
		    		}
		    		formMap.set("send_time", date);
		    		formMap.set("state", 0);
				}else{
		    		formMap.set("send_time", new Date());
		    		formMap.set("state", 1); 
		    	}
				publicBatchSendingService.addPublicBatchSendingLog(formMap);//新增一条群发记录	
	    		
	    		ArrayList list = new ArrayList();
		    	List sendingList = new ArrayList(); 
		    	for (E users : usersList) {
		    		Map<String,String> batchSendingUsersLogMap = new HashMap<String,String>();
		    		batchSendingUsersLogMap.put("authorizer_id", publicInfo.getStr("authorizer_id"));
		    		batchSendingUsersLogMap.put("reason", "");
		    		batchSendingUsersLogMap.put("record_id", formMap.getStr("record_id"));
		    		batchSendingUsersLogMap.put("user_id", users.getStr("user_id"));
		    		if(formMap.getStr("time_type").equals("1")){
		    			batchSendingUsersLogMap.put("state", "1");
		    		}else{
		    			batchSendingUsersLogMap.put("state", "0");
		    		}
		    		sendingList.add(batchSendingUsersLogMap);
	        		list.add(users.get("wx_open_id"));
		    	}
		    	//批量保存群发用户记录
		    	publicBatchSendingService.addPublicBatchSendingUsersLog(sendingList);
		    	
			    if(!formMap.getStr("time_type").equals("1")){	
			    	//获取微信sdk的service
					formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

					WxOpenService openService = weixinOpenService.getInstance(formMap);
			    	WxMpService wxMpService=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id"));
			    	try {
			    		WxMpMassOpenIdsMessage massMessage = new WxMpMassOpenIdsMessage();
			    			massMessage.getToUsers().addAll(list); 
			    		if(type.equals("1")){
				    		massMessage.setMsgType(WxConsts.MassMsgType.TEXT);
				    		massMessage.setContent(formMap.getStr("content22")); 
				    	}else if(type.equals("2")){  
				    		massMessage.setMsgType(WxConsts.MassMsgType.MPNEWS);
				    		massMessage.setMediaId(formMap.getStr("content11"));
				    		massMessage.getToUsers().addAll(list); 
				    	}else if(type.equals("3")){  
				    		massMessage.setMsgType(WxConsts.MassMsgType.IMAGE);
				    		massMessage.setMediaId(formMap.getStr("content33"));
				    	}
			    		WxMpMassSendResult massResult = wxMpService.getMassMessageService().massOpenIdsMessageSend(massMessage);
			    		if(massResult==null || massResult.getMsgId()==null  || massResult.getMsgId().equals("")){//成功的
			    			formMap.set("state", -1);
			    			formMap.set("reason", massResult.getErrorMsg());
	            		}else{
	            			formMap.set("state", 0);
			    			formMap.set("reason", massResult.getMsgId());
	            		}
			    		//回写群发结果
	            		publicBatchSendingService.updatePublicBatchSendingUsersLog(formMap);
						result.addPNotifyMessage("消息群发成功！");
					} catch (Exception e) {
						formMap.set("state", -1);
						formMap.set("reason", e.getMessage());
		        		publicBatchSendingService.updatePublicBatchSendingUsersLog(formMap);
						result.addPNotifyMessage("消息群发完成，但微信端推送失败！");
					}
			    }else{
					result.addErrorMessage("定时消息群发保存成功！");
		    	}
	    	}else{
	    		result.addErrorMessage("消息群发失败，群发用户必须大于等于2位！");
	    	}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return result;
	}
	
	/**
	 *群发消息  重新发送 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("immediatelySending")
	public UIview immediatelySending() throws Exception {
		UIview result = UIView("list?type=1",true); 
		try {
			FormMap formMap=getFormMap(); 
			E publicInfo=(E)this.getSession().getAttribute("publicInfo");
			formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
			 
			String type = formMap.getStr("action_type");
			E sendMap=publicBatchSendingService.selectOne(formMap);
	    	
	    	//查询满足条件的群发用户
	    	List<E> usersList = publicBatchSendingService.selectBatchSendingUsersLogList(formMap);
	    	
	    	if(usersList!=null && usersList.size()>1){  
				publicBatchSendingService.edit(formMap);//新增一条群发记录	
	    		
	    		ArrayList list = new ArrayList(); 
		    	for (E users : usersList) {
	        		list.add(users.get("wx_open_id"));
		    	}
		    	//获取微信sdk的service
				formMap.put("appid",publicInfo.getStr("authorizer_app_id"));

				WxOpenService openService = weixinOpenService.getInstance(formMap);
		    	WxMpService wxMpService=openService.getWxOpenComponentService().getWxMpServiceByAppid(publicInfo.getStr("authorizer_app_id"));
		    	try {
		    		WxMpMassOpenIdsMessage massMessage = new WxMpMassOpenIdsMessage();
	    				massMessage.getToUsers().addAll(list); 
		    		if(type.equals("1")){
			    		massMessage.setMsgType(WxConsts.MassMsgType.TEXT);
			    		massMessage.setContent(sendMap.getStr("send_content")); 
			    	}else if(type.equals("2")){  
			    		massMessage.setMsgType(WxConsts.MassMsgType.MPNEWS);
			    		massMessage.setMediaId(sendMap.getStr("send_content"));
			    		massMessage.getToUsers().addAll(list); 
			    	}else if(type.equals("3")){  
			    		massMessage.setMsgType(WxConsts.MassMsgType.IMAGE);
			    		massMessage.setMediaId(sendMap.getStr("send_content"));
			    	}
		    		WxMpMassSendResult massResult = wxMpService.getMassMessageService().massOpenIdsMessageSend(massMessage);
		    		if(massResult==null || massResult.getMsgId()==null  || massResult.getMsgId().equals("")){//成功的
		    			formMap.set("state", -1);
		    			formMap.set("reason", massResult.getErrorMsg());
	        		}else{
	        			formMap.set("state", 0);
		    			formMap.set("reason", massResult.getMsgId());
	        		}
		    		//回写群发结果
	        		publicBatchSendingService.updatePublicBatchSendingUsersLog(formMap);
					result.addPNotifyMessage("消息群发成功！");
				} catch (Exception e) {
					formMap.set("state", -1);
	    			formMap.set("reason", e.getMessage());
	        		publicBatchSendingService.updatePublicBatchSendingUsersLog(formMap);
					result.addPNotifyMessage("消息群发完成，但微信端推送失败！");
				}
	    	}else{
	    		result.addErrorMessage("消息群发失败，群发用户必须大于等于2位！");
	    	}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("出错啦...");
		}
		return result;
	}
	
    /**
     * 删除
     */
    @RequestMapping("/remove")
    public UIview remove() throws Exception {
    	UIview result = UIView("list?type=1",true);
        try {
            FormMap formMap=getFormMap();
        	E publicInfo=(E)this.getSession().getAttribute("publicInfo");
        	formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
            publicBatchSendingService.remove(formMap);
            result.addErrorMessage("群发消息删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        return result;
    }


	/**
	 * 群发消息用户记录
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("batchSendingUsersLog")
	public ModelAndView batchSendingUsersLog() throws Exception {
		//获取请求参数
    	FormMap formMap=getFormMap(true);
    	E publicInfo=(E)this.getSession().getAttribute("publicInfo");
    	formMap.set("authorizer_id", publicInfo.getStr("authorizer_id"));
    	//开启分页
    	PageHelper.startPage(formMap.getPage(), formMap.getRows());
    	//查询展示数量
    	List<E> list=publicBatchSendingService.selectBatchSendingUsersLogList(formMap); 
 
        //返回到list页面
        ModelAndView result = UIView("/center/weixin/weixin_public_batchSendingUsersLog",false);
        //绑定分页返回
        result.addObject("pageInfo", new PageInfo<E>(list));
        //绑定上一次参数
        result.addObject("queryParam", formMap);
        return result;	
	}


}
