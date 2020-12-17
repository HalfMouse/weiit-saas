package com.weiit.web.admin.init.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weiit.core.entity.E;
import com.weiit.core.entity.FormMap;
import com.weiit.core.view.UIview;
import com.weiit.resource.common.utils.WeiitUtil;
import com.weiit.web.admin.init.service.ArticleService;
import com.weiit.web.common.AdminController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2018-07-12.
 */
@Controller
@RequestMapping("/article")
public class ArticleController extends AdminController {

    @Resource
    private ArticleService articleService;


    /**
     * 图文列表
     */
    @RequestMapping("/list")
    public UIview articleList() {
        logger.info("进入 UserController-list,图文信息列表");
        FormMap formMap = getFormMap();
        List<E> sortList = articleService.selectSortList(formMap);
        PageHelper.startPage(formMap.getPage(), 16);
        List<E> articleList = articleService.selectList(formMap);

        UIview view = UIView("/center/init/articleImageList", false);
        view.addObject("sortList", sortList);
        view.addObject("pageInfo", new PageInfo<E>(articleList));
        view.addObject("formMap",formMap);
        return view;
    }

    /**
     * 添加图文信息
     */
    @RequestMapping("/add")
    public UIview addArticle() throws Exception {
        logger.info("进入 UserController-add,添加图文信息");
        FormMap formMap = getFormMap();
        List<E> sortList = articleService.selectSortList(formMap);
        UIview view = UIView("/center/init/articleEdit", false);
        view.addObject("sortList", sortList);
        return view;
    }


    /**
     * 新增图文     编辑保存
     */
    @RequestMapping("/save")
    public UIview insertArticle() throws Exception {
        logger.info("进入 UserController-save,添加图文");
        FormMap formMap = getFormMap();
        try {
            // 转型为MultipartHttpRequest：
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) this.getRequest();
            // 获得文件：
            MultipartFile cate_image = multipartRequest.getFile("file1");
            if (!cate_image.isEmpty()) {
                String image = WeiitUtil.uploadFile(cate_image);
                formMap.put("cover_img", image);
            }
            if (formMap.getStr("articleId") == null || formMap.getStr("articleId").equals("")) {
                articleService.insert(formMap);
            } else {
                articleService.edit(formMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("出错啦...");
        }
        UIview view = UIView("redirect:list", false);
        return view;
    }


    /**
     * 查询图文详情
     */
    @RequestMapping("/selectArticleDateil")
    public UIview selectArticleDateil() throws Exception {
        logger.info("进入 UserController-add,查询图文详情");
        FormMap formMap = getFormMap();
        E articleInfo = articleService.selectArticleInfo(formMap);
        UIview view = UIView("/center/init/articleDetail", false);
        view.addObject("articleInfo", articleInfo);
        return view;
    }


    /**
     * 查询图文详情
     */
    @RequestMapping("/edit")
    public UIview edit() throws Exception {
        logger.info("进入 UserController-edit,编辑图文详情");
        FormMap formMap = getFormMap();
        E articleInfo = articleService.selectOne(formMap);
        List<E> sortList = articleService.selectSortList(formMap);
        articleInfo.put("editorValue", articleInfo.getStr("main_body"));
        UIview view = UIView("/center/init/articleEdit", false);
        view.addObject("articleInfo", articleInfo);
        view.addObject("sortList", sortList);
        return view;
    }


    /**
     * 删除图文信息
     */
    @RequestMapping("/remove")
    public UIview removeArticle() throws Exception {
        logger.info("进入 UserController-removeArticle,删除图文信息");
        FormMap formMap = getFormMap();
        articleService.remove(formMap);
        UIview view = UIView("redirect:list", false);
        return view;
    }


}
