package com.weiit.web.admin.shopdesign.controller;


import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.RedisUtil;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.miniprogram.service.WxMiniProgramService;
import com.weiit.web.admin.product.service.ProductGroupService;
import com.weiit.web.admin.product.service.ProductService;
import com.weiit.web.admin.publics.service.ParameterService;
import com.weiit.web.admin.publics.service.PublicsService;
import com.weiit.web.admin.shopdesign.service.PageNavService;
import com.weiit.web.admin.shopdesign.service.PageService;
import com.weiit.web.admin.util.JsonUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;

import com.weiit.web.common.RedisKey;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 设计页面
 *
 * @author 半个鼠标
 * @version 1.0
 * @date：2017年2月14日 上午2:01:43
 * @company http://www.wei-it.com
 */
@Controller
@RequestMapping(value = "/design/page")
public class NavigationController extends AdminController {
    public static Logger logger = Logger.getLogger(NavigationController.class);

    @Resource
    private PageNavService pageNavService;
    @Resource
    ParameterService parameterService;
    @Resource
    private PublicsService publicsService;

    @Resource
    WxMiniProgramService wxMiniProgramService;

    @Resource
    RedisUtil redisUtil;

    @Resource
    PageService pageService;

    @Resource
    ProductGroupService productGroupService;

    @Resource
    ProductService productService;


    @RequestMapping("/navigation")
    public UIview navigation() {
        logger.info("进入 NavigationController-navigation,店铺导航装修");
        UIview result = UIView("/center/design/page/navigation", false);
        FormMap formMap = getFormMap();
        List<E> navlist = pageNavService.selectList(formMap);
        List<E> targetList = pageNavService.selectItemList(formMap);
        for (E info : navlist) {
            List<E> list = new ArrayList<E>();
            int count = 0;
            for (E item : targetList) {
                if (info.getStr("id").equals(item.getStr("nav_id"))) {
                    int num = 0;
                    if (item.getStr("parent_id").equals("-1")) {
                        count++;
                        for (E item11 : targetList) {
                            if (item.getStr("item_id").equals(item11.getStr("parent_id"))) {
                                num++;
                            }
                        }
                    }
                    item.put("rowCount", count);
                    item.put("resNum", num);
                    list.add(item);
                }
            }
            info.put("itemList", list);
        }
        List linkList = publicsService.selectWeixinLink(formMap);
        this.getRequest().setAttribute("linkList", linkList);
        this.getRequest().setAttribute("navlist", navlist);
        this.getRequest().setAttribute("targetList", targetList);
        result.addObject("queryParam", formMap);
        return result;
    }

    @RequestMapping("/navigationSave")
    public UIview navigationSave() throws Exception {
        logger.info("进入 NavigationController-navigationSave,微页面装修保存");
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
            // 获得文件：
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

            FormMap param = getFormMap();
            if (fileMap != null && !fileMap.isEmpty()) {
                for (Iterator iterator = fileMap.keySet().iterator(); iterator.hasNext(); ) {
                    String key = iterator.next().toString();
                    MultipartFile mFile = fileMap.get(key);
                    System.out.println(mFile.getName());
                    if (!mFile.isEmpty()) {
                        String pictureName = WeiitUtil.uploadFile(mFile);
                        param.put("img" + mFile.getName(), pictureName);
                    }
                }
            }
//	        MultipartFile fileitemimg11 = multipartRequest.getFile("fileitemimg11");   

            if (param.get("validate_id") == null || param.get("validate_id").equals("")) {
                pageNavService.insert(param);
            } else {
                pageNavService.edit(param);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview result = UIView("navigation", true);

        return result;
    }

    @RequestMapping("/navigationState")
    public UIview navigationState() throws Exception {
        logger.info("进入 NavigationController-navigationState,微页面装修保存");
        try {
            FormMap param = getFormMap();
            pageNavService.editState(param);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview result = UIView("navigation", true);

        return result;
    }

    @RequestMapping("/navigationRemove")
    public UIview navigationRemove() throws Exception {
        logger.info("进入 NavigationController-navigationRemove,微页面装修保存");
        try {
            FormMap param = getFormMap();
            pageNavService.remove(param);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview result = UIView("navigation", true);

        return result;
    }


    @RequestMapping("/bottomMenu")
    public UIview bottomNav() {
        logger.info("进入 NavigationController-bottomMenu,底部菜单装修");
        UIview result = UIView("/center/design/page/bottomMenu", false);
        FormMap formMap = getFormMap();
        List<E> buttonlist = pageNavService.selectButtonList(formMap);

        formMap.put("item_code", "CUSTOM");
        formMap.put("item_name", "BOTTOMNAV");
        List<E> list = parameterService.selectList(formMap);
        if (list != null && list.size() > 0) {
            E info = list.get(0);
            formMap.put("bgcolor", info.get("item_value"));
        }
        List linkList = publicsService.selectWeixinLink(formMap);

        this.getRequest().setAttribute("buttonlist", buttonlist);
        this.getRequest().setAttribute("linkList", linkList);
        result.addObject("queryParam", formMap);
        return result;
    }

    @RequestMapping("/bottomMenuSave")
    public UIview bottomNavSave() throws Exception {
        logger.info("进入 NavigationController-bottomMenuSave,底部菜单保存");
        try {
            FormMap param = getFormMap();
            pageNavService.insertButton(param);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview result = UIView("bottomMenu", true);

        return result;
    }


    /**
     * 自定义导航  图标
     */
    @ResponseBody
    @RequestMapping(value = "/navIconList")
    public String navIconList() {
        return toJsonAPI(pageNavService.navIconList(null));
    }


    /**
     * 自定义导航可选链接  首页、个人中心  必选  （个人中心  剔除我的订单 收货地址）
     */

    @ResponseBody
    @RequestMapping(value = "/navOptionalUrl")
    public String navOptionalUrl() {


        return toJsonAPI(pageNavService.navOptionalUrl(null));
    }

    @ResponseBody
    @RequestMapping(value = "/saveNav")
    public String saveNav() {
        synchronized (this) {
            FormMap formMap = getFormMap();
            //确认短时间内置操作一次
            if (redisUtil.getExpire(RedisKey.LIMIT + formMap.getStr("shop_id")) > 0) {
                return "frequently";
            }
            pageNavService.saveNav(formMap);
            //发布小程序
            E miniPublicInfo = (E) getSession().getAttribute("miniPublicInfo");
            if (miniPublicInfo != null) {
                formMap.putAll(miniPublicInfo);
                wxMiniProgramService.uploadMiniCode(formMap, true,false);
            }
            redisUtil.set(RedisKey.LIMIT + formMap.getStr("shop_id"), formMap.getStr("shop_id"), 30);
            return "success";
        }

    }

    @ResponseBody
    @RequestMapping(value = "/navInfo")
    public String navInfo() {
        FormMap formMap = getFormMap();
        List<E> list = pageNavService.navInfo(formMap);

        for (E nav : list) {
            if (nav.getStr("url").equals("index")) {
                //todo
                if (StringUtils.isEmpty(nav.getStr("nav_value"))){
                    nav.put("branchLine", "");
                }else {
                    formMap.put("page_id",nav.getStr("nav_value"));
                    formMap.put("validate_id",nav.getStr("nav_value"));
                    E pageInfo = pageService.selectOne(formMap);
                    nav.put("branchLine",pageInfo.getStr("page_name"));
                }

            } else if (nav.getStr("url").equals("productGroup") && nav.get("nav_value") != null) {
                if (StringUtils.isEmpty(nav.getStr("nav_value"))){
                    nav.put("branchLine", "");
                }else {
                    formMap.put("validate_id",nav.getStr("nav_value"));
                    E productGroupInfo = productGroupService.selectOne(formMap);
                    nav.put("branchLine",productGroupInfo.getStr("group_name"));
                }
            } else if (nav.getStr("url").equals("detail") && nav.get("nav_value") != null) {
                if (StringUtils.isEmpty(nav.getStr("nav_value"))){
                    nav.put("branchLine", "");
                }else {
                    formMap.put("product_id",nav.getStr("nav_value"));
                    E productInfo = productService.selectProductById(formMap);
                    nav.put("branchLine",productInfo.getStr("product_name"));
                }
            } else {
                nav.put("branchLine", "");
            }
        }
        return toJsonAPI(list);
    }


    @RequestMapping(value = "/navEdit")
    public String navEdit() {
        return "/center/design/page/pageNav";
    }


}