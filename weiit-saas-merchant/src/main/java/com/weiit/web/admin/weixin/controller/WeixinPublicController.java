package com.weiit.web.admin.weixin.controller;


import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.web.admin.miniprogram.service.WxMiniProgramService;
import com.weiit.web.admin.setting.service.SettingService;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.bean.result.WxOpenAuthorizerInfoResult;
import me.chanjar.weixin.open.bean.result.WxOpenQueryAuthResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/***
* @ClassName: WeixinPublicController 
* @Description: 微信公众号视图控制器
* @author lcm
* @date 2017年2月22日 下午1:57:14 
*
*/


@Controller
@RequestMapping("/weixin/public")
public class WeixinPublicController extends AdminController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Resource
	private WeixinPublicService weixinPublicService; 
	
	@Resource
    private WeixinOpenService wxOpenService;

	@Resource
    WxMiniProgramService wxMiniProgramService;

	@Resource
    SettingService settingService;

	@Resource
    RedisUtil redisUtil;

    @RequestMapping("/publicInfo")
    public UIview publicInfo() {
    	UIview result = UIView("/center/weixin/public",false);
    	FormMap formMap = getFormMap();
        Object publicInfo = redisUtil.get(String.format("introPage_%s_%s",formMap.getStr("shop_id"),"publicInfo"));
        if (publicInfo!=null){
            this.getSession().setAttribute("page_publicInfo","publicInfo");
        }

        return result;
    }
 
    @RequestMapping("/go_auth")
    public void gotoPreAuthUrl(HttpServletRequest request, HttpServletResponse response) throws WxErrorException{
        String host = request.getHeader("host");
        String url = "http://"+host+"/center/weixin/public/auth_result";
        try {
            url = wxOpenService.getInstance(null).getWxOpenComponentService().getPreAuthUrl(url);
            response.sendRedirect(url);
        } catch (IOException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e); 
        }
    }
    
    @RequestMapping("/auth_result")
    public UIview authResult(@RequestParam("auth_code") String authorizationCode){
    	UIview result =UIView("/center/weixin/public",false) ;
        try {
            WxOpenService service = wxOpenService.getInstance(null);

            WxOpenQueryAuthResult queryAuthResult = service.getWxOpenComponentService().getQueryAuth(authorizationCode);

            WxOpenAuthorizerInfoResult authInfo=service.getWxOpenComponentService().getAuthorizerInfo(queryAuthResult.getAuthorizationInfo().getAuthorizerAppid());

            Integer service_type_info = authInfo.getAuthorizerInfo().getServiceTypeInfo();

            if (service_type_info.intValue()!=2){
                result.addObject("error","您授权的不是公众号");
                return result;
            }
            //查询是否存在其他的公众号已经绑定
            FormMap formMap=getFormMap();
            FormMap selectMap = new FormMap();
            selectMap.put("authorizer_app_id",authInfo.getAuthorizationInfo().getAuthorizerAppid());
            selectMap.put("shop_id",formMap.getStr("shop_id"));
            E selectPubliInfo = wxOpenService.selectWxPublicInfoAndShopInfo(selectMap);
            if (selectPubliInfo!=null){
                result.addObject("error", String.format("%s已经绑定过该%s",selectPubliInfo.getStr("shop_name"),getAppDesc(service_type_info)));
                return result;
            }



            //查询是否已经存在该公众号设置，如果存在，则更新授权，如果不存在，则新增

            formMap.set("authorizer_app_id", authInfo.getAuthorizationInfo().getAuthorizerAppid());
            formMap.set("authorizer_fresh_token", authInfo.getAuthorizationInfo().getAuthorizerRefreshToken());
			formMap.set("alias", authInfo.getAuthorizerInfo().getAlias());
			formMap.set("head_img", authInfo.getAuthorizerInfo().getHeadImg());
			formMap.set("nick_name", authInfo.getAuthorizerInfo().getNickName());
			formMap.set("principal_name", authInfo.getAuthorizerInfo().getPrincipalName());
			formMap.set("qrcode_url", authInfo.getAuthorizerInfo().getQrcodeUrl());
			formMap.set("service_type_info", service_type_info.toString());
			formMap.set("signature", authInfo.getAuthorizerInfo().getSignature());
			formMap.set("user_name", authInfo.getAuthorizerInfo().getUserName());

            E publicInfo=weixinPublicService.selectOne(formMap);



            FormMap param=new FormMap();




        	param.set("service_type_info", service_type_info.toString());
        	param.set("shop_id", formMap.getStr("shop_id"));
        	
            if(publicInfo!=null){
            	weixinPublicService.edit(formMap);
            	result.addObject("info", "恭喜您，更新授权成功！");
            }else{
            	E oldPublicInfo=weixinPublicService.selectOne(param);
            	if(oldPublicInfo==null){//不存在则新增
            		weixinPublicService.insert(formMap);
            		result.addObject("info", "恭喜您，授权成功！");
                    formMap.put("shop_domain_prex",authInfo.getAuthorizationInfo().getAuthorizerAppid());
                    settingService.editShopSomeInfo(formMap);
            	}else{//如果存在，则告诉商户说已经绑定了，不能更换公众号。
            		result.addObject("info", String.format("您已经绑定过%s，不可以再绑定其他的%s！",getAppDesc(service_type_info),getAppDesc(service_type_info)));
            	}
            	
            }
            //修改或者新增后，重新查询一下公众号信息
            publicInfo=weixinPublicService.selectOne(param);

                this.getSession().setAttribute("publicInfo", publicInfo);


           // this.getSession().setAttribute("publicInfo", publicInfo);//更新过授权，都需要重新更换session中的缓存publicInfo
            logger.info("authInfo",authInfo);
            logger.info("getQueryAuth", queryAuthResult);
            
            return result;
        } catch (WxErrorException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }


    public String  getAppDesc(Integer index){
        String [] desc ={"小程序","","公众号"};
        return desc[index];
    }
    
 
}
