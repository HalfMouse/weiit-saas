package com.weiit.web.admin.miniprogram.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaDomainAction;
import cn.binarywang.wx.miniapp.bean.code.WxMaCategory;
import cn.binarywang.wx.miniapp.bean.code.WxMaCodeAuditStatus;
import cn.binarywang.wx.miniapp.bean.code.WxMaCodeSubmitAuditRequest;
import cn.binarywang.wx.miniapp.util.json.WxMaGsonBuilder;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.miniprogram.service.WxMiniProgramService;
import com.weiit.web.admin.setting.service.SettingService;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.base.AdminController;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.open.api.WxOpenService;
import me.chanjar.weixin.open.bean.result.WxOpenAuthorizerInfoResult;
import me.chanjar.weixin.open.bean.result.WxOpenQueryAuthResult;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by 罗鸿强 on 2018/7/12.
 */

@Controller
@RequestMapping("/miniprogram")
public class WeixinMiniAppCodeController extends AdminController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    WeixinOpenService weixinOpenService;

    @Resource
    WeixinPublicService weixinPublicService;

    @Resource
    WxMiniProgramService wxMiniProgramService;

    @Resource
    SettingService settingService;

    @Resource
    RedisUtil redisUtil;



    @RequestMapping("/go_auth")
    public void gotoPreAuthUrl(HttpServletRequest request, HttpServletResponse response) throws WxErrorException{
        String host = request.getHeader("host");
        String url = "http://"+host+"/center/miniprogram/auth_result";
        try {
            url = weixinOpenService.getInstance(null).getWxOpenComponentService().getPreAuthUrl(url);
            response.sendRedirect(url);
        } catch (IOException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }


    @RequestMapping("/auth_result")
    public UIview authResult(@RequestParam("auth_code") String authorizationCode){
        UIview result = UIView("/center/miniprogram/public",false);
        try {
            WxOpenService service = weixinOpenService.getInstance(null);

            WxOpenQueryAuthResult queryAuthResult = service.getWxOpenComponentService().getQueryAuth(authorizationCode);

            WxOpenAuthorizerInfoResult authInfo=service.getWxOpenComponentService().getAuthorizerInfo(queryAuthResult.getAuthorizationInfo().getAuthorizerAppid());

            Integer service_type_info = authInfo.getAuthorizerInfo().getServiceTypeInfo();

            if (service_type_info.intValue()!=0){
                result.addObject("error","您授权的不是小程序");
                return result;
            }

            //查询是否存在其他的公众号已经绑定
            FormMap selectMap = new FormMap();
            FormMap formMap=getFormMap();
            selectMap.put("authorizer_app_id",authInfo.getAuthorizationInfo().getAuthorizerAppid());
            selectMap.put("shop_id",formMap.getStr("shop_id"));
            E selectPubliInfo = weixinOpenService.selectWxPublicInfoAndShopInfo(selectMap);
            if (selectPubliInfo!=null){
                result.addObject("error", String.format("%s已经绑定过该",selectPubliInfo.getStr("shop_name")));
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
            //查询是否存在其他的公众号已经绑定
            param.set("service_type_info", service_type_info.toString());
            param.set("shop_id", formMap.getStr("shop_id"));

            if(publicInfo!=null){
                weixinPublicService.edit(formMap);
                result.addObject("info", "恭喜您，更新授权成功！");
//                wxMiniProgramService.uploadMiniCode(formMap,true,true);
            }else{
                E oldPublicInfo=weixinPublicService.selectOne(param);
                //不存在则新增
                if(oldPublicInfo==null){
                 weixinPublicService.insert(formMap);
                 result.addObject("info", "恭喜您，授权成功！");
                 E res = wxMiniProgramService.uploadMiniCode(formMap,true,true);
//                 if (!StringUtils.equals(res.getStr("meg"),"ok")){
//                     result.addObject("error",res.getStr("meg"));
//                     return result;
//                 }
                }else{//如果存在，则告诉商户说已经绑定了，不能更换公众号。
                    result.addObject("error","您已经绑定过小程序，不可以再绑定其他的");
                }
            }
            //修改或者新增后，重新查询一下公众号信息
            publicInfo=weixinPublicService.selectOne(param);

            this.getSession().setAttribute("miniPublicInfo", publicInfo);


            logger.info("authInfo {}",authInfo);
            logger.info("getQueryAuth {}",queryAuthResult);
            return result;
        } catch (WxErrorException e) {
            logger.error("gotoPreAuthUrl", e);
            throw new RuntimeException(e);
        }
    }


    @RequestMapping("/miniPublicInfo")
    public UIview publicInfo() {
        UIview result = UIView("/center/miniprogram/public", false);
        FormMap formMap = getFormMap();
        Object publicInfo = redisUtil.get(String.format("introPage_%s_%s",formMap.getStr("shop_id"),"miniPublicInfo"));
        if (publicInfo!=null){
            this.getSession().setAttribute("page_miniPublicInfo","miniPublicInfo");
        }
        return result;
    }


    /**
     * 引导页
     *
     * */
    @RequestMapping("/introPage")
    public UIview introPage() {
        UIview result = UIView("/center/miniprogram/introPage", false);
        FormMap formMap = getFormMap();

        //查询引导页列表
        PageHelper.startPage(formMap.getPage(),formMap.getRows());
        List<E> list = weixinPublicService.selectIntroPageList(formMap);
        result.addObject("pageInfo",new PageInfo<E>(list));
        return result;
    }


    /**
     * 删除引导页
     *
     * */
    @RequestMapping("/introRemove")
    public UIview introRemove() {
        FormMap formMap = getFormMap();
        UIview result = UIView("introPage", true);
        weixinPublicService.introRemove(formMap);
        return result;
    }

    /**
     * 设置默认引导页
     *
     * */
    @RequestMapping("/introDefault")
    public UIview introDefault() {
        FormMap formMap = getFormMap();
        UIview result = UIView("introPage", true);

        weixinPublicService.introDefault(formMap);
        return result;
    }

    @RequestMapping("/introSave")
    public UIview introSave() {
        FormMap formMap = getFormMap();
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartHttpRequest = (MultipartHttpServletRequest)this.getRequest();
            //获得文件
            MultipartFile mFile=multipartHttpRequest.getFile("file_logo");
            //如果logo  更换
            if(!mFile.isEmpty()) {
                String pictureName=WeiitUtil.uploadFile(mFile);
                formMap.put("intro_page_url",pictureName);
            }

        }catch (Exception e){
            e.printStackTrace();
        }

        //保存
        weixinPublicService.introSave(formMap);

        UIview result = UIView("introPage", true);

        return result;
    }

    @RequestMapping("/newIntroModal")
    public UIview newIntroModal() {
        UIview result = UIView("/center/miniprogram/newIntroModal", false);
        return result;
    }


    @RequestMapping("/publishInfo")
    public UIview publishInfo(HttpServletResponse response) {
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        if (miniPublicInfo == null) {
            UIview result = UIView("/center/miniprogram/public", false);
            return result;
        }
        formMap.putAll(miniPublicInfo);

        UIview result = UIView("/center/miniprogram/publishInfo", false);

        //获取体验者列表
        List<E> testUserList = wxMiniProgramService.selectTestUserList(formMap);
        result.addObject("testUserList", testUserList);

        //获取当前版本信息
        E currentAuthInfo = wxMiniProgramService.selectMiniCurrentAuthInfo(formMap);

        result.addObject("currentAuthInfo", currentAuthInfo);


        return result;
    }


    /**
     * 85001	微信号不存在或微信号设置为不可搜索
     * 85002	小程序绑定的体验者数量达到上限
     * 85003	微信号绑定的小程序体验者达到上限
     * 85004	微信号已经绑定
     */

    //添加体验者
    @RequestMapping("addTestUser")
    public UIview addTestUser() {
        UIview result = UIView("publishInfo", true);
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);
        String msg = wxMiniProgramService.bindTester(formMap);
        if(msg!=null){
            if (msg.indexOf("成功") != -1) {
                result.addPNotifyMessage(msg);
            } else {
                result.addErrorMessage(msg);
            }
        }
        return result;


    }

    /**
     *
     *
     * */
    //删除体验者
    @RequestMapping("delTestUser")
    public UIview delTestUser() {
        UIview result = UIView("publishInfo", true);
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);
        String res = wxMiniProgramService.unbindTester(formMap);
        result.addErrorMessage(res);
        return result;
    }


    /**
     * 发布小程序
     * <p>
     * 1、设置小程序服务器域名
     * 授权给第三方的小程序，其服务器域名只可以为第三方的服务器，当小程序通过第三方发布代码上线后，小程序原先自己配置的服务器域名将被删除，
     * 只保留第三方平台的域名，所以第三方平台在代替小程序发布代码之前，需要调用接口为小程序添加第三方自身的域名。
     * 提示：需要先将域名登记到第三方平台的小程序服务器域名中，才可以调用接口进行配置。请求方式: POST（请使用https协议） https://api.weixin.qq.com/wxa/modify_domain?access_token=TOKEN
     * <p>
     * access_token	请使用第三方平台获取到的该小程序授权的authorizer_access_token
     * action	add添加, delete删除, set覆盖, get获取。当参数是get时不需要填四个域名字段
     * requestdomain	request合法域名，当action参数是get时不需要此字段
     * wsrequestdomain	socket合法域名，当action参数是get时不需要此字段
     * uploaddomain	uploadFile合法域名，当action参数是get时不需要此字段
     * downloaddomain	downloadFile合法域名，当action参数是get时不需要此字段
     * <p>
     * 、设置小程序业务域名（仅供第三方代小程序调用）  授权给第三方的小程序，其业务域名只可以为第三方的服务器，当小程序通过第三方发布代码上线后，
     * 小程序原先自己配置的业务域名将被删除，只保留第三方平台的域名，所以第三方平台在代替小程序发布代码之前，需要调用接口为小程序添加业务域名。
     * 请求方式: POST（请使用https协议）
     * https://api.weixin.qq.com/wxa/setwebviewdomain?access_token=TOKEN
     */

    //、设置小程序服务器域名
    @RequestMapping("modifyDomain")
    @ResponseBody
    public void modifyDomain() {
        logger.info("WeixinMiniAppCodeController-modifyDomain,【设置小程序服务器域名】");
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);
        wxMiniProgramService.modifyDomain(formMap);
    }


    /**
     * 授权给第三方的小程序，其业务域名只可以为第三方的服务器，当小程序通过第三方发布代码上线后，小程序原先自己配置的业务域名将被删除，只保留第三方平台的域名，所以第三方平台在代替小程序发布代码之前，需要调用接口为小程序添加业务域名。
     * 提示：
     * 1、需要先将域名登记到第三方平台的小程序业务域名中，才可以调用接口进行配置。
     * 2、为授权的小程序配置域名时支持配置子域名，例如第三方登记的业务域名如为qq.com，则可以直接将qq.com及其子域名（如xxx.qq.com）也配置到授权的小程序中。
     * <p>
     * 请求方式: POST（请使用https协议）
     * https://api.weixin.qq.com/wxa/setwebviewdomain?access_token=TOKEN
     * <p>
     * 参数	说明
     * access_token	            请使用第三方平台获取到的该小程序授权的authorizer_access_token
     * action	                    add添加, delete删除, set覆盖, get获取。当参数是get时不需要填webviewdomain字段。如果没有action字段参数，则默认将开放平台第三方登记的小程序业务域名全部添加到授权的小程序中
     * webviewdomain	            小程序业务域名，当action参数是get时不需要此字段
     */

    //设置小程序业务域名（仅供第三方代小程序调用）
    @RequestMapping("setWebViewDomain")
    @ResponseBody
    public void setWebViewDomain() {
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);
        wxMiniProgramService.setWebViewDomain(formMap);
    }


    //上传代码并提交
    @RequestMapping("/uploadMiniCode")
    @ResponseBody
    public String uploadMiniCode() {
        logger.info("WeixinMiniAppCodeController-publishMiniApp,【上传代码】");
        E miniPublicInfo = (E) getSession().getAttribute("miniPublicInfo");

        if (miniPublicInfo != null) {
            FormMap formMap = new FormMap();
            formMap.putAll(miniPublicInfo);
            wxMiniProgramService.uploadMiniCode(formMap, true,true);
        }
        return "success";
    }


    /**
     *  上传代码
     * 修改域名
     * */
    @RequestMapping("/uploadMiniCodeNoSubmit")
    @ResponseBody
    public String uploadMiniCodeNoSubmit() {
        logger.info("WeixinMiniAppCodeController-uploadMiniCodeNoSubmit,【上传代码】");
        E miniPublicInfo = (E) getSession().getAttribute("miniPublicInfo");

        if (miniPublicInfo != null) {
            FormMap formMap = new FormMap();
            formMap.putAll(miniPublicInfo);
            wxMiniProgramService.uploadMiniCode(formMap, false,true);
        }
        return "success";
    }

    /**
     * status	审核状态，其中0为审核成功，1为审核失败，2为审核中
     * reason	当status=1，审核被拒绝时，返回的拒绝原因
     *
     * 小程序体验二维码
     */
    @RequestMapping("/getQrcode")
    @ResponseBody
    public String getQrcode() {
        logger.info("WeixinMiniAppCodeController-getQrcode,【小程序体验二维码】");

        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);
        return wxMiniProgramService.getQrcode(formMap);
    }


    //获取授权小程序帐号的可选类目
    @RequestMapping("get_category")
    @ResponseBody
    public String get_category() {
        logger.info("WeixinMiniAppCodeController-getQrcode,【获取授权小程序帐号的可选类目】");
        FormMap formMap = new FormMap();
        formMap.put("appid", "wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");
        try {
            wxMaService.getCodeService().getCategory();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    //获取小程序的第三方提交代码的页面配置
    @RequestMapping(value = "get_page", method = RequestMethod.POST)
    @ResponseBody
    public String get_page() {
        logger.info("WeixinMiniAppCodeController-get_page,【获取小程序的第三方提交代码的页面配置】");

        FormMap formMap = new FormMap();
        formMap.put("appid", "wxdde6d44348f138ca");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");
        try {
            List<String> list = wxMaService.getCodeService().getPage();
            return list.toString();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    /**
     * access_token	请使用第三方平台获取到的该小程序授权的authorizer_access_token
     * item_list	提交审核项的一个列表（至少填写1项，至多填写5项）
     * address	小程序的页面，可通过“获取小程序的第三方提交代码的页面配置”接口获得
     * tag	小程序的标签，多个标签用空格分隔，标签不能多于10个，标签长度不超过20
     * first_class	一级类目名称，可通过“获取授权小程序帐号的可选类目”接口获得
     * second_class	二级类目(同上)
     * third_class	三级类目(同上)
     * first_id	一级类目的ID，可通过“获取授权小程序帐号的可选类目”接口获得
     * second_id	二级类目的ID(同上)
     * third_id	三级类目的ID(同上)
     * title	小程序页面的标题,标题长度不超过32
     */

    //将第三方提交的代码包提交审核
    @RequestMapping("submit_audit")
    @ResponseBody
    public String submit_audit() {
        logger.info("WeixinMiniAppCodeController-submit_audit,【将第三方提交的代码包提交审核】");
        FormMap formMap = new FormMap();
        formMap.put("appid", "wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");


//        get_category();  获取可配的分类目录

        WxMaCategory wxMaCategory = WxMaCategory.builder().firstClass("商家自营").address("pages/index/index").tag("食品").title("首页")
                .firstId(304L)
                .secondClass("食品")
                .secondId(321L).build();

        List<WxMaCategory> list = new ArrayList();
        list.add(wxMaCategory);

        WxMaCodeSubmitAuditRequest wxMaCodeSubmitAuditRequest = WxMaCodeSubmitAuditRequest.builder().itemList(list).build();

        try {
            long auditid = wxMaService.getCodeService().submitAudit(wxMaCodeSubmitAuditRequest);
            System.out.printf("" + auditid);
            return auditid + "";
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    //查询某个指定版本的审核状态
    @RequestMapping("getAuthStatus")
    @ResponseBody
    public String getAuthStatus() {
        logger.info("WeixinMiniAppCodeController-getAuthStatus,【查询某个指定版本的审核状态】");

        FormMap formMap = new FormMap();
        formMap.put("appid", "wx32b0e9cfa1917943");

        WxMaService wxMaService = weixinOpenService.getOpenConfig().getWxOpenComponentService().getWxMaServiceByAppid("wx32b0e9cfa1917943");

        try {
            Long auditId = 483473478L;
            WxMaCodeAuditStatus wxMaCodeAuditStatus = wxMaService.getCodeService().getAuditStatus(auditId);
            return wxMaCodeAuditStatus.toString();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }

        return "";
    }


    /**
     * 查询最新一次提交的审核状态
     * 返回参数说明：
     * 参数	说明
     * auditid	最新的审核ID
     * status	审核状态，其中0为审核成功，1为审核失败，2为审核中
     * reason	当status=1，审核被拒绝时，返回的拒绝原因
     */
    @RequestMapping("get_latest_auditstatus")
    @ResponseBody
    public String get_latest_auditstatus() {
        logger.info("WeixinMiniAppCodeController-get_latest_auditstatus,【查询最新一次提交的审核状态】");

        FormMap formMap = new FormMap();
        formMap.put("appid", "wx32b0e9cfa1917943");

        WxMaService wxMaService = weixinOpenService.getOpenConfig().getWxOpenComponentService().getWxMaServiceByAppid("wx32b0e9cfa1917943");
        try {
            WxMaCodeAuditStatus wxMaCodeAuditStatus = wxMaService.getCodeService().getLatestAuditStatus();
            return wxMaCodeAuditStatus.toString();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }

    public static void main(String[] args) throws Exception {
        System.out.println(WeiitUtil.getLogistics("YUNDA","3922010766623"));
    }


    //发布已通过审核的小程序
    @RequestMapping("release")
    @ResponseBody
    public String release() {
        logger.info("WeixinMiniAppCodeController-release,【发布已通过审核的小程序】");

        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);

        wxMiniProgramService.release(formMap);
        return "success";
    }

    //修改小程序线上代码的可见状态
    @RequestMapping("change_visitstatus")
    @ResponseBody
    public String change_visitstatus() {
        logger.info("WeixinMiniAppCodeController-change_visitstatus,【修改小程序线上代码的可见状态】");
        FormMap formMap = new FormMap();
        formMap.put("appid", "wxdde6d44348f138ca");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");
        try {

            String staus = "close"; //open
            wxMaService.getCodeService().changeVisitStatus(staus);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    /**
     * 小程序版本回退
     * 0	成功
     * -1	系统错误
     * 87011	现网已经在灰度发布，不能进行版本回退
     * 87012	该版本不能回退，可能的原因：1:无上一个线上版用于回退 2:此版本为已回退版本，不能回退 3:此版本为回退功能上线之前的版本，不能回退
     */
    @RequestMapping("revertcoderelease")
    @ResponseBody
    public String revertcoderelease() {
        logger.info("WeixinMiniAppCodeController-revertcoderelease,【小程序版本回退】");

        FormMap formMap = new FormMap();
        formMap.put("appid", "wxdde6d44348f138ca");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");
        try {

            wxMaService.getCodeService().revertCodeRelease();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }

    //小程序审核撤回
    @RequestMapping("undocodeaudit")
    @ResponseBody
    public String undocodeaudit() {
        logger.info("WeixinMiniAppCodeController-undocodeaudit,【小程序审核撤回】");

        FormMap formMap = new FormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);
        formMap.put("appid",miniPublicInfo.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(miniPublicInfo.getStr("authorizer_app_id"));
        try {
            wxMaService.getCodeService().undoCodeAudit();
        } catch (WxErrorException e) {
            e.getError().getErrorMsg();

            e.printStackTrace();
        }
        return "success";
    }


    /**
     * 目前官方只返回userStr   一段字符串  没有标识具体用户  没有实际意义
     * 只能系统自己维护
     */
    @ResponseBody
    @RequestMapping("memberauth")
    public String memberauth() throws WxErrorException {
        FormMap formMap = getFormMap();
        //todo  获取小程序的配置信息
        formMap.put("appid", "wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");

        HashMap param = new HashMap(1);
        param.put("action", "get_experiencer");
        String responseContent = wxMaService.post("https://api.weixin.qq.com/wxa/memberauth", WxMaGsonBuilder.create().toJson(param));
        return responseContent;
    }


    @ResponseBody
    @RequestMapping("getDomain")
    public String getDomain() throws WxErrorException {
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);

        formMap.put("appid",formMap.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("authorizer_app_id"));

        WxMaDomainAction getModifyDomain = WxMaDomainAction.builder().action("get")
                .build();

        return  wxMaService.getSettingService().modifyDomain(getModifyDomain).toJson();

    }

    @ResponseBody
    @RequestMapping("addDomain")
    public String addDomain() throws Exception {
        FormMap formMap = getFormMap();
        E miniPublicInfo = (E) this.getSession().getAttribute("miniPublicInfo");
        formMap.putAll(miniPublicInfo);

        formMap.put("appid","wxb47cdc920eda00d2");

        WxMaService wxMaService = weixinOpenService.getOpenConfig().getWxOpenComponentService().getWxMaServiceByAppid("wxb47cdc920eda00d2");


//        File file = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(miniPublicInfo.getStr("authorizer_app_id")).getQrcodeService().createWxaCode("pages/index/index",225);
//        WxMaService wxMaService = new WxMaServiceImpl();
//
//        WxMaInMemoryConfig wxMaInMemoryConfig = new WxMaInMemoryConfig();
//        wxMaInMemoryConfig.setAppid("wxdde6d44348f138ca");
//        wxMaInMemoryConfig.setSecret("d833c4fe415ced5b9a5b597c39568a7b");
//        wxMaInMemoryConfig.setAesKey("weiit");
//        wxMaService.setWxMaConfig(wxMaInMemoryConfig);
//
//
//        WxMpService wxMpService = new WxMpServiceImpl();
//        WxMpInMemoryConfigStorage wxMpInMemoryConfigStorage = new WxMpInMemoryConfigStorage();
//        wxMpInMemoryConfigStorage.setAppId("登录微信公众平台查询APPID");
//        wxMpInMemoryConfigStorage.setSecret("登录微信公众平台查询SECRET");
//        wxMpService.setWxMpConfigStorage(wxMpInMemoryConfigStorage);
//
//        //第一个方法
//        //获取code
//        //redirectURI  接收code 的接口
//        wxMpService.oauth2buildAuthorizationUrl("redirectURI","scope","state");
//
//        //第二个方法  接收code 的接口
//        //通过code获取openId
//        wxMpService.oauth2getAccessToken("code");

//        File file = wxMaService.getQrcodeService().createWxaCode("pages/index/index",225);
//        File file = wxMaService.getQrcodeService().createWxaCodeUnlimit("2259","pages/detail/detail");
        File file = wxMaService.getQrcodeService().createQrcode("pages/detail/detail?shop_id=2259");
        String qrCodePath = WeiitUtil.uploadFile(FileUtils.readFileToByteArray(file),"png");
        logger.info("\n【qrCodePath is {}】",qrCodePath);
        System.out.println(WeiitUtil.getFileDomain()+qrCodePath);
//        List<String> requestDomain = new ArrayList();
//        requestDomain.add("http://merchant.wstore.me/");
//
//        WxMaDomainAction getModifyDomain = WxMaDomainAction.builder().action("add")
//                .requestDomain(requestDomain).uploadDomain(requestDomain).uploadDomain(requestDomain)
//                .build();

//        return  wxMaService.getSettingService().modifyDomain(getModifyDomain).toJson();
        return  WeiitUtil.getFileDomain()+qrCodePath;

    }


}
