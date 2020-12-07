package com.weiit.web.api.controller;


import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import cn.binarywang.wx.miniapp.bean.template.WxMaTemplateLibraryGetResult;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.api.service.IntegralService;
import com.weiit.web.api.service.MessageService;
import com.weiit.web.api.service.PageService;
import com.weiit.web.api.service.PlatformService;
import com.weiit.web.api.service.UserService;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import com.weiit.web.common.FormTemplateVO;
import com.weiit.web.common.RedisKey;
import com.weiit.web.util.Base64Util;
import com.weiit.web.util.JWTUtil;
import com.weiit.web.util.JsonUtil;
import com.weiit.web.weixinopen.service.WeixinOpenService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import me.chanjar.weixin.open.api.WxOpenService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/api")
public class PlatformController extends FrontController {

    @Resource
    PlatformService platformService;


    @Resource
    WeixinOpenService weixinOpenService;

    @Resource
    RedisUtil redisUtil;

    @Resource
    UserService userService;

    @Resource
    PageService pageService;

    @Resource
    MessageService messageService;

    @Resource
    IntegralService integralService;



    /**
     * 【服务号】
     * URL防火墙
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/firewall")
    public String firewall() throws Exception {
        logger.info("【服务号】,PlatformController-firewall");

        FormMap formMap = getFormMap();
        //坚持是否传递了url参数
        if (StringUtils.isEmpty(formMap.getStr("url"))) {
            return toJsonAPI("", "非法请求", "4000");
        } else {
            URL url = new URL(formMap.getStr("url"));
            String shop_domain = url.getHost();
            String shop_domain_prex = shop_domain.split("\\.")[0];
            formMap.set("shop_domain_prex", shop_domain_prex);

            E shopInfo = platformService.selectShopInfoByShopDomainPrex(formMap);
            if (shopInfo == null) {
                return toJsonAPI("", "店铺不存在", "4000");
            } else {
                //查询店铺的服务号信息
                formMap.clear();
                formMap.set("shop_id", shopInfo.getStr("shop_id"));
                formMap.set("type", 2);
                E weixinPublic = platformService.selectWeixinPublicInfoByShopId(formMap);
                if (weixinPublic == null) {
                    return toJsonAPI("", "店铺没有绑定公众号或小程序", "4000");
                } else {
                    //把初始化信息给到前端
                    E result = new E();
                    result.put("shop_id", shopInfo.getStr("shop_id"));
                    result.put("shop_name", shopInfo.getStr("shop_name"));
                    result.put("shop_logo", shopInfo.getStr("shop_logo"));

                    //web端  拿到 appid  可用于授权
                    result.put("appId", weixinPublic.getStr("authorizer_app_id"));

                    E weixinOpenInfo = weixinOpenService.selectWeixinOpenInfo(null);
                    result.put("component_appid", weixinOpenInfo.getStr("component_app_id"));
                    return toJsonAPI(result);

                }
            }
            //今后还可以新增业务判断,比如判断店铺是否已到期，请求url是否合法
        }
    }


    /**
     * 【小程序】
     * APPID 防火墙
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/firewallForApp")
    public String firewallForApp() throws Exception {
        logger.info("【小程序】,PlatformController-firewallForApp");
        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("appid"))) {
            return toJsonAPI("", "非法请求", "4000");
        } else {
            E publicInfo = platformService.selectWeixinPublicInfoByAppId(formMap);
            //后续获取店铺信息，判断店铺的营业状态。
            if (publicInfo == null) {
                return toJsonAPI("", "店铺没有绑定小程序", "4000");
            } else {
                //查询店铺的公众号信息
                return toJsonAPI(ApiResponseCode.SUCCESS);

            }
        }
    }



    /**
     * 全局配置信息  底部菜单  全局风格设置
     * */
    @ResponseBody
    @RequestMapping(value = "/initParam")
    public String initParam(@RequestParam  String appid){
        logger.info("PlatformController-initParam,【全局配置信息  底部菜单  全局风格设置】");

        FormMap formMap = new FormMap();
        formMap.put("appid",appid);
        E result = new E();
        E publicInfo = platformService.selectWeixinPublicInfoByAppId(formMap);
        //后续获取店铺信息，判断店铺的营业状态。
        if (publicInfo == null) {
            return toJsonAPI("", "该店铺还未绑定", "4000");
        }
        //底部菜单信息
        formMap.put("shop_id",publicInfo.get("shop_id"));
        List<E> bottomMenuList = pageService.selectPageBottomMenuByShopId(formMap);

        for(E menu : bottomMenuList){
            if (menu.getStr("target_url").startsWith("zidingyi")){
                menu.put("target_id",menu.getStr("link"));
            }
        }

        //全局风格设置
        E globalStyle = pageService.selectGlobalStyle(formMap);

        result.put("bottomMenuList",bottomMenuList);
        result.put("globalStyle",globalStyle);
        return toJsonAPI(result);
    }


    /**
     * 全局配置信息  底部菜单  全局风格设置
     * */
    @ResponseBody
    @RequestMapping(value = "/navParam")
    public String navParam(@RequestParam  String appid){
        logger.info("PlatformController-navParam,【底部导航设置】");

        FormMap formMap = new FormMap();
        formMap.put("appid",appid);
        E result = new E();
        E publicInfo = platformService.selectWeixinPublicInfoByAppId(formMap);
        //后续获取店铺信息，判断店铺的营业状态。
        if (publicInfo == null) {
            return toJsonAPI("", "该店铺还未绑定", "4000");
        }
        //底部导航信息
        formMap.put("shop_id",publicInfo.get("shop_id"));
        List<E> navInfoList = pageService.selectNavInfoByShopId(formMap);
        result.put("navInfoList",navInfoList);
        return toJsonAPI(result);
    }



    /**
     * 服务号授权登录
     *
     * @return
     * @throws Exception
     * @formMap code appid
     */
    @ResponseBody
    @RequestMapping(value = "/mpLogin")
    public String mpLogin() throws Exception {
        logger.info("【服务号授权登录】,PlatformController-mpLogin");

        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("code"))) {
            return toJsonAPI(ApiResponseCode.WX_CODE_EMPTY);
        }

        WxMpOAuth2AccessToken accessToken;
        WxMpUser wxMpUser;
        try {
            //通过code  获取    （appId  code）
            WxOpenService wxOpenService = weixinOpenService.getInstance(formMap);
            accessToken = wxOpenService.getWxOpenComponentService().oauth2getAccessToken(formMap.getStr("appid"), formMap.getStr("code"));
            //准备入库,登录、生成token，返回json
            formMap.put("wx_open_id", accessToken.getOpenId());
//            wxMpUser = wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(formMap.getStr("appid")).oauth2getUserInfo(accessToken, "zh_CN");
            E user = platformService.weixinLogin(formMap);
            //将用户生成为token，返回给客户端，方便今后进行数据交互。
            if (user != null) {
                user.put("authorizer_app_id",formMap.getStr("appid"));
                user.put("token", JWTUtil.sign(user, 2L * 3600L * 1000L));

                //user_id  编码
                user.put("share_user_id", Base64Util.encode(user.getStr("user_id")));

                return toJsonAPI(user);
            } else {
                wxMpUser = wxOpenService.getWxOpenComponentService().getWxMpServiceByAppid(formMap.getStr("appid")).oauth2getUserInfo(accessToken, "zh_CN");
                this.logger.info("获得基本信息：{}", wxMpUser.toString());
                //如果用户不存在，直接注册
                formMap.set("user_name", wxMpUser.getNickname());
                formMap.set("user_nike", wxMpUser.getNickname());
                formMap.set("user_img", wxMpUser.getHeadImgUrl());
                formMap.set("user_sex", wxMpUser.getSex());
                formMap.set("region", wxMpUser.getCountry());
                formMap.set("balance", 0.00);
                formMap.set("integral", 0);
                formMap.set("user_birthday", "1990-01-01");
                formMap.set("wx_union_id", wxMpUser.getUnionId());
                formMap.set("wx_open_id", wxMpUser.getOpenId());
                formMap.set("open_id_type", 1);

                formMap.set("shop_id", platformService.selectWeixinPublicInfoByAppId(formMap).get("shop_id"));


                if (!StringUtils.isEmpty(formMap.getStr("share_user_id"))&& StringUtils.isNumeric(formMap.getStr("share_user_id"))){
                    formMap.set("parent_id", formMap.getStr("share_user_id"));
                    //share_user_id  获取积分
                    //查看店铺是否已设置积分赠送
                    FormMap paramMap = new FormMap();
                    paramMap.put("item_code","INTEGRALSET");
                    paramMap.put("item_name","GOSHOP");
                    paramMap.put("shop_id",formMap.getStr("shop_id"));

                    E shopParam = integralService.selectShopParamByCode(paramMap);

                    if (shopParam !=null && shopParam.getInt("state")==0 && shopParam.getInt("item_value")>0 ){
                        //添加积分
                        FormMap shareMap = new FormMap();
                        shareMap.put("user_id",formMap.getStr("share_user_id"));
                        shareMap.put("shop_id",formMap.getStr("shop_id"));

                        E shareUserInfo = userService.selectOne(shareMap);
                        if (shareUserInfo!=null){
                            BigDecimal updateIntegral = new BigDecimal(shareUserInfo.getStr("integral")).add(new BigDecimal(shopParam.getStr("item_value")));
                            shareMap.put("updateIntegral",updateIntegral);

                            userService.updateUserIntegral(shareMap);

                            //添加积分记录
                            shareMap.put("i_integral",shopParam.getStr("item_value"));
                            shareMap.put("i_last_integral",updateIntegral);
                            shareMap.put("i_remark",shopParam.getStr("item_desc"));
                            shareMap.put("i_type",4);
                            shareMap.put("i_state",1);

                            userService.addUserIntegralLog(shareMap);
                        }
                    }
                }else {
                    formMap.set("parent_id", -1);
                }


                //注册登陆
                platformService.register(formMap);
                E registerUser = platformService.weixinLogin(formMap);
                if (registerUser != null) {
                    registerUser.put("authorizer_app_id",formMap.getStr("appid"));
                    registerUser.put("token", JWTUtil.sign(registerUser, 2L * 3600L * 1000L));
                    registerUser.put("share_user_id", Base64Util.encode(registerUser.getStr("user_id")));
                    return toJsonAPI(registerUser);
                } else {
                    return toJsonAPI("", "用户不存在", "1000");
                }
            }
        } catch (WxErrorException e) {
            this.logger.error(e.getError().toString());
            return toJsonAPI("", "获取微信基本信息资料失败", "1008");
        }


    }


    /**
     * 小程序获取openID
     *
     * @param code / appId
     */
    @ResponseBody
    @RequestMapping(value = "/getOpenidForApp")
    public String getOpenidForApp(HttpServletResponse response, @RequestParam(value = "code") String code, @RequestParam String appid) {
        logger.info("【小程序】,PlatformController-getOpenidForApp");
        try {
            WxMaJscode2SessionResult session = weixinOpenService.getInstance(getFormMap()).getWxOpenComponentService().miniappJscode2Session(appid, code);
            this.logger.info(session.getSessionKey());
            this.logger.info(session.getOpenid());
            //  可以增加自己的逻辑，关联业务相关数据
            return toJsonAPI(session);
        } catch (WxErrorException e) {
            this.logger.error(e.getMessage(), e);
            return toJsonAPI("", "获取微信openId失败", "1008");
        }

    }




    /**
     * 会员微信登录接口,需要参数,wx_open_id appid  【小程序登录】 sessionKey,  encryptedData,  ivStr
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/maLogin", method = RequestMethod.POST)
    public String maLogin() throws Exception {
        logger.info("会员微信小程序登录,PlatformController-maLogin");
        FormMap formMap = getFormMap();
        if (StringUtils.isEmpty(formMap.getStr("wx_open_id"))) {
            return toJsonAPI("", "微信登录时必须传递wx_open_id参数", "1000");
        } else {
            E user = platformService.weixinLogin(formMap);
            if (user != null) {
                user.put("authorizer_app_id",formMap.getStr("appid"));
                user.put("token", JWTUtil.sign(user,  2L * 3600L * 1000L));
                user.put("share_user_id",Base64Util.encode(user.getStr("user_id")));
                return toJsonAPI(user);
            } else {
                if (StringUtils.isEmpty(formMap.getStr("ivStr"))){
                    return toJsonAPI("", "微信登录时必须传递ivStr参数", "1000");
                }
                if (StringUtils.isEmpty(formMap.getStr("encryptedData"))){
                    return toJsonAPI("", "微信登录时必须传递encryptedData参数", "1000");
                }
                //如果用户不存在，直接注册
                WxMaUserInfo userInfo = weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid(formMap.getStr("appid"))
                        .getUserService().getUserInfo(formMap.getStr("sessionKey"), formMap.getStr("encryptedData"), formMap.getStr("ivStr"));
                formMap.set("user_name", userInfo.getNickName());
                formMap.set("user_nike", userInfo.getNickName());
                formMap.set("user_img", userInfo.getAvatarUrl());
                formMap.set("user_sex", userInfo.getGender());
                formMap.set("region", userInfo.getCountry().concat(userInfo.getProvince()).concat(userInfo.getCity()));
                formMap.set("balance", 0.00);
                formMap.set("integral", 0);
                formMap.set("user_birthday", "1990-01-01");
                formMap.set("wx_open_id", userInfo.getOpenId());
                formMap.set("open_id_type", 0);
                formMap.set("shop_id", platformService.selectWeixinPublicInfoByAppId(formMap).get("shop_id"));
                if (!StringUtils.isEmpty(formMap.getStr("share_user_id")) && StringUtils.isNumeric(formMap.getStr("share_user_id"))){
                    formMap.set("parent_id", formMap.getStr("share_user_id"));


                    //share_user_id  获取积分
                    //查看店铺是否已设置积分赠送
                    FormMap paramMap = new FormMap();
                    paramMap.put("item_code","INTEGRALSET");
                    paramMap.put("item_name","GOSHOP");
                    paramMap.put("shop_id",formMap.getStr("shop_id"));


                    E shopParam = integralService.selectShopParamByCode(paramMap);

                    if (shopParam !=null && shopParam.getInt("state")==0 && shopParam.getInt("item_value")>0 ){
                        //添加积分
                        FormMap shareMap = new FormMap();
                        shareMap.put("user_id",formMap.getStr("share_user_id"));
                        shareMap.put("shop_id",formMap.getStr("shop_id"));

                        E shareUserInfo = userService.selectOne(shareMap);
                        if (shareUserInfo!=null){
                            BigDecimal updateIntegral = new BigDecimal(shareUserInfo.getStr("integral")).add(new BigDecimal(shopParam.getStr("item_value")));
                            shareMap.put("updateIntegral",updateIntegral);

                            userService.updateUserIntegral(shareMap);

                            //添加积分记录
                            shareMap.put("i_integral",shopParam.getStr("item_value"));
                            shareMap.put("i_last_integral",updateIntegral);
                            shareMap.put("i_remark",shopParam.getStr("item_desc"));
                            shareMap.put("i_type",4);
                            shareMap.put("i_state",1);

                            userService.addUserIntegralLog(shareMap);
                        }
                    }
                }else {
                    formMap.set("parent_id", -1);
                }


                platformService.register(formMap);
                E registerUser = platformService.weixinLogin(formMap);
                if (registerUser != null) {
                    registerUser.put("authorizer_app_id",formMap.getStr("appid"));
                    registerUser.put("token", JWTUtil.sign(registerUser, 2L * 3600L * 1000L));
                    registerUser.put("share_user_id",Base64Util.encode(registerUser.getStr("user_id")));
                    return toJsonAPI(registerUser);
                } else {
                    return toJsonAPI("", "用户不存在 ", "1000");
                }
            }
        }

    }



    /**
     * 公共上传图片的接口
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/uploadImg")
    public String uploadImg() {
        logger.info("【异步】接口调用创建计划,PlatformController-uploadImg");

        List<E> imgList = new ArrayList<E>();
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            System.out.println(fileMap);
            if (fileMap != null && !fileMap.isEmpty()) {
                for (Iterator iterator = fileMap.keySet().iterator(); iterator.hasNext(); ) {
                    String key = iterator.next().toString();
                    MultipartFile mFile = fileMap.get(key);
                    if (!mFile.isEmpty()) {
                        String img_url = WeiitUtil.uploadFile(mFile);
                        E img = new E();
                        img.set("img_url", img_url);
                        imgList.add(img);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return toJsonAPI(imgList);

    }


    /**
     * 小程序收集用户推送码
     *
     * @openId  用户的openid
     * @param formId 用户的表单模板
     *
     * 一次收集一个
     */
    @RequestMapping(value = "/collectFormIds")
    @ResponseBody
    public void collectFormIds(@RequestParam String openId, String formId) {
        logger.info("openId {} 收集 formId {}",openId,formId);
        FormTemplateVO formTemplateVO = new FormTemplateVO();
        formTemplateVO.setFormId(formId);
        //有效时间  七天 减少10分钟
        formTemplateVO.setExpire((new Date()).getTime()+604200*1000);

        redisUtil.lSet(RedisKey.MINIFORMID + openId, JsonUtil.writeValueAsString(formTemplateVO));
    }


    /**
     * 访问博客
     * */
    @RequestMapping(value = "/blog/{blogId}.html")
    public ModelAndView publicArticle(@PathVariable("blogId") String blogId) {
        ModelAndView mav = new ModelAndView();
        FormMap formMap = new FormMap();
        formMap.put("blogId",blogId);
        E blogInfo = platformService.selectBlogInfoById(formMap);
        mav.setViewName("publicArticle");
        mav.addObject("blog",blogInfo);
        return mav;
    }




    @ResponseBody
   	@RequestMapping(value = "/findTemplateLibraryKeywordList")
   	public List<WxMaTemplateLibraryGetResult.KeywordInfo> findTemplateLibraryKeywordList(String id)  {
		try {
		    FormMap formMap = new FormMap();
		    formMap.put("appid","wx16abeb3ca941a985");
			WxMaTemplateLibraryGetResult wxMaTemplateListResult =weixinOpenService.getInstance(formMap).getWxOpenComponentService().getWxMaServiceByAppid("wx16abeb3ca941a985").getTemplateService().findTemplateLibraryKeywordList(id);

			List<WxMaTemplateLibraryGetResult.KeywordInfo> list = wxMaTemplateListResult.getKeywordList();
			for (WxMaTemplateLibraryGetResult.KeywordInfo keywordInfo :list){
				System.out.println("ID:"+keywordInfo.getKeywordId());
				System.out.println("名称"+keywordInfo.getName());
				System.out.println("示例"+keywordInfo.getExample());
			}
			return list;
		} catch (WxErrorException e) {
			e.printStackTrace();
		}
		return null;
	}




    /**
     * 店招logo
     */

    @RequestMapping(value = "/shopLogo")
    @ResponseBody
    public E shopLogo( @RequestHeader String token) {
        logger.info("进入ProductGroupController-shopLogo,店招logo");
        E result = new E();
        FormMap formMap =getFormMap();
        E shopInfo = platformService.selectShopInfoById(formMap);
        result.put("shopInfo", shopInfo);
        return result;
    }


    /**
     * 店铺导航图
     */

    @RequestMapping(value = "/navShop")
    @ResponseBody
    public E navShop( @RequestParam String appid) {
        logger.info("进入ProductGroupController-navShop,店铺导航图");
        E result = new E();
        //查询店铺的引导页
        FormMap formMap = new FormMap();
        formMap.put("appid",appid);
        E publicInfo = platformService.selectWeixinPublicInfoByAppId(formMap);
        if (publicInfo!=null){
            formMap.put("shop_id",publicInfo.get("shop_id"));
            E introPage = platformService.selectShopIntroPage(formMap);
            if (introPage!=null){
                result.put("navShopPic",WeiitUtil.getFileDomain()+introPage.getStr("intro_page_url"));
            }else {
                result.put("navShopPic","http://wstore-1255653546.image.myqcloud.com/wstore_saas/2019-07-08/1e8c5605-9ad5-4a00-ad27-393b44cffe2a.png");
                //新增一条记录
                formMap.clear();
                formMap.put("intro_page_url",result.getStr("navShopPic").replace(WeiitUtil.getFileDomain(),""));
                formMap.put("intro_page_desc","默认");
                formMap.put("shop_id",publicInfo.get("shop_id"));
                formMap.put("is_use",1);
                platformService.saveIntroPage(formMap);

        }

        }else {
            result.put("navShopPic","http://wstore-1255653546.image.myqcloud.com/wstore_saas/2019-07-08/1e8c5605-9ad5-4a00-ad27-393b44cffe2a.png");
        }
        return result;

    }












}
