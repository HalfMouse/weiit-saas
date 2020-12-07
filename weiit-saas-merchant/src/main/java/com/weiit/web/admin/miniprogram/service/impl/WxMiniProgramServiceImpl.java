package com.weiit.web.admin.miniprogram.service.impl;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaDomainAction;
import cn.binarywang.wx.miniapp.bean.code.WxMaCategory;
import cn.binarywang.wx.miniapp.bean.code.WxMaCodeSubmitAuditRequest;
import cn.binarywang.wx.miniapp.util.json.WxMaGsonBuilder;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.mapper.BaseMapper;
import com.weiit.core.service.impl.AbstractService;
import com.weiit.web.admin.miniprogram.mapper.WxMiniProgramMapper;
import com.weiit.web.admin.miniprogram.service.WxMiniProgramService;
import com.weiit.web.admin.shopdesign.mapper.PageMapper;
import com.weiit.web.admin.weixin.service.WeixinPublicService;
import com.weiit.web.common.Constants;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import org.apache.commons.lang.StringUtils;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by 罗鸿强 on 2018/7/19.
 */
@Service
public class WxMiniProgramServiceImpl extends AbstractService implements WxMiniProgramService {
    public final org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    WeixinOpenService weixinOpenService;

    @Resource
    WxMiniProgramMapper wxMiniProgramMapper;


    @Resource
    PageMapper pageMapper;

    @Resource
    WeixinPublicService weixinPublicService;


    @Override
    public BaseMapper setMapper() {
        return wxMiniProgramMapper;
    }

    @Override
    public void modifyDomain(FormMap formMap) {
        if (StringUtils.isEmpty(formMap.getStr("authorizer_app_id"))) {
            return;
        }
        formMap.put("appid", formMap.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("authorizer_app_id"));

        List<String> requestDomain = new ArrayList();
        requestDomain.add(Constants.SERVER_HOST);
        WxMaDomainAction modifyDomain = WxMaDomainAction.builder().action("add")
                .uploadDomain(requestDomain)
                .requestDomain(requestDomain)
                .downloadDomain(requestDomain)
                .build();
        try {
            wxMaService.getSettingService().modifyDomain(modifyDomain);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void setWebViewDomain(FormMap formMap) {
        if (StringUtils.isEmpty(formMap.getStr("authorizer_app_id"))) {
            return;
        }
        formMap.put("appid", formMap.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("authorizer_app_id"));

        List<String> requestDomain = new ArrayList();
        requestDomain.add(Constants.SERVER_HOST);
        WxMaDomainAction modifyDomain = WxMaDomainAction.builder().action("add")
                .webViewDomain(requestDomain)
                .build();
        try {
            wxMaService.getSettingService().setWebViewDomain(modifyDomain);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
    }


    @Override
    public E uploadMiniCode(FormMap formMap, boolean isSubmit,boolean isFirst) {
        E result = new E();
        result.put("msg","ok");
        try {
            if (StringUtils.isEmpty(formMap.getStr("authorizer_app_id"))) {
                return null;
            }
            formMap.put("appid", formMap.getStr("authorizer_app_id"));
            WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("authorizer_app_id"));


            //可能存在域名重复授权
            if (isFirst) {
                try {
                    List<String> requestDomain = new ArrayList();
                    requestDomain.add(Constants.SERVER_HOST);

                    WxMaDomainAction getModifyDomain = WxMaDomainAction.builder().action("get")
                            .build();
                    WxMaDomainAction getWxMaDomainAction =  wxMaService.getSettingService().modifyDomain(getModifyDomain);
                    List<String> doDomain = getWxMaDomainAction.getDownloadDomain();
                    List<String> reDomain = getWxMaDomainAction.getRequestDomain();
                    List<String> upDomain = getWxMaDomainAction.getUploadDomain();
                    List<String> wsDomain = getWxMaDomainAction.getWsRequestDomain();

                    //删掉再添加

                    logger.info("\n【获取到小程序之前设定域名为 []】",getWxMaDomainAction.toJson());
                    if (getWxMaDomainAction.getRequestDomain()!=null && getWxMaDomainAction.getRequestDomain().size()>0 ){
                        WxMaDomainAction delModifyDomain = WxMaDomainAction.builder().action("delete")
                                .uploadDomain(upDomain)
                                .requestDomain(reDomain)
                                .downloadDomain(doDomain)
                                .wsRequestDomain(wsDomain)
                                .build();
                        wxMaService.getSettingService().modifyDomain(delModifyDomain);
                    }


                    WxMaDomainAction addmodifyDomain = WxMaDomainAction.builder().action("add")
                            .uploadDomain(requestDomain)
                            .requestDomain(requestDomain)
                            .downloadDomain(requestDomain)
                            .build();
                    wxMaService.getSettingService().modifyDomain(addmodifyDomain);




                    WxMaDomainAction getWebViewDomain = WxMaDomainAction.builder().action("get")
                            .build();
                    WxMaDomainAction getWxMaWebViewDomainAction =  wxMaService.getSettingService().modifyDomain(getWebViewDomain);

                    if (getWxMaWebViewDomainAction.getWebViewDomain()!=null){
                        WxMaDomainAction delWebViewDomain = WxMaDomainAction.builder().action("delete")
                                .webViewDomain(getWxMaWebViewDomainAction.getWebViewDomain())
                                .build();

                        wxMaService.getSettingService().setWebViewDomain(delWebViewDomain);

                    }

                    WxMaDomainAction addWebViewDomain = WxMaDomainAction.builder().action("add")
                            .webViewDomain(requestDomain)
                            .build();

                    wxMaService.getSettingService().setWebViewDomain(addWebViewDomain);
                } catch (WxErrorException e) {
                    //todo  入库  定时任务  刷新域名
                    e.printStackTrace();
                    logger.error("绑定域名失败，请先解绑小程序授权的第三方平台 app_id is{}",formMap.getStr("authorizer_app_id"));



                }
            }
            //获取最新模板Id  及版本号
            E versionInfo = wxMiniProgramMapper.selectMiniVersionInfo(null);
            //extJson
            E param = new E();
            param.put("template_id", versionInfo.getLong("template_id"));
            param.put("user_version", versionInfo.getStr("version_no"));
            param.put("user_desc", formMap.getStr("signature"));


            E extConfig = new E();
            E ext = new E();
            extConfig.put("extAppid", formMap.getStr("authorizer_app_id"));
            extConfig.put("extEnable", true);
            extConfig.put("debug", false);
            ext.put("appid", formMap.getStr("authorizer_app_id"));


            ext.put("url", Constants.SERVER_HOST);
            ext.put("nick_name", formMap.getStr("nick_name"));
            ext.put("head_img", formMap.getStr("head_img"));
            ext.put("dev_name", "蜗店");
            ext.put("version_no", versionInfo.getStr("version_no"));
            //时间戳
            ext.put("commit_time", (versionInfo.getDate("create_time")).getTime());
            //描述
            ext.put("signature", formMap.getStr("signature"));


            List<E> tabBarList = new ArrayList<E>();

            List<String> switchTabUrl = new ArrayList<String>();


            //底部导航  tabBar
            List<E> navInfoList = pageMapper.selectNavInfoByShopId(formMap);
            if (navInfoList!=null &&navInfoList.size()>0){
                for(E navInfo : navInfoList){
                    E tabBar = new E();
                    tabBar.put("pagePath", getMiniPath(navInfo.getStr("nav_url")));
                    tabBar.put("text", navInfo.getStr("nav_name"));
                    tabBar.put("iconPath", navInfo.getStr("mini_path").split("\\|")[0]);
                    tabBar.put("selectedIconPath", navInfo.getStr("mini_path").split("\\|")[1]);
                    tabBarList.add(tabBar);
                    switchTabUrl.add(navInfo.getStr("nav_url"));

                    if (!StringUtils.isEmpty(navInfo.getStr("nav_value"))){
                        if (navInfo.getStr("nav_url").equals("index")  ){
                            ext.put("pageId",navInfo.getInt("nav_value"));
                        }else if (navInfo.getStr("nav_url").equals("productGroup")){
                            ext.put("productGroupId",navInfo.getInt("nav_value"));
                        }else if (navInfo.getStr("nav_url").equals("detail")){
                            ext.put("detailId",navInfo.getInt("nav_value"));
                        }
                    }
                }
            }

            E tabbar = new E();
            tabbar.put("list", tabBarList);

            ext.put("switchTabUrl",switchTabUrl);
            extConfig.put("ext", ext);
            extConfig.put("tabBar", tabbar);
            String config = WxMaGsonBuilder.create().toJson(extConfig);
            param.put("ext_json", config);
            String json = WxMaGsonBuilder.create().toJson(param);
            formMap.put("appid",formMap.getStr("authorizer_app_id"));

            try {
                wxMaService.post("https://api.weixin.qq.com/wxa/commit", json);
            } catch (WxErrorException e) {
                e.printStackTrace();
            }

            if (isSubmit) {
                //提交审核
                // 1 获取小程序可配置的商家类目
                List<WxMaCategory> list = wxMaService.getCodeService().getCategory();

                //需要添加地址
                List<WxMaCategory> itemList = new ArrayList<WxMaCategory>();
                for (WxMaCategory wxMaCategory : list) {
                    WxMaCategory category = WxMaCategory.builder()
                            .address("pages/index/index")
                            .title(formMap.getStr("nick_name"))
                            .firstClass(wxMaCategory.getFirstClass())
                            .firstId(wxMaCategory.getFirstId())
                            .secondClass(wxMaCategory.getSecondClass())
                            .secondId(wxMaCategory.getSecondId())
                            .build();
                    itemList.add(category);
                    // 提交审核项的一个列表（至少填写1项，至多填写5项）填一个就行
                    break;
                }
                if (itemList.size()<1){
                    result.put("msg","请先登录公众平台补充小程序的头像，名称，简介等信息");
                    return result;
                }

                WxMaCodeSubmitAuditRequest wxMaCodeSubmitAuditRequest = WxMaCodeSubmitAuditRequest.builder().itemList(itemList).build();

                //审核Id  入库
                long auditid = wxMaService.getCodeService().submitAudit(wxMaCodeSubmitAuditRequest);



                //更新之前的版本为老版本。
                wxMiniProgramMapper.updateMiniAuth(formMap);

                FormMap authMap = new FormMap();
                authMap.put("audit_id", auditid);
                authMap.put("authorizer_app_id", formMap.getStr("authorizer_app_id"));
                authMap.put("origin_id", formMap.getStr("user_name"));
                authMap.put("version_no", versionInfo.getStr("version_no"));
                authMap.put("template_id", versionInfo.getLong("template_id"));
                authMap.put("shop_id", formMap.getStr("shop_id"));
                wxMiniProgramMapper.addMiniAuth(authMap);
            }

        } catch (WxErrorException e) {
            e.printStackTrace();
            logger.error("msg","提交审核失败，app_id is{},\n error is {}\n code is {}",formMap.getStr("authorizer_app_id"),e.getError().getErrorMsg(),e.getError().getErrorCode());
        }

        return result;
    }



    public void needFreshDomain(String app_id){

    }

    public String getMiniPath(String url){
        return String.format("pages/%s/%s",url,url);
    }

    @Override
    public String getQrcode(FormMap formMap) {
        formMap.put("appid", formMap.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("appid"));
        try {
            byte[] image = wxMaService.getCodeService().getQrCode();
            BASE64Encoder encoder = new BASE64Encoder();
            return "data:image/jpeg;base64," + encoder.encode(image);
        } catch (WxErrorException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String submit_audit(FormMap formMap) {
        return null;
    }

    @Override
    public String getAuthStatus(FormMap formMap) {
        return null;
    }

    @Override
    public String release(FormMap formMap) {
        formMap.put("appid", formMap.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("appid"));
        try {
            wxMaService.getCodeService().release();
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        return "success";
    }

    @Override
    public List<E> selectTestUserList(FormMap formMap) {
        return wxMiniProgramMapper.selectTestUserList(formMap);
    }


    /**
     * 85001	微信号不存在或微信号设置为不可搜索
     * 85002	小程序绑定的体验者数量达到上限
     * 85003	微信号绑定的小程序体验者达到上限
     * 85004	微信号已经绑定
     */
    //绑定微信用户为小程序体验者
    @Override
    public String bindTester(FormMap formMap) {
        formMap.put("appid", formMap.getStr("authorizer_app_id"));

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("appid"));
        try {
            wxMaService.getSettingService().bindTester(formMap.getStr("wechat_id"));
        } catch (WxErrorException e) {
            if (e.getError().getErrorCode() != 85004) {
                return errorDesc(e.getError().getErrorCode());
            }
        }
        // 添加入库
        wxMiniProgramMapper.addTestUser(formMap);
        return "体验用户绑定成功";

    }

    public String errorDesc(Integer key) {
        Map<Integer, String> errorMap = new HashMap<Integer, String>();
        errorMap.put(85001, "微信号不存在或微信号设置为不可搜索");
        errorMap.put(85002, "小程序绑定的体验者数量达到上限");
        errorMap.put(85003, "微信号绑定的小程序体验者达到上限");
        errorMap.put(85004, "微信号已经绑定");

        return errorMap.get(key);
    }

    //解除绑定小程序的体验者
    @Override
    public String unbindTester(FormMap formMap) {

        formMap.put("appid", formMap.getStr("authorizer_app_id"));
        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("appid"));
        String msg = "删除操作成功";
        try {
            wxMaService.getSettingService().unbindTester("wechat_id");
        } catch (WxErrorException e) {
            e.printStackTrace();
            msg = e.getError().getErrorMsg();
        }
        wxMiniProgramMapper.delTestUser(formMap);
        return msg;
    }


    //3. 获取体验者列表
    public void memberauth(FormMap formMap) throws WxErrorException {

        //todo  获取小程序的配置信息
        formMap.put("appid", "wx16abeb3ca941a985");

        WxMaService wxMaService = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985");

        HashMap param = new HashMap(1);
        param.put("wechatid", "");
        wxMaService.post("https://api.weixin.qq.com/wxa/memberauth", WxMaGsonBuilder.create().toJson(param));
    }

    @Override
    public E selectMiniCurrentAuthInfo(FormMap formMap) {
        return wxMiniProgramMapper.selectMiniCurrentAuthInfo(formMap);
    }

    @Override
    public E selectMiniVersionInfo(FormMap formMap) {
        return wxMiniProgramMapper.selectMiniVersionInfo(formMap);
    }


}
