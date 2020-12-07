package com.weiit.web.weixinopen.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaDomainAction;
import cn.binarywang.wx.miniapp.bean.code.*;
import com.sun.imageio.plugins.common.ImageUtil;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.base.FrontController;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.WxMpMassOpenIdsMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;

/**
 * Created by 罗鸿强 on 2018/7/12.
 *
 * 测试用
 */

@Controller
@RequestMapping("/wxCode")
public class WeixinMiniAppCodeController extends FrontController {
    @Autowired
    WeixinOpenService weixinOpenService;


    /**
     * 发布小程序
     *
     * 1、设置小程序服务器域名
     * 授权给第三方的小程序，其服务器域名只可以为第三方的服务器，当小程序通过第三方发布代码上线后，小程序原先自己配置的服务器域名将被删除，
     * 只保留第三方平台的域名，所以第三方平台在代替小程序发布代码之前，需要调用接口为小程序添加第三方自身的域名。
        提示：需要先将域名登记到第三方平台的小程序服务器域名中，才可以调用接口进行配置。请求方式: POST（请使用https协议） https://api.weixin.qq.com/wxa/modify_domain?access_token=TOKEN

         access_token	请使用第三方平台获取到的该小程序授权的authorizer_access_token
     action	add添加, delete删除, set覆盖, get获取。当参数是get时不需要填四个域名字段
     requestdomain	request合法域名，当action参数是get时不需要此字段
     wsrequestdomain	socket合法域名，当action参数是get时不需要此字段
     uploaddomain	uploadFile合法域名，当action参数是get时不需要此字段
     downloaddomain	downloadFile合法域名，当action参数是get时不需要此字段
     *
     * 、设置小程序业务域名（仅供第三方代小程序调用）  授权给第三方的小程序，其业务域名只可以为第三方的服务器，当小程序通过第三方发布代码上线后，
     * 小程序原先自己配置的业务域名将被删除，只保留第三方平台的域名，所以第三方平台在代替小程序发布代码之前，需要调用接口为小程序添加业务域名。
     * 请求方式: POST（请使用https协议）
     https://api.weixin.qq.com/wxa/setwebviewdomain?access_token=TOKEN
     * */

    //、设置小程序服务器域名
    @RequestMapping("modifyDomain")
    @ResponseBody
    public void  modifyDomain(){
        logger.info("WeixinMiniAppCodeController-modifyDomain,【设置小程序服务器域名】");
        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");
        List<String> requestDomain= new ArrayList<String>();
        requestDomain.add("https://api.woyoulian.com");
        List<String> uploadDomain= Arrays.asList("https://api.woyoulian.com");
        List<String> downloadDomain= Arrays.asList("https://api.woyoulian.com");



        WxMaDomainAction modifyDomain =WxMaDomainAction.builder().action("add")
                .uploadDomain(uploadDomain)
                .requestDomain(requestDomain)
                .downloadDomain(downloadDomain)
                .build();

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");


        try {
            wxMaService.getSettingService().modifyDomain(modifyDomain);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
    }



    /**
     *授权给第三方的小程序，其业务域名只可以为第三方的服务器，当小程序通过第三方发布代码上线后，小程序原先自己配置的业务域名将被删除，只保留第三方平台的域名，所以第三方平台在代替小程序发布代码之前，需要调用接口为小程序添加业务域名。
     提示：
     1、需要先将域名登记到第三方平台的小程序业务域名中，才可以调用接口进行配置。
     2、为授权的小程序配置域名时支持配置子域名，例如第三方登记的业务域名如为qq.com，则可以直接将qq.com及其子域名（如xxx.qq.com）也配置到授权的小程序中。

     请求方式: POST（请使用https协议）
     https://api.weixin.qq.com/wxa/setwebviewdomain?access_token=TOKEN

     参数	说明
     access_token	            请使用第三方平台获取到的该小程序授权的authorizer_access_token
     action	                    add添加, delete删除, set覆盖, get获取。当参数是get时不需要填webviewdomain字段。如果没有action字段参数，则默认将开放平台第三方登记的小程序业务域名全部添加到授权的小程序中
     webviewdomain	            小程序业务域名，当action参数是get时不需要此字段
     * */

    //设置小程序业务域名（仅供第三方代小程序调用）
    @RequestMapping("setWebViewDomain")
    @ResponseBody
    public void  setWebViewDomain(){
        logger.info("WeixinMiniAppCodeController-setWebViewDomain,【设置小程序业务域名】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");
        List<String> setWebViewDomain= new ArrayList<String>();
        setWebViewDomain.add("https://api.woyoulian.com");

        WxMaDomainAction modifyDomain =WxMaDomainAction.builder().action("add")
                .webViewDomain(setWebViewDomain)
                .build();

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");


        try {
            wxMaService.getSettingService().setWebViewDomain(modifyDomain);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
    }




    //上传代码
    @RequestMapping("publishMiniApp")
    @ResponseBody
    public String publishMiniApp(){
        logger.info("WeixinMiniAppCodeController-publishMiniApp,【上传代码】");
        FormMap formMap = new FormMap();
        formMap.put("appid","wx16abeb3ca941a985");
        try {
            WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");

//            Map<String, WxMaCodeExtConfig.PageConfig> extPages = new HashMap<>();
//            extPages.put("pages/index/index", WxMaCodeExtConfig.PageConfig.builder().navigationBarTitleText("首页").build());
//            extPages.put("pages/category/category", WxMaCodeExtConfig.PageConfig.builder().navigationBarTitleText("特惠").build());
//            extPages.put("pages/shopCar/shopCar", WxMaCodeExtConfig.PageConfig.builder().navigationBarTitleText("购物车").build());
//            extPages.put("pages/Personal/Personal", WxMaCodeExtConfig.PageConfig.builder().navigationBarTitleText("个人中心a").build());

            E ext = new E();
            ext.put("appid","wx16abeb3ca941a985");
            ext.put("url","https://api.woyoulian.com");
            WxMaCodeExtConfig wxMaCodeExtConfig =WxMaCodeExtConfig.builder()
                    .extEnable(true)
                    .debug(false)
                    .extAppid("wx16abeb3ca941a985")
                    .ext(ext)
                    .build();
            /**
             * extEnable	Boolean	是	配置 ext.json 是否生效
             extAppid	String	是	配置 extAppid
             ext	Object	否	开发自定义的数据字段
             extPages	String Array	否	单独设置每个页面的 json
             directCommit	Boolean	否	是否直接提交到待审核列表
             *
             * */
            WxMaCodeCommitRequest wxMaCodeCommitRequest =WxMaCodeCommitRequest.builder().templateId(11L)
                    .extConfig(wxMaCodeExtConfig)
                    .userVersion("2.0.0")
                    .userDesc("阱陌商珍")
                    .build();

            //发布
            wxMaService.getCodeService().commit(wxMaCodeCommitRequest);

//            logger.info("qrcode,{}", wxMaService.getCodeService().getQrCode());


        } catch (WxErrorException e) {
            e.printStackTrace();
        }

        return "success";
    }

  /**
   *
   *   status	审核状态，其中0为审核成功，1为审核失败，2为审核中
   reason	当status=1，审核被拒绝时，返回的拒绝原因
   * */




    //小程序体验二维码
    @RequestMapping("getQrcode")
    @ResponseBody
    public Object getQrcode(HttpServletResponse response){
        logger.info("WeixinMiniAppCodeController-getQrcode,【小程序体验二维码】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");
        try {
            response.setContentType("image/png");
            byte[] image = wxMaService.getCodeService().getQrCode();


            InputStream input = new ByteArrayInputStream(image);

            BufferedImage bufferedImage = ImageIO.read(input);
            ImageIO.write(bufferedImage, "png", response.getOutputStream());
//            File files = new File("E:\\weiit_solution\\qrcode.png");
//
//            OutputStream output = new FileOutputStream(files);
//
//            BufferedOutputStream bufferedOutput = new BufferedOutputStream(output);
//
//            bufferedOutput.write(file);

            String imgurl = WeiitUtil.uploadFile(image,"png");
                System.out.println("====================================");
                System.out.println(imgurl);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }


    //获取授权小程序帐号的可选类目
    @RequestMapping("get_category")
    @ResponseBody
    public String get_category(){
        logger.info("WeixinMiniAppCodeController-getQrcode,【获取授权小程序帐号的可选类目】");
        FormMap formMap = new FormMap();
        formMap.put("appid","wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");
        try {
            wxMaService.getCodeService().getCategory();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    //获取小程序的第三方提交代码的页面配置
    @RequestMapping(value = "get_page",method = RequestMethod.POST)
    @ResponseBody
    public String get_page(){
        logger.info("WeixinMiniAppCodeController-get_page,【获取小程序的第三方提交代码的页面配置】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");

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
     *
     * access_token	请使用第三方平台获取到的该小程序授权的authorizer_access_token
     item_list	提交审核项的一个列表（至少填写1项，至多填写5项）
     address	小程序的页面，可通过“获取小程序的第三方提交代码的页面配置”接口获得
     tag	小程序的标签，多个标签用空格分隔，标签不能多于10个，标签长度不超过20
     first_class	一级类目名称，可通过“获取授权小程序帐号的可选类目”接口获得
     second_class	二级类目(同上)
     third_class	三级类目(同上)
     first_id	一级类目的ID，可通过“获取授权小程序帐号的可选类目”接口获得
     second_id	二级类目的ID(同上)
     third_id	三级类目的ID(同上)
     title	小程序页面的标题,标题长度不超过32
     * */

    //将第三方提交的代码包提交审核
    @RequestMapping("submit_audit")
    @ResponseBody
    public String submit_audit(){
        logger.info("WeixinMiniAppCodeController-submit_audit,【将第三方提交的代码包提交审核】");
        FormMap formMap = new FormMap();
        formMap.put("appid","wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");


//        get_category();  获取可配的分类目录

        WxMaCategory wxMaCategory = WxMaCategory.builder().firstClass("商家自营").address("pages/index/index").tag("食品 有机农产品").title("首页")
                .firstId(304l)
                .secondClass("食品")
                .secondId(321l).build();

        List<WxMaCategory> list = new ArrayList<WxMaCategory>();
        list.add(wxMaCategory);

        WxMaCodeSubmitAuditRequest wxMaCodeSubmitAuditRequest = WxMaCodeSubmitAuditRequest.builder().itemList(list).build();

        try {
           long auditid = wxMaService.getCodeService().submitAudit(wxMaCodeSubmitAuditRequest);
            System.out.printf(""+auditid);
            return auditid+"";
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }




    //查询某个指定版本的审核状态
    @RequestMapping("getAuthStatus")
    @ResponseBody
    public String getAuthStatus(Long auditId){
        logger.info("WeixinMiniAppCodeController-getAuthStatus,【查询某个指定版本的审核状态】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");

        try {
//            Long auditId =438261194L;
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
     参数	说明
     auditid	最新的审核ID
     status	审核状态，其中0为审核成功，1为审核失败，2为审核中
     reason	当status=1，审核被拒绝时，返回的拒绝原因
     * */
    @RequestMapping("get_latest_auditstatus")
    @ResponseBody
    public String get_latest_auditstatus(){
        logger.info("WeixinMiniAppCodeController-get_latest_auditstatus,【查询最新一次提交的审核状态】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");
        try {
           WxMaCodeAuditStatus wxMaCodeAuditStatus= wxMaService.getCodeService().getLatestAuditStatus();
           return wxMaCodeAuditStatus.toString();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    //发布已通过审核的小程序
    @RequestMapping("release")
    @ResponseBody
    public String release(){
        logger.info("WeixinMiniAppCodeController-release,【发布已通过审核的小程序】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");
        try {
            wxMaService.getCodeService().release();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }

    //修改小程序线上代码的可见状态
    @RequestMapping("change_visitstatus")
    @ResponseBody
    public String change_visitstatus(){
        logger.info("WeixinMiniAppCodeController-change_visitstatus,【修改小程序线上代码的可见状态】");
        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");
        try {

            String staus="close"; //open
            wxMaService.getCodeService().changeVisitStatus(staus);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }


    /**
     * 小程序版本回退
     * 0	成功
     -1	系统错误
     87011	现网已经在灰度发布，不能进行版本回退
     87012	该版本不能回退，可能的原因：1:无上一个线上版用于回退 2:此版本为已回退版本，不能回退 3:此版本为回退功能上线之前的版本，不能回退
     *
     * */
    @RequestMapping("revertcoderelease")
    @ResponseBody
    public String revertcoderelease(){
        logger.info("WeixinMiniAppCodeController-revertcoderelease,【小程序版本回退】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");

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
    public String undocodeaudit(){
        logger.info("WeixinMiniAppCodeController-undocodeaudit,【小程序审核撤回】");

        FormMap formMap = new FormMap();
        formMap.put("appid","wxdde6d44348f138ca");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wxdde6d44348f138ca");
        try {
            wxMaService.getCodeService().undoCodeAudit();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }






}
