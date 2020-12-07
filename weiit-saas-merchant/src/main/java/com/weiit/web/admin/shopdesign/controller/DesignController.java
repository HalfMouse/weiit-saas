package com.weiit.web.admin.shopdesign.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.file.service.PictureService;
import com.weiit.web.admin.shopdesign.service.PageService;
import com.weiit.web.admin.user.service.UserCardService;
import com.weiit.web.admin.util.DesUtil;
import com.weiit.web.base.AdminController;
import com.weiit.web.base.UIview;
import com.weiit.web.common.Constants;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.io.IOException;
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
@RequestMapping(value = "/design")
public class DesignController extends AdminController {
    public static Logger logger = Logger.getLogger(DesignController.class);

    @Resource
    PageService pageService;

    @Resource
    PictureService pictureService;

    @Resource
    UserCardService userCardService;

    @RequestMapping("/dashboard")
    public UIview dashboard() {
        logger.info("进入 StoreController-dashboard,店铺");

        UIview result = UIView("/center/design/dashboard", false);

        return result;
    }


    @RequestMapping("/pageCreate")
    public UIview pageCrate(@RequestParam Integer templateId,String style) {
        logger.info("进入 StoreController-pageCreate,店铺");
        FormMap formMap =getFormMap();
        UIview result = UIView("/center/design/page/pageCreate", false);
        this.getSession().setAttribute("templateId",templateId);
        this.getSession().setAttribute("style",style);
        this.getSession().setAttribute("token", DesUtil.encrypt(formMap.getStr("shop_id")));
        this.getSession().setAttribute("fitDomain", Constants.FIT_DOMAIN);
        return result;
    }



    /**
     * 微页面详情
     */

    @RequestMapping(value = "/weiPage", method = RequestMethod.GET)
    @ResponseBody
    public E weiPage(@RequestParam Integer templateId, @RequestParam String token) {
        logger.info("进入ProductGroupController-weiPage,微页面");
        E result = new E();
        FormMap formMap =new FormMap();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
            formMap.put("validate_id", templateId);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("解密失败");
        }
        E pageres = pageService.selectOne(formMap);

        E resultPage = new E();
        resultPage.put("page_name", pageres.getStr("page_name"));
        resultPage.put("page_desc", pageres.getStr("page_desc"));
        resultPage.put("bgcolor", pageres.getStr("bgcolor"));
        resultPage.put("page_layout", pageres.getStr("page_layout"));
        resultPage.put("validate_id", pageres.getStr("validate_id"));

        result.put("pageInfo", resultPage);
        return result;
    }

    /**
     * 店招logo
     */

    @RequestMapping(value = "/shopLogo", method = RequestMethod.GET)
    @ResponseBody
    public E shopLogo( @RequestParam String token) {
        logger.info("进入ProductGroupController-weiPage,微页面");
        E result = new E();
        FormMap formMap =new FormMap();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("解密失败");
        }
        E shopInfo = userCardService.selectShopInfo(formMap);
        result.put("shopInfo", shopInfo);
        return result;
    }


    /**
     * 选取跳转  微页面列表
     *
     * @author lhq
     * @date 2018年5月7日
     */

    @RequestMapping(value = "/pageList", method = RequestMethod.GET)
    @ResponseBody
    public E pageList(@RequestParam String token,Integer page,Integer rows) {
        E result = new E();

        logger.info("进入DesignController-pageList,微页面列表");
        FormMap formMap = new FormMap();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            return null;
        }
        formMap.put("page",page);
        formMap.put("rows",rows);
        PageHelper.startPage(formMap.getPage(),formMap.getRows());


        result.put("pageList",new PageInfo<E>(pageService.selectList(formMap)));
        return result;
    }

    @RequestMapping(value = "/pageListNotoken", method = RequestMethod.GET)
    @ResponseBody
    public E pageListNotoken(Integer page,Integer rows) {
        E result = new E();
        logger.info("进入DesignController-pageListNotoken,微页面列表");
        FormMap formMap = getFormMap();

        formMap.put("page",page);
        formMap.put("rows",rows);
        PageHelper.startPage(formMap.getPage(),formMap.getRows());


        result.put("pageList",new PageInfo<E>(pageService.selectList(formMap)));
        return result;
    }

    /**
     * 保存微页面
     *
     * @author lhq
     * @date 2018年5月7日
     */
    @RequestMapping(value = "/savePageInfo")
    @ResponseBody
    public E savePageInfo(@RequestParam String token,String page_name,String page_desc,String page_layout,String page_cover,MultipartFile fileDate) {
        logger.info("进入DesignController-savePageInfo,保存微页面");
        FormMap formMap = new  FormMap();
        E result = new E();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("savePageInfo token 解密失败");
            return result ;
        }
        formMap.put("page_name", page_name);
        formMap.put("page_desc", page_desc);
        formMap.put("page_layout", page_layout);
        if (fileDate!=null){
            try {
                formMap.put("page_cover", WeiitUtil.uploadFile(fileDate));
            } catch (Exception e) {
                logger.error("保存上传截图失败");
                formMap.put("page_cover", page_cover);
            }
        }


        int page_id=pageService.insert(formMap);
        result.put("validate_id",page_id);
        return result;
    }

    /**
     * 编辑微页面
     * @author
     * @date 2018年5月7日
     */
    @RequestMapping(value = "/editPageInfo")
    @ResponseBody
    public void editPageInfo(@RequestParam String token,Integer validate_id,String page_name,String page_desc,String page_layout,String page_cover,MultipartFile fileDate) {
        logger.info("进入DesignController-editPageInfo,编辑微页面");
        FormMap formMap = new FormMap();
        try {
            formMap.put("shop_id", DesUtil.decrypt(token));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            return ;
        }
        formMap.put("validate_id", validate_id);
        formMap.put("page_name", page_name);
        formMap.put("page_desc", page_desc);
        formMap.put("page_layout", page_layout);
        if (fileDate!=null){
            try {
                formMap.put("page_cover", WeiitUtil.uploadFile(fileDate));
            } catch (Exception e) {
                logger.error("编辑上传截图失败");
                formMap.put("page_cover", page_cover);
            }
        }
        if (formMap.get("validate_id") != null) {
            pageService.edit(formMap);
        }
    }

    @RequestMapping("uploadPageCover")
    @ResponseBody
    public String uploadPageCover(MultipartFile fileDate) throws IOException {
        return WeiitUtil.uploadFile(fileDate);
    }


    /**
     * 上传 图片 语音 视频
     *
     * @author lhq
     * @date 2018年5月7日
     */
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public List<E> uploadFile(@RequestParam String token,Integer file_type,Integer business_type) throws IOException {
        logger.info("进入DesignController-uploadFile,上传 图片 语音 视频");
        // 转型为MultipartHttpRequest：
        List<E> list = new ArrayList<E>();
        String shop_id;
        try {
            shop_id = DesUtil.decrypt(token);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("token 解密失败");
            return list;
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        if (fileMap != null && !fileMap.isEmpty()) {
            for (Iterator iterator = fileMap.keySet().iterator(); iterator.hasNext(); ) {
                String key = iterator.next().toString();
                MultipartFile uploadFile = fileMap.get(key);

                if (!uploadFile.isEmpty()) {

                    E fileParam = new E();
                    fileParam.put("file_name", uploadFile.getOriginalFilename());
                    fileParam.put("type", file_type);
                    fileParam.put("parent_id", business_type);
                    fileParam.put("file_url", WeiitUtil.uploadFile(uploadFile));
                    fileParam.put("shop_id", shop_id);
                    fileParam.put("is_read", 0);
                    pictureService.uploadFile(fileParam);
                    list.add(fileParam);
                }
            }


        }
        return list;
    }





}