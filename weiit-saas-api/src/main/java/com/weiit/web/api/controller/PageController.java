package com.weiit.web.api.controller;

import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.web.api.service.PageService;
import com.weiit.web.api.service.UserService;
import com.weiit.web.base.FrontController;
import com.weiit.web.common.ApiResponseCode;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 微页面相关
 *
 * @version 1.0
 * @company http://www.wei-it.com 微邦互联
 */
@RestController
@RequestMapping(value = "api/page")
public class PageController extends FrontController {

    @Resource
    UserService userService;

    @Resource
    PageService pageService;

    /**
     * 获取页面信息,初始化页面布局
     *
     * @author：lhq
     * @date：2018年5月7日
     */

    @RequestMapping(value = "/pageInfo")
    public String pageInfo() {
       logger.info("PageController-pageInfo,获取页面信息,初始化页面布局");

        FormMap formMap = getFormMap();
        if (formMap.get("user_id") != null) {
            if (StringUtils.isEmpty(formMap.getStr("page_id")) || !StringUtils.isNumeric(formMap.getStr("page_id"))) {
                //可定义一个异常Code类,,,或可跳转返回一个官方商店默认首页
                formMap.put("is_default", 1);
            } else {
                formMap.put("type_id", formMap.getStr("page_id"));
            }


            //根据 page_id  返回   pageName  pageDesc bgcolor pageLayout//   微页面不存在返回店铺主页
            E eparam = pageService.selectById(formMap);
            if (eparam ==null){
                logger.info("微页面不存在  返回主页   page_id {},shop_id {}",formMap.getStr("page_id"),formMap.getStr("shop_id"));
                formMap.put("page_id", null);
                formMap.put("is_default", 1);
                E newParam = pageService.selectById(formMap);
                formMap.put("page_type", 2);
                formMap.put("type_id", newParam.get("validate_id"));
                userService.addUserPageViewLog(formMap, false);
                userService.addUserShopViewLog(formMap);
                return toJsonAPI(newParam);
            }else {
                formMap.put("page_type", 2);
                formMap.put("type_id", eparam.get("validate_id"));
                userService.addUserPageViewLog(formMap, false);
                userService.addUserShopViewLog(formMap);
                return toJsonAPI(eparam);
            }

            // 访客记录  weiit_user_page_log  weiit_user_log


        }else {
            return toJsonAPI(ApiResponseCode.TOKEN_INVALID);
        }

    }


    /**
     * 获取页面信息  tehui
     *
     * @author：lhq
     * @date：2018年5月7日
     */

    @RequestMapping(value = "/tehuimai")
    public String tehuimai() {
        logger.info("PageController-tehuimai,获取页面信息,tehui");
        FormMap formMap = getFormMap();
        formMap.put("is_default", 2);
        E pageInfo = pageService.selectById(formMap);
        // 访客记录  weiit_user_page_log  weiit_user_log
        if (formMap.get("user_id") != null) {
            formMap.put("page_type", 2);
            formMap.put("type_id", pageInfo.getStr("validate_id"));
            userService.addUserPageViewLog(formMap, false);
        }
        return toJsonAPI(pageInfo);
    }




}
